ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('LSC:garages')
AddEventHandler('LSC:garages', function()
	TriggerClientEvent('LSC:lock',-1,exports['esx_scoreboard']:CounterPlayers("mechanik"))
end)

AddEventHandler('playerDropped', function()
	TriggerClientEvent('LSC:lock',-1,exports['esx_scoreboard']:CounterPlayers("mechanik"))
end)

RegisterServerEvent('LSC:refreshOwnedVehicle')
AddEventHandler('LSC:refreshOwnedVehicle', function(myCar)
	MySQL.Async.execute('UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE `plate` = @plate',
	{
		['@plate']   = myCar.plate,
		['@vehicle'] = json.encode(myCar)
	})
end)

RegisterServerEvent("LSC:accept")
AddEventHandler("LSC:accept", function(name, button)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	mymoney = tonumber(button.price)
	if button.price then
		if button.price < xPlayer.getMoney() then
			TriggerClientEvent("LSC:accept", source, name, button)
			xPlayer.removeMoney(button.price)
		else
			TriggerClientEvent('LSC:cancel', _source, name, button.price)
		end
	end
end)