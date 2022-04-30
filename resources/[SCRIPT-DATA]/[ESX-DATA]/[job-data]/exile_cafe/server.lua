ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_society:registerSociety', 'kawiarnia', 'Bean Machine', 'society_kawiarnia', 'society_kawiarnia', 'society_kawiarnia', {type = 'public'})



local donttouchme = 'donttouchme:'..math.random(11111111,999999999)..':skidsgang'
local exile_cafe = 'exile_cafe:'..math.random(11111111,999999999)..':skidsgang'
local exile_cafe2 = 'exile_cafe2:'..math.random(11111111,999999999)..':skidsgang'
local exile_cafe3 = 'exile_cafe3:'..math.random(11111111,999999999)..':skidsgang'
local exile_cafe4 = 'exile_cafe4:'..math.random(11111111,999999999)..':skidsgang'
local exile_cafe5 = 'exile_cafe5:'..math.random(11111111,999999999)..':skidsgang'



local reviced = {}
local bvnvbvbvbnnvn = TriggerClientEvent

RegisterServerEvent('exile_cafe:request')
AddEventHandler('exile_cafe:request', function()
    local _source = source
    if not reviced[_source] then
        bvnvbvbvbnnvn("exile_cafe:getrequest", _source, donttouchme, exile_cafe, exile_cafe2, exile_cafe3, exile_cafe4, exile_cafe5)
        reviced[_source] = true
    else
        exports.exile_logs:discord(source, "exile_cafe:request", "request", true)
    end
end)





--exile_cafe:removeItemCount
-- RegisterServerEvent(exile_cafe)
-- AddEventHandler(exile_cafe, function(item, itemcount)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     xPlayer.removeInventoryItem(item, itemcount)
-- end)

--exile_cafe:giveItem
RegisterServerEvent(exile_cafe2)
AddEventHandler(exile_cafe2, function(item, token)
    local xPlayer = ESX.GetPlayerFromId(source)
    if token == donttouchme then
        xPlayer.addInventoryItem(item, 100)
    else
        exports.exile_logs:discord(source, "exile_cafe2 token ~= donttouchme", "request", true)
    end
end)

--exile_cafe:przygotowanie
RegisterServerEvent(exile_cafe3)
AddEventHandler(exile_cafe3, function(count, token)
    local xPlayer = ESX.GetPlayerFromId(source)
    if token == donttouchme then
        xPlayer.removeInventoryItem('ziarna', count)
        xPlayer.addInventoryItem('kawa2', 15)
    else
        exports.exile_logs:discord(source, "exile_cafe3 token ~= donttouchme", "request", true)
    end
end)

--exile_cafe:stopPickup
RegisterServerEvent(exile_cafe4)
AddEventHandler(exile_cafe4, function(zone, token)
    if token == donttouchme then
        TriggerClientEvent('exile_cafe:Cancel', source)
    else
        exports.exile_logs:discord(source, "exile_cafe4 token ~= donttouchme", "request", true)
    end
end)

--exile_cafe:sell
RegisterServerEvent(exile_cafe5)
AddEventHandler(exile_cafe5, function(count, token)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if token == donttouchme then

        if count > 15 then
            exports.exile_logs:discord(_source, "Sprzedał/a więcej niż 15 zabezpieczonych kaw", "protect", true)
        end

        local jobReward = nil
        local grade = xPlayer.job.grade

        if grade == 0 then
            jobReward = 3300
        elseif grade == 1 then
            jobReward = 3700
        elseif grade == 2 then
            jobReward = 3800
        elseif grade == 3 then
            jobReward = 3900
        elseif grade == 4 then
            jobReward = 4000
        elseif grade == 5 then
            jobReward = 4100
        elseif grade == 6 then
            jobReward = 4300
        elseif grade == 7 then
            jobReward = 4400
        end

        local jobReward = jobReward * count
 
        local societyAccount
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_kawiarnia', function(account)
            societyAccount = account
        end)

        local xvc;TriggerEvent('esx_addonaccount:getSharedAccount','society_police',function(cvb)xvc=cvb end)
        xvc.addMoney(jobReward / 100 * 15)

        societyAccount.addMoney(jobReward / 2)
        xPlayer.addMoney(jobReward)
        xPlayer.removeInventoryItem('kawa2', count)
        TriggerClientEvent('esx:showNotification',_source, 'Otrzymałeś wypłatę w wysokości ~g~$'..jobReward..'!')
        
        exports.exile_logs:discord(_source, "Otrzymał/a wypłatę w wysokości $"..jobReward, "cafe", true)
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
            ['@identifier'] = GetPlayerIdentifier(_source)
        }, function(result)
            if result[1] ~= nil then
                local kursy = result[1].kawiarniakursy
                local kusrsiki = kursy + 1
                MySQL.Async.execute('UPDATE users SET kawiarniakursy = @kursy WHERE identifier = @identifier', {
                    ['@kursy']      = kusrsiki,
                    ['@identifier'] = GetPlayerIdentifier(_source)
                })
            end
        end)
    else
        exports.exile_logs:discord(_source, "exile_cafe5 token ~= donttouchme", "request", true)
    end
end)
