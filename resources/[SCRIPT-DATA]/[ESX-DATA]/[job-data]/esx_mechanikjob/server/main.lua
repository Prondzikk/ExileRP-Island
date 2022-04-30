ESX                = nil
PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersHarvesting3 = {}
PlayersCrafting    = {}
PlayersCrafting2   = {}
PlayersCrafting3   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'mechanik', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'mechanik', _U('mechanic_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'mechanik', 'Mechanik', 'society_mechanik', 'society_mechanik', 'society_mechanik', {type = 'private'})

local function Harvest(source)

  SetTimeout(4000, function()

    if PlayersHarvesting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

      if GazBottleQuantity >= 5 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
        xPlayer.addInventoryItem('gazbottle', 1)
        Harvest(source)
      end
    end
  end)
end

RegisterServerEvent('esx_mechanikjob:startHarvest')
AddEventHandler('esx_mechanikjob:startHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_gas_can'))
  Harvest(source)
end)

RegisterServerEvent('esx_mechanikjob:stopHarvest')
AddEventHandler('esx_mechanikjob:stopHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = false
end)

local function Harvest2(source)

  SetTimeout(4000, function()

    if PlayersHarvesting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local FixToolQuantity  = xPlayer.getInventoryItem('fixtool').count
      if FixToolQuantity >= 5 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
        xPlayer.addInventoryItem('fixtool', 1)
        Harvest2(source)
      end
    end
  end)
end


RegisterServerEvent('esx_mechanikjob:giveItem')
AddEventHandler('esx_mechanikjob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
  local _source = source
	if xPlayer.job.name ~= 'mechanik' then
		exports.exile_logs:discord(_source, 'esx_mechanikjob:giveItem', 'protect', true)
		return
	elseif (itemName ~= 'gazbottle') and (itemName ~= 'fixtool') and (itemName ~= 'carotool') and (itemName ~= 'blowpipe') and (itemName ~= 'fixkit') and (itemName ~= 'carokit') then
		exports.exile_logs:discord(_source, 'esx_mechanikjob:giveItem', 'protect', true)
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= 1 then
		count = xItem.limit - xItem.count
	end

	if xItem.count < xItem.limit then
    exports.exile_logs:discord(_source, 'Odebrał narzędzie: '..itemName, 'szafkamechanik', true)
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, '~r~Twój ekwipunek jest pełny~w~!')
	end
end)


RegisterServerEvent('esx_mechanikjob:startHarvest2')
AddEventHandler('esx_mechanikjob:startHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_repair_tools'))
  Harvest2(_source)
end)

RegisterServerEvent('esx_mechanikjob:stopHarvest2')
AddEventHandler('esx_mechanikjob:stopHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = false
end)

local function Harvest3(source)

  SetTimeout(4000, function()

    if PlayersHarvesting3[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('carotool').count
      if CaroToolQuantity >= 5 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
        xPlayer.addInventoryItem('carotool', 1)
        Harvest3(source)
      end
    end
  end)
end

RegisterServerEvent('esx_mechanikjob:startHarvest3')
AddEventHandler('esx_mechanikjob:startHarvest3', function()
  local _source = source
  PlayersHarvesting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_body_tools'))
  Harvest3(_source)
end)

RegisterServerEvent('esx_mechanikjob:stopHarvest3')
AddEventHandler('esx_mechanikjob:stopHarvest3', function()
  local _source = source
  PlayersHarvesting3[_source] = false
end)

local function Craft(source)

  SetTimeout(4000, function()

    if PlayersCrafting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

      if GazBottleQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_gas_can'))
      else
        xPlayer.removeInventoryItem('gazbottle', 1)
        xPlayer.addInventoryItem('blowpipe', 1)
        Craft(source)
      end
    end
  end)
end

RegisterServerEvent('esx_mechanikjob:startCraft')
AddEventHandler('esx_mechanikjob:startCraft', function()
  local _source = source
  PlayersCrafting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_blowtorch'))
  Craft(_source)
end)

RegisterServerEvent('esx_mechanikjob:stopCraft')
AddEventHandler('esx_mechanikjob:stopCraft', function()
  local _source = source
  PlayersCrafting[_source] = false
end)

local function Craft2(source)

  SetTimeout(4000, function()

    if PlayersCrafting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local FixToolQuantity  = xPlayer.getInventoryItem('fixtool').count
      if FixToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_repair_tools'))
      else
        xPlayer.removeInventoryItem('fixtool', 1)
        xPlayer.addInventoryItem('fixkit', 1)
        Craft2(source)
      end
    end
  end)
end

RegisterServerEvent('esx_mechanikjob:startCraft2')
AddEventHandler('esx_mechanikjob:startCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_blowtorch'))
  Craft2(_source)
