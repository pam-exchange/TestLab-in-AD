Function Show-LdapMembers () {

    Param(
        [string] $Name,
        [string] $Ident= " "
    )
    Process {
        $obj= Get-ADObject -Identity $Name -Properties Name,ObjectClass,DistinguishedName,Member
        $numItems= $obj.Member.count
        $i= 0
        foreach ($m in $obj.Member) {
            $last= ++$i -eq $numItems

            $o= Get-ADObject -Identity $m -Properties Name,ObjectClass,DistinguishedName

            if ($last) { Write-Host "$Ident└ " -ForegroundColor DarkGray -NoNewline }
            else       { Write-Host "$Ident├ " -ForegroundColor DarkGray -NoNewline }

            if ($o.ObjectClass -eq "group") {
                Write-Host $o.Name -ForegroundColor DarkYellow

                if ($last) { $id= "$ident   " } else { $id= "$ident│  " }
                Show-LdapMembers -Name $o.DistinguishedName -ident $id

            } 
            if ($o.ObjectClass -eq "user") {
                Write-Host $o.Name -ForegroundColor Gray
            }
        }
    }
}

Function Show-LdapTree () {

    Param(
        [string] $path,
        [string] $ident= " ",
        [boolean] $first= $true,
        [switch] $showMembers= $false
    )
    Process {
        if ($first) { 
            Write-Host "$path" -ForegroundColor Green
        }

        $objs= Get-ADObject -Filter * -SearchBase $path -SearchScope OneLevel -Properties Name,ObjectClass,DistinguishedName | Sort-Object

        if ($null -eq $objs) { $numItems= 0 }
        else {
            if ($objs.GetType().Name -eq "Object[]") { $numItems= $objs.length } 
            else { $numItems= 1 }
        }

        $i= 0
        foreach ($o in $objs) {
            $last= ++$i -eq $numItems

            if ($last) { Write-Host "$ident└ " -ForegroundColor DarkGray -NoNewline }
            else       { Write-Host "$ident├ " -ForegroundColor DarkGray -NoNewline }

            switch ($o.ObjectClass) {
                "organizationalUnit" {
                    Write-Host $o.Name -ForegroundColor Green

                    if ($last) { $id= "$ident   " } else { $id= "$ident│  " }

                    Show-LdapTree -path $o.DistinguishedName -Ident $id -first $false -showMembers:$showMembers

                    if (-not $last) { Write-Host $id -ForegroundColor DarkGray }
                    break
                }

                "group" { 
                    Write-Host $o.Name -ForegroundColor DarkYellow

                    # Show members in group
                    if ($showMembers) {
                        if ($last) { $id= "$ident   " } else { $id= "$ident│  " }
                        Show-LdapMembers -Name $o.DistinguishedName -ident $id
                    }

                    break
                }

                "user" { 
                    Write-Host $o.Name -ForegroundColor White 
                    break
                }
            }
        }
    }
}

Show-LdapTree "OU=PAM-CyberArk,DC=VMWare,DC=pam,DC=local" -showMembers
