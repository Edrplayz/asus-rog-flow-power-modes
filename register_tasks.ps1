# Run this script once (right-click > Run with PowerShell) to register the scheduled tasks.
# You will see ONE UAC prompt. After that, no UAC prompts when running the mode scripts.

$folderPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$username   = $env:USERNAME

# Patch the XML files with your actual username and folder path
foreach ($file in @("task_street.xml","task_home.xml","task_video.xml")) {
    $full = Join-Path $folderPath $file
    $content = Get-Content $full -Raw -Encoding Unicode
    $content = $content -replace "YOURUSERNAME", $username
    $content = $content -replace "FOLDERPATH",   $folderPath
    $content | Set-Content $full -Encoding Unicode
}

# Register the tasks
schtasks /Create /TN "ModeScripts\StreetMode" /XML "$folderPath\task_street.xml" /F
schtasks /Create /TN "ModeScripts\HomeMode"   /XML "$folderPath\task_home.xml"   /F
schtasks /Create /TN "ModeScripts\VideoMode"  /XML "$folderPath\task_video.xml"  /F

Write-Host ""
Write-Host "All tasks registered. You can now run the mode scripts without UAC prompts."
pause
