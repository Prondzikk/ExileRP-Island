local charset = {}

for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end

function string.random(length)
  math.randomseed(os.time())

  if length > 0 then
    return string.random(length - 1) .. charset[math.random(1, #charset)]
  else
    return ""
  end
end

CreateThread(function()
	local resourcesStopped = {}

	if ESX.Table.SizeOf(resourcesStopped) > 0 then
		local allStoppedResources = ''

		for resourceName,reason in pairs(resourcesStopped) do
			allStoppedResources = ('%s\n- ^3%s^7, %s'):format(allStoppedResources, resourceName, reason)
		end

	end
end)

RegisterNetEvent('esx:onPlayerJoined')
AddEventHandler('esx:onPlayerJoined', function()
	if not ESX.Players[source] then
		onPlayerJoined(source)
	end
end)

function onPlayerJoined(playerId)
	local identifier

	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'steam:') then 
			identifier = v
			break
		end
	end

	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			DropPlayer(playerId, ('there was an error loading your character!\nError code: identifier-active-ingame\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(identifier))
		else
			MySQL.Async.fetchScalar('SELECT 1 FROM users WHERE identifier = @identifier', {
				['@identifier'] = identifier
			}, function(result)
				if result then
					loadESXPlayer(identifier, playerId)
				else
					local accounts = {}

					for account,money in pairs(Config.StartingAccountMoney) do
						accounts[account] = money
					end

					MySQL.Async.execute('INSERT INTO users (accounts, identifier) VALUES (@accounts, @identifier)', {
						['@accounts'] = json.encode(accounts),
						['@identifier'] = identifier
					}, function(rowsChanged)
						loadESXPlayer(identifier, playerId)
					end)
				end
			end)
		end
	else
		DropPlayer(playerId, 'there was an error loading your character!\nError code: identifier-missing-ingame\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	deferrals.defer()
	local playerId, nick, identifier = source, true
	Citizen.Wait(100)
	
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
	--	if string.match(v, 'license:') then
	--		identifier = string.sub(v, 9)
		if string.match(v, 'steam:') then 
			identifier = v
			break
		end
	end
	
	if GetPlayerName(playerId) ~= nil then
		local count = 0
		local nameLength = string.len(GetPlayerName(playerId))
		for i in GetPlayerName(playerId):gmatch('[aąbcćdeęfghijklłmnoópqrsśtuvwxyzżźäöAĄBCĆDEĘFGHIJKLŁMNOÓPQRSŚTUVWXYZŻŹÄÖ0123456789 |._-]') do
			count = count + 1
		end
		if count ~= nameLength then
			nick = false
		end
	else
		nick = false
	end
	
	if identifier then
		if nick then
			if ESX.GetPlayerFromIdentifier(identifier) then
				deferrals.done(('There was an error loading your character!\nError code: identifier-active\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(identifier))
			else
				deferrals.done()
			end	
		else
			deferrals.done('Twój nick posiada niedozwolone znaki\nDozwolone znaki na naszym serwerze: [aąbcćdeęfghijklłmnoópqrsśtuvwxyzżźäöAĄBCĆDEĘFGHIJKLŁMNOÓPQRSŚTUVWXYZŻŹÄÖ0123456789 |._-]')
		end
	else
		deferrals.done('There was an error loading your character!\nError code: identifier-missing\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end)

function loadESXPlayer(identifier, playerId)
	local tasks = {}

	local userData = {
		accounts = {},
		inventory = {},
		job = {},
		loadout = {},
		character    = {},
		playerName = GetPlayerName(playerId),
		hiddenjob    = {},
	}

	table.insert(tasks, function(cb)
		MySQL.Async.fetchAll('SELECT accounts, job, job_grade, hiddenjob, hiddenjob_grade, `group`, loadout, position, inventory, firstname, lastname, fake_firstname, fake_lastname, dateofbirth, height, sex, status, phone_number, account_number, tattoos, odznakakurwa FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result)
			local job, grade, jobObject, gradeObject = result[1].job, tostring(result[1].job_grade)
			local hiddenjob, hiddenjobgrade = result[1].hiddenjob, tostring(result[1].hiddenjob_grade)
			local foundAccounts, foundItems = {}, {}

			--Characters 
			
			if result[1].firstname and result[1].lastname ~= '' then
			    userData.character.firstname 	  = result[1].firstname
                userData.character.lastname 	  = result[1].lastname
				userData.character.fake_firstname = result[1].fake_firstname
                userData.character.fake_lastname  = result[1].fake_lastname
                userData.character.dateofbirth    = result[1].dateofbirth
				userData.character.height         = result[1].height
                userData.character.sex			  = result[1].sex
                userData.character.status 		  = result[1].status
                userData.character.phone_number   = result[1].phone_number
				userData.character.account_number = result[1].account_number
                userData.character.tattoos 		  = result[1].tattoos
				userData.character.odznaka 		  = result[1].odznakakurwa
			end
			
			-- Accounts
			if result[1].accounts and result[1].accounts ~= '' then
				local accounts = json.decode(result[1].accounts)

				for account,money in pairs(accounts) do
					foundAccounts[account] = money
				end
			end

			for account,label in pairs(Config.Accounts) do
				table.insert(userData.accounts, {
					name = account,
					money = foundAccounts[account] or Config.StartingAccountMoney[account] or 0,
					label = label
				})
			end

			--Flux ty kurwo
			if ESX.DoesJobExist(hiddenjob, hiddenjobgrade) then
				local jobObject, gradeObject = ESX.Jobs[hiddenjob], ESX.Jobs[hiddenjob].grades[hiddenjobgrade]

				userData.hiddenjob = {}

				userData.hiddenjob.id    = jobObject.id
				userData.hiddenjob.name  = jobObject.name
				userData.hiddenjob.label = jobObject.label

				userData.hiddenjob.grade        = tonumber(hiddenjobgrade)
				userData.hiddenjob.grade_name   = gradeObject.name
				userData.hiddenjob.grade_label  = gradeObject.label
				userData.hiddenjob.grade_salary = gradeObject.salary

				userData.hiddenjob.skin_male    = {}
				userData.hiddenjob.skin_female  = {}

				if gradeObject.skin_male ~= nil then
					userData.hiddenjob.skin_male = json.decode(gradeObject.skin_male)
				end
	
				if gradeObject.skin_female ~= nil then
					userData.hiddenjob.skin_female = json.decode(gradeObject.skin_female)
				end

			else
				--print(('es_extended: %s had an unknown job [job: %s, grade: %s], setting as unemployed!'):format(player.getIdentifier(), hiddenjob, hiddenjobgrade))

				local hiddenjob, hiddenjobgrade = 'unemployed', '0'
				local jobObject, gradeObject = ESX.Jobs[hiddenjob], ESX.Jobs[hiddenjob].grades[hiddenjobgrade]

				userData.hiddenjob = {}

				userData.hiddenjob.id    = jobObject.id
				userData.hiddenjob.name  = jobObject.name
				userData.hiddenjob.label = jobObject.label
	
				userData.hiddenjob.grade        = tonumber(hiddenjobgrade)
				userData.hiddenjob.grade_name   = gradeObject.name
				userData.hiddenjob.grade_label  = gradeObject.label
				userData.hiddenjob.grade_salary = gradeObject.salary
	
				userData.hiddenjob.skin_male    = {}
				userData.hiddenjob.skin_female  = {}
			end
			-- Job
			if ESX.DoesJobExist(job, grade) then
				jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			else
				job, grade = 'unemployed', '0'
				jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			end

			userData.job.id = jobObject.id
			userData.job.name = jobObject.name
			userData.job.label = jobObject.label

			userData.job.grade = tonumber(grade)
			userData.job.grade_name = gradeObject.name
			userData.job.grade_label = gradeObject.label
			userData.job.grade_salary = gradeObject.salary

			userData.job.skin_male = {}
			userData.job.skin_female = {}

			if gradeObject.skin_male then userData.job.skin_male = json.decode(gradeObject.skin_male) end
			if gradeObject.skin_female then userData.job.skin_female = json.decode(gradeObject.skin_female) end

			-- Inventory
			if result[1].inventory and result[1].inventory ~= '' then
				local inventory = json.decode(result[1].inventory)

				for name, data in pairs(inventory) do
					local item = ESX.Items[name]

					if item then
						-- if data and data.slot then
						-- 	foundItems[name] = { count = data.count, slot = data.slot }
						-- else
						-- 	foundItems[name] = data
						-- end
						if data.slot then
							foundItems[name] = { count = data.count, slot = data.slot }
						else
							foundItems[name] = { count = data.count }
						end
					end
				end
			end

			for name,item in pairs(ESX.Items) do
				local count = 0
				local slot = false

				-- if foundItems[name] then
				-- 	if foundItems[name].count then
				-- 		count = foundItems[name].count
				-- 	else
				-- 		count = foundItems[name]
				-- 	end

				-- 	if foundItems[name].slot then
				-- 		slot = foundItems[name].slot
				-- 	end
				-- end

				if foundItems[name] then
					if foundItems[name].count then
						count = foundItems[name].count
					end

					if foundItems[name].slot then
						slot = foundItems[name].slot
					end
				end

				table.insert(userData.inventory, {
					name = name,
					count = count,
					slot = slot,
					label = item.label,
					limit = item.limit,
					usable = ESX.UsableItemsCallbacks[name] ~= nil,
					rare = item.rare,
					canRemove = item.canRemove
				})
			end
			table.sort(userData.inventory, function(a, b)
				return a.label < b.label
			end)

			-- Group
			if result[1].group then
				userData.group = result[1].group
			else
				userData.group = 'user'
			end

			-- Loadout
			if result[1].loadout and result[1].loadout ~= '' then
				local loadout = json.decode(result[1].loadout)

				for name,weapon in pairs(loadout) do
					local label = ESX.GetWeaponLabel(name)

					if label then
						if not weapon.components then weapon.components = {} end
						if not weapon.tintIndex then weapon.tintIndex = 0 end

						table.insert(userData.loadout, {
							name = name,
							ammo = weapon.ammo,
							label = label,
							components = weapon.components,
							tintIndex = weapon.tintIndex
						})
					end
				end
			end

			-- Position
			if result[1].position and result[1].position ~= '' then
				userData.coords = json.decode(result[1].position)
			else
				userData.coords = {x = -1042.28, y = -2745.42, z = 20.40, heading = 205.8}
			end

			cb()
		end)
	end)

	Async.parallel(tasks, function(results)
		local xPlayer = CreateExtendedPlayer(playerId, identifier, userData.group, userData.accounts, userData.inventory, userData.job, userData.loadout, userData.playerName, userData.coords, userData.character, userData.hiddenjob)
		ESX.Players[playerId] = xPlayer
		TriggerEvent('esx:playerLoaded', playerId, xPlayer)

		xPlayer.triggerEvent('esx:playerLoaded', {
			accounts = xPlayer.getAccounts(),
			coords = xPlayer.getCoords(),
			identifier = xPlayer.getIdentifier(),
			inventory = xPlayer.getInventory(),
			job = xPlayer.getJob(),
			group = xPlayer.getGroup(),
			loadout = xPlayer.getLoadout(),
			money = xPlayer.getMoney(),
			character	 = xPlayer.getCharacter(),
			hiddenjob	 = xPlayer.getHiddenJob(),
		})

		xPlayer.triggerEvent('esx:registerSuggestions', ESX.RegisteredCommands)
	end)
end

AddEventHandler('chatMessage', function(playerId, author, message)
	if message:sub(1, 1) == '/' and playerId > 0 then
		CancelEvent()
		local commandName = message:sub(1):gmatch("%w+")()
	end
end)

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		TriggerEvent('esx:playerDropped', playerId, reason)

		ESX.SavePlayer(xPlayer, function()
			ESX.Players[playerId] = nil
		end)
	end
end)


RegisterServerEvent('esx:updateLoadout')
AddEventHandler('esx:updateLoadout', function(loadout)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.loadout = loadout
end)

RegisterNetEvent('esx:updateCoords')
AddEventHandler('esx:updateCoords', function(coords)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateCoords(coords)
	end
end)

RegisterNetEvent('esx:updateWeaponAmmo')
AddEventHandler('esx:updateWeaponAmmo', function(weaponName, ammoCount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateWeaponAmmo(weaponName, ammoCount)
	end
end)


RegisterNetEvent('esx:gitestveInventoryItem')
AddEventHandler('esx:gitestveInventoryItem', function(target, type, itemName, itemCount)
	local playerId = source
	local sourceXPlayer = ESX.GetPlayerFromId(playerId)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local czas = os.date("%Y/%m/%d %X")

	if type == 'item_standard' then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if targetXPlayer.canCarryItem(itemName, itemCount) then			
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem   (itemName, itemCount)

				sourceXPlayer.showNotification(_U('gave_item', itemCount, sourceItem.label, targetXPlayer.source))
				targetXPlayer.showNotification(_U('received_item', itemCount, sourceItem.label, sourceXPlayer.source))
				exports.exile_logs:discord(source, 'Przekazał/a '..itemCount..'x '..sourceItem.label..' ('..itemName..') graczowi '..targetXPlayer.name..' ['..targetXPlayer.source..' | '..targetXPlayer.identifier..']', 'extendedgiveitem', true)
				TriggerClientEvent('sendProximityMessageDo', -1, playerId, playerId, "przekazał przedmiot")
			else
				sourceXPlayer.showNotification(_U('ex_inv_lim', targetXPlayer.source))
			end
		else
			sourceXPlayer.showNotification(_U('imp_invalid_quantity'))
		end
	elseif type == 'item_account' then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney   (itemName, itemCount)

			sourceXPlayer.showNotification(_U('gave_account_money', ESX.Math.GroupDigits(itemCount), Config.Accounts[itemName], targetXPlayer.source))
			targetXPlayer.showNotification(_U('received_account_money', ESX.Math.GroupDigits(itemCount), Config.Accounts[itemName], sourceXPlayer.source))
			exports.exile_logs:discord(source, 'Przekazał/a '..itemCount..'$ '..Config.Accounts[itemName]..' graczowi '..targetXPlayer.name..' ['..targetXPlayer.source..' | '..targetXPlayer.identifier..']', 'extendedgivemoney', true)
			TriggerClientEvent('sendProximityMessageDo', -1, playerId, playerId, "przekazał gotówkę")
		else
			sourceXPlayer.showNotification(_U('imp_invalid_amount'))
		end
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local czas = os.date("%Y/%m/%d %X")

	if type == 'item_standard' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showNotification(_U('imp_invalid_quantity'))
		else
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				xPlayer.showNotification(_U('imp_invalid_quantity'))
			else
				xPlayer.removeInventoryItem(itemName, itemCount)
				xPlayer.showNotification(_U('threw_standard', itemCount, xItem.label))
				exports.exile_logs:discord(xPlayer.source, 'Upuścił/a na ziemię '..itemCount..'x '..xItem.label, 'extendedremoveitem', true)
				TriggerClientEvent('sendProximityMessageDo', -1, playerId, playerId, "upuścił na ziemię przedmiot")
			end
		end
	elseif type == 'item_account' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showNotification(_U('imp_invalid_amount'))
		else
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				xPlayer.showNotification(_U('imp_invalid_amount'))
			else
				xPlayer.removeAccountMoney(itemName, itemCount)
				xPlayer.showNotification(_U('threw_account', ESX.Math.GroupDigits(itemCount), string.lower(account.label)))
				exports.exile_logs:discord(xPlayer.source, 'Upuścił/a na ziemię '..itemCount..'$ '..account.label, 'extendedremovemoney', true)
				TriggerClientEvent('sendProximityMessageDo', -1, playerId, playerId, "upuścił na ziemię gotówkę")
			end
		end
	end
end)

RegisterNetEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local count = xPlayer.getInventoryItem(itemName).count

	if count > 0 then
		ESX.UseItem(source, itemName)
	else
		xPlayer.showNotification(_U('act_imp'))
	end
end)

RegisterServerEvent('esx:addToSlot')
AddEventHandler('esx:addToSlot', function(slot, data)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addToSlot(slot, data)
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		hiddenjob 	 = xPlayer.getHiddenJob(),
		loadout      = xPlayer.getLoadout(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:isValidItem', function(source, cb, itemName)
	cb(ESX.Items[itemName] ~= nil)
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		hiddenjob 	 = xPlayer.getHiddenJob(),
		loadout      = xPlayer.getLoadout(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:getPlayerNames', function(source, cb, players)
	players[source] = nil

	for playerId,v in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer then
			players[playerId] = xPlayer.getName()
		else
			players[playerId] = nil
		end
	end

	cb(players)
end)


ESX.StartDBSync()
-- ESX.StartPayCheck()

RegisterServerEvent('esx_inventoryhud:getOwnedSim')
AddEventHandler('esx_inventoryhud:getOwnedSim', function()
	local _source = source
	local Sims = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	
	Sims = MySQL.Sync.fetchAll('SELECT * FROM user_sim WHERE user = @identifier AND house = @house', {
		['@identifier'] = xPlayer.identifier,
		['@house'] = 'Brak',
	})
	
	TriggerClientEvent("esx_inventoryhud:setOwnedSim", _source, Sims)
end)

