--===============================================
--==                 VARIABLES                 ==
--===============================================
local Vehicle = GetVehiclePedIsIn(ped, false)
local inVehicle = IsPedSittingInAnyVehicle(ped)
local lastCar = nil
local myIdentity = {}
local lastGameTimerId = 0
local lastGameTimerPhone = 0
local lastGameTimerOdznaka = 0
local PlayerData = {}
local userName
ESX = nil
local jobTable = {
	{
		job = "sert",
		label = "SERT"
	},
	{
		job = "dtu",
		label = "DTU"
	},
	{
		job = "sheriff",
		label = "SASD"
	},
	{
		job = "police",
		label = "SASP"
	},
	{
		job = "offpolice",
		label = "SASP"
	},{
		job = "ambulance",
		label = "SAMS"
	},
	{
		job = "offambulance",
		label = "SAMS"
	},
	{
		job = "mechanik",
		label = "Los Santos Tuner"
	},
	{
		job = "offmechanik",
		label = "Los Santos Tuner"
	},
	{
		job = "mechanik2",
		label = "Molti Garage"
	},
	{
		job = "offmechanik2",
		label = "Molti Garage"
	},
	{
		job = "doj",
		label = "DOJ"
	},
	{
		job = "psycholog",
		label = "LSPO"
	},
	{
		job = "fib",
		label = "FIB"
	},
}

local Siemanko = {
	job = 'unemployed',
	firstname = '',
	lastname = '',
	hiddenjob = 'unemployed',
	kursy = 0,
}

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)
		
		Citizen.Wait(250)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
	Citizen.Wait(5000)
	TriggerServerEvent('esx_exilemenu:getUserInfo')
end)

RegisterNetEvent('esx_exilemenu:getUserInfo')
AddEventHandler('esx_exilemenu:getUserInfo', function(firstname, lastname, courses)
	Siemanko.kursy = courses
	Siemanko.firstname = firstname
	Siemanko.lastname = lastname
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx:setHiddenJob')
AddEventHandler('esx:setHiddenJob', function(hiddenjob)
	PlayerData.hiddenjob = hiddenjob
end)

RegisterCommand('odznaka', function()
	if PlayerData.job ~= nil or PlayerData.hiddenjob ~= nil then
		local now = GetGameTimer()
		if now > lastGameTimerOdznaka then
			if PlayerData.job.name == 'police' then
				TriggerServerEvent('menu:blacha1', {badge = 'SASP'})
			elseif PlayerData.job.name == 'mechanik' then
				TriggerServerEvent('menu:blacha2', {badge = 'Los Santos Tuners'})
			elseif PlayerData.job.name == 'mechanik2' then
				TriggerServerEvent('menu:blacha4', {badge = 'Molti Garage'})
			elseif PlayerData.job.name == 'ambulance' then
				TriggerServerEvent('menu:blacha3', {badge = 'SAMS'})
			elseif PlayerData.job.name == 'doj' then
				TriggerServerEvent('menu:blacha7', {badge = 'DOJ'})
			elseif PlayerData.job.name == 'psycholog' then
				TriggerServerEvent('menu:blacha8', {badge = 'LSPO'})
			elseif PlayerData.hiddenjob == 'fib' then
				TriggerServerEvent('menu:blacha9', {badge = 'FIB'})
			elseif PlayerData.job.name == 'sheriff' then
				TriggerServerEvent('menu:blacha6', {badge = 'SASD'})
			end
			
			lastGameTimerOdznaka = now + 10000
			if not IsPedInAnyVehicle(PlayerPedId(), true) then
				blachaAnim()
			end
		else
			ESX.ShowNotification('Nie możesz tak często ~r~wyciągać odznaki')
		end
	end
end)

RegisterCommand('exilemenu', function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		type = 'updateInfo',
		name = Siemanko.firstname .. ' ' .. Siemanko.lastname,
		job = PlayerData.job.label .. " - " .. PlayerData.job.grade_label .. ' ' .. Siemanko.kursy,
		hiddenjob = PlayerData.hiddenjob.label .. " - " .. PlayerData.hiddenjob.grade_label,
	})
	
	SendNUIMessage({type = 'openGeneral'})
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, true) then 
		SendNUIMessage({type = 'showVehicleButton'})
	else 
		SendNUIMessage({type = 'hideVehicleButton'})
	end
	local found = 0
	for i = 1, #jobTable, 1 do
		if PlayerData.job.name == jobTable[i].job or PlayerData.hiddenjob.name == jobTable[i].job then
			found = found + 1
			SendNUIMessage({type = 'showBlachaButton' .. tostring(found), value = jobTable[i].label})
			if found == 2 then
				break
			end
		end
	end
	if found == 0 then
		SendNUIMessage({type = 'hideBlachaButton1'})
		SendNUIMessage({type = 'hideBlachaButton2'})
	elseif found == 1 then
		SendNUIMessage({type = 'hideBlachaButton2'})
	end
