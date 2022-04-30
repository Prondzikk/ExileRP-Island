ESX                 = nil
local Jobs = {}
local RegisteredSocieties = {}


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetSociety(name)
	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			return RegisteredSocieties[i]
		end
	end
end

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

	for i=1, #result, 1 do
		Jobs[result[i].name]        = result[i]
		Jobs[result[i].name].grades = {}
	end

	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

	for i=1, #result2, 1 do
		Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
	end
end)
function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	if identifier == nil then
		DropPlayer(source, "Wystąpił problem z Twoją postacią. Połącz się z serwerem ponownie lub napisz ticket!")
	else
		local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
		if result[1] ~= nil then
			local identity = result[1]

			return {
				identifier = identity['identifier'],
				firstname = identity['firstname'],
				lastname = identity['lastname'],
				dateofbirth = identity['dateofbirth'],	
				sex = identity['sex'],
				height = identity['height'],
				job = identity['job'],
				hiddenjob = identity['hiddenjob'],
				hiddenjob_grade = identity['hiddenjob_grade']
			}
		else
			return nil
		end
	end
end


function getIdentityGPS(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	if identifier == nil then
		DropPlayer(source, "Wystąpił problem z Twoją postacią. Połącz się z serwerem ponownie lub napisz ticket!")
		return {
				firstname = "off",
				lastname = "off"
			}
	else
		local result = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
		
		if result[1] ~= nil then
			local identity = result[1]
			return {
				firstname = identity.firstname,
				lastname = identity.lastname
			}
		else
			return {
				firstname = "off",
				lastname = "off"
			}
		end
	end
end


AddEventHandler('esx_society:registerSociety', function(name, label, account, datastore, inventory, data)
	local found = false

	local society = {
		name      = name,
		label     = label,
		account   = account,
		datastore = datastore,
		inventory = inventory,
		data      = data,
	}

	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			found = true
			RegisteredSocieties[i] = society
			break
		end
	end

	if not found then
		table.insert(RegisteredSocieties, society)
	end
end)

AddEventHandler('esx_society:getSocieties', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('esx_society:getSociety', function(name, cb)
	cb(GetSociety(name))
end)





RegisterServerEvent('spoleczenstwo:wyplacajSzmato')
AddEventHandler('spoleczenstwo:wyplacajSzmato', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name ~= society then
		exports.exile_logs:discord(source, "spoleczenstwo:wyplacajSzmato, "..society..", "..amount, "protect", true)
		return
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. society, function(account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)
			xPlayer.addMoney(amount)

			if string.find(society, "org") then
				exports.exile_logs:discord(source, "("..society..") Wypłacił/a "..amount.."$ z szafki", "withdraworg", true)
			else
				exports.exile_logs:discord(source, "("..society..") Wypłacił/a "..amount.."$ z szafki", "bossmenu", true)
			end

			exports.exile_logs:discord(source, "JOB Wypłacił/a pieniądze ["..society..", "..amount.."]", "bossmenu", true)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', ESX.Math.GroupDigits(amount)))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	end)
end)

RegisterServerEvent('esx_society:giveMoney')
AddEventHandler('esx_society:giveMoney', function(zyd, society, amount)
	local _source = source
	local sourceplayer = ESX.GetPlayerFromId(_source)
	local targetplayer = ESX.GetPlayerFromId(zyd)
	if sourceplayer.source ~= targetplayer.source then
		if sourceplayer.job.name == targetplayer.job.name or sourceplayer.job.name == "off"..targetplayer.job.name then
			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. society, function(account)
				if amount > 0 and account.money >= amount then
					account.removeMoney(amount)
					targetplayer.addMoney(amount)
					exports.exile_logs:discord(_source, "Dał/a premie dla ["..targetplayer.source.."] "..targetplayer.name.." | "..targetplayer.identifier, "bossmenu", true)
					TriggerClientEvent('esx:showNotification', sourceplayer.source, "Przelewasz ~g~$" .. amount .. '~s~ dla obywatela ~y~' .. targetplayer.character.firstname .. ' ' .. targetplayer.character.lastname)
					TriggerClientEvent('esx:showNotification', targetplayer.source, "Otrzymujesz ~g~$" .. amount .. '~s~ od swojego pracodawcy')	
				else
					TriggerClientEvent('esx:showNotification', sourceplayer.source, _U('invalid_amount'))
				end
			end)
		else
			exports.exile_logs:discord(_source, "esx_society:giveMoney", "protect", true)
			return
		end
	else
		exports.exile_logs:discord(_source, "esx_society:giveMoney", "protect", true)
		return
	end
end)

RegisterServerEvent('spoleczenstwo:wyplacajUkryteSzmato')
AddEventHandler('spoleczenstwo:wyplacajUkryteSzmato', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.hiddenjob.name ~= society then
		exports.exile_logs:discord(source, "spoleczenstwo:wyplacajUkryteSzmato, "..society..", "..amount, "protect", true)
		return
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..society, function(account)
		if amount > 0 and account.money >= amount then

			if string.find(society, "org") then
				exports.exile_logs:discord(source, "("..society..") Wypłacił/a "..amount.."$ z szafki", "withdraworg", true)
			else
				exports.exile_logs:discord(source, "("..society..") Wypłacił/a "..amount.."$ z szafki", "bossmenu", true)
			end


			account.removeMoney(amount)
			xPlayer.addMoney(amount)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', ESX.Math.GroupDigits(amount)))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	end)
end)


RegisterServerEvent('spoleczenstwo:wyplacajUkryteSzmatoBlack')
AddEventHandler('spoleczenstwo:wyplacajUkryteSzmatoBlack', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.hiddenjob.name ~= society or tonumber(amount) < 0 then
		exports.exile_logs:discord(source, "CHEATER PRÓBA Wypłacił/a pieniądze ["..society.."_black, "..amount.."]", "protect", true)
		return
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..society.."_black", function(account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)
			xPlayer.addAccountMoney("black_money", amount)

			if string.find(society, "org") then
				exports.exile_logs:discord(source, "("..society.."_black) Wypłacił/a "..amount.."$ z szafki", "withdraworg", true)
			else
				exports.exile_logs:discord(source, "("..society.."_black) Wypłacił/a "..amount.."$ z szafki", "bossmenu", true)
			end

			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', ESX.Math.GroupDigits(amount)))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	end)
end)



RegisterServerEvent('spoleczenstwo:kitrajUkrytyHajsBlack')
AddEventHandler('spoleczenstwo:kitrajUkrytyHajsBlack', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.hiddenjob.name ~= society or tonumber(amount) < 0 then
		exports.exile_logs:discord(source, "CHEATER PRÓBA Wpłacił/a pieniądze ["..society.."_black, "..amount.."]", "protect", true)
		return
	end

	if amount > 0 and xPlayer.getAccount("black_money").money >= amount  then
		TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..society.."_black", function(account)
			xPlayer.removeAccountMoney("black_money", amount)
			account.addMoney(amount)

			if string.find(society, "org") then
				exports.exile_logs:discord(source, "("..society.."_black) Wpłacił/a "..amount.."$ do szafki", "depositorg", true)
			else
				exports.exile_logs:discord(source, "("..society.."_black) Wpłacił/a "..amount.."$ do szafki", "bossmenu", true)
			end

		end)
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', ESX.Math.GroupDigits(amount)))
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
	end
end)

