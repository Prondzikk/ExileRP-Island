local rob = false
local robbers = {}
local LastRobbed = 0
local Cooldawn = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function sendToDiscordRabunek(name, message, color)
	local embeds = {
		{
			["description"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "trp_logs",
			},
		}
	}
	if message == nil or message == '' then return FALSE end
	
	local webhok = 'https://discordapp.com/api/webhoks/755819294335434862/Nigx4eVwyZzHmk2ro9qZokxdoOwYtovaxPPJpLX2sl9hy2qZKVma7YukfaQb5qfAOsAh'
	PerformHttpRequest(webhok, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('esx_holdup:tooFar')
AddEventHandler('esx_holdup:tooFar', function(currentStore)
	local _source = source
	local store = Stores[currentStore]
	rob = false
	
	napad = false
	if robbers[_source] then
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)


		TriggerClientEvent('esx_holdup:tooFar', _source, false, '~r~Alarm w obiekcie ~s~' .. Stores[currentStore].name .. '~r~ został wyłączony!')

		local GetPlayers = exports['esx_scoreboard']:MisiaczekPlayers()
		for k,v in pairs(GetPlayers) do
			if v.job == 'police' then
				TriggerClientEvent('esx_holdup:tooFar', v.id, true, '~r~Alarm w obiekcie ~s~' .. Stores[currentStore].name .. '~r~ został wyłączony!')
			end
		end
		
		robbers[_source] = nil
		
		sendToDiscordRabunek('Rabunek | Przerwany', xPlayer.name ..'['..source..'] oddalił się zbyt daleko i zakończył napad na '..Stores[currentStore].name,11750815)
		Cooldawn = Stores[currentStore].delay.failure
	end
end)

RegisterServerEvent('esx_holdup:robberyStarted')
AddEventHandler('esx_holdup:robberyStarted', function(currentStore)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local store = Stores[currentStore]
	local cops = exports['esx_scoreboard']:CounterPlayers('police')
	
	local pass = cops >= Config.typeNapad[store.type].cops
	
	if pass then

		if (os.time() - LastRobbed) <= Cooldawn then
			if math.floor(Cooldawn - (os.time() - LastRobbed)) <= 0 then
				-- nil
			else
				TriggerClientEvent('esx:showNotification', _source, _U('recently_robbed', Cooldawn - (os.time() - LastRobbed)))
				return
			end
		end
		
		if Config.typeNapad[store.type].drill then
			if xPlayer.getInventoryItem('drill').count >= 1 then
				xPlayer.removeInventoryItem('drill', 1)
				napad = true
			else
				TriggerClientEvent('esx:showNotification', _source, '~r~Nie posiadasz drilla')
			end
		else
			napad = true
		end
	else
		xPlayer.showNotification('Minimalnie musi byc ~o~'..tostring(Config.typeNapad[store.type].cops)..'~s~ jednostek żeby rozpocząć napad')
	end
	
	if napad then
		if Stores[currentStore] then

			if not rob then
				rob = true	

				local GetPlayers = exports['esx_scoreboard']:MisiaczekPlayers()
				for k,v in pairs(GetPlayers) do
					if v.job == 'police' then
						TriggerClientEvent('esx_holdup:setBlip', v.id, Stores[currentStore].position, store.name)
					end
				end

				TriggerClientEvent('esx_holdup:animation', _source, Config.typeNapad[store.type].Animation)
				
				TriggerClientEvent('esx:showNotification', _source, _U('started_to_rob', store.name))
				TriggerClientEvent('esx:showNotification', _source, _U('alarm_triggered'))
				sendToDiscordRabunek('Rabunek | Rozpoczęty', xPlayer.name ..'['.._source..'] rozpoczął napad na '..store.name,2061822)
				TriggerClientEvent('esx_holdup:currentlyRobbing', _source, currentStore)
				TriggerClientEvent('esx_holdup:startTimer', _source, Config.typeNapad[store.type].secondsRemaining)
				
				LastRobbed = os.time()
				robbers[_source] = currentStore

				SetTimeout(Config.typeNapad[store.type].secondsRemaining * 1000, function()
					if robbers[_source] then
						rob = false
						if xPlayer then
							TriggerClientEvent('esx_holdup:robberyComplete', _source, store.reward)
							
							if store.rewardItem then
								for k,v in pairs(store.rewardItem) do
									local chance = math.random(1, 100)
									
									if chance <= v then
										xPlayer.addInventoryItem(k, 1)
										xPlayer.showNotification('Udało ci się zdobyć ~b~'..ESX.GetItemLabel(k))
									end
								end
							end
							
							xPlayer.addAccountMoney('black_money', store.reward)
							sendToDiscordRabunek('Rabunek | Udany', xPlayer.name ..'['.._source..'] zakończył napad i wyciągnął z sejfu '..store.reward..'$',56108)
							napad = false

							local GetPlayers = exports['esx_scoreboard']:MisiaczekPlayers()
							for k,v in pairs(GetPlayers) do
								if v.job == 'police' then
									TriggerClientEvent('esx_holdup:killBlip', v.id)
								end
							end						
							
							Cooldawn = Stores[currentStore].delay.success
						end
					end
				end)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('robbery_already'))
			end
		end
	end
end)
