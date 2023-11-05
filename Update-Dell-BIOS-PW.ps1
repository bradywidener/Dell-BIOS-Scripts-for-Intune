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

#Check to see if a PW is set
$validate = get-item DellSmbios:\Security\IsAdminPasswordSet | select -expandproperty CurrentValue


#Put your old and new PW here. If there is no password set on the device, it will simply set the new PW.
#If there is a PW set, you need the old BIOS Password to be able to set a new one. It will use this 
$OldAdminPwd = 'OldBIOSPWHere'
$NewAdminPwd = 'NewBIOSPWHere'
if ($validate -eq "True"){
    Set-Item -Path DellSmbios:\Security\AdminPassword "$NewAdminPwd" -Password "$OldAdminPwd"
}
else{
    Set-Item -Path DellSmbios:\Security\AdminPassword "$NewAdminPwd"
}