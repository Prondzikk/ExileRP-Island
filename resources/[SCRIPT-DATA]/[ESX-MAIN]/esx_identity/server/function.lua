ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Config = {}

Country = {}
Country.Jobs = {}
Country.Items = {}

MySQL.ready(function()

	MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
		for k,v in ipairs(result) do
			Country.Items[v.name] = {
				label = v.label,
				limit = v.limit,
				rare = v.rare,
				canRemove = v.can_remove
			}
		end
	end)

	MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(jobs)
		for k,v in ipairs(jobs) do
			Country.Jobs[v.name] = v
			Country.Jobs[v.name].grades = {}
		end

		MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(jobGrades)
			for k,v in ipairs(jobGrades) do
				if Country.Jobs[v.job_name] then
					Country.Jobs[v.job_name].grades[tostring(v.grade)] = v
				end
			end

			for k2,v2 in pairs(Country.Jobs) do
				if ESX.Table.SizeOf(v2.grades) == 0 then
					Country.Jobs[v2.name] = nil
				end
			end
		end)
	end)
	
	TriggerEvent('esx:UsableItemsCallbacks', function(cb)
		ESX.UsableItemsCallbacks = cb
	end)

end)

Config.Accounts = {
	bank = 'Bank',
	black_money = 'Brudna gotowka',
	money = 'Gotowka'
}

RegisterServerEvent('country:Set')
AddEventHandler("country:Set", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local tasks = {}

	local userData = {
		accounts = {},
		inventory = {},
		job = {},
		loadout = {},
		tattoos = {},
		status = {},
		charid = '',
		number = nil,
		char = {},
		slot = {}
	}
	
	table.insert(tasks, function(cb)
		MySQL.Async.fetchAll('SELECT charid, accounts, inventory, loadout, job, job_grade, tattoos, status, firstname, lastname, fake_firstname, fake_lastname, dateofbirth, sex, height, phone_number, odznaka, cardsnumber, slot FROM `users` WHERE `identifier` = @identifier', {
			['@identifier'] = xPlayer.identifier,
		}, function(result)
			local job, grade, jobObject, gradeObject = result[1].job, tostring(result[1].job_grade)
			local foundAccounts, foundItems = {}, {}
			
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
					money = foundAccounts[account] or 0,
					label = label
				})
			end
			
			--Job
			if ESX.DoesJobExist(job, grade) then
				jobObject, gradeObject = Country.Jobs[job], Country.Jobs[job].grades[grade]
			else
				job, grade = 'unemployed', '0'
				jobObject, gradeObject = Country.Jobs[job], Country.Jobs[job].grades[grade]
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

			--EQ
			if result[1].inventory and result[1].inventory ~= '' then
				local inventory = json.decode(result[1].inventory)

				for name,count in pairs(inventory) do
					local item = Country.Items[name]

					if item then
						foundItems[name] = count
					end
				end
			end
			
			for name,item in pairs(Country.Items) do
				
				local count = foundItems[name] or 0

				table.insert(userData.inventory, {
					name = name,
					count = count,
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
			
			if result[1].loadout and result[1].loadout ~= '' then
				local loadout = json.decode(result[1].loadout)

				for id,weapon in pairs(loadout) do
					local label = ESX.GetWeaponLabel(weapon.name)

					if label then
						if not weapon.components then weapon.components = {} end
						if not weapon.tintIndex then weapon.tintIndex = 0 end
						
						table.insert(userData.loadout, {
							name = weapon.name,
							ammo = weapon.ammo,
							id = id,
							number = weapon.number,
							label = label,
							components = weapon.components,
							tintIndex = weapon.tintIndex
						})
				
					end
				end
			end
			
			if result[1].tattoos ~= nil and result[1].tattoos ~= '' then
				userData.tattoos = json.decode(result[1].tattoos)
			else
				userData.tattoos = {}
			end
			
			if result[1].status ~= nil and result[1].status ~= '' then
				userData.status = json.decode(result[1].status)
			else
				userData.status = {}
			end
			
			if result[1].phone_number ~= nil then
				userData.number = tonumber(result[1].phone_number)
			else
				userData.number = nil
			end
			
			if result[1].charid then
				userData.charid = result[1].charid
			end
			
			userData.char = {
				firstname		= result[1].firstname ~= nil and result[1].firstname or 'Brak',
				lastname	 	= result[1].lastname ~= nil and result[1].lastname or 'Brak',
				fake_firstname 	= result[1].fake_firstname ~= nil and result[1].fake_firstname or '',
				fake_lastname 	= result[1].fake_lastname ~= nil and result[1].fake_lastname or '',
				dateofbirth 	= result[1].dateofbirth ~= nil and result[1].dateofbirth or '0000-0-0',
				sex 			= result[1].sex ~= nil and result[1].sex or 'm',
				height 			= result[1].height ~= nil and result[1].height or '180',
				phone_number 	= result[1].phone_number ~= nil and result[1].phone_number or '',
				odznaka 		= result[1].odznaka ~= nil and result[1].odznaka or '',
				cardsnumber 	= result[1].cardsnumber ~= nil and result[1].cardsnumber or '',
				opaska 			= result[1].opaska ~= nil and result[1].opaska or 0,
			}
			
			if result[1].slot ~= nil and result[1].slot ~= '' then
				userData.slot = json.decode(result[1].slot)
			else
				userData.slot = {}
			end
			
			cb()
		end)
	end)
	
	Async.parallel(tasks, function(results)
		local tasked = {}
		
		table.insert(tasked, function(cb)
			TriggerClientEvent('es_admin:setGroup', _source, xPlayer.group)
			TriggerEvent('esx_license:getLicenses', _source, function(licenses)
				TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
			end)
			
			xPlayer.setLoadout(userData.loadout)
			xPlayer.setInventory(userData.inventory)			
			xPlayer.setAccounts(userData.accounts)
			xPlayer.setJobChar(userData.job)
			xPlayer.setchar(userData.charid)
			xPlayer.updateCharAll(userData.char)
			
			xPlayer.setSlots(userData.slot)
			
			cb()
		end)
		
		Async.parallel(tasked, function(results)			
			ESX.Players[_source] = xPlayer
			TriggerEvent('esx:playerLoaded', _source, xPlayer)		
			
			xPlayer.triggerEvent('esx:playerLoaded', {
				accounts = xPlayer.getAccounts(),
				coords = {x = -1045.4, y = -2751.4795, z = 20.4132, heading = 322.81},
				identifier = xPlayer.getIdentifier(),
				inventory = xPlayer.getInventory(),
				job = xPlayer.getJob(),
				loadout = xPlayer.getLoadout(),
				money = xPlayer.getMoney(),
				slots = xPlayer.getSlots(),
				protect = xPlayer.protect
			})
			
			xPlayer.setJob(xPlayer.getJob().name, xPlayer.getJob().grade)
			
			TriggerClientEvent('esx_tattooshop:setTattoos', _source, userData.tattoos)
			TriggerClientEvent('esx_status:load', _source, userData.status)
			TriggerClientEvent('menu:setName', _source, userData.char.firstname.. " " ..userData.char.lastname)
		
			TriggerClientEvent('gcPhone:myPhoneNumber', _source, userData.number)
		end)		
	end)
end)

