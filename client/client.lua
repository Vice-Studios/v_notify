local DEFAULT_DURATION = Config.DefaultDuration or 4000

local function SendNotification(type, message, duration, title)
    SendNUIMessage({
        action = "notify",
        type = type or "info",
        message = message or "",
        duration = duration or DEFAULT_DURATION,
        title = title,
        icon = Config.Icons[type or "info"]
    })
end

CreateThread(function()
    Wait(100)
    SendNUIMessage({
        action = "config",
        limit = Config.MaxNotifications or 5,
        position = Config.Position or "top-right",
        soundVolume = Config.SoundVolume or 0.35
    })
end)

function notify(type, message, duration, title)
    SendNotification(type, message, duration, title)
end

exports('notify', notify)

RegisterNetEvent('v_notify:notify', function(type, message, duration, title)
    SendNotification(type, message, duration, title)
end)

RegisterCommand("ntest", function()
    notify("success", "Success!", 4000)
    Wait(500)
    notify("error", "Error occurred!", 4000)
    Wait(500)
    notify("warning", "Watch out!", 4000)
    Wait(500)
    notify("info", "This is a long notify example that should ellipsis cleanly but if it doesn't well", 4000)
end)
