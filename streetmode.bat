@echo off
setlocal

:: ── If already running elevated via scheduled task, do the work ─────
net session >nul 2>&1
if %errorlevel% equ 0 goto ELEVATED

:: ── Normal user: set brightness (needs user session), then run task ──
title ASUS ROG Flow Z - Street Mode
color 0A
echo.
echo  ================================================
echo   ASUS ROG Flow Z  -  Street Mode
echo  ================================================
echo.
echo  [1/5] Setting screen brightness to 20%%...
powershell -ExecutionPolicy Bypass -NoProfile -Command "$m = Get-CimInstance -Namespace root/WMI -ClassName WmiMonitorBrightnessMethods; Invoke-CimMethod -InputObject $m -MethodName WmiSetBrightness -Arguments @{Timeout=0; Brightness=[byte]20} | Out-Null"
echo        [OK] Brightness set to 20%%.
echo.
echo  Running admin steps via scheduled task (no UAC prompt)...
schtasks /Run /TN "ModeScripts\StreetMode" >nul 2>&1
echo  [OK] Street Mode activated.
echo.
timeout /t 2 /nobreak >nul
exit /b

:: ── Elevated section (runs via scheduled task) ───────────────────────
:ELEVATED
echo  [2/5] Activating Windows Silent power plan...
powercfg /setactive 64a64f24-65b9-4b56-befd-5ec1eaced9b3
echo        [OK] Silent power plan active.

echo  [3/5] Setting power button + lid to Shut-down...
powercfg /setacvalueindex 64a64f24-65b9-4b56-befd-5ec1eaced9b3 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3
powercfg /setdcvalueindex 64a64f24-65b9-4b56-befd-5ec1eaced9b3 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 3
powercfg /setacvalueindex 64a64f24-65b9-4b56-befd-5ec1eaced9b3 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 3
powercfg /setdcvalueindex 64a64f24-65b9-4b56-befd-5ec1eaced9b3 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 3
echo        [OK] Done.

echo  [4/5] Setting ASUS ROG performance mode to Silent...
powershell -ExecutionPolicy Bypass -NoProfile -Command ^
"try { $w = Get-WmiObject -Namespace 'root\WMI' -Class 'AsusAtkWmiInputMethod' -ErrorAction Stop; $w.DCTS(0x00120075, 0, [byte[]]@(0), 1) | Out-Null; Write-Host '       [OK] ASUS Silent mode activated.' } catch { Write-Host '       [!] WMI call failed:' $_.Exception.Message }"

echo  [5/5] Done.
