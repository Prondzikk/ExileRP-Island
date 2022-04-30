
ESX 						   = nil
local PlayersHarvesting		   = {}
local PlayersTransforming	   = {}
local RequiredPeople = 1
local TimeToFarm = 15000
local TimeToProcess = 30000

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
CreateThread(function()
    while xPlayer == nil do
        Citizen.Wait(100)
    end
end)

local function Harvest(source, name)
	SetTimeout(TimeToFarm, function()
		if PlayersHarvesting[source] == true then
			local xPlayer  = ESX.GetPlayerFromId(source)
			local item = xPlayer.getInventoryItem(name)
			if item.limit ~= -1 and item.count >= 116 then
				TriggerClientEvent('esx:showNotification', source, 'Nie możesz już zbierać, Twój ekwipunek jest ~r~pełen~s~')
			else
				exports.exile_logs:discord(source, "esx_drugs Harvest: "..name, "esxdrugs", false)
				xPlayer.addInventoryItem(name, 10)
				Harvest(source, name)
			end
		else
			return
		end
	end)
end
RegisterServerEvent(GetCurrentResourceName() .. ':pickup')
AddEventHandler(GetCurrentResourceName() .. ':pickup', function(name)
	local _source = source
	PlayersHarvesting[_source] = true
	TriggerClientEvent('esx:showNotification', _source, '~y~Zbieranie w trakcie~s~...')
	Harvest(_source, name)
end)

RegisterServerEvent(GetCurrentResourceName() .. ':stopPickup')
AddEventHandler(GetCurrentResourceName() .. ':stopPickup', function(zone)
	local _source = source
	PlayersHarvesting[_source] = false
end)

local function Transform(source, name, name2)
	SetTimeout(TimeToProcess, function()
		if PlayersTransforming[source] == true then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			local pooch = xPlayer.getInventoryItem(name2..'_pooch')
			local itemQuantity = xPlayer.getInventoryItem(name).count
			local poochQuantity = xPlayer.getInventoryItem(name2..'_pooch').count
			if pooch.limit ~= -1 and poochQuantity >= 21 and itemQuantity >= 25 then
				TriggerClientEvent('esx:showNotification', source, '~r~Masz zbyt wiele woreczków!')
			elseif itemQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, 'Nie masz wystarczająco narkotyku, aby go ~r~przetworzyć~s~')
			else
				exports.exile_logs:discord(source, "esx_drugs Transform: "..name..", "..name2, "esxdrugs", false)
				xPlayer.removeInventoryItem(name, 25)
				xPlayer.addInventoryItem(name2 .. '_pooch', 5)
				Transform(source, name, name2)
			end
		else
			return
		end
	end)
end

RegisterServerEvent(GetCurrentResourceName() .. ':transform')
AddEventHandler(GetCurrentResourceName() .. ':transform', function(name, name2)
	local _source = source
	PlayersTransforming[_source] = true
	TriggerClientEvent('esx:showNotification', _source, '~y~Przetwarzanie w trakcie~s~...')
	Transform(_source, name, name2)
end)

RegisterServerEvent(GetCurrentResourceName() .. ':stopTransform')
AddEventHandler(GetCurrentResourceName() .. ':stopTransform', function(zone)
	local _source = source
	PlayersTransforming[_source] = false
end)

local AuthorizedClients = {}

