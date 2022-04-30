ESX = nil
CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(50)
	end
	
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

isAdmin = false
showLicenses = false
RedM = false

settings = {
	button = 289,
	forceShowGUIButtons = false,
}


-- generate "slap" table once
local SlapAmount = {}
for i=1,20 do
	table.insert(SlapAmount,i)
end

function handleOrientation(orientation)
	if orientation == "right" then
		return 1320
	elseif orientation == "middle" then
		return 730
	elseif orientation == "left" then
		return 0
	end
end

playlist = nil

RegisterCommand('easyadmin', function(source, args)
		CreateThread(function()
			if not RedM then
				playerlist = nil
				TriggerServerEvent("EasyAdmin:GetInfinityPlayerList") -- shitty fix for bigmode
				repeat
					Wait(100)
				until playerlist
			end

			if strings then
				banLength = {
					{label = "Permamentnie", time = 10444633200},
					{label = "1H", time = 3600},
					{label = "2H", time = 7200},
					{label = "3H", time = 10800},
					{label = "6H", time = 21600},
					{label = "12H", time = 43200},
					{label = "1Dzień", time = 86400},
					{label = "2Dni", time = 172800},
					{label = "3Dni", time = 259200},
					{label = "Tydzień", time = 518400},
					{label = "2Tygodnie", time = 1123200},
					{label = "Miesiąc", time = 2678400},
					{label = "Rok", time = 31536000},
				}
				if mainMenu:Visible() then
					mainMenu:Visible(false)
					_menuPool:Remove()
					collectgarbage()
				else
					GenerateMenu()
					mainMenu:Visible(true)
				end
			else
				TriggerServerEvent("EasyAdmin:amiadmin")
			end
		end)
end)

Citizen.CreateThread(function()
	if CompendiumHorseObserved then -- https://www.youtube.com/watch?v=r7qovpFAGrQ
		RedM = true
		settings.button = "PhotoModePc"
	end
	repeat
		Wait(100)
	until NativeUI


	local status = 0
	while true do
		if status == 0 then
			status = 1
			TriggerEvent('misiaczek:load', function(result)
				if result == 3 then
					status = 2
				else
					status = 0
				end
			end)
		end

		Citizen.Wait(200)
		if status == 2 then
			break
		end
	end

	Citizen.Wait(500)


	_menuPool = NativeUI.CreatePool()
	TriggerServerEvent("EasyAdmin:amiadmin")
	TriggerServerEvent("EasyAdmin:requestBanlist")
	TriggerServerEvent("EasyAdmin:requestCachedPlayers")

	if not GetResourceKvpString("ea_menuorientation") then
		SetResourceKvp("ea_menuorientation", "right")
		SetResourceKvpInt("ea_menuwidth", 0)
		menuWidth = 0
		menuOrientation = handleOrientation("right")
	else
		menuWidth = GetResourceKvpInt("ea_menuwidth")
		menuOrientation = handleOrientation(GetResourceKvpString("ea_menuorientation"))
	end 
	mainMenu = NativeUI.CreateMenu("EasyAdmin", "~y~ ∑ ~b~PlateRP.eu", menuOrientation, 0)
	
	_menuPool:Add(mainMenu)
	
	mainMenu:SetMenuWidthOffset(menuWidth)	
	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
	
	while true do
		if _menuPool then
			_menuPool:ProcessMenus()
		end
		if (RedM and IsControlJustReleased(0, Controls[settings.button]) ) or (not RedM and IsControlJustReleased(0, tonumber(settings.button)) and GetLastInputMethod( 0 )) then
			-- clear and re-create incase of permission change+player count change
			if not isAdmin == true then
				TriggerServerEvent("EasyAdmin:amiadmin")
				local waitTime = 0

				repeat 
					Wait(100)
					waitTime=waitTime+1
				until (isAdmin or waitTime==60)
				if not isAdmin then
				end
			end
			

			
			if not RedM and isAdmin then
				playerlist = nil
				TriggerServerEvent("EasyAdmin:GetInfinityPlayerList") -- shitty fix for bigmode
				repeat
					Wait(100)
				until playerlist
			end

			if strings and isAdmin then
				banLength = {
					{label = "Permamentnie", time = 10444633200},
					{label = "1h", time = 3600},
					{label = "2h", time = 7200},
					{label = "3h", time = 10800},
					{label = "6h", time = 21600},
					{label = "12h", time = 43200},
					{label = "1 dzień", time = 86400},
					{label = "2 dni", time = 172800},
					{label = "3 dni", time = 259200},
					{label = "7 dni", time = 518400},
					{label = "14 dni", time = 1123200},
					{label = "30 dni", time = 2678400},
					{label = "365 dni", time = 31536000},
				}
				if mainMenu:Visible() then
					mainMenu:Visible(false)
					_menuPool:Remove()
					collectgarbage()
				else
					GenerateMenu()
					mainMenu:Visible(true)
				end
			else
				TriggerServerEvent("EasyAdmin:amiadmin")
			end
		end
		
		Citizen.Wait(1)
	end
end)