end)

RegisterKeyMapping('exilemenu', 'Exile-Menu', 'keyboard', 'PAGEUP')

function dowodAnim()
    RequestAnimDict("random@atmrobberygen")
    while not HasAnimDictLoaded("random@atmrobberygen") do 
        Citizen.Wait(1)
    end
    TaskPlayAnim(PlayerPedId(), "random@atmrobberygen", "a_atm_mugging", 8.0, 3.0, 2000, 56, 1, false, false, false)
    wallet = Citizen.InvokeNative(0x509D5878EB39E842, `prop_ld_wallet_01`, GetEntityCoords(PlayerPedId()), true)
    AttachEntityToEntity(wallet, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0x49D9), 0.17, 0.0, 0.019, -120.0, 0.0, 0.0, 1, 0, 0, 0, 0, 1)
    Citizen.Wait(500)
    id = Citizen.InvokeNative(0x509D5878EB39E842, `prop_michael_sec_id`, GetEntityCoords(PlayerPedId()), true)
    AttachEntityToEntity(id, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.150, 0.045, -0.015, 0.0, 0.0, 180.0, 1, 0, 0, 0, 0, 1)
    Citizen.Wait(1300)
    DeleteEntity(wallet)
    DeleteEntity(id)
end

function wizytowkaAnim()
    RequestAnimDict("random@atm_robbery@return_wallet_male")
    while not HasAnimDictLoaded("random@atm_robbery@return_wallet_male") do 
        Citizen.Wait(1)
    end
    local prop = Citizen.InvokeNative(0x509D5878EB39E842, `prop_michael_sec_id`, GetEntityCoords(PlayerPedId()), true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.07, 0.003, -0.045, 90.0, 0.0, 75.0, 1, 0, 0, 0, 0, 1)
    TaskPlayAnim(PlayerPedId(), "random@atm_robbery@return_wallet_male", "return_wallet_positive_a_player", 8.0, 3.0, 1000, 56, 1, false, false, false)
    Citizen.Wait(1000)
    DeleteEntity(prop)
end

function blachaAnim()
    RequestAnimDict("paper_1_rcm_alt1-9")
    while not HasAnimDictLoaded("paper_1_rcm_alt1-9") do 
        Citizen.Wait(1)
    end
    local prop = Citizen.InvokeNative(0x509D5878EB39E842, `prop_fib_badge`, GetEntityCoords(PlayerPedId()), true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 0xDEAD), 0.07, 0.003, -0.065, 90.0, 0.0, 95.0, 1, 0, 0, 0, 0, 1)
    TaskPlayAnim(PlayerPedId(), "paper_1_rcm_alt1-9", "player_one_dual-9", 8.0, 3.0, 1000, 56, 1, false, false, false)
    Citizen.Wait(1000)
    DeleteEntity(prop)
end

--===============================================
--== NUIFocusoff                               ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)

--================================================================================================
--==                                 General Actions GUI                                        ==
--================================================================================================
RegisterNUICallback('NUIGenActions', function()
  SetNuiFocus(true, true)
  SendNUIMessage({type = 'openGeneral'})
end)

function faceNotification(title, subject, msg, playerID)
  local mugshot, mugshotStr = ESX.Game.GetPedMugshot(Citizen.InvokeNative(0x43A66C31C68491C0, GetPlayerFromServerId(playerID)))
  ESX.ShowAdvancedNotification(title, subject, msg, mugshot, 10000)
  UnregisterPedheadshot(mugshot)
end

--===============================================
--== Show ID                                   ==
--===============================================
RegisterNUICallback('toggleid', function(data)
	local now = GetGameTimer()
	if now > lastGameTimerId then
		TriggerServerEvent('menu:id', data)
		lastGameTimerId = now + 10000
		if not IsPedInAnyVehicle(PlayerPedId(), true) then
			dowodAnim()
		end
	else
		ESX.ShowNotification('Nie możesz tak często ~r~wyciągać dowodu')
	end
end)

RegisterNUICallback('lockveh', function(data)
	exports['esx_kluczyki'].LockSystem(PlayerPedId())
end)

RegisterNUICallback('hud', function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
	Citizen.Wait(10)
	exports['exile_hud'].HudConf()
end)


