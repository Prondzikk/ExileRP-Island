local kabura = false
local allowed = false

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('hypex:getTwojStarySharedTwojaStaraObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end

	Citizen.Wait(5000)
	local PlayerData = ESX.GetPlayerData()
	allowed = (PlayerData.job and (PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.hiddenjob.name == 'sheriff'))
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(PlayerData)
	allowed = (PlayerData.job and (PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' or PlayerData.hiddenjob.name == 'sheriff'))
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	allowed = (job and (job.name == 'police' or job.name == 'offpolice'))
end)

Citizen.CreateThread(function()
	while not HasAnimDictLoaded("move_m@intimidation@cop@unarmed") do
		RequestAnimDict("move_m@intimidation@cop@unarmed")
		Citizen.Wait(1)
	end
	
	while true do
		if allowed then
			Citizen.Wait(1)
			if Ped.Active then
				if Ped.Available then
					if IsControlJustPressed(0, 19) and not kabura then
						kabura = true
						TaskPlayAnim(Ped.Id, "move_m@intimidation@cop@unarmed", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
					elseif IsControlJustReleased(0, 19) and kabura then
						kabura = false
						ClearPedSecondaryTask(Ped.Id)
					end
				end
			elseif kabura then
				kabura = false
				if Ped.Available then
					ClearPedSecondaryTask(Ped.Id)
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)