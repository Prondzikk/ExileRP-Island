ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

characters = {}

function getIdentity(source, callback)
  local identifier = GetPlayerIdentifiers(source)[1]
  MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if result[1] ~= nil then
      local kursy1 = 0
      if result[1].job == 'fisherman' then 
        kursy1 = result[1]['rybakkursy']
      elseif result[1].job == 'kawiarnia' then 
        kursy1 = result[1]['kawiarniakursy']
      elseif result[1].job == 'milkman' then 
        kursy1 = result[1]['milkmankursy']
      end

      local data = {
        identifier	= identifier,
        firstname	= result[1]['firstname'],
        lastname	= result[1]['lastname'],
        dateofbirth	= result[1]['dateofbirth'],
        sex			= result[1]['sex'],
        height		= result[1]['height'],
		phonenumber = result[1]['phone_number'],
    kursy = kursy1
      }
			
      callback(data)
    else	
      local data = {
        identifier 	= '',
        firstname 	= '',
        lastname 	= '',
        dateofbirth = '',
        sex 		= '',
        height 		= '',
		phonenumber = '',
    kursy = ''
      }
			
      callback(data)
    end
  end)
end

function getCharacters(source, callback)
  local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll("SELECT * FROM `characters` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if result[1] and result[2] and result[3] then
      local data = {
        identifier    = result[1]['identifier'],
        firstname1    = result[1]['firstname'],
        lastname1    = result[1]['lastname'],
        dateofbirth1  = result[1]['dateofbirth'],
        sex1      = result[1]['sex'],
        height1      = result[1]['height'],
        firstname2    = result[2]['firstname'],
        lastname2    = result[2]['lastname'],
        dateofbirth2  = result[2]['dateofbirth'],
        sex2      = result[2]['sex'],
        height2      = result[2]['height'],
        firstname3    = result[3]['firstname'],
        lastname3    = result[3]['lastname'],
        dateofbirth3  = result[3]['dateofbirth'],
        sex3      = result[3]['sex'],
        height3      = result[3]['height']
      }

      callback(data)
    elseif result[1] and result[2] and not result[3] then
      local data = {
        identifier    = result[1]['identifier'],
        firstname1    = result[1]['firstname'],
        lastname1    = result[1]['lastname'],
        dateofbirth1  = result[1]['dateofbirth'],
        sex1      = result[1]['sex'],
        height1      = result[1]['height'],
        firstname2    = result[2]['firstname'],
        lastname2    = result[2]['lastname'],
        dateofbirth2  = result[2]['dateofbirth'],
        sex2      = result[2]['sex'],
        height2      = result[2]['height'],
        firstname3    = '',
        lastname3    = '',
        dateofbirth3  = '',
        sex3      = '',
        height3      = ''
      }

      callback(data)
    elseif result[1] and not result[2] and not result[3] then
      local data = {
        identifier    = result[1]['identifier'],
        firstname1    = result[1]['firstname'],
        lastname1    = result[1]['lastname'],
        dateofbirth1  = result[1]['dateofbirth'],
        sex1      = result[1]['sex'],
        height1      = result[1]['height'],
        firstname2    = '',
        lastname2    = '',
        dateofbirth2  = '',
        sex2      = '',
        height2      = '',
        firstname3    = '',
        lastname3    = '',
        dateofbirth3  = '',
        sex3      = '',
        height3      = ''
      }

      callback(data)
    else
      local data = {
        identifier    = '',
        firstname1    = '',
        lastname1    = '',
        dateofbirth1  = '',
        sex1      = '',
        height1      = '',
        firstname2    = '',
        lastname2    = '',
        dateofbirth2  = '',
        sex2      = '',
        height2      = '',
        firstname3    = '',
        lastname3    = '',
        dateofbirth3  = '',
        sex3      = '',
        height3      = ''
      }

      callback(data)
    end
  end)
end

