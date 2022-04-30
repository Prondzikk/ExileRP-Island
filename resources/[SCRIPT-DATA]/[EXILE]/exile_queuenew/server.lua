ESX 						   = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Config = {}
Config.AntiSpamTimer = 5
Config.TimerCheckPlaces = 3
Config.TimerRefreshClient = 3

Config.Points = {}

Config.NoSteam = "Nie wykryto Steam. Wyłącz FiveM oraz zresetuj/włącz Steam."
Config.Next = "Jesteś następny w kolejce!"
Config.Waiting = "W kolejce jest "
Config.Waiting2 = " graczy. Poczekaj na swoją kolej.\n"
Config.EmojiMsg = "Jeżeli emotki się zatrzymają, zrestartuj FiveM : "
Config.PleaseWait_1 = "Poczekaj jeszcze "
Config.PleaseWait_2 = " sekund. Weryfikujemy dane Twojego konta..."
Config.Accident = "Wykryto błąd połączenia."
Config.Error = "ERROR : Skontaktuj się z administratorem serwera."


Config.EmojiList = {
	'🐌', 
	'🐍',
	'🐎', 
	'🐑', 
	'🐒',
	'🐘', 
	'🐙', 
	'🐛',
	'🐜',
	'🐝',
	'🐞',
	'🐟',
	'🐠',
	'🐡',
	'🐢',
	'🐤',
	'🐦',
	'🐧',
	'🐩',
	'🐫',
	'🐬',
	'🐲',
	'🐳',
	'🐴',
	'🐅',
	'🐈',
	'🐉',
	'🐋',
	'🐀',
	'🐇',
	'🐏',
	'🐐',
	'🐓',
	'🐕',
	'🐖',
	'🐪',
	'🐆',
	'🐄',
	'🐃',
	'🐂',
	'🐁',
	'🔥'
}

BackList = {}
players = {}
waiting = {}
connecting = {}
disconnected = {}
allTickets = {}
firstDisconnected = {}
nextPlayer = nil
tick = 1

EmojiList = Config.EmojiList

StopResource('hardcap')

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if GetResourceState('hardcap') == 'stopped' then
			StartResource('hardcap')
		end
	end
end)

AddEventHandler("playerConnecting", function(name, reject, def)
	local source	= source
	local steamID = GetSteamID(source)
	print('siemaconnecting')
	if not steamID then
		reject(Config.NoSteam)
		CancelEvent()
		return
	end
	
	if not Rocade(steamID, def, source) then
		CancelEvent()
	end
	
	if GetPlayerName(source) ~= nil then
		--print(('[crrp_kolejka] [^2INFO^7] Connecting Player "%s^7"'):format(GetPlayerName(source)))
	end
end)

Citizen.CreateThread(function()
	local maxServerSlots = 180
	print(maxServerSlots)
	
	while true do
		Citizen.Wait(Config.TimerCheckPlaces * 1000)

		CheckConnecting()
		if #waiting > 0 and #connecting + GetNumPlayerIndices() + #disconnected < maxServerSlots and #firstDisconnected == 0 then
			ConnectFirst()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if #firstDisconnected > 0 then
			for k,v in pairs(firstDisconnected) do
				local now = os.time()
				if v[2] < now then
					nextPlayer = nil
					table.remove(firstDisconnected, k)
				end
			end
		else
			Citizen.Wait(20000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if #disconnected > 0 then
			for k,v in pairs(disconnected) do
				local now = os.time()
				if v[2] < now then
					table.remove(disconnected, k)
				end
			end
		else
			Citizen.Wait(20000)
		end
	end
end)

RegisterServerEvent("crrp_queue:playerKicked")
AddEventHandler("crrp_queue:playerKicked", function(src, points)
	local sid = GetSteamID(src)
	Purge(sid)
end)

RegisterServerEvent("crrp_queue:playerConnected")
AddEventHandler("crrp_queue:playerConnected", function()
	local sid = GetSteamID(source)
	Purge(sid)
end)

AddEventHandler("playerDropped", function()
	local steamID = GetSteamID(source)
	table.insert(disconnected, {steamID, (os.time() + 75)})
	Purge(steamID)
end)