local HaveBagOnHead = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

function ClosestPlayer()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local player = PlayerPedId()

    if closestPlayer == -1 or closestDistance > 2.0 then 
        TriggerEvent('esx:showNotification','~r~Brak graczy w pobliżu!')
    elseif not HaveBagOnHead then
        TriggerServerEvent('esx_headbag:sendclosest', GetPlayerServerId(closestPlayer))
        TriggerServerEvent('esx_headbag:closest')
    else
        TriggerEvent('esx:showAdvancedNotification', '~r~Ten gracz już posiada worek na głowie!')
    end
end

RegisterNetEvent('esx_headbag:put')
AddEventHandler('esx_headbag:put', function()
    OpenHeadbagMenu()
end)

RegisterNetEvent('esx_headbag:puton')
AddEventHandler('esx_headbag:puton', function(player)
    local playerPed = PlayerPedId()
    Headbag = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(Headbag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openGeneral'})
    HaveBagOnHead = true
end)    

AddEventHandler('playerSpawned', function()
    DeleteEntity(Headbag)
    SetEntityAsNoLongerNeeded(Headbag)
    SendNUIMessage({type = 'closeAll'})
    HaveBagOnHead = false
end)

RegisterNetEvent('esx_headbag:putoffc')
AddEventHandler('esx_headbag:putoffc', function(player)
    TriggerEvent('esx:showNotification', '~y~Zdjęto ci worek z głowy')
    DeleteEntity(Headbag)
    SetEntityAsNoLongerNeeded(Headbag)
    SendNUIMessage({type = 'closeAll'})
    HaveBagOnHead = false
end)

function OpenHeadbagMenu()
    local elements = {
          {label = 'Załóż na głowę worek', value = 'puton'},
          {label = 'Zdejmij z głowy worek', value = 'putoff'},
        }
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'headbagging',
      {
        title    = 'Organizacja',
        align    = 'center',
        elements = elements
      },
      function(data2, menu2)
          local player, distance = ESX.Game.GetClosestPlayer()
          if distance ~= -1 and distance <= 2.0 then
              if data2.current.value == 'puton' then
                  NajblizszyGracz()
              end
              if data2.current.value == 'putoff' then
                  TriggerServerEvent('esx_headbag:putoff')
              end
              else
                TriggerEvent('esx:showNotification', '~r~Brak graczy w pobliżu!')
              end
          end,
      function(data2, menu2)
          menu2.close()
      end
    )
end