--[[RegisterNUICallback('kartapostaci', function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
	Citizen.Wait(10)
	TriggerEvent('exilerp:kartapostaci', "1")
end)]]

--[[RegisterNUICallback('kartapostaci2', function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
	Citizen.Wait(10)
	TriggerEvent('exilerp:kartapostaci', "2")
end)

RegisterNUICallback('kartapostaci3', function(data)
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
	Citizen.Wait(10)
	TriggerEvent('exilerp:kartapostaci', "3")
end)]]



RegisterCommand('dowod', function()
	local now = GetGameTimer()
	if now > lastGameTimerId then
		TriggerServerEvent('menu:id', data)
		lastGameTimerId = now + 10000
		if not IsPedInAnyVehicle(PlayerPedId(), true) then
			dowodAnim()
		end
	else
		ESX.ShowNotification('Nie możesz tak często ~r~wyciągać dowodu')
	end
end)

RegisterNetEvent('esx_exilemenu:showID')
AddEventHandler('esx_exilemenu:showID', function()
	local now = GetGameTimer()
	if now > lastGameTimerId then
		TriggerServerEvent('menu:id', data)
		lastGameTimerId = now + 10000
	end
end)


RegisterNUICallback('NUIKeysActions', function()
	GiveKeys()
end)

RegisterCommand('keys', function(source, args, raw)
	GiveKeys()
end)

function GiveKeys()	
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if vehicle and GetPedInVehicleSeat(vehicle, -1) == playerPed then
            local targetPed = GetPedInVehicleSeat(vehicle, 0)
            if IsPedInAnyVehicle(targetPed) then
                for _, player in ipairs(GetActivePlayers()) do
                    if targetPed == Citizen.InvokeNative(0x43A66C31C68491C0, player) then
                        TriggerServerEvent('esx_kluczyki:giveKeysAction', GetPlayerServerId(player), GetVehicleNumberPlateText(vehicle, true))
                        break
                    end
                end
            end
        end
    end
end

RegisterNetEvent('sendProximityMessageID')
AddEventHandler('sendProximityMessageID', function(id, citizen, bron, kata, katb, katc, ubezmedtext, ubezmehtext)
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= -1 then
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end

			local str = "Licencja na broń: " .. (bron and "~g~TAK" or "~r~NIE") .. "~s~\n"
			str = str .. "Ubezpieczenie: " .. (ubezmedtext == true and "~g~NNW" or "~r~NNW") .. " " .. (ubezmehtext == true and "~g~OC" or "~r~OC") .. "~s~\n"
			str = str .. "Prawo jazdy, kat.: " .. (kata and "~g~A" or "~r~A") .. " " .. (katb and "~g~B" or "~r~B") .. " " .. (katc and "~g~C" or "~r~C")

			headshot = GetPedheadshotTxdString(headshot)

			local czekamnaawans= {
				d = 'ExileRP',
				s = 'Card',
				a = 255
			}

			local t = {
				d = 'ExileRP',
				s = 'Card',
				a = 255
			}
            if citizen.sex == 'f' then
                t.s = 'f' .. t.s
            else
                t.s = 'm' .. t.s
            end

			if citizen.dateofbirth == nil then
				dobsuko = "BŁĄD"
			else
				dobsuko = citizen.dateofbirth
			end

            local firstname, lastname = citizen.firstname, citizen.lastname
            if citizen.fake_firstname and citizen.fake_firstname ~= '' and citizen.fake_lastname and citizen.fake_lastname ~= '' then
                firstname, lastname = citizen.fake_firstname, citizen.fake_lastname
                t.s = t.s .. 'F'
            end
        
			if playerId == PlayerId() then
				TriggerEvent('chat:addMessage1', "^*".. id, {112, 56, 128}, " pokazuje dowód osobisty: ".." " .. firstname .. " " .. lastname, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0,myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0,pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {112, 56, 128}, " pokazuje dowód osobisty: ".." " .. firstname .. " " .. lastname, "fas fa-address-card")
			end

			TriggerEvent("FeedM:showAdvancedNotification", firstname .. ' ' .. lastname, '~y~' .. (citizen.sex == 'm' and "Mężczyzna" or "Kobieta") .. ', ' .. dobsuko .. ', ' .. citizen.height .. "cm", str, headshot, 10000, czekamnaawans)
		end)		
	end
end)

