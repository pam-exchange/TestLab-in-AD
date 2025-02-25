<#
.SYNOPSIS
Create an AD OU with content suitable for PAM solutions.

.DESCRIPTION
The script will create a structure in AD with groups and users. The 
information can be used with a PAM solution. Groups are created for
login users, personal privileged accounts, shared accounts and groups,
which can be used to isolate different "companies" within the same structure.

When creating the structure it can be isolated such that the same AD can
be used for different PAM solutions. This is helpful for a test lab, 
where the same AD is used to setup AD structures for multiple PAM solutions,
such that it is not necessary to have separate AD's to have a test
environment for multiple PAM solutions.

The user running this script must be a Domain Administrator in AD.

.PARAMETER VendorName
The VendorName is the name for a PAM vendor.

.PARAMETER VendorPrefix
When creating groups and users in AD their sAMAccountName is unique. The prefix
is used in combination with names for groups and users.

.PARAMETER DefaultPassword
When some of the users are created, it may be necessary to know the initial
password when adding them to PAM. Other users uses a reconcile or master
account where PAM will set the account password to a random value.
The parameter will allow a specific value for users where it is necessary to
know the password.
Default password is "Simple2015!" (without quotes)

.EXAMPLE
Create-PAM-TestLab -VendorName PAM-CyberArk -VendorPrefix cyb
Create-PAM-TestLab -VendorName PAM-Symantec -VendorPrefix sym -DefaultPassword MySecretPassword

#>
Param(
	[Parameter(Mandatory=$true)][string] $VendorName,
	[Parameter(Mandatory=$true)][string] $VendorPrefix,
	[Parameter(Mandatory=$false)][string] $DefaultPassword="Simple2015!"
)

$gDomain= (Get-ADDomain).DistinguishedName
$gAdminGroups= New-Object System.Collections.ArrayList

#--------------------------------------------
function ConvertTo-LdapPath () {
	Param(
		[Parameter(Mandatory=$true,ValueFromPipeline)][string] $Domain
	)

	process {
		$path= ""
		$Domain.Split(".") | %{
			if ($path -ne "") {$path+= ","}
			$path+= "DC=$_"
		}
		return $path
	}
}


#--------------------------------------------
function New-LdapOU () {
	Param(
		[Parameter(Mandatory=$true)][String] $Name,
		[Parameter(Mandatory=$true)][String] $Path,
		[Parameter(Mandatory=$false)][String] $Description= "",
		[Parameter(Mandatory=$false)][Boolean] $Protected= $false
	)

	process {
		if (-not $Path.Contains("DC=")) {
			$Path= ConvertTo-LdapPath -Domain $Path
		}

		try {
			New-ADOrganizationalUnit -Name $Name -Path $Path -Description $Description -ProtectedFromAccidentalDeletion $Protected -Verbose
			return "OU=$Name,$Path"
		} 
		catch {
			# Write-Host "Exception - Type= $($_.Exception.GetType().FullName), Message= $($_.Exception.Message)"
			throw
		}
	}
}


#--------------------------------------------
<#
.SYNOPSIS
Will create a new OU at a given Path.

.Parameters Name
Name of the OU to be created.

.PARAMETER Path
Distinguished name or path where the OU will be created.

.PARAMETER Description
Some description to the new OU.

.PARAMETER Protected
Mark the OU protected to avoid accedential deletion.

#>function New-LdapGroup () {
	Param(
		[Parameter(Mandatory=$true)][String] $Name,
		[Parameter(Mandatory=$true)][String] $Path,
		[Parameter(Mandatory=$false)][String] $Description= "",
		[Parameter(Mandatory=$false)][String] $MemberOf,
		[Parameter(Mandatory=$false)][String] $prefix= $VendorPrefix
	)

	process {
		if ($prefix -ne "") { $name= "$($prefix)-$($name)" }
		try {
			$tmp= New-ADGroup -Name $Name -SamAccountName $Name -Path $Path -GroupCategory Security -GroupScope Global -Description $Description -PassThru -verbose

			if ($MemberOf) {
				$MemberOf.split(";") | %{
					Add-ADGroupMember -Identity $_.Trim() -Members $tmp
				}
			}
			return "CN=$Name,$Path"
		} 
		catch {
			# Write-Host "Exception - Type= $($_.Exception.GetType().FullName), Message= $($_.Exception.Message)"
			throw
		}
	}
}