function DrawPlayerInfo(target)
	drawTarget = target
	drawInfo = true
end

function StopDrawPlayerInfo()
	drawInfo = false
	drawTarget = 0
end


noClipSpeeds =  "noclip speeds"

Citizen.CreateThread(function()
	while true do
		if noClip then
			local noclipEntity = PlayerPedId()
			if IsPedInAnyVehicle(noclipEntity, false) then
				local vehicle = GetVehiclePedIsIn(noclipEntity, false)
				if GetPedInVehicleSeat(vehicle, -1) == noclipEntity then
					noclipEntity = vehicle
				else
					noclipEntity = nil
				end
			end

			FreezeEntityPosition(noclipEntity, true)
			SetEntityInvincible(noclipEntity, true)

			DisableControlAction(0, 31, true)
			DisableControlAction(0, 30, true)
			DisableControlAction(0, 44, true)
			DisableControlAction(0, 20, true)
			DisableControlAction(0, 32, true)
			DisableControlAction(0, 33, true)
			DisableControlAction(0, 34, true)
			DisableControlAction(0, 35, true)

			local yoff = 0.0
			local zoff = 0.0
			if IsControlJustPressed(0, 21) then
				noClipSpeed = noClipSpeed + 1
				if noClipSpeed > #noClipSpeeds then
					noClipSpeed = 1
				end

			end

			if IsDisabledControlPressed(0, 32) then
				yoff = 0.25;
			end

			if IsDisabledControlPressed(0, 33) then
				yoff = -0.25;
			end

			if IsDisabledControlPressed(0, 34) then
				SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) + 2.0)
			end

			if IsDisabledControlPressed(0, 35) then
				SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 2.0)
			end

			if IsDisabledControlPressed(0, 44) then
				zoff = 0.1;
			end

			if IsDisabledControlPressed(0, 20) then
				zoff = -0.1;
			end

			local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (noClipSpeed + 0.3), zoff * (noClipSpeed + 0.3))

			local heading = GetEntityHeading(noclipEntity)
			SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
			SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
			SetEntityHeading(noclipEntity, heading)

			SetEntityCollision(noclipEntity, false, false)
			SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, true, true, true)
			Citizen.Wait(1)

			FreezeEntityPosition(noclipEntity, false)
			SetEntityInvincible(noclipEntity, false)
			SetEntityCollision(noclipEntity, true, true)
		else
			Citizen.Wait(200)
		end
	end
end)
noClip = false
noClipSpeed = 1
noClipLabel = nil

function NoClip()
	return noClip == true
end