--===============================================
--== Show Phone Number                         ==
--===============================================
RegisterNUICallback('togglephone', function(data)
	local now = GetGameTimer()
	if now > lastGameTimerPhone then
		TriggerServerEvent('menu:phone', data)
		lastGameTimerPhone = now + 10000
		if not IsPedInAnyVehicle(PlayerPedId(), true) then
			wizytowkaAnim()
		end
	else
		ESX.ShowNotification('Nie możesz tak często ~r~wyciągać wizytówki')
	end
end)

RegisterCommand('wizytowka', function()
	local now = GetGameTimer()
	if now > lastGameTimerPhone then
		TriggerServerEvent('menu:phone', data)
		lastGameTimerPhone = now + 10000
		if not IsPedInAnyVehicle(PlayerPedId(), true) then
			wizytowkaAnim()
		end
	else
		ESX.ShowNotification('Nie możesz tak często ~r~wyciągać wizytówki')
	end
end)

local falszywyCwel = false
local falszywyPedal = false

RegisterNetEvent('sendProximityMessagePhone')
AddEventHandler('sendProximityMessagePhone', function(id, citizen, jobName, jobLabel, gradeLabel)
	local playerId = GetPlayerFromServerId(id)

	if playerId ~= -1 then
	
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end
		
		if citizen.phone_number ~= nil then
			number = citizen.phone_number
		else
			number = 'Brak karty SIM'
		end

		if citizen.account_number ~= nil then
			account = citizen.account_number
		else
			account = 'Brak konta bankowego'
		end

		if number ~= 'Brak karty SIM' then
			falszywyCwel = number
			CreateThread(function() 
				Wait(4000)
				while falszywyPedal == true do
					Citizen.Wait(100)
				end
				falszywyCwel = false
			end)
		end	

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end

			headshot = GetPedheadshotTxdString(headshot)
			
			local czekamnaawans= {
				d = 'ExileRP',
				s = 'Card2',
				a = 255
			}

			local t = {
				d = 'ExileRP',
				s = 'Card2',
				a = 255
			}

            if citizen.sex == 'f' then
                t.s = 'f' .. t.s
            else
                t.s = 'm' .. t.s
            end
        
            local firstname, lastname = citizen.firstname, citizen.lastname
            if citizen.fake_firstname and citizen.fake_firstname ~= '' and citizen.fake_lastname and citizen.fake_lastname ~= '' then
                firstname, lastname = citizen.fake_firstname, citizen.fake_lastname
                t.s = t.s .. 'F'
            end
			
			if playerId == PlayerId() then
				--TriggerEvent('chatMessage',"^*Obywatel["  .. id .. "] pokazuje wizytówkę: " .. number, {255, 152, 247})
				TriggerEvent('chat:addMessage1', "^*"..id, {112, 56, 128}, " pokazuje wizytówkę: ".." " .. firstname .. " " .. lastname .. " " .. number, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {112, 56, 128}, " pokazuje wizytówkę: ".." " .. firstname .. " " .. lastname .. " " .. number, "fas fa-address-card")
			end

			TriggerEvent("FeedM:showAdvancedNotification", firstname, '~y~' .. jobLabel .. " - " .. gradeLabel, "~o~Numer telefonu:~w~ " .. number .. "\n~o~Numer konta:~w~ " .. account, headshot, 10000, czekamnaawans)

		end)
	end
end)

CreateThread(function() 
	while true do
		if falszywyCwel and not falszywyPedal then
			Wait(0)
			ESX.ShowHelpNotification('Naciśnij ~INPUT_CONTEXT~ aby zapisać numer')
			if IsControlJustPressed(0, 51) then
				AddTextEntry('FMMC_KEY_TIP1', "Podaj nazwę kontaktu")
				DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP1", "", "", "", "", "", 64)
				falszywyPedal = true
			end	
		else
			Wait(100)	
		end	
	end	
end)

CreateThread(function() 
	while true do
		Wait(100)
		if falszywyPedal then
			if UpdateOnscreenKeyboard() == 3 then
				falszywyPedal = false
			elseif UpdateOnscreenKeyboard() == 1 then
				local inputText = GetOnscreenKeyboardResult()
				if string.len(inputText) > 0 then
					exports['gcphone']:addContact(inputText, falszywyCwel)
					falszywyPedal = false
				else
					AddTextEntry('FMMC_KEY_TIP1', "Podaj nazwę kontaktu")
					DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP1", "", "", "", "", "", 64)
				end
			elseif UpdateOnscreenKeyboard() == 2 then
				falszywyPedal = false
			end
		end
	end	
end)