function getChars(steamid, callback)
    MySQL.Async.fetchAll("SELECT * FROM `characters` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = steamid
  },
  function(result)
    if result[1] and result[2] and result[3] then
      local data = {
        identifier    = result[1]['identifier'],
        firstname1    = result[1]['firstname'],
        lastname1    = result[1]['lastname'],
        dateofbirth1  = result[1]['dateofbirth'],
        sex1      = result[1]['sex'],
        height1      = result[1]['height'],
        firstname2    = result[2]['firstname'],
        lastname2    = result[2]['lastname'],
        dateofbirth2  = result[2]['dateofbirth'],
        sex2      = result[2]['sex'],
        height2      = result[2]['height'],
        firstname3    = result[3]['firstname'],
        lastname3    = result[3]['lastname'],
        dateofbirth3  = result[3]['dateofbirth'],
        sex3      = result[3]['sex'],
        height3      = result[3]['height']
      }

      callback(data)
    elseif result[1] and result[2] and not result[3] then
      local data = {
        identifier    = result[1]['identifier'],
        firstname1    = result[1]['firstname'],
        lastname1    = result[1]['lastname'],
        dateofbirth1  = result[1]['dateofbirth'],
        sex1      = result[1]['sex'],
        height1      = result[1]['height'],
        firstname2    = result[2]['firstname'],
        lastname2    = result[2]['lastname'],
        dateofbirth2  = result[2]['dateofbirth'],
        sex2      = result[2]['sex'],
        height2      = result[2]['height'],
        firstname3    = '',
        lastname3    = '',
        dateofbirth3  = '',
        sex3      = '',
        height3      = ''
      }

      callback(data)
    elseif result[1] and not result[2] and not result[3] then
      local data = {
        identifier    = result[1]['identifier'],
        firstname1    = result[1]['firstname'],
        lastname1    = result[1]['lastname'],
        dateofbirth1  = result[1]['dateofbirth'],
        sex1      = result[1]['sex'],
        height1      = result[1]['height'],
        firstname2    = '',
        lastname2    = '',
        dateofbirth2  = '',
        sex2      = '',
        height2      = '',
        firstname3    = '',
        lastname3    = '',
        dateofbirth3  = '',
        sex3      = '',
        height3      = ''
      }

      callback(data)
    else
      local data = {
        identifier    = '',
        firstname1    = '',
        lastname1    = '',
        dateofbirth1  = '',
        sex1      = '',
        height1      = '',
        firstname2    = '',
        lastname2    = '',
        dateofbirth2  = '',
        sex2      = '',
        height2      = '',
        firstname3    = '',
        lastname3    = '',
        dateofbirth3  = '',
        sex3      = '',
        height3      = ''
      }

      callback(data)
    end
  end)
end

function getID(steamid, callback)
  MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = steamid
  },
  function(result)
    if result[1] ~= nil then
      local data = {
        identifier	= identifier,
        firstname	= result[1]['firstname'],
        lastname	= result[1]['lastname'],
        dateofbirth	= result[1]['dateofbirth'],
        sex			= result[1]['sex'],
        height		= result[1]['height'],
		phonenumber = result[1]['phone_number']
      }
			
      callback(data)
    else	
      local data = {
        identifier 	= '',
        firstname 	= '',
        lastname 	= '',
        dateofbirth = '',
        sex 		= '',
        height 		= '',
		phonenumber = ''
      }
			
      callback(data)
    end
  end)
end

RegisterServerEvent('menu:id')
AddEventHandler('menu:id', function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local citizen = {}
  local bron = false
  local kata = false
  local katb = false
  local katc = false
  local ubezmehtext = false
  local ubezmedtext = false

  local resulta = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
  {
    ['@owner']   = xPlayer.identifier,
    ['@type'] = 'drive_bike'

  })
  local resultb = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
  {
    ['@owner']   = xPlayer.identifier,
    ['@type'] = 'drive'

  })
  local resultc = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
  {
    ['@owner']   = xPlayer.identifier,
    ['@type'] = 'drive_truck'

  })
  local resultems = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = xPlayer.identifier,
	    ['@type'] = 'ems_insurance',

    })
  local resultmech = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = xPlayer.identifier,
      ['@type'] = 'oc_insurance',
  
    })
  local resultwea = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
	  	['@type'] = 'weapon',
	  	['@owner']   = xPlayer.identifier
    })
  
  if resultwea[1] ~= nil then
    if resultwea[1].type == "weapon" then
      bron = true
    end
  end
	if resultems[1] ~= nil then
    ubezmedtext = true
  end
  if resultmech[1] ~= nil then
    ubezmehtext = true
  end
  if resulta[1] ~= nil then
    kata = true
  end
  if resultb[1] ~= nil then
    katb = true
  end
  if resultc[1] ~= nil then
    katc = true
  end


  TriggerClientEvent('sendProximityMessageID', -1, _source, xPlayer.character, bron, kata, katb, katc, ubezmedtext, ubezmehtext)
