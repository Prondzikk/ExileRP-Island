ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local Inventories = {}
local Weapons = {}

TriggerEvent('esx_phone:registerNumber', 'doj','Ostrzeż doj', true, true)
--Star Leaks https://discord.gg/5cBhmVpbVk

LegalJobs = {
    {
        name = "casino",
        organizationName = "Casino Royale"
    },
	{
		name = "cardealer",
		organizationName = "Lux MotorSport"
	},
	{
		name = "extreme",
		organizationName = "Extreme Sports"
	},
	{
		name = 'kawiarnia',
		organizationName = 'Kawiarnia'
	},
	{
		name = 'doj',
		organizationName = 'Department Of Justice'
	},
	{
		name = 'galaxy',
		organizationName = 'Galaxy Club'
	}
}

for i=1, #LegalJobs, 1 do
    TriggerEvent('esx_society:registerSociety', LegalJobs[i].name, LegalJobs[i].organizationName, 'society_'..LegalJobs[i].name, 'society_'..LegalJobs[i].name, 'society_'..LegalJobs[i].name, {type = 'private'})
end

ESX.RegisterServerCallback('exile:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount('black_money').money
	local items      = xPlayer.inventory

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = xPlayer.getLoadout()
	})
end)

ESX.RegisterServerCallback('exile:getStockItems', function(source, cb, society)
	TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
		if account ~= nil then
			blackMoney = account.money
		else	
			print('')
			print('')
			print('')
			print('Error exile_legaljobs exile:getStockItems society: '..society)
			print('')
			print('')
			print('')
			blackMoney = 'Błąd'
		end
	end)

	TriggerEvent('esx_addoninventory:getSharedInventory', society, function(inventory)
		if inventory == nil then
			items = {}
		else
			items = inventory.items
		end
	end)

	TriggerEvent('esx_datastore:getSharedDataStore', society, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)

RegisterServerEvent('exile:getStockItem')
AddEventHandler('exile:getStockItem', function(itemType, itemName, count, society)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	local scriptJob = string.sub(society, 9)
	
	if xPlayer.job.name == scriptJob or xPlayer.hiddenjob.name == scriptJob then	
		TriggerEvent('esx_addoninventory:getSharedInventory', society, function(inventory)
			local inventoryItem = inventory.getItem(itemName)
			if count > 0 and inventoryItem.count >= count then
				if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, "~r~Nieprawidłowa wartość")
				else

					if string.find(society, "org") then
						exports.exile_logs:discord(source, '('..society..') Wyjął/ęła z szafki '..count..'x '..inventoryItem.label..' ['..itemName..']', 'szafkaorg', true)
					else
						exports.exile_logs:discord(source, '('..society..') Wyjął/ęła z szafki '..count..'x '..inventoryItem.label..' ['..itemName..']', 'szafkalegaljobs', true)
					end

					inventory.removeItem(itemName, count)
					xPlayer.addInventoryItem(itemName, count)
					TriggerClientEvent('esx:showNotification', _source, "Wyciągnąłeś ~y~" .. inventoryItem.label .. " ~b~x" .. count .. "~w~ z szafki")
				end
			else
				TriggerClientEvent('esx:showNotification', _source, "~r~Nieprawidłowa wartość")
			end
		end)
	end
end)

RegisterServerEvent('exile:putItemInStock')
AddEventHandler('exile:putItemInStock', function(itemType, itemName, count, society)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	local scriptJob = string.sub(society, 9)
	if xPlayer.job.name == scriptJob or xPlayer.hiddenjob.name == scriptJob then
		TriggerEvent('esx_addoninventory:getSharedInventory', society, function(inventory)
			local inventoryItem = inventory.getItem(itemName)

			if sourceItem.count >= count and count > 0 then

				if string.find(society, "org") then
					exports.exile_logs:discord(source, '('..society..') Włożył/a do szafki '..count..'x '..inventoryItem.label..' ['..itemName..']', 'szafkaorg', true)
				else
					exports.exile_logs:discord(source, '('..society..') Włożył/a do szafki '..count..'x '..inventoryItem.label..' ['..itemName..']', 'szafkalegaljobs', true)
				end

				xPlayer.removeInventoryItem(itemName, count)
				inventory.addItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Włożyłeś ~y~" .. inventoryItem.label .. " ~b~x" .. count .. "~w~ do szafki")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~Nieprawidłowa ilość")
			end
		end)
	end
