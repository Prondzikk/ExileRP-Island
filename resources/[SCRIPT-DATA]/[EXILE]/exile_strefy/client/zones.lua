local IsTaking     = false
local ClosestZone  = nil

local Blips        = {}
local ActiveTimers = {}

RegisterNetEvent('kossek-zones:activeZone')
AddEventHandler('kossek-zones:activeZone', function(id, owner, data)
    ActiveTimers[data.name] = {
        timer = Config.Timer + 1,
        owner = owner,
        source = id
    }

    ESX.ShowNotification('Strefa ~b~' .. data.id .. ' ~w~jest aktualnie ~b~przejmowana!')
    TriggerEvent('kossek-zones:createBlip', data)
end)

RegisterNetEvent('kossek-zones:zoneTaken')
AddEventHandler('kossek-zones:zoneTaken', function(data, id, notify, job, owners)
    Config.Zones = owners

    ActiveTimers[Config.Prefix .. id] = nil

    ESX.ShowNotification('Strefa ~b~' .. id .. ' ~w~została przejęta przez ~b~' .. notify)
    TriggerEvent('kossek-zones:removeBlip', id)

    if job then
        if PlayerData.hiddenjob.name == job then
            ESX.ShowNotification('~g~Gratulacje ~w~przejęcia strefy! Na konto twojej organizacji wpadło ~g~$' .. Config.Rewards.money)
        end
    end
end)

RegisterNetEvent('kossek-zones:stopTaking')
AddEventHandler('kossek-zones:stopTaking', function(data, id)
    if id ~= nil then
        ActiveTimers[Config.Prefix .. id] = nil
        TriggerEvent('kossek-zones:removeBlip', id)
    end
end)

RegisterNetEvent('kossek-zones:createBlip')
AddEventHandler('kossek-zones:createBlip', function(data)
    blip = AddBlipForCoord(data.data.coords.x, data.data.coords.y, data.data.coords.z)

    SetBlipSprite(blip, Config.Blip['zones'].sprite)
    SetBlipColour(blip, Config.Blip['zones'].colour)
    SetBlipAlpha(blip, Config.Blip['zones'].alpha)
    SetBlipScale (blip, Config.Blip['zones'].scale)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(data.data.label)
    EndTextCommandSetBlipName(blip)

    table.insert(Blips, { blipID = blip, zoneID = data.id })
end)