end)

RegisterNetEvent('menu:phone')
AddEventHandler('menu:phone', function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  TriggerClientEvent('sendProximityMessagePhone', -1, _source, xPlayer.character, xPlayer.job.name, xPlayer.job.label, xPlayer.job.grade_label)
end)

RegisterServerEvent('menu:characters')
AddEventHandler('menu:characters', function(callback)
  getCharacters(source, function(data)
    if data.firstname1 ~= '' and data.firstname2 ~= '' and data.firstname3 ~= '' then
      TriggerClientEvent('chatMessage', -1, '', {217, 217, 217}, "Character 1: " .. data.firstname1 .. " " .. data.firstname1)
      TriggerClientEvent('chatMessage', -1, '', {217, 217, 217}, "Character 2: " .. data.firstname2 .. " " .. data.lastname2)
      TriggerClientEvent('chatMessage', -1, '', {217, 217, 217}, "Character 3: " .. data.firstname3 .. " " .. data.lastname3)
	elseif data.firstname1 ~= '' and data.firstname2 ~= '' and data.firstname3 == '' then
      TriggerClientEvent('chatMessage', -1, '', {217, 217, 217}, "Character 1: " .. data.firstname1 .. " " .. data.firstname1)
      TriggerClientEvent('chatMessage', -1, '', {217, 217, 217}, "Character 2: " .. data.firstname2 .. " " .. data.lastname2)
	elseif data.firstname1 ~= '' and data.firstname2 == '' and data.firstname3 == '' then
      TriggerClientEvent('chatMessage', -1, '', {217, 217, 217}, "Character 1: " .. data.firstname1 .. " " .. data.firstname1)
	elseif data.firstname1 == '' and data.firstname2 == '' and data.firstname3 == '' then
      TriggerClientEvent('chatMessage', -1, '', {217, 217, 217}, "You have no characters.")
	end
  end)
end)

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

AddEventHandler('es:playerLoaded', function(source)
  local steamid = GetPlayerIdentifiers(source)[1]
  
  getCharacters(source, function(data)
    if data ~= nil then
      if data.firstname1 ~= '' and data.firstname2 ~= '' and data.firstname3 ~= '' then
	    local char1 = tostring(data.firstname1) .. " " .. tostring(data.lastname1)
	    local char2 = tostring(data.firstname2) .. " " .. tostring(data.lastname2)
	    local char3 = tostring(data.firstname3) .. " " .. tostring(data.lastname3)
		
		identification = {
		  steamidentifier = steamid,
		  playerid        = source
		}
		
	    characters = {
	      character1         = char1,
		  character2         = char2,
		  character3         = char3,
	    }
		  
		TriggerClientEvent('menu:setCharacters', source, characters)	
		TriggerClientEvent('menu:setIdentifier', source, identification)
		
      elseif data.firstname1 ~= '' and data.firstname2 ~= '' and data.firstname3 == '' then
	    local char1 = tostring(data.firstname1) .. " " .. tostring(data.lastname1)
	    local char2 = tostring(data.firstname2) .. " " .. tostring(data.lastname2)
	    local char3 = "No Character"
		
		identification = {
		  steamidentifier = steamid,
		  playerid        = source
		}
		
	    characters = {
	      character1         = char1,
		  character2         = char2,
		  character3         = char3,
	    }
		  
		TriggerClientEvent('menu:setCharacters', source, characters)	
		TriggerClientEvent('menu:setIdentifier', source, identification)
		
      elseif data.firstname1 ~= '' and data.firstname2 == '' and data.firstname3 == '' then
      	local char1 = tostring(data.firstname1) .. " " .. tostring(data.lastname1)
      	local char2 = "No Character"
      	local char3 = "No Character"
		
		identification = {
		  steamidentifier = steamid,
		  playerid        = source
		}
		
	    characters = {
	      character1         = char1,
		  character2         = char2,
		  character3         = char3,
	    }
		  
		TriggerClientEvent('menu:setCharacters', source, characters)	
		TriggerClientEvent('menu:setIdentifier', source, identification)
		
      elseif data.firstname1 == '' and data.firstname2 == '' and data.firstname3 == '' then
      	local char1 = "No Character"
	    local char2 = "No Character"
      	local char3 = "No Character"
		
		identification = {
		  steamidentifier = steamid,
		  playerid        = source
		}
		
	    characters = {
	      character1         = char1,
		  character2         = char2,
		  character3         = char3,
	    }
		  
		TriggerClientEvent('menu:setCharacters', source, characters)	
		TriggerClientEvent('menu:setIdentifier', source, identification)
		
      else
	  
	    identification = {
		  steamidentifier = steamid,
		  playerid        = source
		}
		
      	characters = {
      	  character1 = "No Character",
      	  character2 = "No Character",
      	  character3 = "No Character"
      	}
	  
      	TriggerClientEvent('menu:setCharacters', source, characters)
        TriggerClientEvent('menu:setIdentifier', source, identification)			
		
      end
    end
  end)
end)

