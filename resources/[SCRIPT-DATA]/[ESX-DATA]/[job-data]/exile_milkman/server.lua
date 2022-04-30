ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_society:registerSociety', 'milkman', 'Milk Man', 'society_milkman', 'society_milkman', 'society_milkman', {type = 'public'})

local donttouchme = 'donttouchme:'..math.random(11111111,999999999)..':skidsgang'
local exile_milkman = 'exile_milkman:'..math.random(11111111,999999999)..':skidsgang'
local exile_milkman2 = 'exile_milkman2:'..math.random(11111111,999999999)..':skidsgang'

local reviced = {}
local jnbikedfgbkjergboujkgrejkb = TriggerClientEvent

RegisterServerEvent('exile_milkman:request')
AddEventHandler('exile_milkman:request', function()
    local _source = source
    if not reviced[_source] then
        jnbikedfgbkjergboujkgrejkb("exile_milkman:getrequest", _source, donttouchme, exile_milkman, exile_milkman2)
        reviced[_source] = true
    else
        exports.exile_logs:discord(source, "exile_milkman:request", "request", true)
    end
end)

--milkman:pay
RegisterServerEvent(exile_milkman)
AddEventHandler(exile_milkman, function(count, token)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if token == donttouchme then
        local item = xPlayer.getInventoryItem('milk_in_pail').count

        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_milkman', function(account)
            societyAccount = account
        end)

        local jobReward = nil
        local grade = xPlayer.job.grade

        if grade == 0 then
            jobReward = 5000
        elseif grade == 1 then
            jobReward = 5600
        elseif grade == 2 then
            jobReward = 5700
        elseif grade == 3 then
            jobReward = 5800
        elseif grade == 4 then
            jobReward = 5900
        elseif grade == 5 then
            jobReward = 6000
        elseif grade == 6 then
            jobReward = 6100
        elseif grade == 7 then
            jobReward = 6200
        end

        local jobReward = jobReward * count
      

        local societyAccount
        TriggerEvent('esx_addonaccount:getSharedAccount', 'society_milkman', function(account)
            societyAccount = account
        end)

        societyAccount.addMoney(jobReward / 2)

        local xvc;TriggerEvent('esx_addonaccount:getSharedAccount','society_police',function(cvb)xvc=cvb end)
        xvc.addMoney(jobReward / 100 * 15)

        xPlayer.removeInventoryItem('milk_in_pail', count)
        xPlayer.addMoney(jobReward)
        TriggerClientEvent('esx:showNotification', _source, 'Otrzymałeś wypłatę w wysokości ~g~$'..jobReward..'!')
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result)
            if result[1] ~= nil then
                local kursy = result[1].milkmankursy
                local kusrsiki = kursy + 1
                MySQL.Async.execute('UPDATE users SET milkmankursy = @kursy WHERE identifier = @identifier', {
                    ['@kursy']      = kusrsiki,
                    ['@identifier'] = identifier
                })
            end
        end)
        exports.exile_logs:discord(source, "Otrzymał/a wypłatę w wysokości $"..jobReward, "milkman", true)

    else
       exports.exile_logs:discord(source, "exile_milkman token ~= donttouchme", "request", true)
    end
end)

--milkman:CollectMilk
RegisterServerEvent(exile_milkman2)
AddEventHandler(exile_milkman2, function(token)
    local xPlayer = ESX.GetPlayerFromId(source)
    if token == donttouchme then
        xPlayer.addInventoryItem('milk_in_pail', 1)
    else
        exports.exile_logs:discord(source, "exile_milkman2 token ~= donttouchme", "request", true)
    end
end)