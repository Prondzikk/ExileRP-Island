CreateThread(function()
    local eventName = ('drugs:'..math.random(1000,9999)..'-'..math.random(1000,9999))
    RegisterNetEvent(eventName)
    AddEventHandler(eventName, function(serverConfig)
        Config.Zones = serverConfig
    end)
    TriggerServerEvent('drugs:registerClient', eventName)
    Wait(15)
end)