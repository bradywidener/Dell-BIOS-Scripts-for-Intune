#See if the DellBIOSProvider module is installed and import it
set-executionpolicy bypass
if (Get-Module -ListAvailable -Name DellBIOSProvider) {
    Import-Module DellBIOSProvider -verbose
} 
else {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module DellBIOSProvider -Force
    Import-Module DellBIOSProvider -verbose
}

#Set BIOS PW
$NewAdminPwd = 'StrongBIOSPWHere'
Set-Item -Path DellSmbios:\Security\AdminPassword "$NewAdminPwd"