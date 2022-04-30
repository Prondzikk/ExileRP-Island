ESX = nil

local b = 2500

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('basiuniasuki', function(source, cb, option, money)
	local xPlayer = ESX.GetPlayerFromId(source)

    if option == 'money' then
        if xPlayer.getMoney() >= b then
            xPlayer.removeMoney(b)
            TriggerClientEvent('esx:showNotification', source, 'Zapłaciłeś/aś ~g~'..b..'$~w~ za leczenie')
            cb(true)
        else
            cb(false)
        end
    elseif option == 'bank' then
        if xPlayer.getAccount('bank').money >= b then
            xPlayer.removeAccountMoney('bank', b)
            TriggerClientEvent('esx:showNotification', source, 'Zapłaciłeś/aś ~g~'..b..'$~w~ za leczenie')
            cb(true)
        else
            cb(false)
        end
    end
end)