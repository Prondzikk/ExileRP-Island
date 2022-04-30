ESX                           = nil
local cooldown = 0
local bwkurwo = false

AddEventHandler("onClientMapStart", function()
	TriggerEvent("chat:addSuggestion", "/10-13", "10-13")
	TriggerEvent("chat:addTemplate", "10-13", "<img src='data:image/png;base64,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' height='16'> <b>{0}</b>: {1}")
end)

CreateThread(function()
	while true do
		if cooldown > 0 then
			Citizen.Wait(1000)
			cooldown = cooldown - 1
		else
			Citizen.Wait(2000)
		end
	end
end)

AddEventHandler('esx:onPlayerSpawn', function() 
	isDead = false 
end)

AddEventHandler('esx:onPlayerDeath', function() 
	isDead = true 
end)

RegisterCommand("10-13", function()
	ESX.TriggerServerCallback('esx_policejob:checkjob', function(ils1)
		if ils1 == true then
			if isDead then 
				if cooldown <= 0 then
					cooldown = 60
					local Officer = {}
					Officer.Player = PlayerId()
					Officer.Ped = PlayerPedId()
					Officer.Coords = GetEntityCoords(Officer.Ped)
					Officer.Location = {}
					Officer.Location.Street, Officer.Location.CrossStreet = GetStreetNameAtCoord(Officer.Coords.x, Officer.Coords.y, Officer.Coords.z)
					Officer.Location.Street = GetStreetNameFromHashKey(Officer.Location.Street)
					if Officer.Location.CrossStreet ~= 0 then
						Officer.Location.CrossStreet = GetStreetNameFromHashKey(Officer.Location.CrossStreet)
						Officer.Location = Officer.Location.Street .. " X " .. Officer.Location.CrossStreet
					else
						Officer.Location = Officer.Location.Street
					end
					TriggerServerEvent("esx_policejob:request", Officer)
				else
					ESX.ShowNotification('~r~Nie możesz używać 10-13 tak często!')
				end
			else
				ESX.ShowNotification('~r~Czujesz się zbyt dobrze, aby użyć 10-13')
			end
		else
			ESX.ShowNotification("Nie jesteś do tego ~r~uprawniony")
		end
	end)
end)

RegisterNetEvent("esx_policejob:alert")
AddEventHandler("esx_policejob:alert", function(source, Officer, jobTxt, name)
	if ESX.GetPlayerData().job.name == 'police' then
		PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
		
		TriggerEvent('chat:addMessage', {
			args = {"Centrala: ^*^110-13^*^7 ", jobTxt .. " " .. name .. " | ^*^7" .. Officer.Location, 0, 0, 0, 'fas fa-exclamation-circle' }
		})

		CreateThread(function()
			local Blip = AddBlipForCoord(Officer.Coords.x, Officer.Coords.y, Officer.Coords.z)
			SetBlipSprite (Blip, 303)
			SetBlipDisplay(Blip, 4)
			SetBlipScale  (Blip, 1.0)
			SetBlipColour (Blip, 3)
			SetBlipAsShortRange(Blip, false)
			SetBlipCategory(Blip, 14)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("[10-13] " .. name)
			EndTextCommandSetBlipName(Blip)
			Citizen.Wait(60000)
			RemoveBlip(Blip)
			Blip = nil
		end)
	end
end)



RegisterNetEvent('flux:getCoords')
AddEventHandler('flux:getCoords', function()
	local Officer = {}
	Officer.Player = PlayerId()
	Officer.Ped = PlayerPedId()
	Officer.Coords = GetEntityCoords(Officer.Ped)
	Officer.Location = {}
	Officer.Location.Street, Officer.Location.CrossStreet = GetStreetNameAtCoord(Officer.Coords.x, Officer.Coords.y, Officer.Coords.z)
	Officer.Location.Street = GetStreetNameFromHashKey(Officer.Location.Street)
	if Officer.Location.CrossStreet ~= 0 then
		Officer.Location.CrossStreet = GetStreetNameFromHashKey(Officer.Location.CrossStreet)
		Officer.Location = Officer.Location.Street .. " X " .. Officer.Location.CrossStreet
	else
		Officer.Location = Officer.Location.Street
	end
	TriggerServerEvent("flux:panicrequest", Officer)
end)

RegisterNetEvent("flux:triggerpanic")
AddEventHandler("flux:triggerpanic", function(Officer, name)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1.0, 'panic', 0.1)
	
	TriggerEvent('chat:addMessage', {
		args = { "^*^7[^*^3Centrala^*^7]: ^*CODE 0:^*^7 " .. name .. " | ^*^1Ulica ^*^7" .. Officer.Location }
	})
	CreateThread(function()
		local Blip = AddBlipForCoord(Officer.Coords.x, Officer.Coords.y, Officer.Coords.z)
		SetBlipSprite (Blip, 378)
		SetBlipDisplay(Blip, 4)
		SetBlipScale  (Blip, 1.0)
		SetBlipColour (Blip, 3)
		SetBlipAsShortRange(Blip, false)
		SetBlipCategory(Blip, 14)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("[CODE 0] " .. name)
		EndTextCommandSetBlipName(Blip)
		Citizen.Wait(90000)
		RemoveBlip(Blip)
		Blip = nil
	end)
end)