--===============================================
--== Pokaz blache	                           ==
--===============================================
RegisterNUICallback('toggleblacha', function(data)	
	local now = GetGameTimer()
	if now > lastGameTimerOdznaka then
		if PlayerData.job.name == 'police' then
			TriggerServerEvent('menu:blacha1', data)
		elseif PlayerData.job.name == 'mechanik' then
			TriggerServerEvent('menu:blacha2', data)
		elseif PlayerData.job.name == 'mechanik2' then
			TriggerServerEvent('menu:blacha4', data)
		elseif PlayerData.job.name == 'ambulance' then
			TriggerServerEvent('menu:blacha3', data)
		elseif PlayerData.job.name == 'doj' then
			TriggerServerEvent('menu:blacha7', data)
		elseif PlayerData.job.name == 'psycholog' then
			TriggerServerEvent('menu:blacha8', data)
		elseif PlayerData.job.name == 'fib' then
			TriggerServerEvent('menu:blacha9', data)
		elseif PlayerData.job.name == 'sheriff' then
			TriggerServerEvent('menu:blacha6', data)
		end
		lastGameTimerOdznaka = now + 10000
		if not IsPedInAnyVehicle(PlayerPedId(), true) then
			blachaAnim()
		end
	else
		ESX.ShowNotification('Nie możesz tak często ~r~wyciągać odznaki')
	end
end)


function ShowOdznaka()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped, false) then
		Citizen.CreateThread(function()
			RequestAnimDict("random@atm_robbery@return_wallet_male")
			while not HasAnimDictLoaded("random@atm_robbery@return_wallet_male") do		
				Citizen.Wait(1)
			end


			TaskPlayAnim(ped, "random@atm_robbery@return_wallet_male", "return_wallet_positive_a_player", 8.0, 3.0, 1000, 56, 1, false, false, false)
			Citizen.Wait(1000)
			DeleteObject(object)
		end)
	end
end

RegisterNetEvent('sendProximityMessageBlacha1')
AddEventHandler('sendProximityMessageBlacha1', function(id, citizen, jobName, jobLabel, gradeLabel)
	local source = sid
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= -1 then
	
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end
			
			local odznaka = citizen.odznaka
			local subject = "["..odznaka .. "] " .. citizen.firstname .. " " .. citizen.lastname.. " - " .. jobLabel

			local gigadev  = {
				d = 'ExileRP',
				s = 'Card5',
				a = 255
			}

			local t = {
                d = 'CHAR_BANK_MAZE',
                s = 'warning',
                a = 180
			}

			local str = "Numer odznaki: " .. ("~y~"..odznaka) .. "~s~\n"
			str = str .. "Stopień: " .. ("~y~"..gradeLabel)

			headshot = GetPedheadshotTxdString(headshot)
			
			local firstname, lastname = citizen.firstname, citizen.lastname
			if citizen.fake_firstname and citizen.fake_firstname ~= '' then
				firstname, lastname = citizen.fake_firstname, citizen.fake_lastname
			end
			
			if playerId == PlayerId() then
				--TriggerEvent('chatMessage', "^*Obywatel [".. id .."]", {255, 152, 247}, " pokazuje identyfikator: ".." " .. subject)
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " wyciąga odznakę ".." " .. subject, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " wyciąga odznakę ".." " .. subject, "fas fa-address-card")
			end
			TriggerEvent("FeedM:showAdvancedNotification", firstname..' '..lastname, '~y~Identyfikator - ' .. jobLabel, str, headshot, 10000, gigadev)
		end)
	end
end)
RegisterNetEvent('sendProximityMessageBlacha2')
AddEventHandler('sendProximityMessageBlacha2', function(id, citizen, jobName, jobLabel, gradeLabel)
	local source = sid
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= -1 then
	
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end
			
			local odznaka = citizen.odznaka
			local subject = "["..odznaka .. "] " .. citizen.firstname .. " " .. citizen.lastname.. " - Los Santos Tuners"

			local gigadev  = {
				d = 'ExileRP',
				s = 'Card3',
				a = 255
			}


			local t = {
                d = 'CHAR_BANK_MAZE',
                s = 'warning',
                a = 180
			}

			local str = "Numer odznaki: " .. ("~y~"..odznaka) .. "~s~\n"

			headshot = GetPedheadshotTxdString(headshot)
			
			local firstname, lastname = citizen.firstname, citizen.lastname
			if citizen.fake_firstname and citizen.fake_firstname ~= '' then
				firstname, lastname = citizen.fake_firstname, citizen.fake_lastname
			end
			
			if playerId == PlayerId() then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje identyfikator: ".." " .. subject, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje identyfikator: ".." " .. subject, "fas fa-address-card")
			end
			TriggerEvent("FeedM:showAdvancedNotification", firstname..' '..lastname, '~y~Identyfikator - Los Santos Tuners', str, headshot, 10000, gigadev)
		end)
	end
