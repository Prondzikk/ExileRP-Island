function CreateExtendedPlayer(playerId, identifier, group, accounts, inventory, job, loadout, name, coords, character, hiddenjob)
	local self = {}

	self.accounts = accounts
	self.coords = coords
	self.group = group
	self.identifier = identifier
	self.inventory = inventory
	self.character = character
	self.job = job
	self.hiddenjob = hiddenjob
	self.loadout = loadout
	self.name = name
	self.playerId = playerId
	self.source = playerId
	self.variables = {}

	
	ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.identifier, self.group))

	self.getHiddenJob = function()
		return self.hiddenjob
	end
	
	self.getCharacter = function()
		return self.character
	end

	self.setHiddenJob = function(job, grade)
		grade = tostring(grade)
		local lastJob = json.decode(json.encode(self.hiddenjob))

		if ESX.DoesJobExist(job, grade) then
			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

			self.hiddenjob.id    = jobObject.id
			self.hiddenjob.name  = jobObject.name
			self.hiddenjob.label = jobObject.label

			self.hiddenjob.grade        = tonumber(grade)
			self.hiddenjob.grade_name   = gradeObject.name
			self.hiddenjob.grade_label  = gradeObject.label
			self.hiddenjob.grade_salary = gradeObject.salary

			self.hiddenjob.skin_male    = {}
			self.hiddenjob.skin_female  = {}

			if gradeObject.skin_male then
				self.hiddenjob.skin_male = json.decode(gradeObject.skin_male)
			end

			if gradeObject.skin_female then
				self.hiddenjob.skin_female = json.decode(gradeObject.skin_female)
			end

			TriggerEvent('esx:setHiddenJob', self.source, self.hiddenjob, lastJob)
			self.triggerEvent('esx:setHiddenJob', self.hiddenjob)
		end
	end
	
	self.triggerEvent = function(eventName, ...)
		TriggerClientEvent(eventName, self.source, ...)
	end

	self.setCoords = function(coords)
		self.updateCoords(coords)
		self.triggerEvent('esx:teleport', coords)
	end

	self.updateCoords = function(coords)
		self.coords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1), heading = ESX.Math.Round(coords.heading or 0.0, 1)}
	end

	self.getCoords = function(vector)
		if vector then
			return vector3(self.coords.x, self.coords.y, self.coords.z)
		else
			return self.coords
		end
	end

	self.kick = function(reason)
		DropPlayer(self.source, reason)
	end

	self.setMoney = function(money)
		money = ESX.Math.Round(money)
		self.setAccountMoney('money', money)
	end

	self.getMoney = function()
		return self.getAccount('money').money
	end

	self.addMoney = function(money)
		money = ESX.Math.Round(money)
		self.addAccountMoney('money', money)
	end

	self.removeMoney = function(money)
		money = ESX.Math.Round(money)
		self.removeAccountMoney('money', money)
	end

	self.getIdentifier = function()
		return self.identifier
	end

	self.setGroup = function(newGroup)
		ExecuteCommand(('remove_principal identifier.%s group.%s'):format(self.identifier, self.group))
		self.group = newGroup
		ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.identifier, self.group))
	end

	self.getGroup = function()
		return self.group
	end

	self.set = function(k, v)
		self.variables[k] = v
	end

	self.get = function(k)
		return self.variables[k]
	end

	self.getAccounts = function(minimal)
		if minimal then
			local minimalAccounts = {}

			for k,v in ipairs(self.accounts) do
				minimalAccounts[v.name] = v.money
			end

			return minimalAccounts
		else
			return self.accounts
		end
	end

	self.getAccount = function(account)
		for k,v in ipairs(self.accounts) do
			if v.name == account then
				return v
			end
		end
	end

	self.getInventory = function(minimal)
		if minimal then
			local minimalInventory = {}

			for k, v in ipairs(self.inventory) do
				if v.count > 0 then
					if v.slot then
						minimalInventory[v.name] = { count = v.count, slot = v.slot }
					else
						minimalInventory[v.name] = { count = v.count }
					end
				end
			end

			return minimalInventory
		else
			return self.inventory
		end
	end

	self.getJob = function()
		return self.job
	end

	self.getLoadout = function(minimal)
		if minimal then
			local minimalLoadout = {}

			for k,v in ipairs(self.loadout) do
				minimalLoadout[v.name] = {ammo = v.ammo}
				if v.tintIndex > 0 then minimalLoadout[v.name].tintIndex = v.tintIndex end

				if #v.components > 0 then
					local components = {}

					for k2,component in ipairs(v.components) do
						if component ~= 'clip_default' then
							table.insert(components, component)
						end
					end

					if #components > 0 then
						minimalLoadout[v.name].components = components
					end
				end
			end

			return minimalLoadout
		else
			return self.loadout
		end
	end

	self.getName = function()
		return self.name
	end

	self.setName = function(newName)
		self.name = newName
	end

	self.setAccountMoney = function(accountName, money)
		local account = self.getAccount(accountName)

		if account then
			local prevMoney = account.money
			local newMoney = ESX.Math.Round(money)
			account.money = newMoney

			self.triggerEvent('esx:setAccountMoney', account)
		end
	end

	self.addAccountMoney = function(accountName, money)
		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				local newMoney = account.money + ESX.Math.Round(money)
				account.money = newMoney

				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.removeAccountMoney = function(accountName, money)
		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				local newMoney = account.money - ESX.Math.Round(money)
				account.money = newMoney

				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	self.getInventoryItem = function(name)
		for k,v in ipairs(self.inventory) do
			if v.name == name then
				return v
			end
		end

		return
	end

	self.addInventoryItem = function(name, count)
		local item = self.getInventoryItem(name)

		if item then
			count = ESX.Math.Round(count)
			item.count = item.count + count

			TriggerEvent('esx:onAddInventoryItem', self.source, item.name, item.count)
			self.triggerEvent('esx:addInventoryItem', item.name, item.count)
		end
	end

	self.removeInventoryItem = function(name, count)
		local item = self.getInventoryItem(name)

		if item then
			count = ESX.Math.Round(count)
			local newCount = item.count - count

			if item.slot and newCount <= 0 then
				self.removeFromSlot(item.name)
			end
			
			if newCount >= 0 then
				item.count = newCount

				TriggerEvent('esx:onRemoveInventoryItem', self.source, item.name, item.count)
				self.triggerEvent('esx:removeInventoryItem', item.name, item.count)
			end
		end
	end

	self.setInventoryItem = function(name, count)
		local item = self.getInventoryItem(name)

		if item and count >= 0 then
			count = ESX.Math.Round(count)

			if item.slot and count <= 0 then
				self.removeFromSlot(item.name)
			end
			
			if count > item.count then
				self.addInventoryItem(item.name, count - item.count)
			else
				self.removeInventoryItem(item.name, item.count - count)
			end
		end
	end

	self.removeFromSlot = function(name)
        for k, v in ipairs(self.inventory) do
            if v.name == name then
                v.slot = false
                self.triggerEvent('esx:removeFromSlot', name)
                break
            end
        end
    end

	self.addToSlot = function(slot, name)
		for k, v in ipairs(self.inventory) do
			if v.slot == slot and v.name ~= name then
				v.slot = false
				self.triggerEvent('esx:removeFromSlot', v.name)
			end

			if v.name == name then
				v.slot = slot
				self.triggerEvent('esx:addToSlot', name, slot)
			end
		end
	end

	self.getItemFromSlot = function(slot)
		for k, v in ipairs(self.inventory) do
			if v.slot and v.slot == slot then
				return v
			end
		end

		return
	end

	self.setJob = function(job, grade)
		grade = tostring(grade)
		local lastJob = json.decode(json.encode(self.job))

		if ESX.DoesJobExist(job, grade) then
			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]

			self.job.id    = jobObject.id
			self.job.name  = jobObject.name
			self.job.label = jobObject.label

			self.job.grade        = tonumber(grade)
			self.job.grade_name   = gradeObject.name
			self.job.grade_label  = gradeObject.label
			self.job.grade_salary = gradeObject.salary

			if gradeObject.skin_male then
				self.job.skin_male = json.decode(gradeObject.skin_male)
			else
				self.job.skin_male = {}
			end

			if gradeObject.skin_female then
				self.job.skin_female = json.decode(gradeObject.skin_female)
			else
				self.job.skin_female = {}
			end

			TriggerEvent('esx:setJob', self.source, self.job, lastJob)
			self.triggerEvent('esx:setJob', self.job)
		end
	end

	self.canCarryItem = function(name, count)		
		local item, limit = self.getInventoryItem(name), ESX.Items[name].limit
		
		if item and limit then
			count = ESX.Math.Round(count)
			local newCount = item.count + count
			
			return newCount <= limit
		end
	end
	
	self.addWeapon = function(weaponName, ammo)
		if not self.hasWeapon(weaponName) then
			local weaponLabel = ESX.GetWeaponLabel(weaponName)
			table.insert(self.loadout, { 
				name = weaponName,
				ammo = ammo,
				label = weaponLabel,
				components = {},
				tintIndex = 0
				
			})
			self.triggerEvent('esx:addWeapon', weaponName, ammo)
			self.triggerEvent('esx:addInventoryItem', weaponLabel, false, true)
		else
			local loadoutNum, weapon = self.getWeapon(weaponName)

			if weapon then
				weapon.ammo = weapon.ammo + ammo
				self.triggerEvent('esx:setWeaponAmmo', weaponName, weapon.ammo)
			end
		end
	end

	self.addWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				if not self.hasWeaponComponent(weaponName, weaponComponent) then
					table.insert(self.loadout[loadoutNum].components, weaponComponent)
					self.triggerEvent('esx:addWeaponComponent', weaponName, weaponComponent)
					self.removeInventoryItem(component.name, 1)
					--self.triggerEvent('esx:removeInventoryItem', component.name, 1)
				else
					self.showNotification('~r~Ten dodatek jest już założony na tej broni')
				end
			else
				self.showNotification('~r~Do tej broni nie możesz zamontować dodatku')
			end
		end
	end

	self.addWeaponAmmo = function(weaponName, ammoCount)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			weapon.ammo = weapon.ammo + ammoCount
			self.triggerEvent('esx:setWeaponAmmo', weaponName, weapon.ammo)
		end
	end

	self.updateWeaponAmmo = function(weaponName, ammoCount)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			if ammoCount < weapon.ammo then
				weapon.ammo = ammoCount
			end
		end
	end

	self.setWeaponTint = function(weaponName, weaponTintIndex)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local weaponNum, weaponObject = ESX.GetWeapon(weaponName)

			if weaponObject.tints and weaponObject.tints[weaponTintIndex] then
				self.loadout[loadoutNum].tintIndex = weaponTintIndex
				self.triggerEvent('esx:setWeaponTint', weaponName, weaponTintIndex)
				self.triggerEvent('esx:addInventoryItem', weaponObject.tints[weaponTintIndex], false, true)
			end
		end
	end

	self.getWeaponTint = function(weaponName)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			return weapon.tintIndex
		end

		return 0
	end

	self.removeWeapon = function(weaponName, ammo)
		local weaponLabel

		for k,v in ipairs(self.loadout) do
			if v.name == weaponName then
				weaponLabel = v.label
				
				--[[for k2,v2 in ipairs(v.components) do
					self.triggerEvent('esx:removeWeaponComponent', weaponName, v2)
				end]]

				table.remove(self.loadout, k)
				break
			end
		end
		if weaponLabel then
			self.triggerEvent('esx:removeWeapon', weaponName, ammo)
			self.triggerEvent('esx:removeInventoryItem', weaponLabel, false, true)
		end
	end

	self.removeWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				if self.hasWeaponComponent(weaponName, weaponComponent) then
					for k,v in ipairs(self.loadout[loadoutNum].components) do
						if v == weaponComponent then
							table.remove(self.loadout[loadoutNum].components, k)
							break
						end
					end

					self.triggerEvent('esx:removeWeaponComponent', weaponName, weaponComponent)
					self.addInventoryItem(component.name, 1)
					--self.triggerEvent('esx:addInventoryItem', component.name, 1)
				else
					self.showNotification('~r~Ten dodatek nie jest zamontowany w tej broni')
				end
			else
				self.showNotification('~r~W tej broni nie da się zdemontować tego dodatku')
			end
		end
	end

	self.removeWeaponAmmo = function(weaponName, ammoCount)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			weapon.ammo = weapon.ammo - ammoCount
			self.triggerEvent('esx:setWeaponAmmo', weaponName, weapon.ammo)
		end
	end

	self.hasWeaponComponent = function(weaponName, weaponComponent)
		local loadoutNum, weapon = self.getWeapon(weaponName)

		if weapon then
			for k,v in ipairs(weapon.components) do
				if v == weaponComponent then
					return true
				end
			end

			return false
		else
			return false
		end
	end

	self.hasWeapon = function(weaponName)
		for k,v in ipairs(self.loadout) do
			if v.name == weaponName then
				return true
			end
		end

		return false
	end

	self.getWeapon = function(weaponName)
		for k,v in ipairs(self.loadout) do
			if v.name == weaponName then
				return k, v
			end
		end

		return
	end
	
	self.showNotification = function(msg, flash, saveToBrief, hudColorIndex)
		self.triggerEvent('esx:showNotification', msg, flash, saveToBrief, hudColorIndex)
	end

	self.showHelpNotification = function(msg, thisFrame, beep, duration)
		self.triggerEvent('esx:showHelpNotification', msg, thisFrame, beep, duration)
	end

	return self
end