Invoke-WebRequest -UseBasicParsing https://cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi -OutFile C:\Windows\Temp\cloudbaseinit.msi
msiexec /i C:\Windows\Temp\cloudbaseinit.msi.msi /qn /l*v log.txt
Remove-Item C:\Windows\Temp\cloudbaseinit.msi.msi
