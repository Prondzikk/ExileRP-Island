ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Get history
ESX.RegisterServerCallback('lscmtablet:getHistory', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM lscmtablet_history', {}, function(result)
		if result then
			cb(result)
		else
			cb(false)
		end
	end)
end)

-- Parse doctor
ESX.RegisterServerCallback('lscmtablet:parseDoctor', function(source, cb, data)
	MySQL.Async.fetchAll("SELECT firstname,lastname FROM `users` WHERE `identifier` = @identifier", {['@identifier'] = data.identifier}, function(result)
		if result[1]['firstname'] ~= nil then
			cb(result[1]['firstname'] .. ' ' .. result[1]['lastname'])
		else
			cb('-')
		end
	end)
end)

-- Parse name
ESX.RegisterServerCallback('lscmtablet:parseName', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(id)
	MySQL.Async.fetchAll("SELECT firstname,lastname FROM `users` WHERE `identifier` = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
		if result[1]['firstname'] ~= nil then
			local data = {
				firstname = result[1]['firstname'],
				lastname = result[1]['lastname']
			}
			cb(data)
		else
			local data = {
				firstname = '',
				lastname = ''
			}
			cb(data)
		end
	end)
end)

-- Get assistance (for individual check)
ESX.RegisterServerCallback('lscmtablet:getUserAssistance', function(source, cb, data)
	local name = split(data.name, " ")
	if name[1] ~= nil and name[2] ~= nil then
		MySQL.Async.fetchAll("SELECT firstname,lastname,mechanicyDate,identifier FROM `users` WHERE `firstname` LIKE @firstname AND `lastname` LIKE @lastname", {['@firstname'] = name[1] .. '%', ['@lastname'] = name[2] .. '%'}, function(result)
			if result then
				cb(result)
			else
				cb(false)
			end
		end)
	else
		cb(false)
	end
end)

function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

-- Get assistance (for history)
ESX.RegisterServerCallback('lscmtablet:getAssistance', function(source, cb, data)
	MySQL.Async.fetchAll("SELECT mechanicyDate FROM `users` WHERE `identifier` = @identifier", {['@identifier'] = data.identifier}, function(result)
		if result[1]['mechanicyDate'] ~= nil then
			date = tonumber(result[1]['mechanicyDate'])
			local today = os.date("*t")
			local todaySecond = (today.year-1970) * 31556926 + today.yday * 86400
			if date >= todaySecond then
				local dateSec = os.date("*t", date)
				if dateSec.day < 10 then
					day = '0' .. dateSec.day
				else
					day = dateSec.day
				end
				if dateSec.month < 10 then
					month = '0' .. dateSec.month
				else
					month = dateSec.month
				end
				year = dateSec.year
				cb(day .. '.' .. month .. '.' .. year)
			else
				cb('brak')
			end
		else
			cb('brak')
		end
	end)
end)

function sendToDiscordLSCTABLET (name, message, color)
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "cnt_logs",
			},
		}
	}
	  if message == nil or message == '' then return FALSE end
		PerformHttpRequest('https://discordapp.com/api/webhoks/755823095998316716/81SwbUz2N2YNEaUtLOpfNB4hVAA_rgyElho0edCUlJGtYiSpqXSIcWnDn4qnrGsJGlbf', function(err, text, headers) end, 'POST', json.encode({ username = hook,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

-- Add invoice to history
ESX.RegisterServerCallback('lscmtablet:addHistory', function(source, cb, data)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _data = data.data
	local _target = ESX.GetPlayerFromId(data.target)
	

	if tonumber(_data.price) > 2000000 then
		exports.exile_logs:discord(source, "ciota wyjebała z permem: ["..tostring(data.target).."] lscmtablet:addHistory, "..tostring(_data.price), "protect", true)
		Wait(3000)
		TriggerEvent("BanSql:ICheat", "elo cioto jebana fajnie sie triggerowalo ale juz koniec have fun on discord.gg/sativarp", xPlayer.source)
		return
	end


	_target.removeAccountMoney('bank', tonumber(_data.price))
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanik', function(account)
		local oblicz = math.floor(tonumber(_data.price) / 100 * 5)
		account.addMoney(oblicz)
	end)
	
	xPlayer.showNotification('Wystawiono fakturę dla ['.._target.source..'] o wartości: ~g~'.._data.price..' ~s~$')
	_target.showNotification('Otrzymano fakturę od ['..xPlayer.source..'] o wartości: ~g~'.._data.price..' ~s~$')

	local xvc;TriggerEvent('esx_addonaccount:getSharedAccount','society_police',function(cvb)xvc=cvb end)
	xvc.addMoney(math.floor(tonumber(_data.price) / 100 * 15))

	exports.exile_logs:discord(source, "Wystawił/a fakturę dla ".._target.name.." w wysokości $".._data.price, "tabletmechanik", true)
	
	MySQL.Async.execute('INSERT INTO lscmtablet_history (owner, name, surname, treatment, price, date, doctor) VALUES (@owner, @name, @surname, @treatment, @price, @date, @doctor)', {
		['@owner'] = _target.identifier,
		['@name'] = _data.name,
		['@surname'] = _data.surname,
		['@treatment'] = _data.treatment,
		['@price'] = _data.price,
		['@date'] = _data.date,
		['@doctor'] = xPlayer.identifier
	})
	cb(true)
end)

-- Get default data
ESX.RegisterServerCallback('lscmtablet:getDefaultData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	-- Getting firstname and lastname
	MySQL.Async.fetchAll("SELECT firstname, lastname FROM `users` WHERE `identifier` = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
		if result[1]['firstname'] ~= nil then
			_firstname = result[1]['firstname']
			_lastname = result[1]['lastname']
		else
			_firstname = ''
			_lastname = ''
		end
		-- Getting invoices count
		MySQL.Async.fetchAll("SELECT COUNT(*) as count FROM `lscmtablet_history` WHERE `doctor` = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
			if result[1]['count'] ~= nil then
				_invoices = result[1]['count']
			else
				_invoices = 0
			end

			local data = {
				firstname = _firstname,
				lastname = _lastname,
				invoices = _invoices
			}
			cb(data)
		end)
	end)
end)