ESX = nil
local playersHealing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_ambulancejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	cb({
	  items = items
	})
end)

ESX.RegisterServerCallback('esx_ambulancejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
	  cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()
	local _source = source
	exports.exile_logs:discord(_source, 'CHEATER KURWA CHEATER HALO @everyone', 'protect', true)
end)


RegisterServerEvent('esx_ambvlancejob:revive')
AddEventHandler('esx_ambvlancejob:revive', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(target)
	if xPlayer.job.name == 'ambulance' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('esx_ambvlancejob:revive', xTarget.source)
		exports.exile_logs:discord(_source, 'Ożywił/a gracza ['..xTarget.source..'] '..xTarget.name..' | '..xTarget.identifier, 'revivemedyk', true)
	else
		exports.exile_logs:discord(_source, 'esx_ambvlancejob:revive '..target, 'protect', true)
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
		exports.exile_logs:discord(source, 'Dał/a plaster dla ['..xTarget.source..'] '..xTarget.name..' | '..xTarget.identifier, 'revivemedyk', true)
	else
		exports.exile_logs:discord(source, 'esx_ambulancejob:heal '..target, 'protect', true)
	end
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	else
		exports.exile_logs:discord(source, 'esx_ambulancejob:putInVehicle '..target, 'protect', true)
	end
end)

RegisterServerEvent('esx_ambulancejob:putOutVehicle')
AddEventHandler('esx_ambulancejob:putOutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putOutVehicle', target)
	else
		exports.exile_logs:discord(source, 'esx_ambulancejob:putOutVehicle '..target, 'protect', true)
	end
end)


RegisterServerEvent('esx_ambulancejob:putStockItems')
AddEventHandler('esx_ambulancejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
      		inventory.addItem(itemName, count)
			exports.exile_logs:discord(source, 'Włożył/a do szafki '..count..'x '..inventoryItem.label..' ['..itemName..']', 'szafkamedyk', true)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('odklada', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('zla_ilosc'))
		end
	end)
end)

RegisterServerEvent('esx_ambulancejob:getStockItem')
AddEventHandler('esx_ambulancejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	if xPlayer.job.name == 'ambulance' or  xPlayer.job.name == 'offambulance' then
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
			local inventoryItem = inventory.getItem(itemName)

			if count > 0 and inventoryItem.count >= count then
				if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('zla_ilosc'))
				else
					inventory.removeItem(itemName, count)
					xPlayer.addInventoryItem(itemName, count)
					exports.exile_logs:discord(source, 'Wyjął/ęła z szafki '..count..'x '..inventoryItem.label..' ['..itemName..']', 'szafkamedyk', true)
					TriggerClientEvent('esx:showNotification', _source, _U('zabral', count, inventoryItem.label))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('zla_ilosc'))
			end
		end)
	else
		exports.exile_logs:discord(_source, 'esx_ambulancejob:getStockItem', 'protect', true)
	end
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)
TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	ESX.SavePlayers()
	cb()
end)

RegisterServerEvent('CUSTOM_esx_ambulance:requestCPR')
AddEventHandler('CUSTOM_esx_ambulance:requestCPR', function(target, playerheading, playerCoords, playerlocation)
    --print(target)
    TriggerClientEvent("CUSTOM_esx_ambulance:playCPR", target, playerheading, playerCoords, playerlocation)
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	if price == 0 then
		--print(('esx_ambulancejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
			['@owner'] = xPlayer.identifier,
			['@vehicle'] = json.encode(vehicleProps),
			['@plate'] = vehicleProps.plate,
			['@type'] = type,
			['@job'] = xPlayer.job.name,
			['@stored'] = true
		}, function (rowsChanged)
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				--print(('esx_ambulancejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end
end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end
	return 0
end

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end
end)

RegisterServerEvent('esx_ambulancejob:odbierzsygnal')
AddEventHandler('esx_ambulancejob:odbierzsygnal', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local telefon = xPlayer.getInventoryItem('phone').count
	if telefon > 0 then
		Citizen.Wait(100)
		TriggerClientEvent('esx_ambulancejob:sygnal', _source)
	else
		TriggerClientEvent('esx:showNotification', _source, '~r~Nie posiadasz telefonu')
	end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	if xPlayer.job.name ~= 'ambulance' then
		exports.exile_logs:discord(_source, 'esx_ambulancejob:giveItem', 'protect', true)
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage' and itemName ~= 'leki' and itemName ~= 'gps' and itemName ~= 'radio' and itemName ~= 'stungun' and itemName ~= 'bodycam') then
		exports.exile_logs:discord(_source, 'esx_ambulancejob:giveItem', 'protect', true)
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end

	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)

RegisterCommand('revive', function(source, args, user)
	if source == 0 then
		if args[1] ~= nil then
			if GetPlayerName(tonumber(args[1])) ~= nil then
				print('Dałeś revive dla ['..args[1]..'] '..GetPlayerName(args[1]))
				TriggerClientEvent('esx_ambvlancejob:revive', tonumber(args[1]), true)
				TriggerClientEvent('esx:showNotification', tonumber(args[1]), 'Otrzymałeś revive od ~y~console')
			end
		else
			print("wpisz id garbaty")
		end
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		if (xPlayer.group == 'superadmin' or xPlayer.group == 'admin' or xPlayer.group == 'moderator' or xPlayer.group == 'support' or xPlayer.group == 'trialsupport') then
			if args[1] ~= nil then
				if GetPlayerName(tonumber(args[1])) ~= nil then
					local nazwa = xPlayer.getName(source)
					exports.exile_logs:discord(source, '/revive '..tostring(args[1]), 'revivekomenda', true)
					TriggerClientEvent('esx:showNotification', source, 'Dałeś revive dla ~y~'..tonumber(args[1]))
					TriggerClientEvent('esx_ambvlancejob:revive', tonumber(args[1]), true)
					TriggerClientEvent('esx:showNotification', tonumber(args[1]), 'Otrzymałeś revive od ~y~' ..nazwa)
				end
			else
				exports.exile_logs:discord(source, '/revive '..source, 'revivekomenda', true)
				TriggerClientEvent('esx_ambvlancejob:revive', source, true)
			end
		end
	end
end, false)

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		cb(isDead)
	end)
end)

RegisterNetEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(take)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Sync.execute('UPDATE users SET is_dead = @is_dead WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
		['@is_dead'] = take
	})
end)

RegisterServerEvent('esx_ambulancejob:firstSpawn')
AddEventHandler('esx_ambulancejob:firstSpawn', function()
	local _source    = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier=@identifier',
	{
		['@identifier'] = xPlayer.identifier
	}, function(isDead)
		if isDead then
			TriggerClientEvent('esx_ambulancejob:requestDeath', _source)
		end
	end)
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname']
		}
	else
		return nil
	end
end