local banlistPage = 1
function GenerateMenu() -- this is a big ass function
	TriggerServerEvent("EasyAdmin:requestCachedPlayers")
	_menuPool:Remove()
	_menuPool = NativeUI.CreatePool()
	collectgarbage()
	if not GetResourceKvpString("ea_menuorientation") then
		SetResourceKvp("ea_menuorientation", "right")
		SetResourceKvpInt("ea_menuwidth", 0)
		menuWidth = 0
		menuOrientation = handleOrientation("right")
	else
		menuWidth = GetResourceKvpInt("ea_menuwidth")
		menuOrientation = handleOrientation(GetResourceKvpString("ea_menuorientation"))
	end 
	
	mainMenu = NativeUI.CreateMenu("EasyAdmin", "~y~ ∑ ~b~PlateRP.eu", menuOrientation, 0)
	_menuPool:Add(mainMenu)
	
		mainMenu:SetMenuWidthOffset(menuWidth)	
	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
	
	playermanagement = _menuPool:AddSubMenu(mainMenu, "Lista graczy", "",true)
	settingsMenu = _menuPool:AddSubMenu(mainMenu, "Ustawienia","",true)
	servermanagement = _menuPool:AddSubMenu(mainMenu, "Inne","",true)

	mainMenu:SetMenuWidthOffset(menuWidth)	
	playermanagement:SetMenuWidthOffset(menuWidth)	
	servermanagement:SetMenuWidthOffset(menuWidth)	
	settingsMenu:SetMenuWidthOffset(menuWidth)	

	-- util stuff
	players = {}
	local localplayers = {}
	if not RedM then
		local localplayers = playerlist
		local temp = {}
		--table.sort(localplayers)
		for i,thePlayer in pairs(localplayers) do
			table.insert(temp, thePlayer.id)
		end
		table.sort(temp)
		for i, thePlayerId in pairs(temp) do
			for _, thePlayer in pairs(localplayers) do
				if thePlayerId == thePlayer.id then
					players[i] = thePlayer
				end
			end
		end
		temp=nil
	else
		for i = 0, 250 do
			if NetworkIsPlayerActive( i ) then
			  table.insert( localplayers, GetPlayerServerId(i) )
			end
		end
		table.sort(localplayers)
		for i,thePlayer in ipairs(localplayers) do
			table.insert(players,GetPlayerFromServerId(thePlayer))
		end
	end


	for i,thePlayer in pairs(players) do
		if RedM then
			thePlayer = {
				id = GetPlayerServerId(thePlayer), 
				name = GetPlayerName(thePlayer)
			}
		end
		thisPlayer = _menuPool:AddSubMenu(playermanagement,"[ID: "..thePlayer.id.."] "..thePlayer.name,"",true)

		thisPlayer:SetMenuWidthOffset(menuWidth)

		if permissions["trialsupport"] then
			local thisItem = NativeUI.CreateItem(GetLocalisedText("spectateplayer"), "")
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				TriggerServerEvent("EasyAdmin:requestSpectate",thePlayer.id)
			end
		end
		
		if permissions["moderator"] then
			local thisItem = NativeUI.CreateItem(GetLocalisedText("teleporttoplayer"),"")
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				if not RedM then
					TriggerServerEvent('EasyAdmin:TeleportAdminToPlayer', thePlayer.id)
				else
					local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(GetPlayerFromServerId(thePlayer.id)),true))
					local heading = GetEntityHeading(PlayerPedId(player))
					SetEntityCoords(PlayerPedId(), x,y,z,0,0,heading, false)
				end
			end
		end
		
		if permissions["moderator"] then
			local thisItem = NativeUI.CreateItem(GetLocalisedText("teleportplayertome"),"")
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				local coords = GetEntityCoords(PlayerPedId(),true)
				TriggerServerEvent("EasyAdmin:TeleportPlayerToCoords", thePlayer.id, coords)
			end
		end
		
		if permissions["admin"] then
			local sl = {GetLocalisedText("on"), GetLocalisedText("off")}
			local thisItem = NativeUI.CreateListItem(GetLocalisedText("setplayerfrozen"), sl, 1)
			thisPlayer:AddItem(thisItem)
			thisPlayer.OnListSelect = function(sender, item, index)
				if item == thisItem then
						i = item:IndexToItem(index)
						if i == GetLocalisedText("on") then
							TriggerServerEvent("EasyAdmin:FreezePlayer", thePlayer.id, true)
						else
							TriggerServerEvent("EasyAdmin:FreezePlayer", thePlayer.id, false)
						end
				end
			end
		end
			
		_menuPool:ControlDisablingEnabled(false)
		_menuPool:MouseControlsEnabled(false)
	end
	
	local coordsVisible = false

	function DrawGenericText(text)
		SetTextColour(255, 186, 186, 255)
		SetTextFont(7)
		SetTextScale(1.0, 1.0)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 200, 200, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(0.40, 0.00)
	end
	
	Citizen.CreateThread(function()
		while true do
			local sleepThread = 250
			
			if coordsVisible then
				sleepThread = 5
	
				local playerPed = PlayerPedId()
				local playerX, playerY, playerZ = table.unpack(GetEntityCoords(playerPed))
				local playerH = GetEntityHeading(playerPed)
	
				DrawGenericText(("~g~X~w~: %s ~g~Y~w~: %s ~g~Z~w~: %s ~g~H~w~: %s"):format(FormatCoord(playerX), FormatCoord(playerY), FormatCoord(playerZ), FormatCoord(playerH)))
			end
	
			Citizen.Wait(sleepThread)
		end
	end)

	function tpm()
		local WaypointHandle = GetFirstBlipInfoId(8)

		if DoesBlipExist(WaypointHandle) then
			local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

			for height = 1, 1000 do
				SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

				local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

				if foundGround then
					SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

					break
				end

				Citizen.Wait(5)
			end

			TriggerEvent("esx:showNotification","Przeteleportowano.")
		else
			TriggerEvent("esx:showNotification","Zaznacz na mapie teleport.")
		end
	end

	function getmyposXD()
		local ped = PlayerPedId(PlayerId())
		local coords = GetEntityCoords(ped, false)
		local heading = GetEntityHeading(ped)
		TriggerEvent("chatMessage", tostring("X: " .. coords.x .. " Y: " .. coords.y .. " Z: " .. coords.z .. " HEADING: " .. heading))
	end
	
	function daojosdinpatpemata()
		local ax = PlayerPedId()
		local ay = GetVehiclePedIsIn(ax, true)
		if
			IsPedInAnyVehicle(PlayerPedId(), 0) and
				GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), 0), -1) == PlayerPedId()
		 then
			SetVehicleOnGroundProperly(ay)
			TriggerEvent('esx:showNotification', '~g~Pojazd obrócony')
		else
			TriggerEvent('esx:showNotification', '~b~Nie jesteś w pojeździe')
		end
	end
	
	function FormatCoord(coord)
		if coord == nil then
			return "unknown"
		end
	
		return tonumber(string.format("%.2f", coord))
	end	

	function ToggleCoords()
		coordsVisible = not coordsVisible
	end


	if permissions["moderator"] then
	
		local twojstarydev = _menuPool:AddSubMenu(servermanagement, "Narzędzia developerskie", "", true)
		twojstarydev:SetMenuWidthOffset(menuWidth)	

	if permissions["superadmin"] then
		local thisItem = NativeUI.CreateCheckboxItem('Pokaż coordy ', "")
		twojstarydev:AddItem(thisItem)
		thisItem.CheckboxEvent = function(sender, item, status)
			if item == thisItem then
				ToggleCoords()
				else
			end
		end
	end
		
		--[[

			Pojazdy

	]]--

	if permissions["support"] then
		
		local twojstaryauta = _menuPool:AddSubMenu(servermanagement, "Interakcje z samochodem", "", true)
		twojstaryauta:SetMenuWidthOffset(menuWidth)	


	if permissions["moderator"] then
		local thisItem = NativeUI.CreateItem("Napraw pojazd", "")
		twojstaryauta:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId(), false))
			TriggerEvent('esx:showNotification', 'Naprawiono pojazd!')
		end
	end

	if permissions["support"] then
		local thisItem = NativeUI.CreateItem("Obróć pojazd", "")
		twojstaryauta:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			daojosdinpatpemata()
		end
	end

	if permissions["support"] then
		local thisItem = NativeUI.CreateItem("Usuń pojazd", "")
		twojstaryauta:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			TriggerEvent('esx:deleteVehicle')
			TriggerEvent('esx:showNotification', 'Usunięto pojazd!')
			TriggerServerEvent("logMenuAdmin", '\n- Usunięto pojazd!')
		end
	end
