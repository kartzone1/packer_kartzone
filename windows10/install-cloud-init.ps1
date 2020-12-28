Invoke-WebRequest -Uri https://cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi -OutFile ${env:SystemRoot}\Temp\cloudbaseinit.msi
cd ${env:SystemRoot}\Temp\
Start-Process "${env:SystemRoot}\System32\msiexec.exe" -ArgumentList "/i ${env:SystemRoot}\Temp\cloudbaseinit.msi /norestart /qn /l*v log.txt INJECTMETADATAPASSWORD='0'" -wait
Add-Content "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" "metadata_services=cloudbaseinit.metadata.services.nocloudservice.NoCloudConfigDriveService"
$file = "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init-unattend.conf"
$line = Get-Content $file | Select-String metadata_services | Select-Object -ExpandProperty Line
$content = Get-Content $file
$content | ForEach-Object {$_ -replace $line,"metadata_services=cloudbaseinit.metadata.services.nocloudservice.NoCloudConfigDriveService"} | Set-Content $file
Copy-Item "e:\config-salt-minionid.ps1" -Destination "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\LocalScripts"
