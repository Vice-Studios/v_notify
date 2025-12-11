# v_notify — Custom FiveM Notification System
<img width="342" height="471" alt="image" src="https://github.com/user-attachments/assets/aeee804a-6ac8-45c0-b10b-da711aede562" />

A modern notification system for FiveM using FontAwesome icons, smooth animations, stacking limits, and per-notification sounds.

---

## Features

- SVG-based notification backgrounds  
- 4 notification types: **success**, **error**, **warning**, **info**  
- Custom titles & FontAwesome icons  
- Per-type sound effects  
- Auto-remove with animations  
- Notification stacking with configurable limit  
- Configurable through `config.lua`  

---

## Client Usage

### Standard Notification
```lua
exports['v_notify']:notify(
    "success",                      -- notification type
    "This is a notification!",      -- message
    4000,                           -- duration (ms)
    "Success Title"                 -- optional custom title
)
```
### Error Example
```lua
exports['v_notify']:notify(
    "error",
    "Something went wrong!",
    5000,
    "Error"
)
```

### Warning Example
```lua
exports['v_notify']:notify(
    "warning",
    "This is a warning message!",
    4000,
    "Warning"
)
```

## Server Usage
```lua
TriggerClientEvent('v_notify:notify', targetPlayerId,
    "info",
    "Welcome to the server!",
    4000,
    "Information"
)
```

### Send Error From Server
```lua
TriggerClientEvent('v_notify:notify', targetPlayerId,
    "error",
    "You lack permissions!",
    4500,
    "Access Denied"
)
```

---

## Configuration (`config.lua`)

```lua
Config = {}

-- Default duration for notifications (ms)
Config.DefaultDuration = 4000

-- Max visible notifications at once
Config.MaxNotifications = 5

-- Icon mapping (FontAwesome classes)
Config.Icons = {
    success = "fa-solid fa-circle-check",
    error   = "fa-solid fa-circle-xmark",
    warning = "fa-solid fa-triangle-exclamation",
    info    = "fa-solid fa-circle-info"
}
```
---
## Installation
1. Download or clone this repository
2. Place the folder v_notify into your `resources/` directory
3. Add the following to your `server.cfg`:
```lua
ensure v_notify
```

---
Needs help? Join our [discord](https://discord.gg/YkcxmA2a8s). 
