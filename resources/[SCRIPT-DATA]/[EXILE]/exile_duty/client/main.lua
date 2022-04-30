ESX                           = nil
local PlayerData              = {}

CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj 
	end)
    
	Citizen.Wait(250)
 	PlayerData = ESX.GetPlayerData()
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterCommand('duty', function()
  if PlayerData.job.name == 'offpolice' or PlayerData.job.name == 'police' or PlayerData.job.name == 'offambulance' or PlayerData.job.name == 'ambulance' then
    if PlayerData.job.name == 'offambulance' then
      TriggerServerEvent('exile:setJob', 'ambulance', true)
      ESX.ShowNotification('~r~[SAMS] ~b~Wchodzisz na służbę')
      Citizen.Wait(1000)
    elseif PlayerData.job.name == 'ambulance' then
      TriggerServerEvent('exile:setJob', 'ambulance', false)
      ESX.ShowNotification('~r~[SAMS] ~b~Schodzisz ze służby')
      Citizen.Wait(1000)
    elseif PlayerData.job.name == 'offpolice' then
      TriggerServerEvent('exile:setJob', 'police', true)
      ESX.ShowNotification('~y~[SASP] ~b~Wchodzisz na służbę')
      Citizen.Wait(1000)
    elseif PlayerData.job.name == 'police' then
      TriggerServerEvent('exile:setJob', 'police', false)
      ESX.ShowNotification('~y~[SASP] ~b~Schodzisz ze służby')
      Citizen.Wait(1000)
    end
	else
		ESX.ShowNotification('~r~Nie jesteś zatrudniony')
		Citizen.Wait(1000)
	end
end)