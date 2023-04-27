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

Stop-Service WRCoreService
sleep 1
Stop-Service WKSkyClient
sleep 1
Stop-Service WRSVC
sleep 1

Remove-Item –path 'C:\Program Files (x86)\Webroot' –recurse
sleep 1
Remove-Item –path 'C:\programdata\Webroot' –recurse
sleep 1
Remove-Item -path 'C:\Program Files\Webroot' -recurse
sleep 1

Restart-computer -force