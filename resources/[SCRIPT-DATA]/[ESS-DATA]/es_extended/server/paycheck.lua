local donttouchme = 'donttouchme:'..math.random(11111111,999999999)..':skidsgang'
local xskapewnie = 'imaginebycdogiem:'..math.random(11111111,999999999)..':skidsgang'

local reviced = {}
local jnbikedfgbkjergboujkgrejkb = TriggerClientEvent

RegisterServerEvent('minutuwa:request')
AddEventHandler('minutuwa:request', function()
    local _source = source
    if not reviced[_source] then
        jnbikedfgbkjergboujkgrejkb("minutuwa:getrequest", _source, donttouchme, xskapewnie)
        reviced[_source] = true
    else
        
        exports.exile_logs:discord(source, "minutuwa:request", "request", true)
    end
end)

RegisterServerEvent(xskapewnie)
AddEventHandler(xskapewnie, function(token)
	local _source = source

	if token == donttouchme then

		local xPlayer = ESX.GetPlayerFromId(_source)
		local job     = xPlayer.job.name
		local praca   = xPlayer.job.label
		local stopien = xPlayer.job.grade_label
		local salary  = xPlayer.job.grade_salary
		local hiddenjob = xPlayer.hiddenjob.name
		local hiddenpraca = xPlayer.hiddenjob.label
		local hiddensalary = xPlayer.hiddenjob.grade_salary
		if salary > 0 then
			if job == 'unemployed' then
				xPlayer.addAccountMoney('bank', salary)
				if hiddenjob ~= 'unemployed' and hiddenjob ~= job then
					xPlayer.addAccountMoney('bank', hiddensalary)
					TriggerClientEvent('FeedM:showAdvancedNotification', xPlayer.source, 'Bank', 'Konto bankowe: ~g~'..xPlayer.getAccount('bank').money..'$~s~', 'Wynagrodzenia:\n~y~Zasiłek: ~g~'..salary..'$\n~y~' .. hiddenpraca .. ':~g~ ' .. hiddensalary .. '$', 'CHAR_BANK_MAZE')
				else
					TriggerClientEvent('FeedM:showAdvancedNotification', xPlayer.source, 'Bank', 'Konto bankowe: ~g~'..xPlayer.getAccount('bank').money..'$~s~', 'Wynagrodzenia:\n~y~Zasiłek: ~g~'..salary..'$', 'CHAR_BANK_MAZE')
				end
			else
				xPlayer.addAccountMoney('bank', salary)
				if hiddenjob ~= 'unemployed' and hiddenjob ~= job then
					xPlayer.addAccountMoney('bank', hiddensalary)
					TriggerClientEvent('FeedM:showAdvancedNotification', xPlayer.source, 'Bank', 'Konto bankowe: ~g~'..xPlayer.getAccount('bank').money..'$~s~', 'Wynagrodzenia:\n~y~'..praca..' - '..stopien..':~g~ '..salary..'$\n~y~' .. hiddenpraca .. ':~g~ ' .. hiddensalary .. '$', 'CHAR_BANK_MAZE')
				else
					TriggerClientEvent('FeedM:showAdvancedNotification', xPlayer.source, 'Bank', 'Konto bankowe: ~g~'..xPlayer.getAccount('bank').money..'$~s~', 'Wynagrodzenia:\n~y~'..praca..' - '..stopien..':~g~ '..salary..'$', 'CHAR_BANK_MAZE')
				end
			end
		end
	else
		exports.exile_logs:discord(_source, "es_extended salary bypassed!!!", "protect", true)
	end
end)