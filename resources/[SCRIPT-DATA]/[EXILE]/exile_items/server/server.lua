ESX 						   = nil
local PlayersHarvestingJablka    = {}
local PlayersTransformingJablka  = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function HarvestJablka(source)
	SetTimeout(Config.TimeToFarm, function()
		if PlayersHarvestingJablka[source] == true then
			local xPlayer  = ESX.GetPlayerFromId(source)
			local jablka = xPlayer.getInventoryItem('untransformed_apple')
			if jablka.limit ~= -1 and jablka.count >= jablka.limit then
				TriggerClientEvent('esx:showNotification', source, '~r~Masz już przy sobie wystarczająco jabłek do przetworzenia')
			else
				xPlayer.addInventoryItem('untransformed_apple', 1)
				HarvestJablka(source)
			end
		end
	end)
end

RegisterServerEvent('exile_items:startZbieranie')
AddEventHandler('exile_items:startZbieranie', function()
	local _source = source
	PlayersHarvestingJablka[_source] = true
	TriggerClientEvent('esx:showNotification', _source, '~b~Zbieranie...')
	HarvestJablka(_source)
end)

local function TransformJablka(source)
	SetTimeout(Config.TimeToFarm, function()
		if PlayersTransformingJablka[source] == true then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local unappleQuantity = xPlayer.getInventoryItem('untransformed_apple').count
			local appleQuantity = xPlayer.getInventoryItem('apple').count

			if appleQuantity > 100 then
				TriggerClientEvent('esx:showNotification', source, '~r~Masz już przy sobie wystarczająco jabłek')
			elseif unappleQuantity < 2 then
				TriggerClientEvent('esx:showNotification', source, '~r~Nie masz przy sobie wystarczająco jabłek do przetworzenia')
			else
				xPlayer.removeInventoryItem('untransformed_apple', 2)
				xPlayer.addInventoryItem('apple', 1)
				TransformJablka(source)
			end
		end
	end)
end

RegisterServerEvent('exile_items:startPrzetwarzanie')
AddEventHandler('exile_items:startPrzetwarzanie', function()
	local _source = source
	PlayersTransformingJablka[_source] = true
	TriggerClientEvent('esx:showNotification', _source, '~b~Przetwarzanie...')
	TransformJablka(_source)
end)

RegisterServerEvent('exile_items:getInventory')
AddEventHandler('exile_items:getInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('exile_items:returnInventory', 
		_source, 
		xPlayer.getInventoryItem('untransformed_apple').count, 
		xPlayer.getInventoryItem('apple').count, 
		xPlayer.job.name, 
		currentZone
	)
end)

RegisterServerEvent('exile_items:cancel')
AddEventHandler('exile_items:cancel', function()
	local _source = source
	PlayersHarvestingJablka[_source] = false
	PlayersTransformingJablka[_source] = false
end)