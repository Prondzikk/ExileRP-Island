ESX = nil

local Weapons = {}
local AmmoTypes = {}

local PlayerData = {}
local AmmoInClip = {}
local ItemsList = {}
local AmmoBefore = 0

for name,item in pairs(Config.Weapons) do
  Weapons[GetHashKey(name)] = item
  ItemsList[item.item] = name
end

for name,item in pairs(Config.AmmoTypes) do
  AmmoTypes[GetHashKey(name)] = item
end

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
  Citizen.Wait(5000)
  PlayerData = ESX.GetPlayerData()
end)

function IsWeapon(name)
  if ItemsList[name] then
    return ItemsList[name]
  end
  
  return false
end


function GetInventoryItem(name)
  local inventory = PlayerData.inventory
  for i=1, #inventory, 1 do
    if inventory[i].name == name then
      return inventory[i]
    end
  end
  return nil
end

function RebuildLoadout()
  
  while not PlayerData do
    Citizen.Wait(100)
  end
  
  local playerPed = PlayerPedId()

  for weaponHash,v in pairs(Weapons) do
    local item = GetInventoryItem(v.item)
    if item and item.count > 0 then
      local ammo = 0
      local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

      if ammoType and AmmoTypes[ammoType] then
        local ammoItem = GetInventoryItem(AmmoTypes[ammoType].item)
        if ammoItem then
          ammo = ammoItem.count
        end
      end
      if item.name == "flaregun" then
        ammo = 25
      end
      
      if HasPedGotWeapon(playerPed, weaponHash, false) then
        if GetAmmoInPedWeapon(playerPed, weaponHash) ~= ammo then
          SetPedAmmo(playerPed, weaponHash, ammo)
        end
      else
        GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
        SetPedAmmo(playerPed, weaponHash, ammo)
      end
    elseif HasPedGotWeapon(playerPed, weaponHash, false) then
      RemoveWeaponFromPed(playerPed, weaponHash)
    end
  end

end

function RemoveUsedAmmo(CurrentWeapon) 
  local playerPed = PlayerPedId()
  local AmmoAfter = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
  local ammoType = AmmoTypes[GetPedAmmoTypeFromWeapon(playerPed, CurrentWeapon)]
  
  if ammoType and ammoType.item then
    TriggerServerEvent('esx:discardInventoryItem', ammoType.item, 1)
  end

  return AmmoAfter
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

AddEventHandler('skinchanger:modelLoaded', function()
  RebuildLoadout()
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(name, count)
  Citizen.Wait(1) -- Wait a tick to make sure ESX has updated PlayerData
  PlayerData = ESX.GetPlayerData()
  RebuildLoadout()
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(name, count)
  Citizen.Wait(1) -- Wait a tick to make sure ESX has updated PlayerData
  PlayerData = ESX.GetPlayerData()
  RebuildLoadout()
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local playerPed = PlayerPedId()
    if IsPedArmed(playerPed, 4) then
      if IsPedShooting(playerPed) then
        CurrentWeapon = GetSelectedPedWeapon(playerPed)
        RemoveUsedAmmo(CurrentWeapon)
      end
    else
      Citizen.Wait(500)
    end
  end
end)