end)
RegisterNetEvent('sendProximityMessageBlacha3')
AddEventHandler('sendProximityMessageBlacha3', function(id, citizen, jobName, jobLabel, gradeLabel)
	local source = sid
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= -1 then
	
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end
			
			local odznaka = citizen.odznaka
			local subject = "["..odznaka .. "] " .. citizen.firstname .. " " .. citizen.lastname.. " - " .. jobLabel

			local gigadev  = {
				d = 'ExileRP',
				s = 'Card4',
				a = 255
			}


			local t = {
                d = 'CHAR_BANK_MAZE',
                s = 'warning',
                a = 180
			}

			local str = "Numer odznaki: " .. ("~y~"..odznaka) .. "~s~\n"
			str = str .. "Stopień: " .. ("~y~"..gradeLabel)

			headshot = GetPedheadshotTxdString(headshot)
			
			local firstname, lastname = citizen.firstname, citizen.lastname
			if citizen.fake_firstname and citizen.fake_firstname ~= '' then
				firstname, lastname = citizen.fake_firstname, citizen.fake_lastname
			end
			
			if playerId == PlayerId() then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje identyfikator SAMS: ".." " .. subject, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje identyfikator SAMS: ".." " .. subject, "fas fa-address-card")
			end
			TriggerEvent("FeedM:showAdvancedNotification", firstname..' '..lastname, '~y~Identyfikator - ' .. jobLabel, str, headshot, 10000, gigadev)
		end)
	end
end)

RegisterNetEvent('sendProximityMessageBlacha4')
AddEventHandler('sendProximityMessageBlacha4', function(id, citizen, jobName, jobLabel, gradeLabel)
	local source = sid
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= -1 then
	
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end
			
			local odznaka = citizen.odznaka
			local subject = "[".. odznaka .. "] " .. citizen.firstname .. " " .. citizen.lastname.. " - " .. jobLabel

			local gigadev  = {
				d = 'ExileRP',
				s = 'Card3',
				a = 255
			}


			local t = {
                d = 'CHAR_BANK_MAZE',
                s = 'warning',
                a = 180
			}

			local str = "Numer odznaki: " .. ("~y~"..odznaka) .. "~s~\n"
			str = str .. "Stopień: " .. ("~y~"..gradeLabel)

			headshot = GetPedheadshotTxdString(headshot)
			
			local firstname, lastname = citizen.firstname, citizen.lastname
			if citizen.fake_firstname and citizen.fake_firstname ~= '' then
				firstname, lastname = citizen.fake_firstname, citizen.fake_lastname
			end
			
			if playerId == PlayerId() then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje legitymacje adwokacką: ".." " .. subject, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje legitymacje adwokacką: ".." " .. subject, "fas fa-address-card")
			end
			TriggerEvent("FeedM:showAdvancedNotification", firstname..' '..lastname, '~y~Identyfikator - ' .. jobLabel, str, headshot, 10000, gigadev)
		end)
	end
end)

RegisterNetEvent('sendProximityMessageBlacha5')
AddEventHandler('sendProximityMessageBlacha5', function(id, citizen, jobName, jobLabel, gradeLabel)
	local source = sid
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= -1 then
	
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end
			
			local odznaka = citizen.odznaka
			local subject = "[".. odznaka .. "] " .. citizen.firstname .. " " .. citizen.lastname.. " - " .. jobLabel

			local gigadev  = {
				d = 'ExileRP',
				s = 'Card5',
				a = 255
			}


			local t = {
                d = 'CHAR_BANK_MAZE',
                s = 'warning',
                a = 180
			}

			local str = "Numer odznaki: " .. ("~y~"..odznaka) .. "~s~\n"
			str = str .. "Stopień: " .. ("~y~"..gradeLabel)

			headshot = GetPedheadshotTxdString(headshot)
			
			local firstname, lastname = citizen.firstname, citizen.lastname
			if citizen.fake_firstname and citizen.fake_firstname ~= '' then
				firstname, lastname = citizen.fake_firstname, citizen.fake_lastname
			end
			
			if playerId == PlayerId() then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje identyfikator psychologa: ".." " .. subject, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje identyfikator psychologa: ".." " .. subject, "fas fa-address-card")
			end
			TriggerEvent("FeedM:showAdvancedNotification", firstname..' '..lastname, '~y~Identyfikator - ' .. jobLabel, str, headshot, 10000, gigadev)
		end)
	end