RegisterServerEvent('spoleczenstwo:kitrajHajs')
AddEventHandler('spoleczenstwo:kitrajHajs', function(society, amount, paying)
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name ~= society or tonumber(amount) < 0 then
		exports.exile_logs:discord(source, "spoleczenstwo:wyplacajUkryteSzmato, "..society..", "..amount, "protect", true)
		return
	end

	if amount > 0 and xPlayer.getMoney() >= amount  then
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_' .. society, function(account)
			xPlayer.removeMoney(amount)
			account.addMoney(amount)
		end)

		if string.find(society, "org") then
			exports.exile_logs:discord(source, "("..society..") Wpłacił/a "..amount.."$ do szafki", "depositorg", true)
		else
			exports.exile_logs:discord(source, "("..society..") Wpłacił/a "..amount.."$ do szafki", "bossmenu", true)
		end


		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', ESX.Math.GroupDigits(amount)))
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
	end

end)

RegisterServerEvent('spoleczenstwo:kitrajUkrytyHajs')
AddEventHandler('spoleczenstwo:kitrajUkrytyHajs', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.hiddenjob.name ~= society or tonumber(amount) < 0 then
		exports.exile_logs:discord(source, "spoleczenstwo:kitrajUkrytyHajs, "..society..", "..amount, "protect", true)
		return
	end

	if amount > 0 and xPlayer.getMoney() >= amount  then
		TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..society, function(account)
			xPlayer.removeMoney(amount)
			account.addMoney(amount)
		end)
		if string.find(society, "org") then
			exports.exile_logs:discord(source, "("..society..") Wpłacił/a "..amount.."$ do szafki", "depositorg", true)
		else
			exports.exile_logs:discord(source, "("..society..") Wpłacił/a "..amount.."$ do szafki", "bossmenu", true)
		end
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', ESX.Math.GroupDigits(amount)))
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
	end