end)

ESX.RegisterServerCallback('exile:isUsed', function(source, cb, tName, society)
	if tName == 'Inventories' then
		if Inventories[society] == true then
			cb(true)
		else
			cb(false)
		end
	elseif tName == 'Weapons' then
		if Weapons[society] == true then
			cb(true)
		else
			cb(false)
		end
	end
end)

RegisterServerEvent('exile:setUsed')
AddEventHandler('exile:setUsed', function(tName, society, boolean)
	if tName == 'Inventories' then
		Inventories[society] = boolean
	elseif tName == 'Weapons' then
		Weapons[society] = boolean
	end
end)

function getID(steamid, callback)
	MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
	{
	  ['@identifier'] = steamid
	},
	function(result)
	  if result[1] ~= nil then
		local data = {
		  identifier	= identifier,
		  firstname	= result[1]['firstname'],
		  lastname	= result[1]['lastname'],
		  dateofbirth	= result[1]['dateofbirth'],
		  sex			= result[1]['sex'],
		  height		= result[1]['height'],
		  phonenumber = result[1]['phone_number']
		}
			  
		callback(data)
	  else	
		local data = {
		  identifier 	= '',
		  firstname 	= '',
		  lastname 	= '',
		  dateofbirth = '',
		  sex 		= '',
		  height 		= '',
		  phonenumber = ''
		}
			  
		callback(data)
	  end
	end)
end

RegisterServerEvent(GetCurrentResourceName() .. ':showIdentify')
AddEventHandler(GetCurrentResourceName() .. ':showIdentify', function(currentJob)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local job = ""
	local job_grade = 0
	if xPlayer.job.name == currentJob then
		job = xPlayer.job.label
		job_grade = xPlayer.job.grade_label
	elseif xPlayer.hiddenjob.name == currentJob then
		job = xPlayer.hiddenjob.label
		job_grade = xPlayer.hiddenjob.grade_label
	end
	getID(xPlayer.identifier, function(data)
		if data ~= nil then
			TriggerClientEvent(GetCurrentResourceName() .. ':sendProx', -1, _source, data.firstname .. " " .. data.lastname, job, job_grade, data.phonenumber)
		end
	end)
end)

RegisterServerEvent(GetCurrentResourceName() .. ':giveWeapon')
AddEventHandler(GetCurrentResourceName() .. ':giveWeapon', function(name, quantity)
	local xPlayer = ESX.GetPlayerFromId(source)
	if name == 'GADGET_PARACHUTE' then
		xPlayer.addWeapon(name, tonumber(quantity))
	end
end)

RegisterServerEvent(GetCurrentResourceName() .. ':giveItem')
AddEventHandler(GetCurrentResourceName() .. ':giveItem', function(name, quantity)
	local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(name)
    
	if name == 'nurek_1' or name == 'nurek_2' or name == 'nurek_3' or name == 'nurek_4' or name == 'nurek_5' or name == 'nurek_6' or name == 'beer' or name == 'vodka' or name == 'whisky' or name == 'tequila' or name == 'burbon' or name == 'aperitif' or name == 'cydr' or name == 'koniak' then
		if item.limit ~= -1 and item.count >= item.limit then
			TriggerClientEvent('esx:showNotification', source, "~r~Nie uniesiesz więcej " .. item.label)
		else
			xPlayer.addInventoryItem(name, quantity)
		end
	end
end)

local Clothes = {
	'nurek_1',
	'nurek_2',
	'nurek_3',
	'nurek_4',
	'nurek_5',
	'nurek_6'
}

CreateThread(function()
	for i=1, #Clothes, 1 do
		ESX.RegisterUsableItem(Clothes[i], function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.removeInventoryItem(Clothes[i], 1)
			TriggerClientEvent('exile_legaljobs:putOnClothes', source, Clothes[i])
		end)
	end
end)

