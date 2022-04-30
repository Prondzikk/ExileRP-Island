local connected = true
-- brak whitelist ? false
AddEventHandler("playerSpawned", function()
	if not connected then
		TriggerServerEvent("crrp_queue:playerConnected")
		connected = true
	end
end)