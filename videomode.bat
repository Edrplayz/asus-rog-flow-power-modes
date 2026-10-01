@echo off
setlocal

:: ── If already running elevated via scheduled task, do the work ─────
net session >nul 2>&1
if %errorlevel% equ 0 goto ELEVATED

:: ── Normal user: trigger the scheduled task (no UAC prompt) ─────────
title ASUS ROG Flow Z - Video Mode
color 0D
echo.
echo  ================================================
echo   ASUS ROG Flow Z  -  Video Mode
echo  ================================================
echo.
echo  Running via scheduled task (no UAC prompt)...
schtasks /Run /TN "ModeScripts\VideoMode" >nul 2>&1
echo  [OK] Video Mode activated.
echo  Screen off: 1hr  ^|  Sleep: 1hr  (AC + Battery)
echo.
timeout /t 2 /nobreak >nul
exit /b

:: ── Elevated section (runs via scheduled task) ───────────────────────
:ELEVATED

:: Get active plan GUID
for /f "tokens=4 delims=: " %%G in ('powercfg /getactivescheme') do set PLAN=%%G

:: Classic /x commands (works on all plans)
powercfg /x monitor-timeout-ac 60
powercfg /x monitor-timeout-dc 60
powercfg /x standby-timeout-ac 60
powercfg /x standby-timeout-dc 60

:: Modern Standby display timeout (17aaa29b) - what Settings reads on S0ix devices
powercfg /setacvalueindex %PLAN% 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 3600
powercfg /setdcvalueindex %PLAN% 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 3600

:: Console lock display off timeout (8ec4b3a5) - battery screen off on this device
powercfg /setacvalueindex %PLAN% 7516b95f-f776-4464-8c53-06167f40cc99 8ec4b3a5-6868-48c2-be75-4f3044be88a7 3600
powercfg /setdcvalueindex %PLAN% 7516b95f-f776-4464-8c53-06167f40cc99 8ec4b3a5-6868-48c2-be75-4f3044be88a7 3600

:: Apply
powercfg /setactive %PLAN%