#--------------------------------------------
function New-LdapUser () {
	Param(
		[Parameter(Mandatory=$true)][String] $Name,
		[Parameter(Mandatory=$false)][String] $Password,
		[Parameter(Mandatory=$true)][String] $Path,
		[Parameter(Mandatory=$false)][String] $Domain= $gDomain,
		[Parameter(Mandatory=$false)][String] $upn,
		[Parameter(Mandatory=$false)][String] $Description,
		[Parameter(Mandatory=$false)][String] $MemberOf,
		[Parameter(Mandatory=$false)][String] $prefix= $VendorPrefix,
		[Parameter(Mandatory=$false)][Switch] $Reconcile= $false
	)

	process {
		if (-not $password) {
			$password= -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 32 | % {[char]$_})
		}
		$Passwd= (ConvertTo-SecureString -AsPlainText $Password -Force)

		if ($prefix) { $name= "$($prefix)_$($name)" }

		if (-not $upn) { $upn= "$($name)@$($domain)" }

		try {
			$tmp= New-ADUser -Name $Name `
						-AccountPassword $Passwd `
						-Path $Path `
						-CannotChangePassword $True `
						-ChangePasswordAtLogon $False `
						-Description $Name `
						-Enabled $True `
						-PasswordNeverExpires $True `
						-SamAccountName $Name `
						-UserPrincipalName $upn `
						-PassThru `
						-verbose

			if ($MemberOf) {
				$MemberOf.split(";") | %{
					Add-ADGroupMember -Identity $_.Trim() -Members $tmp
				}
			}

			if ($Reconcile) {
				#
				# Permissions to change passwords for other users
				# The scope is the OU for all users within the Vendor OU
				# It is possible to restrict the reconcile account further, 
				# but for the test setup the settings below will do.
				#
				dsacls.exe $Domain /i:S /G $Name":CA;Reset Password;User" | Out-Null

 				dsacls.exe $Domain /i:S /G $Name":WD" | Out-Null
				dsacls.exe $Domain /i:S /G $Name":WPRP;LockoutTime;user" | Out-Null
				dsacls.exe $Domain /i:S /G $Name":WPRP;account restrictions;user" | Out-Null
				
				#
				# Users in the AdminSDHolder OU are special
				#
				$AdminSDHolderDN= "CN=AdminSDHolder,CN=System,"+$((Get-ADDomain).DistinguishedName)
				dsacls.exe $AdminSDHolderDN /G $Name":CA;Reset Password" | Out-Null
				dsacls.exe $AdminSDHolderDN /G $Name":WD" | Out-Null
				dsacls.exe $AdminSDHolderDN /G $Name":RP;LockoutTime" | Out-Null
				dsacls.exe $AdminSDHolderDN /G $Name":WP;LockoutTime" | Out-Null
				dsacls.exe $AdminSDHolderDN /G $Name":RP;account restrictions" | Out-Null
				dsacls.exe $AdminSDHolderDN /G $Name":WP;account restrictions" | Out-Null
			}
			
			return $tmp.DistinguishedName
		} 
		catch {
			# Write-Host "Exception - Type= $($_.Exception.GetType().FullName), Message= $($_.Exception.Message)"
			throw
		}
	}
}

#--------------------------------------------
Function New-Team () {
Param(
	[Parameter(Mandatory=$true)][string] $path,
	[Parameter(Mandatory=$false)][string] $TeamTitle,
	[Parameter(Mandatory=$true)][string] $TeamName,
	[Parameter(Mandatory=$false)][string] $Description= "",
	[Parameter(Mandatory=$true)][string] $AccessGroup= "",
	[Parameter(Mandatory=$true)][string] $UserName,
	[Parameter(Mandatory=$false)][int] $UserCount= 2,
	[Parameter(Mandatory=$false)][string] $ManagerName,
	[Parameter(Mandatory=$false)][int] $ManagerCount= 2,
	[Parameter(Mandatory=$false)][string] $SharedAccountName,
	[Parameter(Mandatory=$false)][int] $SharedAccountCount= 2,
	[Parameter(Mandatory=$false)][switch] $UsePersonalAccount= $false,
	[Parameter(Mandatory=$false)][string] $PersonalAccountOU
	)
	Process {

		$useSharedAccount= ($SharedAccountName -and $SharedAccountCount -gt 0)

		if (-not $TeamTitle) {$TeamTitle= $TeamName}

		try {
			$dnTeam= New-LdapOU -Name $TeamTitle -Path $Path
			$dnUsers= New-LdapOU -Name "Users" -Path $dnTeam
			$dnGroups= New-LdapOU -Name "Groups" -Path $dnTeam

			if ($useSharedAccount) {
				$dnSharedAccounts= New-LdapOU -Name "SharedAccounts" -Path $dnTeam
			}
		} 
		catch {
			if ($_.Exception.Message -match "already in use") {
				$dnTeam= "OU=$TeamTitle,$path"
				$dnUsers= "OU=Users,$dnTeam" 
				$dnGroups= "OU=Groups,$dnTeam" 
				$dnSharedAccounts= "OU=SharedAccounts,$dnTeam"
			} 
			else {
				throw
			}
		}
		$dnGroup= New-LdapGroup "$($TeamName)" -Path $dnGroups -Description $Description -MemberOf $AccessGroup

		if ($UsePersonalAccount -and -not $PersonalAccountOU) {
			$PersonalAccountOU= $dnUsers
		}

		# PAM login - managers
		if ($ManagerName) {
			$dnManagersGroup= New-LdapGroup "$($TeamName)Managers" -Path $dnGroups -Description "AD group for $($TeamName) Managers" -MemberOf $dnGroup
			1..$ManagerCount | %{
				$dn= New-LdapUser -Name $("$($ManagerName){0:d2}" -f $_) -Password $defaultPassword -Domain $Domain -Path $dnUsers -MemberOf $dnManagersGroup
			}
		}

		# PAM login - users
		$dnUsersGroup= New-LdapGroup "$($TeamName)Admins" -Path $dnGroups -Description $Description -MemberOf $dnGroup
		$gAdminGroups.Add($dnUsersGroup) | Out-Null
		1..$UserCount | %{
			$dn= New-LdapUser -Name $("$($UserName){0:d2}" -f $_) -Password $defaultPassword -Domain $Domain -Path $dnUsers -MemberOf "$dnUsersGroup"
		}

		# Personal Privileged Accounts (managed)
		if ($UsePersonalAccount) {
			1..$UserCount | %{
				$dn= New-LdapUser -Name $("$($UserName){0:d2}-p" -f $_) -Domain $Domain -Path $PersonalAccountOU
			}
		}

		# Shared accounts (managed)
		if ($useSharedAccount) {
			1..$SharedAccountCount | %{
				$dn= New-LdapUser -Name $("$($SharedAccountName){0:d2}" -f $_) -Domain $Domain -Path $dnSharedAccounts
			}
		}
		return $dnTeam

	}
}

#############################

#
# Create a new OU for this vendor.
# The OU is created below the top level of the domain
#

$basePath= New-LdapOU -Name $VendorName -Path $gDomain

#
# Create some OU and groups for login users
# The group for login users can be used in PAM to grant login privileges
#
$dnPersonalPrivilegedAccounts= New-LdapOU -Name "PersonalPrivilegedAccounts" -Path $basePath
$dnGroups= New-LdapOU -Name "Groups" -Path $basePath
$dnAccess= New-LdapGroup -Name "PAM-Access" -Path $dnGroups -Description "Users with PAM login permission"


# --- PAM ---
$dnPAM= New-LdapOU -Name "PAM Technical" -Path $basePath
$dnPAMUsers= New-LdapOU -Name "Users" -Path $dnPAM
$dnPAMGroups= New-LdapOU -Name "Groups" -Path $dnPAM
$dnPAMServices= New-LdapOU -Name "Service Accounts" -Path $dnPAM

$dn= New-LdapUser -Name "Lookup" -Password $defaultPassword -Path $dnPAMServices
$dn= New-LdapUser -Name "Bind" -Password $defaultPassword -Path $dnPAMServices
$dn= New-LdapUser -Name "Scan" -Password $defaultPassword -Path $dnPAMServices
$dn= New-LdapUser -Name "Recording" -Password $defaultPassword -Path $dnPAMServices
$dn= New-LdapUser -Name "Reconcile" -Password $defaultPassword -Path $dnPAMServices -Reconcile
# --- PAM ---

# --- some groups ---
$dn= New-Team -path $basePath -TeamTitle "Audit" -TeamName "Audit" -UserName "auditUsr" -ManagerName "auditMgr" -UsePersonalAccount -PersonalAccountOU $dnPersonalPrivilegedAccounts -AccessGroup $dnAccess 
$dn= New-Team -path $basePath -TeamTitle "Finance" -TeamName "Finance" -UserName "finUsr" -ManagerName "finMgr" -UsePersonalAccount -PersonalAccountOU $dnPersonalPrivilegedAccounts -AccessGroup $dnAccess 
$dn= New-Team -path $basePath -TeamTitle "ABC Vision" -TeamName "ABC" -UserName "abcUsr" -ManagerName "abcMgr" -SharedAccountName "shrAbc" -AccessGroup $dnAccess 
# --- some groups ---


# --- IT ---
$dnIT= New-LdapOU -Name "IT" -Path $basePath

# --- Database ---
$dnDB= New-LdapOU -Name "Database" -Path $dnIT

$dn= New-Team -path $dnDB -TeamTitle "MSSQL" -TeamName "MSSQL" -UserName "mssqlUsr" -ManagerName "mssqlMgr" -SharedAccountName "shrMssql" -UsePersonalAccount -PersonalAccountOU $dnPersonalPrivilegedAccounts -AccessGroup $dnAccess 
$dn= New-Team -path $dnDB -TeamTitle "Oracle" -TeamName "Oracle" -UserName "oraUsr" -ManagerName "oraMgr" -UsePersonalAccount -PersonalAccountOU $dnPersonalPrivilegedAccounts -AccessGroup $dnAccess 

# --- Linux ---
$dn= New-Team -path $dnIT -TeamTitle "Linux" -TeamName "Linux" -UserName "linuxUsr" -ManagerName "linuxlMgr" -UsePersonalAccount -PersonalAccountOU $dnPersonalPrivilegedAccounts -AccessGroup $dnAccess 

# --- Network ---
$dn= New-Team -path $dnIT -TeamTitle "Network" -TeamName "Network" -UserName "netUsr" -ManagerName "netMgr" -UsePersonalAccount -PersonalAccountOU $dnPersonalPrivilegedAccounts -AccessGroup $dnAccess 

# --- Windows ---
$dnWindows= New-Team -path $dnIT -TeamTitle "Windows" -TeamName "Windows" -UserName "winAdm" -ManagerName "winMgr" -SharedAccountName "shrWin" -UsePersonalAccount -PersonalAccountOU $dnPersonalPrivilegedAccounts -AccessGroup $dnAccess 
$dn= New-Team -path $dnIT -TeamTitle "Windows" -TeamName "Helpdesk" -UserName "hlpdsk" -SharedAccountName "shrHlpdsk" -AccessGroup $dnAccess 
$dn= New-Team -path $dnIT -TeamTitle "Windows" -TeamName "RemoteUser" -UserName "rmtUsr" -SharedAccountName "shrRemote" -AccessGroup $dnAccess 
$dn= New-Team -path $dnIT -TeamTitle "Windows" -TeamName "StdUser" -UserName "stdUsr" -SharedAccountName "shrStdUsr" -AccessGroup $dnAccess 


# --- IT Manager ---
$dnWindowsGroups= "OU=Groups,$dnWindows"
$dnWindowsUsers= "OU=Users,$dnWindows"

$grps= $gAdminGroups -join ";"
$dnWindowsITManagersGroup= New-LdapGroup "ITManagers" -Path $dnWindowsGroups -Description "AD group for IT Managers" -MemberOf "$dnAccess; $grps"

1..3 | %{
	$dn= New-LdapUser -Name $("itmanager{0:d2}" -f $_) -Password $defaultPassword -Path $dnWindowsUsers -MemberOf $dnWindowsITManagersGroup
}
# --- IT ---

#Read-Host -Prompt "Press Enter to exit"
