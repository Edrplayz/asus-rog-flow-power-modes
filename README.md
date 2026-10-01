# ASUS ROG Flow Z13 Power Mode Scripts

Automated power mode switching scripts for the **ASUS ROG Flow Z13 (2025)**. One-click shortcuts to switch between Street Mode, Home Mode, and Video Mode — no UAC prompts after initial setup.

---

## Modes

### Street Mode
For use on the go (battery saving).
- Power plan: `silent`
- Screen brightness: **20%**
- ASUS ROG performance mode: **Silent**
- Power button + Lid close: **Shut-down**

### Home Mode
For use at home (plugged in or light battery use).
- Power plan: `PD_silent`
- Screen brightness: **50%**
- ASUS ROG performance mode: **Silent**
- Power button + Lid close: **Shut-down**

### Video Mode
Prevents screen and sleep interruptions while watching video.
- Screen turn-off: **1 hour** (AC + battery)
- Sleep timeout: **1 hour** (AC + battery)
- Run Street Mode or Home Mode afterwards to restore normal timeouts.

---

## Requirements

- **ASUS ROG Flow Z13 (2025)** or similar ASUS ROG device running Windows 11
- Windows 11 with Modern Standby (S0 Low Power Idle)
- Administrator account
- ASUS Armoury Crate / ATK WMI drivers installed (for ASUS performance mode switching)

---

## Installation

### Step 1 — Clone or download the repo

```
git clone https://github.com/Edrplayz/asus-rog-flow-power-modes.git
```

Or download the ZIP from GitHub and extract it anywhere (e.g. your Desktop).

### Step 2 — Register the scheduled tasks (one-time, requires UAC once)

Right-click `register_tasks.ps1` → **Run with PowerShell**

This registers three background tasks in Windows Task Scheduler (`ModeScripts\StreetMode`, `ModeScripts\HomeMode`, `ModeScripts\VideoMode`) that run with admin privileges silently — **no UAC prompt** on every use after this.

> You will see one UAC prompt during this setup step only.

### Step 3 — Create desktop shortcuts (optional)

Right-click each `.bat` file → **Send to → Desktop (create shortcut)**

Or use the existing shortcuts if you cloned into the same path.

---

## How it works

Each `.bat` file has two sections:

1. **User section** — runs immediately as your normal account. Sets screen brightness (brightness control requires the user session, not admin).
2. **Elevated section** — triggered silently via the pre-registered scheduled task. Applies the power plan, power button/lid settings, and ASUS performance mode — no UAC prompt.

The brightness is set using `WmiMonitorBrightnessMethods` via CIM, which works on the internal ASUS panel.

The power plan and timeout changes use `powercfg` commands targeting both the classic and Modern Standby (S0ix) timeout GUIDs, which is required on Windows 11 devices with S0 Low Power Idle (like the ROG Flow Z13 2025).

---

## Files

| File | Description |
|---|---|
| `streetmode.bat` | Street Mode script |
| `homemode.bat` | Home Mode script |
| `videomode.bat` | Video Mode script |
| `set_brightness.ps1` | Brightness helper (called by bat files) |
| `register_tasks.ps1` | One-time setup — registers scheduled tasks |
| `task_street.xml` | Task Scheduler XML for Street Mode |
| `task_home.xml` | Task Scheduler XML for Home Mode |
| `task_video.xml` | Task Scheduler XML for Video Mode |

---

## Notes

- **Windows Update** may reset some power timeout values. Just re-run Video Mode if screen/sleep timeouts revert after an update.
- The scripts are hardcoded for the `wwwed` Windows user account in the task XML files. If your username is different, edit the `<UserId>` field in each `task_*.xml` before running `register_tasks.ps1`.
- Tested on ASUS ROG Flow Z13 2025 running Windows 11 with Modern Standby.
