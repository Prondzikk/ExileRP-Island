ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_barbershop:pay')
AddEventHandler('esx_barbershop:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeAccountMoney('money', Config.Price)
	TriggerClientEvent('FeedM:showNotification', _source, "Zapłaciłeś ~g~$"..Config.Price) 
end)


ESX.RegisterServerCallback('esx_barbershop:checkMoney', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= Config.Price then
		cb(true)
	else
		cb(false)
	end
end)
