ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_myjnia:canAfford', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.EnablePrice then
		if xPlayer.getMoney() >= Config.Price then
			xPlayer.removeMoney(Config.Price)
			cb(true)
		else
			cb(false)
		end
	else
		cb(true)
	end
end)