RegisterServerEvent('country:SetNewChar')
AddEventHandler("country:SetNewChar", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local userData = {
		char = {}
	}
	
	local tasks = {}
	
	table.insert(tasks, function(cb)
		MySQL.Async.fetchAll('SELECT charid FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(results)
			MySQL.Async.fetchAll('SELECT firstname, lastname, fake_firstname, fake_lastname, dateofbirth, sex, height, phone_number, odznaka, cardsnumber FROM users WHERE `identifier` = @identifier AND charid = @charid', {
				['@identifier'] = xPlayer.identifier,
				['@charid']		= results[1].charid
			}, function(result)
				if result[1] ~= nil then	
					--Kasa
					xPlayer.setAccountMoney('money', 5000)
					
					xPlayer.setAccountMoney('bank', 15000)
					xPlayer.setAccountMoney('black_money', 0)
			
					--Itemy
					for k,v in ipairs(xPlayer.inventory) do
						if v.count > 0 then
							xPlayer.removeInventoryItem(v.name, v.count)
						end
					end
					
					--Bronie
					for k,v in ipairs(xPlayer.loadout) do
						xPlayer.removeWeapon(v.name, v.id)
					end

					xPlayer.setJob('unemployed', 0)
					
					if results[1].charid ~= nil then
						xPlayer.setchar(results[1].charid)
					end
					
					userData.char = {
						firstname		= result[1].firstname ~= nil and result[1].firstname or 'Brak',
						lastname	 	= result[1].lastname ~= nil and result[1].lastname or 'Brak',
						fake_firstname 	= result[1].fake_firstname ~= nil and result[1].fake_firstname or '',
						fake_lastname 	= result[1].fake_lastname ~= nil and result[1].fake_lastname or '',
						dateofbirth 	= result[1].dateofbirth ~= nil and result[1].dateofbirth or '0000-0-0',
						sex 			= result[1].sex ~= nil and result[1].sex or 'm',
						height 			= result[1].height ~= nil and result[1].height or '180',
						phone_number 	= result[1].phone_number ~= nil and result[1].phone_number or '',
						odznaka 		= result[1].odznaka ~= nil and result[1].odznaka or '',
						cardsnumber 	= result[1].cardsnumber ~= nil and result[1].cardsnumber or '',
						opaska 			= result[1].opaska ~= nil and result[1].opaska or 0,
					}
					
					xPlayer.Slot = {}
				end
				
				cb()
			end)		
		end)
	end)
	
	Async.parallel(tasks, function(results)
		xPlayer.updateCharAll(userData.char)
		TriggerEvent('esx:datastoreChange', xPlayer)
		TriggerClientEvent('es_admin:setGroup', _source, xPlayer.group)
		TriggerClientEvent('esx_status:load', _source, {})
		TriggerClientEvent('esx_tattooshop:setTattoos', _source, {})
		TriggerClientEvent('menu:setName', _source, userData.char.firstname.. " " ..userData.char.lastname)
		
		TriggerEvent('esx_bank:generatecard', _source)
		TriggerClientEvent('gcPhone:myPhoneNumber', _source, nil)
		
		local date = os.date("*t")
		local sec = (date.year-1970) * 31556926 + (date.yday * 86400) + (3 * 86400)

	
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
		end)
	end)
end)