# TestLab-in-AD
There are two Powershell scripts available. 
The first script will uild a test lab with structure ready to be used in a PAM solution. The setup One Powershell script which will create an OU in AD containing several sub-OU, test users, reconcile users, and more.

Name colision for groups and users

Run the script with parameters -VendorName <vendor> -VendorPrefix <prefix>

```
PS C:\Users\Administrator\Desktop> .\CreateTestLab.ps1 -VendorName PAM-CyberArk -VendorPrefix cyb
VERBOSE: Performing the operation "New" on target "OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-PAM-Access,OU=Groups,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=PAM Technical,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Users,OU=PAM Technical,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=PAM Technical,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Service Accounts,OU=PAM Technical,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_Lookup,OU=Service Accounts,OU=PAM Technical,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_Bind,OU=Service Accounts,OU=PAM Technical,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_Scan,OU=Service Accounts,OU=PAM Technical,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_Recording,OU=Service Accounts,OU=PAM Technical,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_Reconcile,OU=Service Accounts,OU=PAM Technical,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Audit,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Users,OU=Audit,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=Audit,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-Audit,OU=Groups,OU=Audit,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-AuditManagers,OU=Groups,OU=Audit,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_auditMgr01,OU=Users,OU=Audit,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_auditMgr02,OU=Users,OU=Audit,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-AuditAdmins,OU=Groups,OU=Audit,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_auditUsr01,OU=Users,OU=Audit,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_auditUsr02,OU=Users,OU=Audit,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_auditUsr01-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_auditUsr02-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Finance,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Users,OU=Finance,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=Finance,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-Finance,OU=Groups,OU=Finance,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-FinanceManagers,OU=Groups,OU=Finance,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_finMgr01,OU=Users,OU=Finance,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_finMgr02,OU=Users,OU=Finance,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-FinanceAdmins,OU=Groups,OU=Finance,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_finUsr01,OU=Users,OU=Finance,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_finUsr02,OU=Users,OU=Finance,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_finUsr01-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_finUsr02-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Users,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=SharedAccounts,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-ABC,OU=Groups,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-ABCManagers,OU=Groups,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_abcMgr01,OU=Users,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_abcMgr02,OU=Users,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-ABCAdmins,OU=Groups,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_abcUsr01,OU=Users,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_abcUsr02,OU=Users,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrAbc01,OU=SharedAccounts,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrAbc02,OU=SharedAccounts,OU=ABC Vision,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Users,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=SharedAccounts,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-MSSQL,OU=Groups,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-MSSQLManagers,OU=Groups,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_mssqlMgr01,OU=Users,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_mssqlMgr02,OU=Users,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-MSSQLAdmins,OU=Groups,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_mssqlUsr01,OU=Users,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_mssqlUsr02,OU=Users,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_mssqlUsr01-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_mssqlUsr02-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrMssql01,OU=SharedAccounts,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrMssql02,OU=SharedAccounts,OU=MSSQL,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Oracle,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Users,OU=Oracle,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=Oracle,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-Oracle,OU=Groups,OU=Oracle,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-OracleManagers,OU=Groups,OU=Oracle,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_oraMgr01,OU=Users,OU=Oracle,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_oraMgr02,OU=Users,OU=Oracle,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-OracleAdmins,OU=Groups,OU=Oracle,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_oraUsr01,OU=Users,OU=Oracle,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_oraUsr02,OU=Users,OU=Oracle,OU=Database,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_oraUsr01-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_oraUsr02-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Linux,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Users,OU=Linux,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=Linux,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-Linux,OU=Groups,OU=Linux,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-LinuxManagers,OU=Groups,OU=Linux,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_linuxlMgr01,OU=Users,OU=Linux,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_linuxlMgr02,OU=Users,OU=Linux,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-LinuxAdmins,OU=Groups,OU=Linux,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_linuxUsr01,OU=Users,OU=Linux,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_linuxUsr02,OU=Users,OU=Linux,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_linuxUsr01-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_linuxUsr02-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Network,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Users,OU=Network,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=Network,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-Network,OU=Groups,OU=Network,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-NetworkManagers,OU=Groups,OU=Network,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_netMgr01,OU=Users,OU=Network,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_netMgr02,OU=Users,OU=Network,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-NetworkAdmins,OU=Groups,OU=Network,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_netUsr01,OU=Users,OU=Network,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_netUsr02,OU=Users,OU=Network,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_netUsr01-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_netUsr02-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=SharedAccounts,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-Windows,OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-WindowsManagers,OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_winMgr01,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_winMgr02,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-WindowsAdmins,OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_winAdm01,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_winAdm02,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_winAdm01-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_winAdm02-p,OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrWin01,OU=SharedAccounts,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrWin02,OU=SharedAccounts,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-Helpdesk,OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-HelpdeskAdmins,OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_hlpdsk01,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_hlpdsk02,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrHlpdsk01,OU=SharedAccounts,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrHlpdsk02,OU=SharedAccounts,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-RemoteUser,OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-RemoteUserAdmins,OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_rmtUsr01,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_rmtUsr02,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrRemote01,OU=SharedAccounts,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrRemote02,OU=SharedAccounts,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-StdUser,OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-StdUserAdmins,OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_stdUsr01,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_stdUsr02,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrStdUsr01,OU=SharedAccounts,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_shrStdUsr02,OU=SharedAccounts,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb-ITManagers,OU=Groups,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_itmanager01,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_itmanager02,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_itmanager03,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
```
