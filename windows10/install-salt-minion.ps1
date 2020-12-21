Invoke-WebRequest -Uri https://winbootstrap.saltstack.com -OutFile C:\Windows\Temp\bootstrap-salt.ps1
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
C:\Windows\Temp\bootstrap-salt.ps1
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
Remove-Item C:\Windows\Temp\bootstrap-salt.ps1
