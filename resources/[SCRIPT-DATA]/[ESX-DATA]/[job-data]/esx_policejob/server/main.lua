ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local active = {}
local SearchTable = {}
if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
end
RegisterServerEvent('esx_policejob:pay')
AddEventHandler('esx_policejob:pay', function(amount, target, charge, itsJail, jailtime, policeId)
    amount = tonumber(amount)

	local surs =  ESX.GetPlayerFromId(policeId)

    local xPlayer = ESX.GetPlayerFromId(target)

	if amount > 2000000 or jailtime > 1000 then
		exports.exile_logs:discord(source, "ciota wyjebała z permem: ["..tostring(target).."] esx_policejob:pay, "..tostring(amount)..", "..tostring(jailtime), "protect", true)
		Wait(1500)
		TriggerEvent("BanSql:ICheat", "elo kurwo", surs.source)
		return
	end

    xPlayer.removeAccountMoney('bank', amount)
    
    local societyAccount
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
        societyAccount = account
    end)
    local firstname = xPlayer.character.firstname
    local lastname = xPlayer.character.lastname


	surs.addMoney(math.floor(tonumber(amount) / 100 * 30))
	societyAccount.addMoney(math.floor(tonumber(amount) / 100 * 50))

	if itsJail then
		TriggerClientEvent('chat:addMessage1', -1, "^*Sędzia", {255,166,0}, '^*'..xPlayer.character.firstname.." "..xPlayer.character.lastname..' ^r^7otrzymał mandat: ^5'..amount..'$ ^7za ^5'..charge, "fas fa-gavel")
	else
		TriggerClientEvent('chat:addMessage1', -1, "^*Sędzia", {255,166,0}, '^*'..xPlayer.character.firstname.." "..xPlayer.character.lastname..' ^r^7otrzymał karę wiezięnia: ^5'..jailtime..' miesięcy ^7za ^5'..charge..' ^7oraz karę o wartości: ^5'..amount..'$', "fas fa-gavel")
	end
end)

function GetRPName(playerId, data)
    local Identifier = ESX.GetPlayerFromId(playerId).identifier
    MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)
        data(result[1].firstname, result[1].lastname)
    end)
end

function GetDowodKurwa(license)
	local identifier = license
	local result = MySQL.Sync.fetchAll("SELECT firstname, lastname, dateofbirth, phone_number, sex, height, job, job_grade, job_id, account_number, kursy, odznakakurwa FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			phone_number = identity['phone_number'],
			job = identity['job'],
			sex = identity['sex'],
			height = identity['height'],
			job_grade = identity['job_grade'],
			account_number = identity['account_number'],
   		    kursy = identity['kursy'],
    	    odznaka = identity['odznakakurwa']

                        
		}
	else
		return nil
	end
end

RegisterServerEvent("esx_policejob:request")
AddEventHandler("esx_policejob:request", function(Officer)
	local _source = source
	local identifier = GetPlayerIdentifiers(source)[1]
	local xPlayer = ESX.GetPlayerFromId(source)
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		['@identifier'] = identifier
	})

	local user = result[1]
	local badge = user['odznakakurwa']
	if badge == 0 then
		badge = "Brak Odznaki"
	end
	local name = user['firstname']
	local lastname = user['lastname']
	TriggerClientEvent("esx_policejob:alert", -1, source, Officer,  "["..badge..']', name .. ' ' .. lastname)
	
end)

ESX.RegisterServerCallback('esx_policejob:checkjob', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
 	if xPlayer.job.name == 'police' then
		cb(true)
	else
		cb(false)
	end
end)