end)

RegisterServerEvent('esx_society:putVehicleInGarage')
AddEventHandler('esx_society:putVehicleInGarage', function(societyName, vehicle)
	local society = GetSociety(societyName)

	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}

		table.insert(garage, vehicle)
		store.set('garage', garage)
	end)
end)

RegisterServerEvent('esx_society:removeVehicleFromGarage')
AddEventHandler('esx_society:removeVehicleFromGarage', function(societyName, vehicle)
	local society = GetSociety(societyName)

	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}

		for i=1, #garage, 1 do
			if garage[i].plate == vehicle.plate then
				table.remove(garage, i)
				break
			end
		end

		store.set('garage', garage)
	end)
end)

ESX.RegisterServerCallback('esx_society:getSocietyMoney', function(source, cb, societyName)
	local society = GetSociety(societyName)
	local benckaska = {
		normal = 0,
		black = 0,
	}

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..societyName, function(account)
		if account.money ~= nil then
			benckaska.normal = account.money
		else
			print('')
			print('')
			print('')
			print('Error 1 esx_society:getSocietyMoney societyName: '..societyName)
			print('')
			print('')
			print('')
			cb("Błąd")
		end
	end)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..societyName..'_black', function(account)
		if account ~= nil then
			benckaska.black = account.money
		else
			benckaska.black = 0
		end
	end)

	cb(benckaska)
end)


ESX.RegisterServerCallback('flux:pokazUkrytychKlapkow', function(source, cb, society)
	MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, hiddenjob, hiddenjob_grade, kursy, odznakakurwa FROM users WHERE hiddenjob = @hiddenjob ORDER BY job_grade DESC', {
		['@hiddenjob'] = society
	}, function (results)
		local employees = {}

		for i=1, #results, 1 do
			table.insert(employees, {
				name       = results[i].firstname .. ' ' .. results[i].lastname,
				identifier = results[i].identifier,
				hiddenjob = {
					name        = results[i].hiddenjob,
					label       = Jobs[results[i].hiddenjob].label,
					grade       = results[i].hiddenjob_grade,
					grade_name  = Jobs[results[i].hiddenjob].grades[tostring(results[i].hiddenjob_grade)].name,
					grade_label = Jobs[results[i].hiddenjob].grades[tostring(results[i].hiddenjob_grade)].label
				},
			})
		end

		cb(employees)
	end)
end)


ESX.RegisterServerCallback('society:countHiddenMembers', function(source, cb, society)
    local count = MySQL.Sync.fetchScalar("SELECT COUNT(1) FROM users WHERE `hiddenjob` = '"..society.."'")
    cb(count)
end)

ESX.RegisterServerCallback('esx_society:getEmployees', function(source, cb, society)
	MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, job, job_grade, kursy, odznakakurwa FROM users WHERE job = @job ORDER BY job_grade DESC', {
		['@job'] = society
	}, function (results)
		local employees = {}

		for i=1, #results, 1 do
			table.insert(employees, {
				name       = results[i].firstname .. ' ' .. results[i].lastname,
				identifier = results[i].identifier,
				job = {
					name        = results[i].job,
					label       = Jobs[results[i].job].label,
					grade       = results[i].job_grade,
					grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
					grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label,
					kursy		= results[i].kursy
				},
				badge = {
					number        = results[i].odznakakurwa,
				}
			})
		end

		cb(employees)
	end)