RegisterServerEvent('menu:setChars')
AddEventHandler('menu:setChars', function(myIdentifiers)
  getChars(myIdentifiers.steamidentifier, function(data)	
    if data ~= nil then
	  if data.firstname1 ~= '' and data.firstname2 ~= '' and data.firstname3 ~= '' then
	    getID(myIdentifiers.steamidentifier, function(result)
		  if result ~= nil then
		    local activeName = tostring(result.firstname) .. " " .. tostring(result.lastname)
	        local char1 = tostring(data.firstname1) .. " " .. tostring(data.lastname1)
	        local char2 = tostring(data.firstname2) .. " " .. tostring(data.lastname2)
	        local char3 = tostring(data.firstname3) .. " " .. tostring(data.lastname3)
		      
			if activeName == char1 then
	          characters = {
	            character1 = char1 .. " [Active]",
		        character2 = char2,
		        character3 = char3
	          }	
		  
              TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
			elseif activeName == char2 then
	          characters = {
	            character1 = char1,
		        character2 = char2 .. " [Active]",
		        character3 = char3
	          }	
		  
              TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
			elseif activeName == char3 then
	          characters = {
	            character1 = char1,
		        character2 = char2,
		        character3 = char3 .. " [Active]"
	          }	
		  
              TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
		    else
			  characters = {
			    character1 = char1,
			    character2 = char2,
			    character3 = char3
		      }
				
			  TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
			end
		  else
			characters = {
			  character1 = char1,
			  character2 = char2,
			  character3 = char3
		    }
				
			TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
		  end
		end)
      elseif data.firstname1 ~= '' and data.firstname2 ~= '' and data.firstname3 == '' then
		getID(myIdentifiers.steamidentifier, function(result)
		  if result ~= nil then
			local activeName = tostring(result.firstname) .. " " .. tostring(result.lastname)
	        local char1 = tostring(data.firstname1) .. " " .. tostring(data.lastname1)
	        local char2 = tostring(data.firstname2) .. " " .. tostring(data.lastname2)
	        local char3 = "No Character"
		      
			if activeName == char1 then
	          characters = {
	            character1 = char1 .. " [Active]",
		        character2 = char2,
		        character3 = char3
	          }	
		  
              TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
			elseif activeName == char2 then
	          characters = {
	            character1 = char1,
		        character2 = char2 .. " [Active]",
		        character3 = char3
	          }	
		  
              TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
			else
			  characters = {
				character1 = char1,
				character2 = char2,
				character3 = char3
		      }
				
			  TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
			end
		  else
			characters = {
			  character1 = char1,
		      character2 = char2,
		      character3 = char3
		    }
				
			TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
		  end
		end)
      elseif data.firstname1 ~= '' and data.firstname2 == '' and data.firstname3 == '' then
		getID(myIdentifiers.steamidentifier, function(result)
		  if result ~= nil then
			local activeName = tostring(result.firstname) .. " " .. tostring(result.lastname)
	        local char1 = tostring(data.firstname1) .. " " .. tostring(data.lastname1)
	        local char2 = "No Character"
	        local char3 = "No Character"
		      
			if activeName == char1 then
	          characters = {
	            character1 = char1 .. " [Active]",
		        character2 = char2,
		        character3 = char3
	          }	
		  
              TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
			else
			  characters = {
				character1 = char1,
				character2 = char2,
				character3 = char3
			  }
				
			  TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
			end
		  else
			characters = {
		      character1 = char1,
			  character2 = char2,
			  character3 = char3
		    }
				
			TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)
		  end
		end)  
	  else	
	    characters = {
	      character1 = "No Character",
		  character2 = "No Character",
		  character3 = "No Character"
	    }  
		
		TriggerClientEvent('menu:setCharacters', myIdentifiers.playerid, characters)	  
	  end
	end
  end)
