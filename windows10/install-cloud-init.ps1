Invoke-WebRequest -Uri https://cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi -OutFile ${env:SystemRoot}\Temp\cloudbaseinit.msi
cd ${env:SystemRoot}\Temp\
Start-Process "${env:SystemRoot}\System32\msiexec.exe" -ArgumentList "/i ${env:SystemRoot}\Temp\cloudbaseinit.msi /qn /l*v log.txt INJECTMETADATAPASSWORD='0'" -wait
$unattendedXmlPath = "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\conf\Unattend.xml"
Add-Content "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf" "metadata_services=cloudbaseinit.metadata.services.nocloudservice.NoCloudConfigDriveService"
