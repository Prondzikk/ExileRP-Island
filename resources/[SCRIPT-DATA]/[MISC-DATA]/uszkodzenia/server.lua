------------------------------------------
--	iEnsomatic RealisticVehicleFailure  --
------------------------------------------
--
--	Created by Jens Sandalgaard
--
--	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--
--	https://github.com/iEns/RealisticVehicleFailure
--
ESX                       = nil

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

local function checkWhitelist(id)
	for key, value in pairs(RepairWhitelist) do
		if id == value then
			return true
		end
	end	
	return false
end

RegisterServerEvent('notifyEngine')
AddEventHandler('notifyEngine', function(msg)
  local _source = source
  local mSg = msg
  TriggerClientEvent('esx:showNotification', _source, mSg)
end)