end)


RegisterServerEvent('menu:deleteChar1')
AddEventHandler('menu:deleteChar1', function(myIdentifiers)
  getChars(myIdentifiers.steamidentifier, function(data)
    local data = {
      identifier   = data.identifier,
      firstname  = data.firstname1,
      lastname  = data.lastname1,
      dateofbirth  = data.dateofbirth1,
      sex      = data.sex1,
      height    = data.height1
    }
	
	if data.firstname ~= '' then
      deleteCharacter(myIdentifiers.steamidentifier, data, function(callback)
	    if callback == true then
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "You Have Deleted " .. data.firstname .. " " .. data.lastname .. "!")
		else
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "Failed To Delete Identity!")
		end
	  end)
	else
	  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "No Character In Slot 1!")
	end
  end)
end)

RegisterServerEvent('menu:deleteChar2')
AddEventHandler('menu:deleteChar2', function(myIdentifiers)
  getChars(myIdentifiers.steamidentifier, function(data)
    local data = {
      identifier   = data.identifier,
      firstname  = data.firstname2,
      lastname  = data.lastname2,
      dateofbirth  = data.dateofbirth2,
      sex      = data.sex2,
      height    = data.height2
    }
	
	if data.firstname ~= '' then
      deleteCharacter(myIdentifiers.steamidentifier, data, function(callback)
	    if callback == true then
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "You Have Deleted " .. data.firstname .. " " .. data.lastname .. "!")
		else
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "Failed To Delete Identity!")
		end
	  end)
	else
	  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "No Character In Slot 2!")
	end
  end)
end)

RegisterServerEvent('menu:deleteChar3')
AddEventHandler('menu:deleteChar3', function(myIdentifiers)
  getChars(myIdentifiers.steamidentifier, function(data)
    local data = {
      identifier   = data.identifier,
      firstname  = data.firstname3,
      lastname  = data.lastname3,
      dateofbirth  = data.dateofbirth3,
      sex      = data.sex3,
      height    = data.height3
    }
	
	if data.firstname ~= '' then
      deleteCharacter(myIdentifiers.steamidentifier, data, function(callback)
	    if callback == true then
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "You Have Deleted " .. data.firstname .. " " .. data.lastname .. "!")
		else
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "Failed To Delete Identity!")
		end
	  end)
	else
	  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "No Character In Slot 3!")
	end
  end)
end)

RegisterServerEvent('menu:selectChar1')
AddEventHandler('menu:selectChar1', function(myIdentifiers)
  getChars(myIdentifiers.steamidentifier, function(data)
    local data = {
      identifier   = data.identifier,
      firstname  = data.firstname1,
      lastname  = data.lastname1,
      dateofbirth  = data.dateofbirth1,
      sex      = data.sex1,
      height    = data.height1
    }
	
	if data.firstname ~= '' then
      updateIdentity(myIdentifiers.steamidentifier, data, function(callback)
	    if callback == true then
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "You Are Now " .. data.firstname .. " " .. data.lastname .. "!")
		else
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "Failed To Update Identity!")
		end
	  end)
	else
	  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "No Character In Slot 1!")
	end
  end)
end)

RegisterServerEvent('menu:selectChar2')
AddEventHandler('menu:selectChar2', function(myIdentifiers)
  getChars(myIdentifiers.steamidentifier, function(data)
    local data = {
      identifier   = data.identifier,
      firstname  = data.firstname2,
      lastname  = data.lastname2,
      dateofbirth  = data.dateofbirth2,
      sex      = data.sex2,
      height    = data.height2
    }
	
	if data.firstname ~= '' then
      updateIdentity(myIdentifiers.steamidentifier, data, function(callback)
	    if callback == true then
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "You Are Now " .. data.firstname .. " " .. data.lastname .. "!")
		else
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "Failed To Update Identity!")
		end
	  end)
	else
	  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "No Character In Slot 2!")
	end
  end)
end)

