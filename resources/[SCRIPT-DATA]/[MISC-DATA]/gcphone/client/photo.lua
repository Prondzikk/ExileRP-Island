local phone = false
local frontCam = false
local hook = nil

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

RegisterNetEvent('camera:open')
AddEventHandler('camera:open', function(h)
	SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    CreateMobilePhone(1)
	CellCamActivate(true, true)
	phone = true
	hook = h

	ESX.UI.HUD.SetDisplay(0.0)
	TriggerEvent('es:setMoneyDisplay', 0.0)
	TriggerEvent('esx_status:setDisplay', 0.0)
	TriggerEvent('esx_voice:setDisplay', 0.0)
	TriggerEvent('radar:setHidden', true)
	TriggerEvent('FeedM:halt', true)
	TriggerEvent('chat:toggleChat', true)
	TriggerEvent('carhud:display', false)
end)

function closeCamera()
	DestroyMobilePhone()
	PhonePlayOut()
	phone = false
	hook = nil

	ESX.UI.HUD.SetDisplay(1.0)
	TriggerEvent('es:setMoneyDisplay', 1.0)
	TriggerEvent('esx_status:setDisplay', 1.0)
	TriggerEvent('esx_voice:setDisplay', 1.0)
	TriggerEvent('radar:setHidden', false)
	TriggerEvent('FeedM:halt', false)
	TriggerEvent('chat:toggleChat', false)
	TriggerEvent('carhud:display', true)

	CellCamActivate(false, false)
	TooglePhone(false)
	PhonePlayIn()
end

CreateThread(function()
	DestroyMobilePhone()
	
	local unload = false
	while true do
		Citizen.Wait(5)
		if phone then
			if IsControlJustPressed(1, 177) then
				closeCamera()
			end
			
			if IsControlJustPressed(1, 27) then
				frontCam = not frontCam
				CellFrontCamActivate(frontCam)
			end
			
			if IsControlJustPressed(0, 176) and hook then
				local _hook = hook
				hook = nil

				Citizen.InvokeNative(0xABA17D7CE615ADBF, "FMMC_PLYLOAD")
				Citizen.InvokeNative(0xBD12F8228410D9B4, 4)

				PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)				

				exports['screenshot-basic']:requestScreenshotUpload('https://questionable.link/api/files/create', 'file', function(data)
					local resp = json.decode(data)
		
					while resp == nil do
						Citizen.Wait(100)
					end

					screenshot = resp.url..".jpeg"
					TriggerServerEvent('gcPhone:sendMessage', _hook, screenshot)
					unload = true
			
				end)

			end			
		end
		
		if unload then
			Citizen.Wait(1000)
			Citizen.InvokeNative(0x10D373323E5B9C0D)
			unload = false
			Citizen.Wait(1300)
			closeCamera()
		end
	end
end)
