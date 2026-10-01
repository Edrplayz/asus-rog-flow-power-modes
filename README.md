# ASUS ROG Flow Z13 Power Mode Scripts

Automated power mode switching scripts for the **ASUS ROG Flow Z13 (2025)**. One-click shortcuts to switch between Street Mode, Home Mode, Video Mode, and instant Shutdown — no UAC prompts after initial setup.

> **Compatibility notice:** These scripts are designed specifically for ASUS ROG devices running Windows 11 with Modern Standby (S0 Low Power Idle). Some features (custom power plans, ASUS Silent mode) require ASUS Armoury Crate / ATK WMI drivers and will not work on non-ASUS hardware. The brightness control, video mode timeouts, and shutdown script will work on any Windows 11 laptop.

---

## Modes

### Street Mode
For use on the go (battery saving).
- Power plan: `silent` *(ASUS ROG only)*
- Screen brightness: **20%**
- ASUS ROG performance mode: **Silent** *(ASUS ROG only)*
- Power button + Lid close: **Shut-down**

### Home Mode
For use at home (plugged in or light battery use).
- Power plan: `PD_silent` *(ASUS ROG only)*
- Screen brightness: **50%**
- ASUS ROG performance mode: **Silent** *(ASUS ROG only)*
- Power button + Lid close: **Shut-down**

### Video Mode
Prevents screen and sleep interruptions while watching video.
- Screen turn-off: **1 hour** (plugged in + battery)
- Sleep timeout: **1 hour** (plugged in + battery)
- Run Street Mode or Home Mode afterwards to restore normal timeouts
- Works on any Windows 11 laptop

### Shutdown
Instantly shuts down the PC with no confirmation prompt.
- Works on any Windows PC

---

## Compatibility

| Feature | Any Windows 11 laptop | ASUS ROG only |
|---|---|---|
| Brightness control | ✅ | |
| Video Mode (screen/sleep timeouts) | ✅ | |
| Power button + lid = Shut-down | ✅ | |
| Instant shutdown script | ✅ | |
| Custom ASUS power plans (silent, PD_silent) | | ✅ |
| ASUS ROG Silent performance mode | | ✅ |

**Tested on:** ASUS ROG Flow Z13 2025 · Windows 11 · Modern Standby (S0 Low Power Idle)

If you are on a different ASUS ROG device the power plan GUIDs and Modern Standby timeout GUIDs may differ. Check your own plan GUIDs with `powercfg /list` and update the GUIDs in the bat files accordingly.

---

## Requirements

- Windows 11
- Administrator account (one-time setup only — no UAC prompts after)
- **For ASUS features:** Armoury Crate / ATK WMI drivers installed

---

## Installation

### Step 1 — Clone or download

```
git clone https://github.com/Edrplayz/asus-rog-flow-power-modes.git
```

Or download the ZIP from GitHub and extract it anywhere (e.g. your Desktop).

### Step 2 — Register the scheduled tasks (one-time setup)

Right-click `register_tasks.ps1` → **Run with PowerShell**

This registers three background tasks in Windows Task Scheduler that run with admin privileges silently — **no UAC prompt** on every use after this.

> You will see one UAC prompt during this setup step only.

### Step 3 — Create desktop shortcuts (optional)

Right-click each `.bat` file → **Send to → Desktop (create shortcut)**

---

## How it works

Each mode `.bat` file runs in two stages:

1. **User stage** — runs immediately as your normal account. Sets screen brightness (brightness control requires the user session, not an admin process).
2. **Admin stage** — triggered silently via a pre-registered Task Scheduler task. Applies the power plan, power button/lid settings, and ASUS performance mode with no UAC prompt.

The brightness is set via `WmiMonitorBrightnessMethods` using CIM, which works on internal laptop panels.

The power timeout changes use `powercfg /x` plus explicit Modern Standby GUID overrides, which is required on Windows 11 devices with S0 Low Power Idle (the Settings UI reads different registry keys than classic `powercfg` on these devices).

---

## Files

| File | Description | Works on |
|---|---|---|
| `streetmode.bat` | Street Mode | ASUS ROG |
| `homemode.bat` | Home Mode | ASUS ROG |
| `videomode.bat` | Video Mode (1hr screen/sleep) | Any Windows 11 |
| `shutdown.bat` | Instant shutdown | Any Windows |
| `set_brightness.ps1` | Brightness helper used by bat files | Any Windows 11 |
| `register_tasks.ps1` | One-time setup — registers scheduled tasks | Any Windows 11 |
| `task_street.xml` | Task Scheduler definition for Street Mode | ASUS ROG |
| `task_home.xml` | Task Scheduler definition for Home Mode | ASUS ROG |
| `task_video.xml` | Task Scheduler definition for Video Mode | Any Windows 11 |

---

## Notes

- **Windows Update** may reset some Modern Standby power timeout values. Just re-run Video Mode if screen/sleep timeouts revert after an update.
- If your Windows username or install path contains spaces, the paths in `register_tasks.ps1` will still work as it uses `$MyInvocation` to detect the folder automatically.
- The ASUS power plan GUIDs are unique to Armoury Crate installations. Run `powercfg /list` to find the GUIDs on your own device and update the bat files if they differ.