RegisterServerEvent('menu:selectChar3')
AddEventHandler('menu:selectChar3', function(myIdentifiers)
  getChars(myIdentifiers.steamidentifier, function(data)
    local data = {
      identifier   = data.identifier,
      firstname  = data.firstname3,
      lastname  = data.lastname3,
      dateofbirth  = data.dateofbirth3,
      sex      = data.sex3,
      height    = data.height3
    }
	
	if data.firstname ~= '' then
      updateIdentity(myIdentifiers.steamidentifier, data, function(callback)
	    if callback == true then
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "You Are Now " .. data.firstname .. " " .. data.lastname .. "!")
		else
		  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "Failed To Update Identity!")
		end
	  end)
	else
	  TriggerClientEvent('chatMessage', myIdentifiers.playerid, "[IDENTITY]", {255, 0, 0}, "No Character In Slot 3!")
	end
  end)
end)

--===============================================
--==  Update The Player's Identification       ==
--===============================================
function updateIdentity(steamid, data, callback)
  MySQL.Async.execute("UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier",
    {
      ['@identifier']   = steamid,
      ['@firstname']    = data.firstname,
      ['@lastname']     = data.lastname,
      ['@dateofbirth']  = data.dateofbirth,
      ['@sex']        = data.sex,
      ['@height']       = data.height
    },
  function(done)
    if callback then
      callback(true)
    end
  end)
end

--===============================================
--==  Delete The Player's Character            ==
--===============================================
function deleteCharacter(steamid, data, callback)
  MySQL.Async.execute("DELETE FROM `characters` WHERE identifier = @identifier AND firstname = @firstname AND lastname = @lastname AND dateofbirth = @dateofbirth AND sex = @sex AND height = @height",
    {
      ['@identifier']   = steamid,
      ['@firstname']    = data.firstname,
      ['@lastname']     = data.lastname,
      ['@dateofbirth']  = data.dateofbirth,
      ['@sex']        = data.sex,
      ['@height']       = data.height
    },
  function(done)
    if callback then
      callback(true)
    end
  end)
end

--===============================================
--== /charselect 1,2,3 Select Your Active Char ==
--===============================================
TriggerEvent('es:addCommand', 'getID', function(source, args, user)

  identification = {
    steamidentifier = GetPlayerIdentifiers(source)[1],
	playerid        = source
  }
		
  TriggerClientEvent('menu:setIdentifier', source, identification)	
end)

--===============================================
--== /charselect 1,2,3 Select Your Active Char ==
--===============================================
TriggerEvent('es:addCommand', 'retID', function(source, args, user)
  TriggerClientEvent('menu:getSteamIdent', source)
end)



-- dowody


local katb = false
local kata = false
local katc = false
local jestb = 'nil'
local jestzdrowie = nil
local jestoc = nil
function GetDowodKurwa(license)
	local identifier = license
	local result = MySQL.Sync.fetchAll("SELECT firstname, lastname, dateofbirth, phone_number, sex, height, job, job_grade, account_number, kursy, odznakakurwa FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			phone_number = identity['phone_number'],
			job = identity['job'],
			sex = identity['sex'],
			height = identity['height'],
			job_grade = identity['job_grade'],
			account_number = identity['account_number'],
      kursy = identity['kursy'],
      odznaka = identity['odznakakurwa'],

                        
		}
	else
		return nil
	end
end

function getlicenseA(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = xPlayer.identifier,
      ['@type'] = 'drive_bike'

    })
	if result[1] ~= nil then
        jesta = '~g~A ~s~'
	else
		jesta = '~r~A ~s~'
	end
end

function getlicenseB(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = xPlayer.identifier,
      ['@type'] = 'drive'

    })
	if result[1] ~= nil then
        jestb = '~g~B ~s~'
	else
		jestb = '~r~B ~s~'
	end
end

function getlicenseC(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = xPlayer.identifier,
      ['@type'] = 'drive_truck'

    })
	if result[1] ~= nil then 
        jestc = '~g~C~s~'
	else
		jestc = '~r~C~s~'
	end
end

function getlicenseW(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
		['@type'] = 'weapon',
		['@owner']   = xPlayer.identifier
    })
    if result[1] ~= nil then
      if result[1].type == "weapon" then
            jestw = '~g~Tak~s~\n'
      else
        jestw = '~r~Nie~s~\n'
      end
    else
      jestw = '~r~Nie~s~\n'
    end
end