end)

ESX.RegisterServerCallback('esx_society:hiddenjob', function(source, cb)
	local player = getIdentity(source)
	local hiddenjobname = player.hiddenjob

	cb(hiddenjobname)
end)


ESX.RegisterServerCallback('esx_kurwa:getLicensesList', function(source, cb)

	MySQL.Async.fetchAll('SELECT firstname, lastname, identifier FROM users WHERE job = @job', {
		['@job'] = "police"
	}, function (results)

		local id = {}
		for i=1, #results, 1 do

			table.insert(id, results[i].identifier)
			MySQL.Async.fetchAll('SELECT * FROM users_licenses WHERE identifier = @identifiers', {
				['@identifiers'] = "steam:110000141309a14"
			}, function (results2)
				local employees = {}
				for i=1, #results2, 1 do
					table.insert(employees, {
						name       = name,
						licenses = results2[i].type
					})
				end
				
				cb(employees)
			end)
		end
	end)
end)



RegisterServerEvent('esx_society:setBadge')
AddEventHandler('esx_society:setBadge', function(user, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job.grade_name == 'boss'
	if isBoss then
		local xTarget = ESX.GetPlayerFromIdentifier(user.identifier)

		if xTarget then
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~Zaktualizowano odznakę dla: ' ..  xTarget.source)
			TriggerClientEvent('esx:showNotification', xTarget.source, '~g~Twoja odznaka została zaktualizowana przez: '.. xPlayer.source)
			MySQL.Async.execute('UPDATE users SET odznakakurwa = @odznakakurwa WHERE identifier = @identifier', {
				['@odznakakurwa'] = amount,
				['@identifier']   = user.identifier
			})
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~Zaktualizowano odznakę!')
			MySQL.Async.execute('UPDATE users SET odznakakurwa = @odznakakurwa WHERE identifier = @identifier', {
				['@odznakakurwa'] = amount,
				['@identifier']   = user.identifier
			})
		end
	end
end)

ESX.RegisterServerCallback('esx_society:getEmployees2', function(source, cb, society)
	if Config.EnableESXIdentity then

		MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, hiddenjob, hiddenjob_grade FROM users WHERE hiddenjob = @hiddenjob ORDER BY hiddenjob_grade DESC', {
			['@hiddenjob'] = society
		}, function (results)
			local employees = {}

			for i=1, #results, 1 do
				table.insert(employees, {
					name       = results[i].firstname .. ' ' .. results[i].lastname,
					identifier = results[i].identifier,
					hiddenjob = results[i].hiddenjob,
					hiddenjob_grade = results[i].hiddenjob_grade
				})
			end

			cb(employees)
		end)
	else
		MySQL.Async.fetchAll('SELECT name, identifier, hiddenjob, hiddenjob_grade FROM users WHERE hiddenjob = @hiddenjob ORDER BY hiddenjob_grade DESC', {
			['@hiddenjob'] = society
		}, function (result)
			local employees = {}

			for i=1, #result, 1 do
				table.insert(employees, {
					name       = result[i].name,
					identifier = result[i].identifier,
					hiddenjob = results[i].hiddenjob,
					hiddenjob_grade = results[i].hiddenjob_grade
				})
			end

			cb(employees)
		end)
	end
end)

ESX.RegisterServerCallback('esx_society:getJob', function(source, cb, society)
	local job    = json.decode(json.encode(Jobs[society]))
	local grades = {}

	for k,v in pairs(job.grades) do
		table.insert(grades, v)
	end

	table.sort(grades, function(a, b)
		return a.grade < b.grade
	end)

	job.grades = grades

	cb(job)
end)