end
	


if permissions["admin"] then
	local thisItem = NativeUI.CreateCheckboxItem('Niewidoczność', not IsEntityVisible(PlayerPedId()), "")
	twojstarydev:AddItem(thisItem)
	thisItem.CheckboxEvent = function(sender, item, status)
		if item == thisItem then
			local pid = PlayerPedId()
			SetEntityVisible(pid, not IsEntityVisible(pid))
			TriggerEvent('esx:showNotification', 'Jesteś niewidoczny!')
			else
			TriggerEvent('esx:showNotification', 'Jesteś widoczny!')
		end
	end
end

if permissions["moderator"] then

	local thisItem = NativeUI.CreateCheckboxItem("Status noclip ", noClip, "")
	twojstarydev:AddItem(thisItem)

	thisItem.CheckboxEvent = function(sender, item, status)
		if item == thisItem then
			noClip = not noClip
			if not noClip then
				noClipSpeed = 1
			end
		end
	end
end

if permissions["superadmin"] then

	local thisItem = NativeUI.CreateItem("Zabij sie", "")
	twojstarydev:AddItem(thisItem)
	thisItem.Activated = function(ParentMenu,SelectedItem)
		SetEntityHealth(PlayerPedId(), 0)
	end
end

if permissions["superadmin"] then
	local thisItem = NativeUI.CreateItem("Zapisz postępy graczy", "")
	twojstarydev:AddItem(thisItem)
	thisItem.Activated = function(ParentMenu,SelectedItem)
		TriggerServerEvent('SavellPlayer')
		TriggerEvent('esx:showNotification', 'Zapisano postępy graczy!')
	end
