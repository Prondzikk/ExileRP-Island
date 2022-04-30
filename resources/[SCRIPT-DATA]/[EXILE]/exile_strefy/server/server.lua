ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local TakeOver     = {}
local LastTaken    = {}
local ActiveZones  = {}

local TakingPeople = {}

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM exile_zones', {}, function(result)
        if next(result) then
            for i, data in pairs(result) do
                if data.taken then
                    LastTaken[data.name] = data.taken
                end

                if data.owner or data.label then
                    local id = string.gsub(data.name, 'zone_', '')
                    Config.Zones[tonumber(id)].owner_label = data.label
                end
            end
        end
    end)
end)

ESX.RegisterServerCallback('kossek-zones:getData', function(source, cb)
    cb(Config.Zones)
end)

ESX.RegisterServerCallback('kossek-zones:isTakenOver', function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    if GetNumPlayerIndices() >= Config.RequiredPlayers then
        local zoneID = string.gsub(id, 'zone_', '')

        zoneID = tonumber(zoneID)
        if Config.Zones[zoneID].owner_label and (Config.Zones[zoneID].owner_label == xPlayer.hiddenjob.label) or (Config.Zones[zoneID].owner_label == GetPlayerData(xPlayer.identifier)) then
            cb(true, false, false, false)
            return
        end

        local canStart   = true
        local nextAttack = nil
        local time       = LastTaken[id]

        if time then
            if (os.time() - time) < Config.TimeBeforeNextTake then
                canStart = false
                nextAttack = Config.TimeBeforeNextTake - (os.time() - time)
            end
        end
        
        if next(TakeOver) then
            if TakeOver[id] then
                cb(true, false, canStart, nextAttack)
            else
                if canStart then
                    TakeOver[id] = true
                    TakingPeople[source] = id
                end
                cb(true, true, canStart, nextAttack)
            end
        else
            if canStart then
                TakeOver[id] = true
                TakingPeople[source] = id
            end
            cb(true, true, canStart, nextAttack)
        end
    else
        cb(false, false, false, false)
    end
end)

RegisterServerEvent('kossek-zones:startTakingOver')
AddEventHandler('kossek-zones:startTakingOver', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local wait   = false

    MySQL.Async.fetchAll('SELECT owner FROM exile_zones WHERE name = @name', {
		['@name'] = data.name
    }, function(result)
        if next(result) then
            local owner = result[1].owner

            if not ESX.DoesJobExist(owner, 0) then
                local xPlayer = ESX.GetPlayerFromIdentifier(owner)

                if xPlayer then
                    xPlayer.showNotification('Strefa ~b~' .. data.id .. ' ~w~należąca do ~b~Ciebie ~w~jest aktualnie ~b~przejmowana!')
                    xPlayer.triggerEvent('kossek-zones:createBlip', data)
                end
                wait = true
            else
                wait = true
            end
        else
            wait = true
        end
    end)

    while not wait do
        Wait(50)
    end

    if xPlayer.hiddenjob.name == 'unemployed' then
        suczki = GetPlayerData(xPlayer.identifier)
    else
        suczki = xPlayer.hiddenjob.label
    end

    TriggerClientEvent('kossek-zones:activeZone', -1, _source, suczki, data)
end)