RegisterNetEvent('kossek-zones:removeBlip')
AddEventHandler('kossek-zones:removeBlip', function(id)
    if next(Blips) then
        for i, info in pairs(Blips) do
            if info.zoneID == id then
                RemoveBlip(info.blipID)
                table.remove(Blips, i)
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)

        local sleep = true

        for zone, data in pairs(Config.Zones) do
            local dst = #(PlayerPos - data.coords)

            if dst < Config.Marker.draw then
                sleep = false
                ClosestZone = { id = zone, name = Config.Prefix .. zone, data = data }
            end
        end

        if sleep then
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if ClosestZone then
            local sleep = true
            local data  = ClosestZone.data

            local dst   = #(PlayerPos - data.coords)
            
            if dst < Config.Marker.draw then
                sleep = false

                DrawMarker(Config.Marker.type, data.coords.x, data.coords.y, data.coords.z, 0.0, 0.0, 0.0, Config.Marker.rotation.x, Config.Marker.rotation.y, Config.Marker.rotation.z, Config.Marker.size.x, Config.Marker.size.y, Config.Marker.size.z, Config.Marker.color.r, Config.Marker.color.g, Config.Marker.color.b, Config.Marker.color.a, false, true, 2)
                DrawText3D(data.coords.x, data.coords.y, data.coords.z + 0.6, 'Strefa ' .. ClosestZone.id .. ' ~b~| ~w~' .. ((data.owner_label and 'Przejęta przez: ~b~' .. data.owner_label) or 'Możliwa do ~b~przejęcia'))
                if dst < Config.Marker.size.x / 2 then
                    if not IsDead then
                        if not IsPedInAnyVehicle(PlayerPed, false) then
                            ESX.ShowHelpNotification('Naciśnij ~INPUT_PICKUP~ aby rozpocząć ~b~przejmowanie strefy')

                            if IsControlJustPressed(0, 38) then

                                ESX.TriggerServerCallback('kossek-zones:isTakenOver', function(required, can, allowed, next)
                                    if required then
                                        if not can and not allowed and not next then
                                            ESX.ShowNotification('~r~Nie możesz ponownie przejąć tej samej strefy!')
                                            return
                                        end

                                        if allowed then
                                            if can then
                                                IsTaking = true
                                                ESX.ShowNotification('~g~Rozpoczęto ~w~przejmowanie strefy! Opuszczenie strefy, badź smierć podczas przejmowania spowoduje ~r~anulowanie ~w~przejmowania strefy!')
                                                TriggerServerEvent('kossek-zones:startTakingOver', ClosestZone)
                                            else
                                                ESX.ShowNotification('~r~Ktoś aktualnie przejmuje tą strefe!')
                                            end
                                        else
                                            ESX.ShowNotification('Odczekaj ~b~' .. next .. ' ~w~sekund przed następnym przejęciem tej strefy!')
                                        end
                                    else
                                        ESX.ShowNotification('Wymagana liczba obywateli to ~b~' .. Config.RequiredPlayers .. ' ~w~aby rozpocząć przejmowanie strefy!')
                                    end
                                end, ClosestZone.name)
                            end
                        else
                            ESX.ShowNotification('~r~Wysiądź z pojazdu!')
                        end
                    end
                end
            end
        else
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if ClosestZone and (ActiveTimers[ClosestZone.name] and ActiveTimers[ClosestZone.name].timer) then
            local sleep = true
            local dst = #(PlayerPos - ClosestZone.data.coords)

            if dst < Config.Text3D.draw then
                sleep = false
                local format = nil

                if ActiveTimers[ClosestZone.name].timer <= Config.Timer and ActiveTimers[ClosestZone.name].timer >= 5 then
                    format = 'sekund'
                elseif ActiveTimers[ClosestZone.name].timer <= 4 and ActiveTimers[ClosestZone.name].timer >= 2 then
                    format = 'sekundy'
                else
                    format = 'sekunda'
                end

                DrawText3D(ClosestZone.data.coords.x, ClosestZone.data.coords.y, ClosestZone.data.coords.z + 0.4, 'Przejmowanie przez: ~b~' .. ActiveTimers[ClosestZone.name].owner .. ' ~w~| Pozostało: '.. ActiveTimers[ClosestZone.name].timer .. ' '.. format)
            end

            if sleep then
                Wait(500)
            end
        else
            Wait(500)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if next(ActiveTimers) then
            for zone, data in pairs(Config.Zones) do
                if ActiveTimers[Config.Prefix .. zone] and ActiveTimers[Config.Prefix .. zone].timer then
                    ActiveTimers[Config.Prefix .. zone].timer = ActiveTimers[Config.Prefix .. zone].timer - 1
                    
                    if ActiveTimers[Config.Prefix .. zone].timer <= 0 then
                        IsTaking = false
                        if ActiveTimers[Config.Prefix .. zone].source == GetPlayerServerId(PlayerId()) then
                            TriggerServerEvent('kossek-zones:zoneTaken', Config.Zones[zone], zone)
                        end

                        ActiveTimers[Config.Prefix .. zone] = nil
                    end

                    local dst = nil 
                    if ClosestZone then
                        dst = #(PlayerPos - ClosestZone.data.coords)
                    end

                    if IsTaking and (IsDead or dst and (dst > Config.Marker.size.x / 2)) then
                        ActiveTimers[ClosestZone.name] = nil
                        print(ClosestZone.name,zone,"ss")
                        IsTaking = false
                        ESX.ShowNotification('~r~Anulowano przejmowanie strefy!')
                        TriggerServerEvent('kossek-zones:stopTaking', Config.Zones[zone], zone)
                    end
                end
            end

            Wait(1000)
        else
            Wait(200)
        end
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Zones) do
        local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)

        SetBlipSprite(blip, v.blip.sprite)
        SetBlipColour(blip, v.blip.colour)
        SetBlipAsShortRange(blip, true)
        SetBlipDisplay(blip, 4)
        SetBlipShowCone(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(blip)
    end
end)