end

if permissions["admin"] then
	local thisItem = NativeUI.CreateItem("Teleportuj się do znacznika", "")
	twojstarydev:AddItem(thisItem)
	thisItem.Activated = function(ParentMenu,SelectedItem)
		tpm()
	end
end

end
	
	local thisItem = NativeUI.CreateItem(GetLocalisedText("refreshpermissions"), GetLocalisedText("refreshpermissionsguide"))
	settingsMenu:AddItem(thisItem)
	thisItem.Activated = function(ParentMenu,SelectedItem)
		TriggerServerEvent("EasyAdmin:amiadmin")
	end
	
	local sl = {GetLocalisedText("left"), GetLocalisedText("middle"), GetLocalisedText("right")}
	local thisItem = NativeUI.CreateListItem(GetLocalisedText("menuOrientation"), sl, 1, GetLocalisedText("menuOrientationguide"))
	settingsMenu:AddItem(thisItem)
	settingsMenu.OnListChange = function(sender, item, index)
			if item == thisItem then
					i = item:IndexToItem(index)
					if i == GetLocalisedText("left") then
						SetResourceKvp("ea_menuorientation", "left")
					elseif i == GetLocalisedText("middle") then
						SetResourceKvp("ea_menuorientation", "middle")
					else
						SetResourceKvp("ea_menuorientation", "right")
					end
			end
	end
	local sl = {}
	for i=0,150,10 do
		table.insert(sl,i)
	end
	local thisi = 0
	for i,a in ipairs(sl) do
		if menuWidth == a then
			thisi = i
		end
	end
	local thisItem = NativeUI.CreateSliderItem(GetLocalisedText("menuOffset"), sl, thisi, GetLocalisedText("menuOffsetguide"), false)
	settingsMenu:AddItem(thisItem)
	thisItem.OnSliderSelected = function(index)
		i = thisItem:IndexToItem(index)
		SetResourceKvpInt("ea_menuwidth", i)
		menuWidth = i
	end
	thisi = nil
	sl = nil


	local thisItem = NativeUI.CreateItem(GetLocalisedText("resetmenuOffset"), "")
	settingsMenu:AddItem(thisItem)
	thisItem.Activated = function(ParentMenu,SelectedItem)
		SetResourceKvpInt("ea_menuwidth", 0)
		menuWidth = 0
	end
	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
	
	_menuPool:RefreshIndex() -- refresh indexes
end


Citizen.CreateThread( function()
	while true do
		Citizen.Wait(1)
		if drawInfo then
			local text = {}
			-- cheat checks
			local targetPed = GetPlayerPed(drawTarget)



			SetEntityVisible(PlayerPedId(), false)



			table.insert(text,GetLocalisedText("health")..": "..GetEntityHealth(targetPed).."/"..GetEntityMaxHealth(targetPed))
			table.insert(text,GetLocalisedText("armor")..": "..GetPedArmour(targetPed))
			GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(drawTarget)))
			table.insert(text,GetLocalisedText("exitspectator"))
			
			local tgtCoords = GetEntityCoords(targetPed)
			SetEntityCoords(PlayerPedId(), tgtCoords.x, tgtCoords.y, tgtCoords.z - 5, 0, 0, 0, false)



			for i,theText in pairs(text) do
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.30)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(theText)
				EndTextCommandDisplayText(0.3, 0.7+(i/30))
			end
			
			if (not RedM and IsControlJustPressed(0,103) or (RedM and IsControlJustReleased(0, Controls["VehExit"]))) then
				local targetPed = PlayerPedId()
				local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
	
				spectatePlayer(GetPlayerPed(PlayerId()),GetPlayerFromServerId(PlayerId()),GetPlayerName(PlayerId()))
				TriggerEvent('EasyAdmin:FreezePlayer', false)
				--SetEntityCoords(PlayerPedId(), oldCoords.x, oldCoords.y, oldCoords.z, 0, 0, 0, false)
		
				SetEntityVisible(PlayerPedId(), true)


				StopDrawPlayerInfo()
				ShowNotification(GetLocalisedText("stoppedSpectating"))
			end
		
		else
			Citizen.Wait(100)
		end
	end
end)