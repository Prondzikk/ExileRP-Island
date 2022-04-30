ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_society:registerSociety', 'fisherman', 'Lets Fish', 'society_fisherman', 'society_fisherman', 'society_fisherman', {type = 'public'})
local kurwa = false



local donttouchme = 'donttouchme:'..math.random(11111111,999999999)..':skidsgang'
local exile_fisherman = 'exile_fisherman:'..math.random(11111111,999999999)..':skidsgang'
local exile_fisherman2 = 'exile_fisherman2:'..math.random(11111111,999999999)..':skidsgang'
local exile_fisherman3 = 'exile_fisherman3:'..math.random(11111111,999999999)..':skidsgang'
local exile_fisherman4 = 'exile_fisherman4:'..math.random(11111111,999999999)..':skidsgang'
local exile_fisherman5 = 'exile_fisherman5:'..math.random(11111111,999999999)..':skidsgang'



local reviced = {}
local jnbikedfgbkjergboujkgrejkb = TriggerClientEvent

RegisterServerEvent('exile_fisherman:request')
AddEventHandler('exile_fisherman:request', function()
    local _source = source
    if not reviced[_source] then
        jnbikedfgbkjergboujkgrejkb("exile_fisherman:getrequest", _source, donttouchme, exile_fisherman, exile_fisherman2, exile_fisherman3, exile_fisherman4)
        reviced[_source] = true
    else
        
        exports.exile_logs:discord(source, "exile_fisherman:request", "request", true)
    end
end)

--fisherman:removeItem
RegisterServerEvent(exile_fisherman)
AddEventHandler(exile_fisherman, function(item, itemcount, token)
    local xPlayer = ESX.GetPlayerFromId(source)
    if token == donttouchme then
        xPlayer.removeInventoryItem(item, itemcount)
    else
        exports.exile_logs:discord(source, "exile_fisherman token ~= donttouchme", "request", true)
    end
end)

--exile_fisherman:additem
RegisterServerEvent(exile_fisherman2)
AddEventHandler(exile_fisherman2, function(item, itemcount, token)
    local xPlayer = ESX.GetPlayerFromId(source)
    if token == donttouchme then
        if item == "ryba" then 
            if xPlayer.getInventoryItem(item).count > 100 then
                TriggerClientEvent('~r~Nie możesz posiadać więcej ryb')
            else
                xPlayer.addInventoryItem(item, itemcount)
            end
        else
            xPlayer.addInventoryItem(item, itemcount)
        end
    else
        exports.exile_logs:discord(source, "exile_fisherman2 token ~= donttouchme", "request", true)
    end
end)

--fisherman:Marker
RegisterServerEvent(exile_fisherman3)
AddEventHandler(exile_fisherman3, function(zone, co, token)
    if token == donttouchme then
        if zone == 'SellFishes' and co == true then 
            kurwa = true 
        elseif zone ~= 'SellFishes' then 
            kurwa = false
        end
    else
        exports.exile_logs:discord(source, "exile_fisherman3 token ~= donttouchme", "request", true)
    end
end)

--exile_fishermansianko
RegisterServerEvent(exile_fisherman4)
AddEventHandler(exile_fisherman4, function(token)
    local kursy
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if token == donttouchme then
        local identifier = GetPlayerIdentifier(_source)
        local ranga = xPlayer.job.grade
        local wyplata = nil

        if ranga == 0 then
            wyplata = 50000
        elseif ranga == 1 then
            wyplata = 56000
        elseif ranga == 2 then
            wyplata = 57000
        elseif ranga == 3 then
            wyplata = 58000
        elseif ranga == 4 then
            wyplata = 59000
        elseif ranga == 5 then
            wyplata = 60000
        elseif ranga == 6 then
            wyplata = 61000
        elseif ranga == 7 then
            wyplata = 62000
        end

        local societyAccount
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_fisherman', function(account)
            societyAccount = account
        end)

        societyAccount.addMoney(wyplata / 2)

        local xvc;TriggerEvent('esx_addonaccount:getSharedAccount','society_police',function(cvb)xvc=cvb end)
        xvc.addMoney(wyplata / 100 * 15)

        xPlayer.removeInventoryItem('ryba', 100)
        xPlayer.addAccountMoney('money', wyplata)
        TriggerClientEvent('esx:showNotification', _source, 'Otrzymałeś wypłatę w wysokości ~g~$'..wyplata)
        exports.exile_logs:discord(source, "Otrzymał/a wypłatę w wysokości $"..wyplata, "fisherman", true)
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result)
            if result[1] ~= nil then
                local kursy = result[1].rybakkursy
                local kusrsiki = kursy + 1
                MySQL.Async.execute('UPDATE users SET rybakkursy = @kursy WHERE identifier = @identifier', {
                    ['@kursy']      = kusrsiki,
                    ['@identifier'] = identifier
                })
            end
        end)
    else
        exports.exile_logs:discord(source, "exile_fisherman4 token ~= donttouchme", "request", true)
    end
end)

ESX.RegisterUsableItem('wedka', function(source)
    TriggerClientEvent('fisherman:startFishing', source)
end)