end)

RegisterServerEvent('esx_mechanikjob:stopCraft2')
AddEventHandler('esx_mechanikjob:stopCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = false
end)

local function Craft3(source)

  SetTimeout(4000, function()

    if PlayersCrafting3[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('carotool').count
            if CaroToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_body_tools'))
      else
        xPlayer.removeInventoryItem('carotool', 1)
        xPlayer.addInventoryItem('carokit', 1)
        Craft3(source)
      end
    end
  end)
end

RegisterServerEvent('esx_mechanikjob:startCraft3')
AddEventHandler('esx_mechanikjob:startCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_body_kit'))
  Craft3(_source)
end)

RegisterServerEvent('esx_mechanikjob:stopCraft3')
AddEventHandler('esx_mechanikjob:stopCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = false
end)

RegisterServerEvent('esx_mechanikjob:onNPCJobMissionCompleted')
AddEventHandler('esx_mechanikjob:onNPCJobMissionCompleted', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local total   = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max);

  if xPlayer.job.grade >= 3 then
    total = total * 2
  end

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanik', function(account)
    account.addMoney(total)
  end)

  exports.exile_logs:discord(_source, 'Odebrał narzędzie: '..itemName, 'misjamechanik', true)

  TriggerClientEvent("esx:showNotification", _source, _U('your_comp_earned').. total)

end)

ESX.RegisterUsableItem('blowpipe', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('blowpipe', 1)

  TriggerClientEvent('esx_mechanicjob:onHijack', _source)
  TriggerClientEvent('esx:showNotification', _source, _U('you_used_blowtorch'))

end)

ESX.RegisterUsableItem('fixkit', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('fixkit', 1)

  TriggerClientEvent('esx_mechanikjob:onFixkit', _source)
  TriggerClientEvent('esx:showNotification', _source, _U('you_used_repair_kit'))

end)

ESX.RegisterUsableItem('carokit', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('carokit', 1)

  TriggerClientEvent('esx_mechanikjob:onCarokit', _source)
  TriggerClientEvent('esx:showNotification', _source, _U('you_used_body_kit'))

end)

RegisterServerEvent('esx_mechanikjob:getStockItem')
AddEventHandler('esx_mechanikjob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanik', function(inventory)
		local item = inventory.getItem(itemName)
		local sourceItem = xPlayer.getInventoryItem(itemName)
		
		-- is there enough in the society?
		if count > 0 and item.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('player_cannot_hold'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)

        exports.exile_logs:discord(source, 'Wyciągnął/ęła z szafki '..count..'x '..itemName, 'szafkamechanik', true)

        
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, item.label))
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_mechanikjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanik', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_mechanikjob:putStockItems')
AddEventHandler('esx_mechanikjob:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanik', function(inventory)

    local item = inventory.getItem(itemName)
    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if item.count >= 0 and count <= playerItemCount then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
      exports.exile_logs:discord(source, 'Schował/a do szafki '..count..'x '..itemName, 'szafkamechanik', true)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, item.label))

  end)

end)

ESX.RegisterServerCallback('esx_mechanikjob:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)

TriggerEvent('es:addCommand', 'carstats', function(source, args, user)
	      TriggerClientEvent('carstats', source, {})
end, {help = "Informacje na temat pojazdu"})

RegisterServerEvent('mechanik:woda')
AddEventHandler('mechanik:woda', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == 'mechanik' then
    if xPlayer.getInventoryItem('water').count < xPlayer.getInventoryItem('water').limit then
      xPlayer.addInventoryItem('water', 1)
    else
      xPlayer.showNotification('~r~Masz tego za dużo!')
    end
  else
    exports.exile_logs:discord(source, 'mechanik:woda', 'protect', true)
  end
end)

RegisterServerEvent('mechanik:chleb')
AddEventHandler('mechanik:chleb', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == 'mechanik' then
    if xPlayer.getInventoryItem('bread').count < xPlayer.getInventoryItem('bread').limit then
      xPlayer.addInventoryItem('bread', 1)
    else
      xPlayer.showNotification('~r~Masz tego za dużo!')
    end
  else
    exports.exile_logs:discord(source, 'mechanik:woda', 'protect', true)
  end
end)

RegisterServerEvent('mechanik:redbull')
AddEventHandler('mechanik:redbull', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == 'mechanik' then
    if xPlayer.getInventoryItem('kawa').count < xPlayer.getInventoryItem('kawa').limit then
      xPlayer.addInventoryItem('kawa', 1)
    else
      xPlayer.showNotification('~r~Masz tego za dużo!')
    end
  else
    exports.exile_logs:discord(source, 'mechanik:woda', 'protect', true)
  end
end)