local Alcohols = {
	{
		name = 'beer',
		label = "piwo",
		status = 150000
	},
	{
		name = 'vodka',
		label = "setkę wódki",
		status = 250000
	},
	{
		name = 'whisky',
		label = "100ml czystej szkockiej",
		status = 300000
	},
	{
		name = 'tequila',
		label = "setkę pysznej tequili",
		status = 300000
	},
	{
		name = 'burbon',
		label = "szklankę burbonu",
		status = 250000
	},
	{
		name = 'aperitif',
		label = "kieliszek aperitif",
		status = 300000
	},
	{
		name = 'cydr',
		label = "butelkę cydru",
		status = 250000
	},
	{
		name = 'koniak',
		label = "200ml koniaku",
		status = 350000
	},
}

CreateThread(function()
	for i=1, #Alcohols, 1 do
		ESX.RegisterUsableItem(Alcohols[i].name, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			xPlayer.removeInventoryItem(Alcohols[i].name, 1)
			TriggerClientEvent('esx_status:add', source, 'drunk', Alcohols[i].status)
			TriggerClientEvent('esx_optionalneeds:onDrink', source)
			TriggerClientEvent('esx:showNotification', source, "Wypiłeś/aś ~y~" .. Alcohols[i].label)
		end)
	end
end)


RegisterCommand("roll", function(source, args, rawCommand)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		local Message = ""
		if xPlayer.job.name == 'casino' then
			local count = tonumber(args[1])
			if count and count > 0 and count <= 5 then
				if count == 1 then
					local value = math.random(1,6)
					Message = "rzuca kością, wypada [" .. value .. "]"
					TriggerClientEvent('sendProximityMessageDo', -1, source, source, Message)
				else
					Message = "rzuca " .. count .. " koścmi i wypada odpowiednio:"
					for i=1, count, 1 do
						local value = math.random(1,6)
						Message = Message .. " [" .. value .. "]"
					end
					TriggerClientEvent('sendProximityMessageDo', -1, source, source, Message)
				end
			elseif args[1] == nil then
				local value = math.random(1,6)
				Message = "rzuca kością, wypada [" .. value .. "]"
				TriggerClientEvent('sendProximityMessageDo', -1, source, source, Message)
			end
		end
	end
end, false)

RegisterServerEvent('exile:pay')
AddEventHandler('exile:pay', function(cash)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  xPlayer.removeAccountMoney('bank', cash)
  xPlayer.showNotification('~w~Zapłaciłeś ~g~' ..cash.. ' ~w~za usługę.')
end)


-- licencje pedaly 
ESX.RegisterServerCallback('exile_legaljobs:getLicenses', function(source, cb, society)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local licka = {}
    MySQL.Async.fetchAll('SELECT * FROM exile_org WHERE orgname = @job',{
		['@job'] = society
	}, function(result)
        if result[1] ~= nil then
            licka.menuf7 = result[1].menuf7
            licka.level = result[1].level
            licka.safe = result[1].safe
            licka.items = result[1].items
            licka.addoncloakroom = result[1].addoncloakroom
            cb(licka)
        end
    end)
end)

-- kupowanie licencji pedaly
RegisterServerEvent('exile_legaljobs:upgradeSociety')
AddEventHandler('exile_legaljobs:upgradeSociety', function(co, naco, org, cena)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if cena > xPlayer.getMoney() then
        local brakuje = cena - xPlayer.getMoney()
        TriggerClientEvent('esx:showNotification', _source, "~r~Nie posiadasz wystarczającej ilosci gotówki\nBrakuje ci ~g~" .. brakuje .. "$ ~s~czystej gotówki")
    else
        TriggerClientEvent('esx:showNotification', _source, "~g~Pomyślnie zapłacono za ulepszenie!")
        xPlayer.removeAccountMoney('money', cena)
        MySQL.Async.execute('UPDATE exile_org SET ' .. co .. ' = @chuj WHERE orgname = @job',{
            ['@job'] = org,
            ['@chuj'] = naco
        })
    end
end)