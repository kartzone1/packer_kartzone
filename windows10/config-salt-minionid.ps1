$filePath = 'c:\salt\conf\minion_id'
$tempFilePath = "$env:TEMP\$($filePath | Split-Path -Leaf)"
$find = 'packerimg'
$salthostname=[System.Net.Dns]::GetHostByName($env:computerName).HostName

(Get-Content -Path $filePath) -replace $find, $salthostname | Add-Content -Path $tempFilePath

Remove-Item -Path $filePath
Move-Item -Path $tempFilePath -Destination $filePath

Add-Content "C:\salt\conf\minion" "startup_states: highstate"
