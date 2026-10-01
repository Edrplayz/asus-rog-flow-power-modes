param([int]$Level = 50)
$m = Get-CimInstance -Namespace root/WMI -ClassName WmiMonitorBrightnessMethods
Invoke-CimMethod -InputObject $m -MethodName WmiSetBrightness -Arguments @{Timeout=0; Brightness=[byte]$Level} | Out-Null