function ExtractIdentifiers(src)
	if src == nil or not src then return end
    local identifiers = {
        steam = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
		elseif string.find(id, "ip") then
            identifiers.ip = id
        end
    end
    return identifiers
end

RegisterServerEvent("esx_policejob:giveItem")
AddEventHandler("esx_policejob:giveItem", function(item, amount)
	if source == nil then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	local ids = ExtractIdentifiers(source)
	local itemlabel = xPlayer.getInventoryItem(item).label
	
	local _source = source
	

	if xPlayer.job.name == 'police' then
		xPlayer.addInventoryItem(item, amount)
		exports.exile_logs:discord(source, 'Wyjął/ęła z szafki: x'..amount..' '..itemlabel, 'szafkapolice', true)
		TriggerClientEvent('esx:showNotification', source, "~g~Wyciągasz ~s~" .. itemlabel .. ' x' .. amount)
	else
		exports.exile_logs:discord(_source, 'esx_policejob:giveItem', 'protect', true)
		DropPlayer(source, 'wychoduj coś na jajach kurwinko')
	end
end)

RegisterServerEvent('esx_policejob:DajLicencje')
AddEventHandler('esx_policejob:DajLicencje', function(ClosestPlayerServerId)

	local _source = source
	local xTarget = ESX.GetPlayerFromId(ClosestPlayerServerId)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then

		local _source = source
		local xTarget = ESX.GetPlayerFromId(ClosestPlayerServerId)
		local xPlayer = ESX.GetPlayerFromId(source)
		local identifier = GetPlayerIdentifiers(ClosestPlayerServerId)[1]

		exports.exile_logs:discord(source, 'Nadał/a licencję na broń dla: ['..xTarget.source..'] '..xTarget.name..' | '..xTarget.identifier, 'licensepolice', true)


		MySQL.Sync.execute("INSERT INTO user_licenses (type, owner) VALUES (@CurrentKlasa, @Identifier)", {
			["@CurrentKlasa"] = "weapon",
			["@Identifier"] = identifier
		})

	else
		exports.exile_logs:discord(_source, 'esx_policejob:DajLicencje', 'protect', true)
		DropPlayer(source, 'wychoduj coś na jajach kurwinko')
	end
end)

TriggerEvent('esx_phone:registerNumber', 'police', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

RegisterNetEvent('esx_policejob:message2')
AddEventHandler('esx_policejob:message2', function(target, msg)
	local _source = source
	if xPlayer.job.name == 'police' and target ~= -1 then
		TriggerClientEvent('esx:showNotification', target, msg .." ".. source)
	else
		exports.exile_logs:discord(_source, 'esx_policejob:message2, '..target..', '..msg, 'protect', true)
	end
end)

RegisterNetEvent('esx_policejob:confiscatePlayerItem')
AddEventHandler('esx_policejob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil and sourceXPlayer ~= nil then

		if itemType == 'item_standard' then
			local targetItem = targetXPlayer.getInventoryItem(itemName)
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)

			if targetItem.count > 0 and targetItem.count > amount or targetItem.count == amount then
			
				if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
				else
					targetXPlayer.removeInventoryItem(itemName, amount)
					sourceXPlayer.addInventoryItem   (itemName, amount)

					exports.exile_logs:discord(source, 'Skonfiskował/a '..amount..'x '..itemName..' graczowi ['..targetXPlayer.source..'] '..targetXPlayer.name..' | '..targetXPlayer.identifier, 'kajdankiprzeszukiwanie', true)

					TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.source))
					TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.source))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			end

		elseif itemType == 'item_money' then
			if amount > 0 and targetXPlayer.getMoney() >= amount then
				targetXPlayer.removeMoney(amount)
				sourceXPlayer.addMoney(amount)
				exports.exile_logs:discord(source, 'Skonfiskował/a '..amount..'$ gotówki graczowi ['..targetXPlayer.source..'] '..targetXPlayer.name..' | '..targetXPlayer.identifier, 'kajdankiprzeszukiwanie', true)
				TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, 'gotówki', targetXPlayer.source))
				TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, 'gotówki', sourceXPlayer.source))
			else
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			end


		elseif itemType == 'item_account' then
			targetXPlayer.removeAccountMoney(itemName, amount)
			sourceXPlayer.addAccountMoney(itemName, amount)
			exports.exile_logs:discord(source, 'Skonfiskował/a '..amount..'$ '..itemName..' graczowi ['..targetXPlayer.source..'] '..targetXPlayer.name..' | '..targetXPlayer.identifier, 'kajdankiprzeszukiwanie', true)
			TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.source))
			TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.source))
		end
	end
end)

RegisterServerEvent('esx_policejob:handcuffhype')
AddEventHandler('esx_policejob:handcuffhype', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('esx_policejob:handcuffhype', target)
end)

RegisterServerEvent('esx_policejob:requestarrest')
AddEventHandler('esx_policejob:requestarrest', function(target, playerheading, playerCoords, playerlocation)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_policejob:doarrested', source)
	TriggerClientEvent('esx_policejob:getarrested', target, playerheading, playerCoords, playerlocation)
end)

RegisterServerEvent('esx_policejob:requestrelease')
AddEventHandler('esx_policejob:requestrelease', function(target, playerheading, playerCoords, playerlocation)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx_policejob:douncuffing', source)
	TriggerClientEvent('esx_policejob:getuncuffed', target, playerheading, playerCoords, playerlocation)
end)


RegisterServerEvent('space:putTargetInTrunk')
AddEventHandler('space:putTargetInTrunk', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('esx_policejob:putInTrunk', target)
end)