ESX.RegisterServerCallback('flux:pokazKlapkow', function(source, cb, job)
	local xPlayer = ESX.GetPlayerFromId(source)
	if job then

		MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, job, job_grade, odznakakurwa, rybakkursy, kawiarniakursy, milkmankursy FROM users WHERE job = @job ORDER BY job_grade DESC', {
			['@job'] = job
		}, function (results)
			local employees = {}

			for i=1, #results, 1 do
				local kursy = 0
				if job == 'fisherman' then 
					kursy = results[i].rybakkursy
				elseif job == 'milkman' then
					kursy = results[i].milkmankursy
				elseif job == 'kawiarnia' then
					kursy = results[i].kawiarniakursy
				end
				table.insert(employees, {
					name       = results[i].firstname .. ' ' .. results[i].lastname,
					identifier = results[i].identifier,
					badge = {
						number = results[i].odznakakurwa,
					},
					job = {
						name        = results[i].job,
						label       = Jobs[results[i].job].label,
						grade       = results[i].job_grade,
						courses     = kursy,
						grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
						grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label,
					}
				})
			end

			cb(employees)
		end)
	
	end
end)

ESX.RegisterServerCallback('esx_society:setJob', function(source, cb, identifier, job, grade, type, job2, society)
	local xPlayer = ESX.GetPlayerFromId(source)
		
	if job2 ~= society and type == 'fire' then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)
		
		if xTarget ~= nil then
			TriggerClientEvent('esx:setJob', xTarget.source, xTarget.getJob(), true)
		end
		
		cb()
		return
	end
	
	if type == 'fire' then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)
		if xTarget then
			if xTarget.identifier == identifier then
				xTarget.setJob(job, grade)
			end
			
			TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_fired', xTarget.getJob().label))
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier,
			}, function(rowsChanged)
				if rowsChanged then
					cb()
				end
			end)
		else			
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				if rowsChanged then
					cb()		
				end
			end)	
		end
		return
	end

	if type == 'hire' then
		local xPlayer2 = ESX.GetPlayerFromId(identifier)		
		if xPlayer2 ~= nil then
			xPlayer2.setJob(job, grade)
			TriggerClientEvent('esx:showNotification', xPlayer2.source, _U('you_have_been_hired', job))
			
			
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = xPlayer2.identifier
			}, function(rowsChanged)
				if rowsChanged then
					cb()			
				end
			end)
		end
		return	
	end

	if type == 'promote' then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)
		if xTarget then
			if xTarget.identifier == identifier then
				xTarget.setJob(job, grade)
			end
			
			TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_promoted'))
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				if rowsChanged then
					cb()			
				end
			end)	
		else			
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				if rowsChanged then
					cb()			
				end
			end)	
		end		
	end
end)