RegisterServerEvent('ExileRP:Dowod1')
AddEventHandler('ExileRP:Dowod1', function(xd)

local _source = source
local xPlayer = ESX.GetPlayerFromId(xd)
local citizen = {}
local bron = false
local kata = false
local katb = false
local katc = false
local ubezmehtext = false
local ubezmedtext = false

local resulta = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
{
  ['@owner']   = xPlayer.identifier,
  ['@type'] = 'drive_bike'

})
local resultb = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
{
  ['@owner']   = xPlayer.identifier,
  ['@type'] = 'drive'

})
local resultc = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
{
  ['@owner']   = xPlayer.identifier,
  ['@type'] = 'drive_truck'

})
local resultems = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
  {
    ['@owner']   = xPlayer.identifier,
    ['@type'] = 'ems_insurance',

  })
local resultmech = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
  {
    ['@owner']   = xPlayer.identifier,
    ['@type'] = 'oc_insurance',

  })
local resultwea = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
  {
    ['@type'] = 'weapon',
    ['@owner']   = xPlayer.identifier
  })

if resultwea[1] ~= nil then
  if resultwea[1].type == "weapon" then
    bron = true
  end
end
if resultems[1] ~= nil then
  ubezmedtext = true
end
if resultmech[1] ~= nil then
  ubezmehtext = true
end
if resulta[1] ~= nil then
  kata = true
end
if resultb[1] ~= nil then
  katb = true
end
if resultc[1] ~= nil then
  katc = true
end





TriggerClientEvent('sendProximityMessageID', -1, xPlayer.source, xPlayer.character, bron, kata, katb, katc, ubezmedtext, ubezmehtext)
end)


RegisterServerEvent('ExileRP:Dowod')
AddEventHandler('ExileRP:Dowod', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)

local lickaB = getlicenseB(_source)
local lickaA = getlicenseA(_source)
local lickaC = getlicenseC(_source)
local lickaW = getlicenseW(_source)
local lickaZdrowie = getlicenseZdrowie(_source)
local lickaOC = getlicenseOC(_source)
local name = GetDowodKurwa(xPlayer.identifier)
local sex = name.sex

local firstname, lastname = name.firstname, name.lastname
local str = "Licencja na broń: " .. jestw
str = str .. "Ubezpieczenie: " ..jestzdrowie.. ' ' ..jestoc .. "\n"
str = str .. "Prawo jazdy kat: " ..jesta.. jestb ..jestc 

if name.firstname == nil then
  name.firstname = 'X'
elseif name.lastname == nil then
  name.lastname = 'X'
elseif name.dateofbirth == nil then
  name.dateofbirth = 'X'
elseif name.sex == nil then
  name.sex= 'Płeć Nieznana'
elseif name.sex == 'M' then
  name.sex= 'Mężczyzna'
elseif name.sex == 'K' then
  name.sex= 'Kobieta'
elseif name.height == nil then
  name.height = 'X'
end

TriggerClientEvent('ExileRP:Dow', -1, _source, name.firstname..' '..name.lastname, '~y~' .. name.sex .. ', ' ..name.dateofbirth .. ', ' .. name.height .. 'cm', str )
end)



function getlicenseZdrowie(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = xPlayer.identifier,
	  ['@type'] = 'ems_insurance',

    })


	if result[1] ~= nil then

ubeznw = true
jestzdrowie = '~g~NW~s~'
	else
		jestzdrowie = '~r~NW~s~'
	end
end

function GetCharacterName(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier',
	{
	['@identifier'] = xPlayer.identifier
	})
	return result[1].firstname .. ' ' .. result[1].lastname
end

function getlicenseOC(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

local result = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE type = @type and owner = @owner",
    {
      ['@owner']   = xPlayer.identifier,
      ['@type'] = 'oc_insurance'

    })


if result[1] ~= nil then
	ubezoc = true
	jestoc = '~g~OC~s~'
	else
		jestoc = '~r~OC~s~'
	end
end

RegisterServerEvent('esx_exilemenu:getUserInfo')
AddEventHandler('esx_exilemenu:getUserInfo', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local suczka = GetDowodKurwa(xPlayer.identifier).firstname
	local MiniDiva = GetDowodKurwa(xPlayer.identifier).lastname
  local krzysiu = GetDowodKurwa(xPlayer.identifier).kursy
	TriggerClientEvent('esx_exilemenu:getUserInfo', _source, suczka, MiniDiva, krzysiu)
end)