RegisterServerEvent('kossek-zones:zoneTaken')
AddEventHandler('kossek-zones:zoneTaken', function(data, id)
    TakeOver[Config.Prefix .. id] = nil
    TakingPeople[source]          = nil

    local xPlayer = ESX.GetPlayerFromId(source)
 
    if xPlayer.hiddenjob.name ~= 'unemployed' then
        suki = xPlayer.hiddenjob.name
        sukidata = xPlayer.hiddenjob.label
    else
        suki = xPlayer.identifier
        sukidata = GetPlayerData(xPlayer.identifier)
    end

    MySQL.Async.fetchAll('SELECT owner FROM exile_zones WHERE name = @name', {
		['@name'] = Config.Prefix .. id
    }, function(result)
        if not result[1] then
            MySQL.Async.execute('INSERT INTO exile_zones (name, owner, label, taken) VALUES (@name, @owner, @label, @taken)', {
                ['@name'] = Config.Prefix .. id,
                ['@owner'] = suki,
                ['@label'] = sukidata,
                ['@taken']  = os.time()
            })
        else
            MySQL.Async.execute('UPDATE exile_zones SET owner = @owner, label = @label, taken = @taken WHERE name = @name', {
                ['@name'] = Config.Prefix .. id,
                ['@owner'] = suki,
                ['@label'] = sukidata,
                ['@taken'] = os.time()
            })
        end
    end)

    if xPlayer.hiddenjob.name ~= 'unemployed' then
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. xPlayer.hiddenjob.name, function(account)
            account.addMoney(Config.Rewards.money)
        end)
    else
        xPlayer.addMoney(Config.Rewards.money)
        xPlayer.showNotification('Otrzymałeś/aś $' .. Config.Rewards.money .. ' za przejęcie strefy!')
    end

    local szansa = math.random(1,3)

    if szansa == 1 then
        xPlayer.addInventoryItem("vintagepistol", 3)
        xPlayer.addInventoryItem("snspistolmk2", 2)
    elseif szansa == 2 then
        xPlayer.addInventoryItem("vintagepistol", 2)
        xPlayer.addInventoryItem("snspistolmk2", 2)
        xPlayer.addInventoryItem("ceramicpistol", 1)
    elseif szansa == 3 then
        xPlayer.addInventoryItem("vintagepistol", 2)
        xPlayer.addInventoryItem("snspistolmk2", 1)
        xPlayer.addInventoryItem("ceramicpistol", 2)
    end

    xPlayer.addInventoryItem("kawa", math.random(4,10))
    xPlayer.addInventoryItem("pistol_ammo", math.random(150,500))


    LastTaken[Config.Prefix .. id] = os.time()
    exports.exile_logs:discord(source, 'Przejął/ęła strefę '..Config.Prefix..""..id, 'strefy', true)
    Config.Zones[tonumber(id)].owner_label = sukidata
    TriggerClientEvent('kossek-zones:zoneTaken', -1, data, id, sukidata, suki, Config.Zones)
end)

RegisterServerEvent('kossek-zones:stopTaking')
AddEventHandler('kossek-zones:stopTaking', function(data, id)
    TakeOver[Config.Prefix .. id] = nil

    TriggerClientEvent('kossek-zones:stopTaking', -1, data, id)
end)

GiveRewards = function()
    MySQL.Async.fetchAll('SELECT owner FROM exile_zones', {}, function(results)
        if next(results) then
            for _, data in ipairs(results) do
                if ESX.DoesJobExist(data.owner, 0) then
                    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. data.owner, function(account)
                        account.addMoney(Config.Rewards.money)
                    end)

                    local Players = ESX.GetPlayers()

                    for i=1, #Players, 1 do
                        local xPlayer = ESX.GetPlayerFromId(Players[i])
                        if xPlayer.hiddenjob.name == data.owner then
                            xPlayer.showNotification('Na konto twojej organizacji wpadło ~g~$' .. Config.Rewards.money .. ' ~w~za przejętą strefę!')
                        end
                    end
                else
                    local xPlayer = ESX.GetPlayerFromIdentifier(data.owner)
                    if xPlayer then
                        xPlayer.addMoney(Config.Rewards.money)
                        xPlayer.showNotification('Otrzymałeś ~g~$' .. Config.Rewards.money .. ' ~w~za przejętą przez Ciebie strefę!')
                    end
                end
            end
        end
    end)
end

GetPlayerData = function(identifier)
    local found = false

    local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    })

    local data = result[1]

    found = data.firstname .. ' ' .. data.lastname

    return found
end

for _, data in pairs(Config.Rewards.times) do
    TriggerEvent('cron:runAt', data.hour, data.minute, GiveRewards)
end

AddEventHandler('playerDropped', function()
    if TakingPeople[source] then
        local what = TakingPeople[source]
        local id = string.gsub(what, 'zone_', '')
        TakeOver[what] = nil
        TriggerClientEvent('kossek-zones:stopTaking', -1, id)
    end
end)