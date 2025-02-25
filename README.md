# TestLab-in-AD
There are two Powershell scripts available. 
The first script will build a test lab with structure ready to be used in a PAM solution. The setup One Powershell script which will create an OU in AD containing several sub-OU, test users, reconcile users, and more.
The second script will show the content of an OU structure in a tree view.

## Create-TestLab

Run script to create TestLab structue in AD.</br>
The user running the script must have read/write permissions in AD.

```
.\Create-TestLab.ps1 -VendorName PAM-BeyondTrust -VendorPrefix bey
.\Create-TestLab.ps1 -VendorName PAM-Symantec -VendorPrefix sym
```

The two commands will create two OU structures for two different setups.
To avoid name colission in groups and users, use different VendorPrefix.

```
PS C:\Users\Administrator\Desktop> .\CreateTestLab.ps1 -VendorName PAM-CyberArk -VendorPrefix cyb
VERBOSE: Performing the operation "New" on target "OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=PersonalPrivilegedAccounts,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "OU=Groups,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
...
VERBOSE: Performing the operation "New" on target "CN=cyb_itmanager01,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_itmanager02,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
VERBOSE: Performing the operation "New" on target "CN=cyb_itmanager03,OU=Users,OU=Windows,OU=IT,OU=PAM-CyberArk,DC=vmware,DC=pam,DC=local".
```

## TreeView

This script will show the structure in a tree like view.