end)
RegisterNetEvent('sendProximityMessageBlacha6')
AddEventHandler('sendProximityMessageBlacha6', function(id, citizen, jobName, jobLabel, gradeLabel)
	local source = sid
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= -1 then
	
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end
			
			local odznaka = citizen.odznaka
			local subject = "["..odznaka .. "] " .. citizen.firstname .. " " .. citizen.lastname.. " - " .. jobLabel

			local gigadev  = {
				d = 'ExileRP',
				s = 'Card6',
				a = 255
			}


			local t = {
                d = 'CHAR_BANK_MAZE',
                s = 'warning',
                a = 180
			}

			local str = "Numer odznaki: " .. ("~y~"..odznaka) .. "~s~\n"
			str = str .. "Stopień: " .. ("~y~"..gradeLabel)

			headshot = GetPedheadshotTxdString(headshot)
			
			local firstname, lastname = citizen.firstname, citizen.lastname
			if citizen.fake_firstname and citizen.fake_firstname ~= '' then
				firstname, lastname = citizen.fake_firstname, citizen.fake_lastname
			end
			
			if playerId == PlayerId() then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " wyciąga blache: ".." " .. subject, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " wyciąga blache: ".." " .. subject, "fas fa-address-card")
			end
			TriggerEvent("FeedM:showAdvancedNotification", firstname..' '..lastname, '~y~Identyfikator - ' .. jobLabel, str, headshot, 10000, gigadev)
		end)
	end
end)

RegisterNetEvent('sendProximityMessageBlacha7')
AddEventHandler('sendProximityMessageBlacha7', function(id, citizen, jobName, jobLabel, gradeLabel)
	local source = sid
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	local jobLabel = "Department of Justice"
	
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= -1 then
	
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end
			
			local odznaka = citizen.odznaka
			local subject = "[".. odznaka .. "] " .. citizen.firstname .. " " .. citizen.lastname.. " - " .. jobLabel

			local gigadev  = {
				d = 'ExileRP',
				s = 'Card7',
				a = 255
			}


			local t = {
                d = 'CHAR_BANK_MAZE',
                s = 'warning',
                a = 180
			}

			local str = "Numer odznaki: " .. ("~y~"..odznaka) .. "~s~"

			headshot = GetPedheadshotTxdString(headshot)
			
			local firstname, lastname = citizen.firstname, citizen.lastname
			if citizen.fake_firstname and citizen.fake_firstname ~= '' then
				firstname, lastname = citizen.fake_firstname, citizen.fake_lastname
			end
			
			if playerId == PlayerId() then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje legitymacje adwokacką: ".." " .. subject, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje legitymacje adwokacką: ".." " .. subject, "fas fa-address-card")
			end
			TriggerEvent("FeedM:showAdvancedNotification", firstname..' '..lastname, '~y~Identyfikator - ' .. jobLabel, str, headshot, 10000, gigadev)
		end)
	end
end)

RegisterNetEvent('sendProximityMessageBlacha8')
AddEventHandler('sendProximityMessageBlacha8', function(id, citizen, jobName, jobLabel, gradeLabel)
	local source = sid
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	local jobLabel = "Los Santos Psychologist Office"
	
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= -1 then
	
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end
			
			local odznaka = citizen.odznaka
			local subject = "[".. odznaka .. "] " .. citizen.firstname .. " " .. citizen.lastname.. " - " .. jobLabel

			local gigadev  = {
				d = 'ExileRP',
				s = 'Card8',
				a = 255
			}


			local t = {
                d = 'CHAR_BANK_MAZE',
                s = 'warning',
                a = 180
			}

			local str = "Numer odznaki: " .. ("~y~"..odznaka) .. "~s~"

			headshot = GetPedheadshotTxdString(headshot)
			
			local firstname, lastname = citizen.firstname, citizen.lastname
			if citizen.fake_firstname and citizen.fake_firstname ~= '' then
				firstname, lastname = citizen.fake_firstname, citizen.fake_lastname
			end
			
			if playerId == PlayerId() then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje identyfikator psychologa: ".." " .. subject, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje identyfikator psychologa: ".." " .. subject, "fas fa-address-card")
			end
			TriggerEvent("FeedM:showAdvancedNotification", firstname..' '..lastname, '~y~Identyfikator - ' .. jobLabel, str, headshot, 10000, gigadev)
		end)
	end
end)

