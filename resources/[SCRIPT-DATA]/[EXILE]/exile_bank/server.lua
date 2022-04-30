
--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GenerateAccountNumber()
    local running = true
    local account = nil
    while running do
        local rand = '' .. math.random(1111111,9999999)
        local count = MySQL.Sync.fetchScalar("SELECT COUNT(account_number) FROM users WHERE account_number = @account_number", { ['@account_number'] = rand })
		if count < 1 then
			account = rand
			running = false
        end
    end
    return account
end

AddEventHandler('esx:playerLoaded',function(playerId, xPlayer)
	local _source = playerId
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT account_number FROM users WHERE identifier = @identifier',
	{
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].account_number == nil or result[1].account_number == '0' then
			local accountNumber = GenerateAccountNumber()
			MySQL.Async.execute('UPDATE users SET account_number = @account_number WHERE identifier = @identifier',
			{
				['@identifier'] = xPlayer.identifier,
				['@account_number'] = accountNumber
			})
		end
	end)
end)

RegisterServerEvent('xlem0n_bank:deposit')
AddEventHandler('xlem0n_bank:deposit', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('esx:showNotification', _source, "~r~Niepoprawna kwota!")
	else
		xPlayer.removeMoney(amount)
		TriggerClientEvent('esx:showNotification', _source, "~y~Pomyślnie wpłacono gowtówkę w kwocie ~g~" .. amount .. "$")
		xPlayer.addAccountMoney('bank', tonumber(amount))
		exports.exile_logs:discord(_source, 'Wpłacił/a '..amount..'$', 'deposit', false)
	end
end)


RegisterServerEvent('xlem0n_bank:withdraw')
AddEventHandler('xlem0n_bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('esx:showNotification', _source, "~r~Niepoprawna kwota!")
	else
		xPlayer.removeAccountMoney('bank', amount)
		TriggerClientEvent('esx:showNotification', _source, "~y~Pomyślnie wyplacono gowtówkę w kwocie ~g~" .. amount .. "$")
		xPlayer.addMoney(amount)
		exports.exile_logs:discord(_source, 'Wypłacił/a '..amount..'$', 'withdraw', false)
	end
end)

RegisterServerEvent('xlem0n_bank:balance')
AddEventHandler('xlem0n_bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('currentbalance1', _source, balance)
	
end)


RegisterServerEvent('csskrouble_bank:showTransfers')
AddEventHandler('csskrouble_bank:showTransfers', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT * FROM exile_transfers WHERE account_number = @account_number',
	{ 
		['@account_number'] = xPlayer.character.account_number
	}, function(result)
		TriggerClientEvent('csskrouble_bank:callbackTransfers', _source, result)
	end)
end)

RegisterServerEvent('xlem0n_bank:transfer')
AddEventHandler('xlem0n_bank:transfer', function(to, amountt, anon, contestt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local identifier = xPlayer.identifier
    local steamhex = GetPlayerIdentifier(_source)
	local balance = 0
	local found = false
	local tresc = nil
	local str = string.len(contestt)
	local dane = 'Brak'
	if str > 0 then 
		tresc = contestt
	else
		tresc = 'Brak'
	end
	if anon then 
		dane = "Anonimowego nadawcy"
	else 
		dane = xPlayer.character.firstname .. ' ' .. xPlayer.character.lastname
	end

	MySQL.Async.fetchAll('SELECT * FROM users WHERE account_number = @account_number',
	{ 
		['@account_number'] = to
	},
	function (result)
		if result[1] ~= nil then
			local targetbankaccount = result[1].account_number
			local targetbabkbalance = json.decode(result[1].accounts)
			local targetidentifier = result[1].identifier
			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',
			{ 
				['@identifier'] = identifier
			}, function (result2)
				if result2[1] ~= nil then
					local sourcebankaccount = result2[1].account_number
					if targetbankaccount == sourcebankaccount then
						TriggerClientEvent('xlem0n_bank:result', _source, "error", "Przelew nieudany.")
						TriggerClientEvent('esx:showNotification', _source, "~r~Przelew nieudany.")
					else
						balance = xPlayer.getAccount('bank').money
						if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
							TriggerClientEvent('xlem0n_bank:result', _source, "error", "Przelew nieudany.")
							TriggerClientEvent('esx:showNotification', _source, "~r~Przelew nieudany.")
						else
							local newtargetbabkbalance = targetbabkbalance.bank + amountt
							xPlayer.removeAccountMoney('bank', tonumber(amountt))
							local xdddddd = "Brak"
							if dane == "Anonimowego nadawcy" then 
								xdddddd = "Anonimowy Nadawca"
							else
								xdddddd = xPlayer.character.firstname .. ' ' .. xPlayer.character.lastname
							end
							MySQL.Async.execute('INSERT INTO exile_transfers (account_number, from_label, money, title) VALUES (@account_number, @from_label, @money, @title)',
								{
									['@account_number'] = targetbankaccount,
									['@from_label'] = xdddddd,
									['@money'] = amountt,
									['@title'] = tresc,

								}
							)
							for i=1, #xPlayers, 1 do
								local xPlayerx = ESX.GetPlayerFromId(xPlayers[i])
								if xPlayerx.identifier == targetidentifier then
									xPlayerx.addAccountMoney('bank', tonumber(amountt))
									found = true
									TriggerClientEvent('esx:showNotification', xPlayers[i], "~y~Otrzymałeś przelew ~s~ na kwotę ~g~" .. amountt .."$ ~y~od " .. dane .." ~s~o treści ~y~" .. tresc)
									ESX.SavePlayers()
									exports.exile_logs:discord(_source, 'Przelał/a '..amountt..'$ na konto ['..targetbankaccount..']', 'transfer', false)
								end
							end
							if not found then
								MySQL.Async.execute('UPDATE users SET accounts = JSON_SET(accounts, "$.bank", @newBank) WHERE account_number = @account_number',
									{
										['@account_number'] = targetbankaccount,
										['@newBank'] = newtargetbabkbalance
									}
								)
							end
							TriggerClientEvent('xlem0n_bank:result', _source, "success", "Pieniadze zostaly przelane na inne konto.")
							TriggerClientEvent('esx:showNotification', _source, "~y~Wyslaleś przelew na kwotę ~g~" .. amountt .."$ ~s~na konto ~y~" .. to)
							exports.exile_logs:discord(_source, 'Przelał/a '..amountt..'$ na konto ['..targetbankaccount..']', 'transfer', false)
						end
					end
				else
					TriggerClientEvent('xlem0n_bank:result', _source, "error", "Przelew nieudany.")
					TriggerClientEvent('esx:showNotification', _source, "~r~Przelew nieudany.")
				end
			end)
		else
			TriggerClientEvent('xlem0n_bank:result', _source, "error", "Przelew nieudany.")
			TriggerClientEvent('esx:showNotification', _source, "~r~Przelew nieudany.")
		end
	end)
end)

ESX.RegisterServerCallback('xlem0n_bank:character', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer then 
		cb(('Imię i nazwisko: %s %s <br>Numer konta: %s'):format(xPlayer.character.firstname, xPlayer.character.lastname, xPlayer.character.account_number))
	else
		cb('Imię i nazwisko: Brak <br>Numer konta: Brak')
	end
end)