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

Restart-computer -force