RegisterNetEvent('sendProximityMessageBlacha9')
AddEventHandler('sendProximityMessageBlacha9', function(id, citizen, jobName, jobLabel, gradeLabel)
	local source = sid
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	
	local playerId = GetPlayerFromServerId(id)
	if playerId ~= -1 then
	
		local playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, playerId)
		if playerId ~= PlayerId() then
			if #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(playerPed, true)) > 3.0 then
				return
			end
		end

		CreateThread(function()
			local headshot = RegisterPedheadshot(playerPed)
			while not IsPedheadshotReady(headshot) do
				Citizen.Wait(1)
			end
			
			local odznaka = citizen.odznaka
			local subject = "["..odznaka .. "] - " .. jobLabel

			local gigadev  = {
				d = 'ExileRP',
				s = 'Card9',
				a = 255
			}


			local t = {
                d = 'CHAR_BANK_MAZE',
                s = 'warning',
                a = 180
			}

			local str = "Numer odznaki: " .. ("~y~"..odznaka) .. "~s~\n"
			str = str .. "Stopień: " .. ("~y~"..gradeLabel)

			headshot = GetPedheadshotTxdString(headshot)
			
			local firstname = "Agent"
			local lastname = "FIB"
			
			if playerId == PlayerId() then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje identyfikator FIB: ".." " .. subject, "fas fa-address-card")
			elseif #(GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, myId)) - GetEntityCoords(Citizen.InvokeNative(0x43A66C31C68491C0, pid))) < 19.999 then
				TriggerEvent('chat:addMessage1', "^*"..id, {145, 129, 39}, " pokazuje identyfikator FIB: ".." " .. subject, "fas fa-address-card")
			end
			TriggerEvent("FeedM:showAdvancedNotification", firstname..' '..lastname, '~y~Identyfikator - ' .. jobLabel, str, headshot, 10000, gigadev)
		end)
	end
end)
--================================================================================================
--==                                 Vehicles Actions GUI                                        ==
--================================================================================================
RegisterNUICallback('NUIVehicleActions', function()
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openVehicles'})
end)

--================================================================================================
--==                                   Door Actions GUI                                         ==
--================================================================================================
RegisterNUICallback('NUIDoorActions', function()
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openDoorActions'})
end)

RegisterNUICallback('toggleFrontLeftDoor', function()
   local playerPed = PlayerPedId()
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 0, false)            
       else
         SetVehicleDoorOpen(playerVeh, 0, false)             
      end
   end
end)

RegisterNUICallback('toggleFrontRightDoor', function()
   local playerPed = PlayerPedId()
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 1, false)            
       else
         SetVehicleDoorOpen(playerVeh, 1, false)             
      end
   end
end)

RegisterNUICallback('toggleBackLeftDoor', function()
   local playerPed = PlayerPedId()
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 2, false)            
       else
         SetVehicleDoorOpen(playerVeh, 2, false)             
      end
   end
end)

RegisterNUICallback('toggleBackRightDoor', function()
   local playerPed = PlayerPedId()
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 3, false)            
       else
         SetVehicleDoorOpen(playerVeh, 3, false)             
      end
   end
end)

RegisterNUICallback('toggleHood', function()
   local playerPed = PlayerPedId()
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 4, false)            
       else
         SetVehicleDoorOpen(playerVeh, 4, false)             
      end
   end
end)

RegisterNUICallback('toggleTrunk', function()
   local playerPed = PlayerPedId()
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 5, false)            
       else
         SetVehicleDoorOpen(playerVeh, 5, false)             
      end
   end
end)

RegisterNUICallback('toggleWindowsUp', function()
	local playerPed = PlayerPedId()
	local playerVeh = GetVehiclePedIsIn(playerPed, false)
	if ( IsPedSittingInAnyVehicle( playerPed ) ) then
		RollUpWindow(playerVeh, 0)
		RollUpWindow(playerVeh, 1)
		RollUpWindow(playerVeh, 2)
		RollUpWindow(playerVeh, 3)
	end
end)

RegisterNUICallback('toggleWindowsDown', function()
	local playerPed = PlayerPedId()
	local playerVeh = GetVehiclePedIsIn(playerPed, false)
	if ( IsPedSittingInAnyVehicle( playerPed ) ) then
		RollDownWindow(playerVeh, 0)
		RollDownWindow(playerVeh, 1)
		RollDownWindow(playerVeh, 2)
		RollDownWindow(playerVeh, 3)
	end
end)

--================================================================================================
--==                                Windows Actions GUI                                         ==
--================================================================================================
RegisterNUICallback('NUIWindowActions', function()
  SetNuiFocus(true, true)
  SendNUIMessage({type = 'openWindows'})
end)