RegisterServerEvent('ExileRP:Wizytowka')
AddEventHandler('ExileRP:Wizytowka', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	
	local name = GetDowodKurwa(xPlayer.identifier)
		if name.phone_number == nil then 
			name.phone_number = "Brak karty SIM" 
		end
		
	TriggerClientEvent('ExileRP:Wiz', -1,_source, name.firstname, '~y~'..xPlayer.job.label .. ' - ' .. xPlayer.job.grade_label, '~o~Numer telefonu: ~s~' .. name.phone_number .. '\n~o~Numer konta: ~s~' .. name.account_number)
--	TriggerClientEvent("pokazujewiz", -1, _source, name.firstname .. " - ".. name.phone_number)
end)

RegisterServerEvent('ExileRP:CarDealer')
AddEventHandler('ExileRP:CarDealer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	
	local name = GetDowodKurwa(xPlayer.identifier)
		if name.phone_number == nil then 
			name.phone_number = "Brak karty SIM" 
		end
		
	TriggerClientEvent('ExileRP:CarDealer', -1,_source, name.firstname.. ' ' ..name.lastname, '~y~'..xPlayer.job.label .. ' - ' .. xPlayer.job.grade_label, '~o~Numer kontaktowy: ~s~' .. name.phone_number)
end)

RegisterServerEvent('accounttest')
AddEventHandler('accounttest', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)	
	local name = GetDowodKurwa(xPlayer.identifier)
	if name.account_number == nil then
		name.account_number = "XXXXXX"
	end
	TriggerClientEvent('esx:dowod_account', -1,_source, name.firstname.. ' ' ..name.lastname,' ','Numer Konta: ~y~' ..name.account_number)
end)


RegisterServerEvent('menu:blacha1')
AddEventHandler('menu:blacha1', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent('sendProximityMessageBlacha1', -1, _source, xPlayer.character,  xPlayer.job.name, xPlayer.job.label, xPlayer.job.grade_label)
end)

RegisterServerEvent('menu:blacha2')
AddEventHandler('menu:blacha2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	TriggerClientEvent('sendProximityMessageBlacha2', -1, _source, xPlayer.character,  xPlayer.job.name, xPlayer.job.label, xPlayer.job.grade_label)
end)

RegisterServerEvent('menu:blacha3')
AddEventHandler('menu:blacha3', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	TriggerClientEvent('sendProximityMessageBlacha3', -1, _source, xPlayer.character,  xPlayer.job.name, xPlayer.job.label, xPlayer.job.grade_label)
end)

RegisterServerEvent('ExileRP:Badges2')
AddEventHandler('ExileRP:Badges2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = GetDowodKurwa(xPlayer.identifier)
	local imie = name.firstname .. ' ' .. name.lastname
	local job = xPlayer.job
	local stopien = job.grade_label
	local badgeFull = 'Brak odznaki'
	if name.badge.number ~= 0 then 
		badgeFull = name.badge.label .. ' ' .. name.badge.number
	end

	local message = '^6Pokazuje legitymację SAMS: '  .. imie .. ' - [' .. badgeFull .. '] ' .. stopien ..''

	TriggerClientEvent('ExileRP:Badge2', -1,_source, '~w~'..name.firstname..' '..name.lastname, '~y~Legitymacja - SAMS', '~w~Stopień: ~y~'..stopien, '~w~Numer odznaki: ~y~' .. badgeFull)
	TriggerClientEvent('esx_dowod:sendProximityMessage', -1, _source, _source, message)
end)

RegisterServerEvent('ExileRP:Badges3')
AddEventHandler('ExileRP:Badges3', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = GetDowodKurwa(xPlayer.identifier)
	local imie = name.firstname .. ' ' .. name.lastname
	local job = xPlayer.job
	local stopien = job.grade_label
	local badgeFull = 'Brak odznaki'
	if name.badge.number ~= 0 then 
		badgeFull = name.badge.label .. ' ' .. name.badge.number
	end

	local message = '^6Pokazuje plakietkę LSC: '  .. imie .. ' - [' .. badgeFull .. '] ' .. stopien ..''

	TriggerClientEvent('ExileRP:Badge3', -1,_source, '~w~'..name.firstname..' '..name.lastname, '~y~Legitymacja - LSC', '~w~Stopień: ~y~'..stopien, '~w~Numer odznaki: ~y~' .. badgeFull)
	TriggerClientEvent('esx_dowod:sendProximityMessage', -1, _source, _source, message)
end)