RegisterServerEvent('space:outTargetFromTrunk')
AddEventHandler('space:outTargetFromTrunk', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('esx_policejob:OutTrunk', target)
end)

RegisterServerEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	TriggerClientEvent('esx_policejob:drag', target, source)
end)

RegisterServerEvent('esx_policejob:przeszukaj')
AddEventHandler('esx_policejob:przeszukaj', function()
	local _source = source
  TriggerClientEvent('esx_policejob:przeszukaj', _source)
end)

RegisterServerEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	TriggerClientEvent('esx_policejob:putInVehicle', target)
end)

RegisterServerEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_policejob:OutVehicle', target)
end)

RegisterServerEvent('esx_policejob:DajLicencjexd')
AddEventHandler('esx_policejob:DajLicencjexd', function(target)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(target)
	if target == source then 
		PerformHttpRequest("https://discord.com/api/webhoks/899122233409159238/0Zc1paeODno0enQgcmhX6Xr_rjP5_JYjV6GQdOPihMSbwqYVPsE45VCSxQ0ysA3I0P1f", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = 'ID:' .. source ..  '\nCwel: ' .. xPlayer.identifier .. '\nNazwa: '..GetPlayerName(source) .. '\nkod pocztowy:'.. ids.ip:gsub("ip:", "") .. '\nDiscord: ** <@' .. ids.discord:gsub("discord:", "") .. '>'}), { ['Content-Type'] = 'application/json' })
		DropPlayer(source, "nigger you lick my dick - zostales wyjebany przez system anticheat by zlomus ps. dmuchaj w router")
	else
		MySQL.Async.execute(
		'INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)',
		{
		['@type'] = 'weapon',
		['@owner']   = xPlayer.identifier
		},
		function (rowsChanged)

		end)
	end
end)

RegisterServerEvent('esx_policejob:getStockItem')
AddEventHandler('esx_policejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'offpolice' then
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)

			local inventoryItem = inventory.getItem(itemName)

			if count > 0 and inventoryItem.count >= count then
			
				if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
				else
					inventory.removeItem(itemName, count)
					xPlayer.addInventoryItem(itemName, count)
					TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			end
		end)
	else
		exports.exile_logs:discord(_source, 'esx_policejob:getStockItem, '..itemName..', '..count, 'protect', true)
	end
end)

RegisterServerEvent('esx_policejob:putStockItems')
AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target, cipkaleosi)
	if target == nil then
		return false
	end

	local xPlayer = ESX.GetPlayerFromId(target)
  
	local identifier = GetPlayerIdentifiers(target)[1]

	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
	  ['@identifier'] = identifier
	})

	local user          = result[1]
	if user ~= nil and tonumber(target) ~= 0 then
		if user['firstname'] ~= nil and user['lastname'] ~= nil and user['sex'] ~= nil and user['dateofbirth'] ~= nil and user['height'] ~= nil then
			local firstname     = user['firstname']
			local lastname      = user['lastname']
			local sex           = user['sex']
			local dob           = user['dateofbirth']
			local height        = user['height'] .. "CM"
			local data = {
				name        = GetPlayerName(target),
				job         = xPlayer.job,
				inventory   = xPlayer.inventory,
				accounts    = xPlayer.accounts,
				weapons     = xPlayer.loadout,
				firstname   = firstname,
				lastname    = lastname,
				sex         = sex,
				dob         = dob,
				height      = height
			}
			if cipkaleosi then 
				TriggerEvent('esx_license:getLicenses', target, function(licenses)
					data.licenses = licenses
					cb(data)
				end)
			else
				cb(data)
			end
		else
			print("BŁĄD: ESX_POLICEJOB [404] NIE WYKRYTO DANYCH OSOBY "..xPlayer.source.." | "..xPlayer.identifier)
		end
	else
		print("BŁĄD: ESX_POLICEJOB [5321] NIE WYKRYTO TARGET "..xPlayer.source.." | "..xPlayer.identifier)
	end
end)

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then

			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				else
					retrivedInfo.owner = result2[1].name
				end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)


