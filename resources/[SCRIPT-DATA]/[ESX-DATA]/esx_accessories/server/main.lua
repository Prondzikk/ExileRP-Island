ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_accessories:save')
AddEventHandler('esx_accessories:save', function(skin, accessory)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		
		store.set('has' .. string.lower(accessory), true)

		local itemSkin = {}
		local item1 = string.lower(accessory) .. '_1'
		local item2 = string.lower(accessory) .. '_2'
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]
		store.set('skin', itemSkin)
	end)
end)

ESX.RegisterServerCallback('esx_accessories:get', function(source, cb, accessory)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	----print("asdssst" .. tostring(accessory)) - DAFAQ IS THAT
	TriggerEvent('esx_datastore:getDataStore', 'user_' .. tostring(accessory), xPlayer.identifier, function(store)
		
		local hasAccessory = (store.get('has' .. accessory) and store.get('has' .. accessory) or false)
		local skin = (store.get('skin') and store.get('skin') or {})

		cb(hasAccessory, skin)
	end)
end)