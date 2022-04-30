local resourceName = GetCurrentResourceName()

RegisterServerEvent(resourceName)
AddEventHandler(resourceName, function()
    local script = [=[local standardVolumeOutput = 1.0;

RegisterNetEvent('InteractSound_CL:PlayOnOne')
AddEventHandler('InteractSound_CL:PlayOnOne', function(soundFile, soundVolume)
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = soundFile,
        transactionVolume   = soundVolume
    })
end)

RegisterNetEvent('InteractSound_CL:PlayOnAll')
AddEventHandler('InteractSound_CL:PlayOnAll', function(soundFile, soundVolume)
    TriggerServerEvent("InteractSound_SV:PlayOnSource")
end)

RegisterNetEvent('InteractSound_CL:PlayWithinDistanceOS')
AddEventHandler('InteractSound_CL:PlayWithinDistanceOS', function(playerCoords, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, playerCoords.x, playerCoords.y, playerCoords.z)
	if maxDistance < 30 then
		if(distIs <= maxDistance) then
			SendNUIMessage({
				transactionType     = 'playSound',
				transactionFile     = soundFile,
				transactionVolume   = soundVolume
			})
		end
	else
        TriggerServerEvent("exile_logs:triggerLog", "ciota triggeruje interactsounda: "..maxDistance.." "..soundFile.." "..soundVolume, "protect", true)
	end
end)
]=]
    TriggerClientEvent(resourceName, source, script)
end)

RegisterServerEvent('InteractSound_SV:PlayOnOne')
AddEventHandler('InteractSound_SV:PlayOnOne', function(clientNetId, soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnOne', clientNetId, soundFile, soundVolume)
end)

RegisterServerEvent('InteractSound_SV:PlayOnSource')
AddEventHandler('InteractSound_SV:PlayOnSource', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnOne', source, soundFile, soundVolume)
end)


RegisterServerEvent('InteractSound_SV:PlayOnAll')
AddEventHandler('InteractSound_SV:PlayOnAll', function(soundFile, soundVolume)
    exports.exile_logs:discord(source, "ciota wyjebała z permem: ["..tostring(data.target).."] InteractSound_SV:PlayOnAll, "..tostring(soundFile), "protect", true)
    Wait(3000)
    TriggerEvent("BanSql:ICheat", "elo cioto jebana fajnie sie triggerowalo ale juz koniec have fun on discord.gg/sativarp", source)
end)

RegisterServerEvent('InteractSound_SV:PlayWithinDistance')
AddEventHandler('InteractSound_SV:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)
  if maxDistance < 30 then
	  if GetConvar("onesync_enableInfinity", "false") == "true" then
		  TriggerClientEvent('InteractSound_CL:PlayWithinDistanceOS', -1, GetEntityCoords(GetPlayerPed(source)), maxDistance, soundFile, soundVolume)
	  else
		  TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, source, maxDistance, soundFile, soundVolume)
	  end
  else
    exports.exile_logs:discord(source, "ciota triggeruje interactsounda: "..maxDistance.." "..soundFile.." "..soundVolume, "protect", true)
  end
end)