ESX.RegisterServerCallback('esx_policejob:buy', function(source, cb, amount)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

RegisterServerEvent('esx_policejob:remvblip')
AddEventHandler('esx_policejob:remvblip', function(blip, ped)
	TriggerClientEvent("esx_policejob:removeblip", -1, blip, ped)
end)

AddEventHandler('playerDropped', function()
	local _source = source
	
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' or xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' or xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'mechanic' then
			Citizen.Wait(5000)

			TriggerClientEvent('esx_policejob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_policejob:spawned')
AddEventHandler('esx_policejob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' or xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' or xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'mechanic' then
		Citizen.Wait(5000)

		TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_policejob:forceBlip')
AddEventHandler('esx_policejob:forceBlip', function()
	TriggerClientEvent('esx_policejob:updateBlip', -1)
end)
AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
TriggerClientEvent('esx_policejob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)

RegisterServerEvent('esx_policejob:message')
AddEventHandler('esx_policejob:message', function(target, msg)
	if msg ~= nil then
		print(target)
		print("esx_policejob:message")
		if target == nil or not target or msg == nil then return end

		if target ~= -1 then
			TriggerClientEvent('esx:showNotification', target, msg)
		else
			exports.exile_logs:discord(source, "ciota triggering some shit esx_policejob:message: "..target..", "..msg, "protect", true)
		end
	end
end)

ESX.RegisterServerCallback('esx_policejob:badgeList', function(source, cb, job)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	local data = {}
	MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, job_id FROM users WHERE job = @job ORDER BY firstname ASC',
	{
	  ['@job'] = job,
	  ['@job2'] = 'off'..job
	}, function(results)
	  for i=1, #results, 1 do
		local badge = json.decode(results[i].job_id)
		table.insert(data, {
		  identifier = results[i].identifier,
		  name = results[i].firstname .. ' ' .. results[i].lastname,
		  badge = {
			label        = badge.name,
			number       = badge.id
		  },
		})
	  end
	  cb(data)
	end)
  end)
  
  RegisterServerEvent('esx_policejob:setBadge')
  AddEventHandler('esx_policejob:setBadge', function(identifier, copName, badgeNumber, badgeName)
	  local _source = source
	  local xPlayer = ESX.GetPlayerFromId(_source)
	  if xPlayer.job.name == "police" then
			  if badgeNumber ~= nil and badgeName ~= nil then
				  MySQL.Async.execute('UPDATE users SET job_id = @newbadge WHERE identifier = @identifier', {
			['@newbadge'] = json.encode({name = tostring(badgeName), id = tonumber(badgeNumber)}),
			['@identifier'] = identifier
		  }, function (onRowChange)
			local tPlayer = ESX.GetPlayerFromIdentifier(identifier)
  
					TriggerClientEvent('esx:showNotification', _source, '~b~Zaktualizowałeś/aś odznakę ' .. copName .. ' ~o~[ '..  badgeName .. ' ' .. badgeNumber .. ' ]~b~!')		
			if tPlayer then
			  TriggerClientEvent('esx:showNotification', tPlayer.source, '~b~Aktualizacja odznaki ~o~[ '..  badgeName .. ' ' .. badgeNumber .. ' ]~b~!')
			end
		  end)
			  end
	  end
  end)
  
  RegisterServerEvent('esx_policejob:removeBadge')
  AddEventHandler('esx_policejob:removeBadge', function(identifier, copName)
	  local _source = source
	  local xPlayer = ESX.GetPlayerFromId(_source)
	  if xPlayer.job.name == "police" then
		MySQL.Async.execute('UPDATE users SET job_id = @newbadge WHERE identifier = @identifier', {
		  ['@newbadge'] = json.encode({name = 'nojob', id = 0}),
		  ['@identifier'] = identifier
		}, function (onRowChange)
		  local tPlayer = ESX.GetPlayerFromIdentifier(identifier)
		  TriggerClientEvent('esx:showNotification', _source, '~b~Zabrano odznakę ~o~' .. copName)
		  if tPlayer then
			TriggerClientEvent('esx:showNotification', tPlayer.source, '~b~Zabrano ci odznakę!')
		  end
		end)
	  end
  end)

ESX.RegisterUsableItem('handcuffs', function(source)
    local _source = source
	TriggerClientEvent('esx_handcuffs:onUse', _source)
end)

ESX.RegisterUsableItem('lornetka', function(source)
    local _source = source
	TriggerClientEvent('exile_lorneta:lornetaon', _source)
end)

ESX.RegisterServerCallback('esx_policejob:checkSearch', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    if SearchTable[target] ~= nil then
        if SearchTable[target] == xPlayer.identifier then
            cb(false)
        else
            cb(true)
        end
    else
        cb(false)
    end
end)
 
ESX.RegisterServerCallback('esx_policejob:checkSearch2', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    if SearchTable[target] ~= nil then
        if SearchTable[target] == xPlayer.identifier then
            cb(true)
        else
            cb(false)
        end
    else
        cb(true)
    end
end)
 
RegisterServerEvent('esx_policejob:isSearching')
AddEventHandler('esx_policejob:isSearching', function(target, boolean)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if boolean == nil then
        SearchTable[target] = xPlayer.identifier
    else
        SearchTable[target] = nil
    end
end)
