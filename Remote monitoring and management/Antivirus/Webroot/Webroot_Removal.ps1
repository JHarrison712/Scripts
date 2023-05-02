# Author: John Harrison
# Creation Date: 5/1/2023
# Last Modified Date: N/A
# File Name: Webroot_Removal.PS1
# Description: This script purpose is to remove Webroot from the workstation.
#
#
#
#
#

Stop-Service WRCoreService
sleep 1
Stop-Service WKSkyClient
sleep 1
Stop-Service WRSVC
sleep 1

$Folder = 'C:\Program Files\Webroot'

if (Test-Path -Path $Folder) {
Start-Process 'C:\Program Files\Webroot\WRSA.exe' -ArgumentList '-uninstall'
}

$Folder = 'C:\Program Files (x86)\Webroot'

if (Test-Path -Path $Folder) {
Start-Process 'C:\Program Files (x86)\Webroot\WRSA.exe' -ArgumentList '-uninstall'
}



while($WRSA){
$WRSA = Get-Process -Name WRSA
sleep 5
}

Write-host "Webroot uninstalled"

Remove-Item –path 'C:\Program Files (x86)\Webroot' –recurse
sleep 1
Remove-Item –path 'C:\programdata\WRData' –recurse
sleep 1
Remove-Item –path 'C:\programdata\WRCore' –recurse
sleep 1
Remove-Item -path 'C:\Program Files\Webroot' -recurse
sleep 1

Restart-computer -force