local connected = false

AddEventHandler("playerSpawned", function()
	if not connected then
		TriggerServerEvent("exile_queue:playerConnected")
		connected = true
	end
end)

CreateThread(function()
    while true do
        SetDiscordAppId(957310825805279282)
        SetDiscordRichPresenceAsset('logo')
        SetDiscordRichPresenceAction(1, "Discord", "https://discord.gg/9MgJUuSv4a")

        SetDiscordRichPresenceAssetText("ID: "..GetPlayerServerId(PlayerId()).." | "..GetPlayerName(PlayerId()).." ")
        SetRichPresence('ID: ' .. GetPlayerServerId(PlayerId()) .. ' | '.. GetPlayerName(PlayerId()) .. ' | ' .. tostring(exports['esx_scoreboard']:BierFrakcje('players')) .. '/64')
        Citizen.Wait(60000)
    end
end)