local Zones = {

	--- METH ---

    MethField = {
		x = 157.42, y = 3130.6, z = 43.58 - 0.90,
        name = "Pole metamfetaminy",
        db_item = "meth",
        sprite = 499,
        color = 26
    },
    MethProcessing = {
		x = 1899.9, y = 4924.84, z = 48.8 - 0.90,
        name = "Przetwarzanie metamfetaminy",
        required = "meth",
        db_item = "meth_pooch",
        sprite = 499,
        color = 26
    },

	--- WEED ---

    -- WeedField = {
    --     x = 2222.51, y = 5576.95, z = 53.83 - 0.90,
    --     name = "Pole marihuany",
    --     db_item = "weed",
    --     sprite = 499,
    --     color = 26
    -- },
    -- WeedProcessing = {
    --     x = 1379.79, y = -2087.15, z = 48.6 - 0.90,
    --     name = "Przetwarzanie marihuany",
    --     required = "weed",
    --     db_item = "weed_pooch",
    --     sprite = 499,
    --     color = 26
    -- },

	--- COKE ---

    CokeField = {
        x = 3286.18, y = 5178.84, z = 18.53 - 0.90,
        name = "Pole kokainy",
        db_item = "coke",
        sprite = 501,
        color = 40
    },
    CokeProcessing = {
        x = 287.18, y = 6791.16, z = 15.69 - 0.90,
        name = "Przetwarzanie kokainy",
        required = "coke",
        db_item = "coke_pooch",
        sprite = 478,
        color = 40
    },

	--- OPIUM ---

    -- OpiumField = {
    --     x = 56.89, y = 3690.51, z = 39.92 - 0.90,
    --     name = "Pole opium",
    --     db_item = "opium",
    --     sprite = 501,
    --     color = 26
    -- },
    -- OpiumProcessing = {
    --     x = 2330.17, y = 2571.98, z = 46.68 - 0.90,
    --     name = "Przetwarzanie opium",
    --     required = "opium",
    --     db_item = "opium_pooch",
    --     sprite = 501,
    --     color = 26
    -- },

	--- EXCTASY ---

    -- ExctasyField = {
    --     x = -1079.24, y = -1678.64, z = 4.58 - 0.90,
    --     name = "Pole ekstazy",
    --     db_item = "mdp2p",
    --     sprite = 501,
    --     color = 26
    -- },
    -- ExctasyProcessing = {
    --     x = 1965.05, y = 3819.44, z = 32.4 - 0.90,
    --     name = "Przetwarzanie ekstazy",
    --     required = "mdp2p",
    --     db_item = "exctasy_pooch",
    --     sprite = 501,
    --     color = 26
    -- }
}


RegisterServerEvent('esx_drugs:getInventory')
AddEventHandler('esx_drugs:getInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local count = 0
	local itemName = nil
	for i, data in pairs(Zones) do
		if i == currentZone then
			if string.find(currentZone, "Processing") then
				count = xPlayer.getInventoryItem(data.db_item).count
				itemName = data.db_item
				itemRequired = xPlayer.getInventoryItem(data.required).count
			else
				count = xPlayer.getInventoryItem(data.db_item).count
				itemName = data.db_item
			end
			break
		end
	end
	TriggerClientEvent('esx_drugs:returnInventory', _source, count, itemName, itemRequired, xPlayer.job.name, currentZone)
end)

ESX.RegisterUsableItem('papieros', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local smoke = xPlayer.getInventoryItem('papieros')
	local getzapalara = xPlayer.getInventoryItem('zapalniczka').count
	if getzapalara >= 1 then
		xPlayer.removeInventoryItem('papieros', 1)
		TriggerClientEvent('xlem0n_drugs:cigarette', source)
	else
		xPlayer.showNotification('~o~Nie posiadasz zapalniczki')
	end
end)


RegisterServerEvent('drugs:registerClient')
AddEventHandler('drugs:registerClient', function(_eventName)
	local _source = source
	local _sourceName = GetPlayerName(_source)
	local _sourceIdentifier = GetPlayerIdentifier(_source, 0)

	if _sourceIdentifier ~= nil then
		if (AuthorizedClients[_sourceIdentifier:lower()] == nil) then
			AuthorizedClients[_sourceIdentifier:lower()] = _eventName
			TriggerClientEvent(AuthorizedClients[_sourceIdentifier:lower()], _source, Zones)
		end
	end
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
	local _sourceName = GetPlayerName(_source)
	local _sourceIdentifier = GetPlayerIdentifier(_source, 0)

	if (AuthorizedClients[_sourceIdentifier:lower()] ~= nil) then
		AuthorizedClients[_sourceIdentifier:lower()] = nil
	end
end)