ESX.RegisterServerCallback('esx_society:zeruj_kursy', function(source, cb, identifier)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job.grade_name == 'boss'
	if isBoss then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)
		local praca = xPlayer.job.name

		if praca == 'fisherman' then 
			falszywycwel = 'rybakkursy'
		elseif praca == 'kawiarnia' then 
			falszywycwel = 'kawiarniakursy'
		elseif praca == 'milkman' then
			falszywycwel = 'milkmankursy'
		end

		if xTarget then
			TriggerClientEvent('esx:showNotification', xTarget.source, 'Twoje kursy zostały zresetowwane!')
			MySQL.Async.execute('UPDATE users SET ' .. falszywycwel .. ' = @kursy WHERE identifier = @identifier', {
				['@kursy']      = '0',
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)
		else
			MySQL.Async.execute('UPDATE users SET ' .. falszywycwel .. ' = @kursy WHERE identifier = @identifier', {
				['@kursy']      = '0',
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	else
		exports.exile_logs:discord(source, "esx_society:zeruj_kursy, "..identifier, "protect", true)
		cb()
	end
end)


ESX.RegisterServerCallback('esx_society:setHiddenJob', function(source, cb, identifier, job, grade, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	if string.find(identifier, "steam:") then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)
		if xTarget ~= nil then
			xTarget.setHiddenJob(job, grade)

			if xTarget.source then


				if type == 'hire' then
					TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_hired', job))
				elseif type == 'promote' then
					TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_promoted'))
				elseif type == 'fire' then
					TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_fired', xTarget.getHiddenJob().label))
				end
				MySQL.Async.execute('UPDATE users SET hiddenjob = @hiddenjob, hiddenjob_grade = @hiddenjob_grade WHERE identifier = @identifier', {
					['@hiddenjob']        = job,
					['@hiddenjob_grade']  = grade,
					['@identifier'] = identifier
				}, function(rowsChanged)

					cb()
				end)
			else
				MySQL.Async.execute('UPDATE users SET hiddenjob = @hiddenjob, hiddenjob_grade = @hiddenjob_grade WHERE identifier = @identifier', {
					['@hiddenjob']        = job,
					['@hiddenjob_grade']  = grade,
					['@identifier'] 	  = identifier
				}, function(rowsChanged)
					cb()
				end)
			end
		else
			MySQL.Async.execute('UPDATE users SET hiddenjob = @hiddenjob, hiddenjob_grade = @hiddenjob_grade WHERE identifier = @identifier', {
				['@hiddenjob']        = job,
				['@hiddenjob_grade']  = grade,
				['@identifier'] 	  = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	else
		local xTarget = ESX.GetPlayerFromId(identifier)
		local identifier = xTarget.identifier
		if xTarget ~= nil then
			xTarget.setHiddenJob(job, grade)

			if xTarget.source then


				if type == 'hire' then
					TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_hired', job))
				elseif type == 'promote' then
					TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_promoted'))
				elseif type == 'fire' then
					TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_fired', xTarget.getHiddenJob().label))
				end
				MySQL.Async.execute('UPDATE users SET hiddenjob = @hiddenjob, hiddenjob_grade = @hiddenjob_grade WHERE identifier = @identifier', {
					['@hiddenjob']        = job,
					['@hiddenjob_grade']  = grade,
					['@identifier'] = identifier
				}, function(rowsChanged)

					cb()
				end)
			else

				MySQL.Async.execute('UPDATE users SET hiddenjob = @hiddenjob, hiddenjob_grade = @hiddenjob_grade WHERE identifier = @identifier', {
					['@hiddenjob']        = job,
					['@hiddenjob_grade']  = grade,
					['@identifier'] 	  = identifier
				}, function(rowsChanged)
					cb()
				end)
			end
		else
			MySQL.Async.execute('UPDATE users SET hiddenjob = @hiddenjob, hiddenjob_grade = @hiddenjob_grade WHERE identifier = @identifier', {
				['@hiddenjob']        = job,
				['@hiddenjob_grade']  = grade,
				['@identifier'] 	  = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	end
end)

RegisterServerEvent('esx_society:giveLicense')
AddEventHandler('esx_society:giveLicense', function(identifier, data)
	MySQL.Async.execute('INSERT INTO user_licenses (owner, type, time) VALUES (@owner, @type, -1)', {
		['@owner'] = identifier,
		['@type']    = data,
	}, function(rowsChanged)
		exports.exile_logs:discord(source, 'Dodał/a licencję '..data..' dla: '..identifier, 'licensepolice', true)
	--	TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have', ESX.Math.GroupDigits(amount)))
	end)
end)

RegisterServerEvent('esx_society:getLicense')
AddEventHandler('esx_society:getLicense', function(identifier, data)
	MySQL.Async.execute('DELETE FROM user_licenses WHERE owner = @owner and type = @type', {
		['@owner'] = identifier,
		['@type']  = data,
	}, function(rowsChanged)
		exports.exile_logs:discord(source, 'Odebrał/a licencję '..data..' dla: '..identifier, 'licensepolice', true)
	--	TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have', ESX.Math.GroupDigits(amount)))
	end)
end)

ESX.RegisterServerCallback('esx_society:getEmployeeslic', function(source, cb, society)
	MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, job, job_grade FROM users WHERE job = @job ORDER BY job_grade DESC', {
		['@job'] = society	
	}, function (results)
		local employees = {}
		local count = 0		
		for i=1,99 do if results[i] ~= nil then count = i else break end end
			
			for i=1, #results, 1 do
				local seu = false
				local sert = false
				local usms = false
				local usms = false
				local dtu = false
				local heli = false	
				local nurek = false	
                local aiad = false
				MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
					['@owner'] = results[i].identifier,	
				}, function (results2)
					for k,v in pairs (results2) do
						
						if v.type == 'seu' then
							seu = true
						elseif v.type == 'sert' then
							sert = true
						elseif v.type == 'usms' then
							usms = true
						elseif v.type == 'dtu' then
							dtu = true
						elseif v.type == 'heli' then
							heli = true
						elseif v.type == 'nurek' then
							nurek = true
						elseif v.type == 'aiad' then
							aiad = true
						end
					end	
					table.insert(employees, {
						name       = results[i].firstname .. ' ' .. results[i].lastname,
						identifier = results[i].identifier,
						licensess = {
						--	name = {
								seu = seu,
								sert = sert,
								usms = usms,
								dtu = dtu,
								heli = heli,
								nurek = nurek,
								aiad = aiad,
						--	}
						},
	
				})	
				if count == i then
					cb(employees)
				end				
			end)	
		end
	end)
end)


ESX.RegisterServerCallback('esx_society:setJobSalary', function(source, cb, job, grade, salary)
	local isBoss = isPlayerBoss(source, job)

	local identifier = GetPlayerIdentifier(source, 0)
	if isBoss then
		if salary <= Config.MaxSalary then
			MySQL.Async.execute('UPDATE job_grades SET salary = @salary WHERE job_name = @job_name AND grade = @grade', {
				['@salary']   = salary,
				['@job_name'] = job,
				['@grade']    = grade
			}, function(rowsChanged)
				Jobs[job].grades[tostring(grade)].salary = salary
				local xPlayers = ESX.GetPlayers()

				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

 					if xPlayer.job.name == job and xPlayer.job.grade == grade then
						xPlayer.setJob(job, grade)
					end
				end

 				cb()
			end)
		else
			--print(('esx_society: %s attempted to setJobSalary over config limit!'):format(identifier))
			cb()
		end
	else
		--print(('esx_society: %s attempted to setJobSalary'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('esx_society:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.source,
			job        = xPlayer.job
		})
	end

	cb(players)
end)

ESX.RegisterServerCallback('esx_society:getOnlinePlayersGPS', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		local moreinfo = getIdentityGPS(xPlayers[i])  		-- more info potrzebne do callbacków na GPS, zeby pobrac imie i nazwisko gracza
		if moreinfo ~= nil then
			table.insert(players, {
				source     = xPlayer.source,
				identifier = xPlayer.identifier,
				name       = xPlayer.name,
				firstname  = moreinfo.firstname,
				lastname   = moreinfo.lastname,
				job        = xPlayer.job
			})
		else
			table.insert(players, {
				source     = xPlayer.source,
				identifier = xPlayer.identifier,
				name       = xPlayer.name,
				firstname  = "off",
				lastname   = "off",
				job        = xPlayer.job
			})
		end
		
		
	end
	cb(players)
end)


ESX.RegisterServerCallback('esx_society:getVehiclesInGarage', function(source, cb, societyName)
	local society = GetSociety(societyName)

	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
		local garage = store.get('garage') or {}
		cb(garage)
	end)
end)

ESX.RegisterServerCallback('esx_society:isBoss', function(source, cb, job)
	cb(isPlayerBoss(source, job))
end)

function isPlayerBoss(playerId, job)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer.job.name == job and xPlayer.job.grade_name == 'boss' or xPlayer.job.grade_name == 'urzednik6' or xPlayer.job.grade_name == 'zcadyrektora' or xPlayer.job.grade_name == 'zcakomenda' or xPlayer.job.grade_name == 'uber' or xPlayer.job.grade_name == 'kierownik' or xPlayer.job.grade_name == 'kapitan3' then
		return true
	else
		--print(('esx_society: %s attempted open a society boss menu!'):format(xPlayer.identifier))
		return false
	end
end








------------ zlomus i jego jebana pasta z exilerp POZDRAWIAM!


-- licencje

ESX.RegisterServerCallback('exile_legaljobs:getLicenses', function(source, cb, society)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local licka = {}
    print(society)
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

-- zbieraj zydow kurwo

ESX.RegisterServerCallback('society:countMembers', function(source, cb, society)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zlomuspewniedev = MySQL.Sync.fetchScalar("SELECT COUNT(1) FROM users WHERE `job` = '".. society .."'")
    cb(zlomuspewniedev)
end)


ESX.RegisterServerCallback("esx_society:getMeNames",function(source, callback, ids)
    local identities = {}
    for k,v in pairs(ids) do
        local xPlayer = ESX.GetPlayerFromId(v)

        identities[v] = tostring(xPlayer.character.firstname) .." ".. tostring(xPlayer.character.lastname)
    end
    callback(identities)
end)

local licensed = {}
RegisterServerEvent('esx_policejob:loadLicense')
AddEventHandler('esx_policejob:loadLicense', function()
	licensed = {}
	MySQL.Async.fetchAll("SELECT owner, type FROM user_licenses WHERE type = @type OR type = @type2 OR type = @type3 OR type = @type4 OR type = @type5 OR type = @type6 OR type = @type7",{
		['@type'] 	= 'seu',
		['@type2']  = 'swat',
		['@type3']  = 'dtu',
		['@type4']  = 'eagle',
		['@type5']  = 'wmk2',
		['@type6']  = 'sert',
		['@type7']  = 'awsu',
	}, function(results)
		local lol = {}
		for i=1, #results, 1 do
			table.insert(licensed, results[i])
		end
	end)
end)

function getPlayerLicenses(owner, type)
	local found = false
	for k,v in ipairs(licensed) do
		if v.owner == owner and v.type == type then
			found = true
			break
		end
	end

	if not found then
		return '❌'
	else
		return '✔️'
	end
end


ESX.RegisterServerCallback('flux:pokazLicencje', function(source, cb, job)
	MySQL.Async.fetchAll('SELECT identifier, firstname, lastname FROM users WHERE job = @job',{
		['@job'] = job
	}, function(results)
		local lol = {}

		for i=1, #results, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(results[i].identifier)

			table.insert(lol, {
				identifier  = results[i].identifier,
				name       	= results[i].firstname .. ' ' .. results[i].lastname,
				licenses 	= {
					seu   = getPlayerLicenses(results[i].identifier, 'seu'),
					swat  = getPlayerLicenses(results[i].identifier, 'swat'),
					dtu   = getPlayerLicenses(results[i].identifier, 'dtu'),
					eagle = getPlayerLicenses(results[i].identifier, 'eagle'),
					wmk2  = getPlayerLicenses(results[i].identifier, 'wmk2'),
					sert  = getPlayerLicenses(results[i].identifier, 'sert')
				}
			})
		end
		
		cb(lol)
	end)

end)

RegisterServerEvent('esx:policejob:removeLicenseOffline')
AddEventHandler('esx:policejob:removeLicenseOffline', function(identifier, type)
	MySQL.Async.execute('DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type'] = type,
		['@owner'] = identifier
	}, function(rowsChanged)
		for k,v in ipairs(licensed) do
			if v.owner == identifier and v.type == type then
				table.remove(licensed, k)
				exports.exile_logs:discord(source, 'Usunął/ęłą licencję '..type..' dla: '..identifier, 'licensepolice', true)
				local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
				if xPlayer then
					TriggerEvent('esx_policejob:licenses', xPlayer.source)
				end
			end
		end
	end)
end)

RegisterServerEvent('esx:policejob:addLicenseOffline')
AddEventHandler('esx:policejob:addLicenseOffline', function(identifier, type)
  	MySQL.Async.execute('INSERT INTO user_licenses (owner, type) VALUES (@owner, @type)', {
     	['@owner'] = identifier,
     	['@type']   = type
    }, function(rowsChanged)
		table.insert(licensed, {owner = identifier, type = type})
		exports.exile_logs:discord(source, 'Dodał/a licencję '..type..' dla: '..identifier, 'licensepolice', true)
		local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
		if xPlayer then
			TriggerEvent('esx_policejob:licenses', xPlayer.source)
		end
	end)
end)