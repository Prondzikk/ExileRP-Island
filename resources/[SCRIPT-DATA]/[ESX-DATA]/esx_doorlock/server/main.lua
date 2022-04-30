nESX				= nil
local DoorInfo	= {}
local doors = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_doorlock:updateState')
AddEventHandler('esx_doorlock:updateState', function(id, state)
	local xPlayer = ESX.GetPlayerFromId(source)
	doors[id].locked = state 
	TriggerClientEvent('esx_doorlock:update', -1, id, state)
end)

ESX.RegisterServerCallback('esx_door:get', function(source, cb)
	doors = {
	
	[1] = { objects = {
		[1] = {
			object = 'v_ilev_shrfdoor',
			x = 1854.79, 
			y = 3683.36,
			z = 34.27
		},
	},
	position = vector3(1855.0742, 3683.6052, 34.27),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = false, distance = 1.50,size = 0.6, can = false, draw = true},
	
	[2] = { objects = {
		[1] = {
			object = 'v_ilev_rc_door2',
			x = 1856.34, 
			y = 3689.77,
			z = 34.27
		},
	},
	position = vector3(1856.83, 3689.669, 34.27),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},
	
	[3] = { objects = {
		[1] = {
			object = 'v_ilev_rc_door2',
			x = 1850.11, 
			y = 3683.96,
			z = 34.27
		},
	},
		position = vector3(1850.691, 3682.841, 34.27),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[4] = { objects = {
		[1] = {
			object = 'v_ilev_rc_door2',
			x = 1849.25, 
			y = 3691.02,			
			z = 34.27

		},
	},
	position = vector3(1848.261, 3690.434, 34.27),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[5] = { objects = {
		[1] = {
			object = 'v_ilev_rc_door2',
			x = 1851.96, 
			y = 3695.08,
			z = 34.27
		},
	},
	position = vector3(1852.389, 3694.638, 34.27),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[6] = { objects = {
		[1] = {
			object = 'v_ilev_shrfdoor',
			x = 1859.79, 
			y = 3691.87,
			z = 34.27
		},
	},
	position = vector3(1860.1058, 3692.1274, 34.27),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},
	
	[7] = { objects = {
		[1] = {
			object = 'v_ilev_rc_door2',
			x = 1848.47, 
			y = 3683.8,
			z = 30.26
		},
		[2] = {
			object = 'v_ilev_rc_door2',
			x = 1846.63, 
			y = 3682.72,
			z = 30.26
		},
	},
	position = vector3(1847.557, 3683.2268, 30.26),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},	

	[8] = { objects = {
		[1] = {
			object = 'v_ilev_arm_secdoor',
			x = 1852.12, 
			y = 3685.8,
			z = 30.26
		},
	},
	position = vector3(1852.3867, 3686.02, 30.26),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[9] = { objects = {
		[1] = {
			object = 'v_ilev_arm_secdoor',
			x = 1855.3, 
			y = 3687.66,
			z = 30.26
		},
	},
	position = vector3(1855.6438, 3687.8459, 30.26),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[10] = { objects = {
		[1] = {
			object = 'v_ilev_ph_cellgate',
			x = 1847.0429, 
			y = 3685.0725,
			z = 34.2603
		},
	},
	position = vector3(1847.0429, 3685.0725, 34.4603),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[11] = { objects = {
		[1] = {
			object = 'v_ilev_ph_cellgate',
			x = 1845.2579, 
			y = 3687.9915,
			z = 34.2593
		},
	},
	position = vector3(1845.2579, 3687.9915, 34.4603),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[12] = { objects = {
		[1] = {
			object = 'v_ilev_shrf2door',
			x = -443.1, 
			y = 6015.6,
			z = 31.7
		},
		[2] = {
			object = 'v_ilev_shrf2door',
			x = -443.9, 
			y = 6016.6,
			z = 31.7
		},
	},
	position = vector3(-443.5, 6016.3, 32.0),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},
	

	[13] = { objects = {
		[1] = {
			object = 'v_ilev_gc_door01',
			x = -451.5, 
			y = 6006.6,
			z = 31.7
		},
	},
	position = vector3(-451.5, 6006.6, 31.7),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[14] = { objects = {
		[1] = {
			object = 'v_ilev_gc_door01',
			x = -446.5, 
			y = 6001.8,
			z = 31.7
		},
	},
	position = vector3(-446.8, 6001.81, 31.7),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[15] = { objects = {
		[1] = {
			object = 'v_ilev_ph_cellgate',
			x = -432.9, 
			y = 5992.5,
			z = 31.7
		},
	},
	position = vector3(-432.9, 5992.5, 31.7),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[16] = { objects = {
		[1] = {
			object = 'v_ilev_ph_cellgate',
			x = -428.5, 
			y = 5997.1,
			z = 31.7
		},
	},
	position = vector3(-428.5, 5997.1, 31.7),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[17] = { objects = {
		[1] = {
			object = 'v_ilev_ph_cellgate',
			x = -431.7, 
			y = 6000.2,
			z = 31.7
		},
	},
	position = vector3(-431.7, 6000.2, 31.7),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = false,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[18] = { objects = {
		[1] = {
			object = 'gabz_pillbox_singledoor',
			x = -669.70, 
			y = 333.17,
			z = 83.1
		},
	},
	position = vector3(-669.70, 333.17, 83.1),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[19] = { objects = {
		[1] = {
			object = 'gabz_pillbox_singledoor',
			x = -667.14, 
			y = 328.85,
			z = 83.12
		},
	},
	position = vector3(-667.14, 328.85, 83.12),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[20] = { objects = {
		[1] = {
			object = 'gabz_pillbox_doubledoor_l',
			x = -693.05,  
			y = 326.82,
			z = 83.13
		},
		[2] = {
			object = 'gabz_pillbox_doubledoor_r',
			x = -693.05,  
			y = 326.82,
			z = 83.13
		},
	},

	position = vector3(-693.05, 326.82, 83.13),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},
	

	[21] = { objects = {
		[1] = {
			object = 'gabz_pillbox_doubledoor_l',
			x = -692.51,  
			y = 332.99,
			z = 83.12
		},
		[2] = {
			object = 'gabz_pillbox_doubledoor_r',
			x = -692.51,  
			y = 332.99,
			z = 83.12
		},
	},

	position = vector3(-692.51, 332.99, 83.12),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},


	[22] = { objects = {
		[1] = {
			object = 'gabz_pillbox_doubledoor_l',
			x = -691.96, 
			y = 338.84,
			z = 83.12
		},
		[2] = {
			object = 'gabz_pillbox_doubledoor_r',
			x = -691.96, 
			y = 338.84,
			z = 83.12
		},
	},
		
	position = vector3(-691.96, 338.84, 83.12),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},


	[23] = { objects = {
		[1] = {
			object = 'gabz_pillbox_singledoor',
			x = -690.87,  
			y = 352.04,
			z = 83.12
		},
	},
		
	position = vector3(-690.89, 351.82, 84.12-0.90),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},
	

	[24] = { objects = {
		[1] = {
			object = 'gabz_pillbox_singledoor',
			x = -690.48,  
			y = 356.73,
			z = 83.12
		},
	},
			
	position = vector3(-690.48, 356.73, 84.12-0.90),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[25] = { objects = {
		[1] = {
			object = 'gabz_pillbox_singledoor',
			x = -689.93,  
			y = 363.20,
			z = 84.12
		},
	},
			
	position = vector3(-689.93, 363.20, 84.12-0.90),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[26] = { objects = {
		[1] = {
			object = 'v_ilev_cor_doorglassa',
			x = 1826.2,  
			y = 3681.7,
			z = 34.2
		},
		[2] = {
			object = 'v_ilev_cor_doorglassb',
			x = 1825.6,
			y = 3681.6,
			z = 34.2
		},
	},
				
	position = vector3(1826.1, 3681.4, 34.7),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[27] = { objects = {
		[1] = {
			object = 'v_ilev_roc_door3',
			x = 948.3,  
			y = -964.9,
			z = 39.5
		},
	},
					
	position = vector3(948.3, -964.7, 39.5),jobs = { ['mecano'] = true, ['offmecano'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[28] = { objects = {
		[1] = {
			object = 'v_ilev_roc_door3',
			x = 954.5,  
			y = -972.3,
			z = 39.5
		},
	},
						
	position = vector3(954.5, -972.3, 39.5),jobs = { ['mecano'] = true, ['offmecano'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

	[29] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -448.28,
			y = -316.69,
			z = 34.91
		},
	},
	
	position  = vector3(-448.28,-316.69, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[30] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -449.42,
			y = -313.89,
			z = 34.91
		},
	},
	
	position  = vector3(-449.42,-313.89, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[31] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -451.81,
			y = -308.43,
			z = 34.91
		},
	},
	
	position  = vector3(-451.81,-308.43, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[32] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -453.05,
			y = -305.36,
			z = 34.91
		},
	},
	
	position  = vector3(-453.05,-305.36, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[33] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -455.19,
			y = -299.82,
			z = 34.91
		},
	},
	
	position  = vector3(-455.19,-299.82, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[34] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -457.43,
			y = -294.56,
			z = 34.91
		},
	},
	
	position  = vector3(-457.43,-294.56, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[35] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -443.02,
			y = -316.44,
			z = 34.91
		},
	},
	
	position  = vector3(-443.02,-316.44, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[36] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -447.01,
			y = -306.18,
			z = 34.91
		},
	},
	
	position  = vector3(-447.01,-306.18, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[37] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -449.36,
			y = -300.51,
			z = 34.91
		},
	},
	
	position  = vector3(-449.36,-300.51, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[38] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -452.87,
			y = -292.28,
			z = 34.91
		},
	},
	
	position  = vector3(-452.87,-292.28, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
---Przebieralnia / Recepcja----	

	[39] = { objects = {
		[1] = {
			object = 'gus_hos_door',
			x = -440.57,
			y = -322.28,
			z = 34.91
		},
	},
	
	position  = vector3(-440.57,-322.28, 34.91),jobs = { ['ambulance'] = true, ['offambulance'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
---MEchanik--- Bramy

	[40] = { objects = { 
		[1] = {
			object = 'prop_com_ls_door_01',
			x = -355.64900000,
			y = -134.87710000,
			z = 39.00735500
		} 
	},
	position = vector3(-355.64940000, -134.8710000, 39.00735500),jobs = { ['mecano'] = true,  ['offmecano'] = true,}, locked = false, distance = 15.0,size = 1.5, can = false, draw = true, gate = true},
	
	[41] = { objects = { 
		[1] = {
			object = 'prop_com_ls_door_01',
			x = -350.27900000,
			y = -116.65710000,
			z = 39.00735500
		} 
	},
	position = vector3(-350.27940000, -116.6510000, 39.00735500),jobs = { ['mecano'] = true,  ['offmecano'] = true,}, locked = false, distance = 15.0,size = 1.5, can = false, draw = true, gate = true},

---Zaplecze Mechanik----
	[42] = { objects = {
		[1] = {
			object = 'v_ilev_rc_door2',
			x = -316.19,
			y = -135.42,
			z = 39.00
		},
	},
	
	position  = vector3(-316.19,-135.42, 39.00),jobs = { ['mecano'] = true,  ['offmecano'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[43] = { objects = {
		[1] = {
			object = 'v_ilev_rc_door2',
			x = -312.50,
			y = -124.39,
			z = 39.00
		},
	},
	
	position  = vector3(-312.50,-124.39, 39.00),jobs = { ['mecano'] = true,  ['offmecano'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[44] = { objects = {
		[1] = {
			object = 'apa_V_ILev_SS_Door8',
			x = -312.18,
			y = -115.87,
			z = 39.00
		},
	},
	
	position  = vector3(-312.18,-115.87, 39.00),jobs = { ['mecano'] = true,  ['offmecano'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[45] = { objects = {
		[1] = {
			object = 'apa_V_ILev_SS_Door7',
			x = -320.68,
			y = -138.20,
			z = 39.00
		},
	},
	
	position  = vector3(-320.68,-138.20, 39.00),jobs = { ['mecano'] = true,  ['offmecano'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[46] = { objects = {
		[1] = {
			object = 'apa_V_ILev_SS_Door8',
			x = -347.83,
			y = -133.54,
			z = 39.00
		},
	},
	
	position  = vector3(-347.83,-133.54, 39.00),jobs = { ['mecano'] = true,  ['offmecano'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[47] = { objects = {
		[1] = {
			object = 'apa_V_ILev_SS_Door7',
			x = -345.73 ,
			y = -122.64,
			z = 39.00
		},
	},
	
	position  = vector3(-345.73,-122.64, 39.00),jobs = { ['mecano'] = true,  ['offmecano'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[48] = { objects = {
		[1] = {
			object = 'apa_V_ILev_SS_Door8',
			x = -354.19 ,
			y = -128.37,
			z = 39.00
		},
	},
	
	position  = vector3(-354.19,-128.37, 39.00),jobs = { ['mecano'] = true,  ['offmecano'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[49] = { objects = {
		[1] = {
			object = -1360054856,
			x = 361.5, 
			y = -1585.13,
			z = 29.29
		},
		
		[2] = {
			object = 471928866,
			x = 361.5, 
			y = -1585.13,
			z = 29.29
		},
		
	},
	position  = vector3(361.5, -1585.13, 29.29),jobs = {['police'] = true},locked = false, distance = 1.5,size = 0.6, can = false, draw = true},

	[50] = { objects = {
		[1] = {
			object = -1360054856,
			x = 354.13, 
			y = -1593.94,
			z = 29.29
		},
		
		[2] = {
			object = 471928866,
			x = 354.13, 
			y = -1593.94,
			z = 29.29
		},
		
	},
	position  = vector3(354.13, -1593.94, 29.29),jobs = {['police'] = true},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[51] = { objects = {
		[1] = {
			object = -667323357,
			x = 371.48,
			y = -1586.13,
			z = 29.29
		},
	},
	
	position  = vector3(371.48,-1586.13, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[52] = { objects = {
		[1] = {
			object = -667323357,
			x = 370.52,
			y = -1587.15,
			z = 29.29
		},
	},
	
	position  = vector3(370.52,-1587.15, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[53] = { objects = {
		[1] = {
			object = -667323357,
			x = 377.4,
			y = -1593.93,
			z = 29.29
		},
	},
	
	position  = vector3(377.4,-1593.93, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[54] = { objects = {
		[1] = {
			object = -667323357,
			x = 376.76,
			y = -1593.29,
			z = 29.29
		},
	},
	
	position  = vector3(376.76,-1593.29, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[55] = { objects = {
		[1] = {
			object = -667323357,
			x = 372.43,
			y = -1600.3,
			z = 29.29
		},
	},
	
	position  = vector3(372.43,-1600.3, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[56] = { objects = {
		[1] = {
			object = -667323357,
			x = 371.7,
			y = -1599.31,
			z = 29.29
		},
	},
	
	position  = vector3(371.7,-1599.31, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[57] = { objects = {
		[1] = {
			object = -667323357,
			x = 381.86,
			y = -1608.59,
			z = 29.29
		},
	},
	
	position  = vector3(381.86,-1608.59, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[58] = { objects = {
		[1] = {
			object = -667323357,
			x = 382.95,
			y = -1609.52,
			z = 29.29
		},
	},
	
	position  = vector3(382.95,-1609.52, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[59] = { objects = {
		[1] = {
			object = -1925177820,
			x = 384.13,
			y = -1604.96,
			z = 29.29
		},
	},
	
	position  = vector3(384.13,-1604.96, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[60] = { objects = {
		[1] = {
			object = -1925177820,
			x = 371.66,
			y = -1602.62,
			z = 29.29
		},
	},
	
	position  = vector3(371.66,-1602.62, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[61] = { objects = {
		[1] = {
			object = -1925177820,
			x = 365.03,
			y = -1602.08,
			z = 29.29
		},
	},
	
	position  = vector3(365.03,-1602.08, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	
	[62] = { objects = {
		[1] = {
			object = 1738519111,
			x = 369.09, 
			y = -1607.26,
			z = 29.29
		},
		
		[2] = {
			object = -1047370197,
			x = 369.09, 
			y = -1607.26,
			z = 29.29
		},
		
	},
	position  = vector3(369.09, -1607.26, 29.29),jobs = {['police'] = true},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[63] = { objects = {
		[1] = {
			object = -1925177820,
			x = 365.53,
			y = -1601.53,
			z = 29.29
		},
	},
	
	position  = vector3(365.53,-1601.53, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[64] = { objects = {
		[1] = {
			object = -1685865813,
			x = 355.9,
			y = -1596.32,
			z = 29.29
		},
	},
	
	position  = vector3(355.9,-1596.32, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[65] = { objects = {
		[1] = {
			object = -1842288246,
			x = 349.89,
			y = -1601.66,
			z = 29.29
		},
	},
	
	position  = vector3(349.89,-1601.66, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[66] = { objects = {
		[1] = {
			object = -1842288246,
			x = 352.73,
			y = -1604.09,
			z = 29.29
		},
	},
	
	position  = vector3(352.73,-1604.09, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[67] = { objects = {
		[1] = {
			object = -1842288246,
			x = 354.93,
			y = -1605.98,
			z = 29.29
		},
	},
	
	position  = vector3(354.93,-1605.98, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[68] = { objects = {
		[1] = {
			object = -1842288246,
			x = 357.2,
			y = -1607.79,
			z = 29.29
		},
	},
	
	position  = vector3(357.2,-1607.79, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[69] = { objects = {
		[1] = {
			object = -1842288246,
			x = 359.3,
			y = -1609.62,
			z = 29.29
		},
	},
	
	position  = vector3(359.3,-1609.62, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[70] = { objects = {
		[1] = {
			object = -1842288246,
			x = 361.64,
			y = -1611.64,
			z = 29.29
		},
	},
	
	position  = vector3(361.64,-1611.64, 29.29),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[71] = { objects = {
		[1] = {
			object = 2130535758,
			x = 383.4,
			y = -1603.82,
			z = 36.9
		},
	},
	
	position  = vector3(383.4,-1603.82, 36.9),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[72] = { objects = {
		[1] = {
			object = 2130535758,
			x = 383.4,
			y = -1603.82,
			z = 36.9
		},
	},
	
	position  = vector3(383.4,-1603.82, 36.9),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[73] = { objects = {
		[1] = {
			object = -584365942,
			x = 1536.64,
			y = 820.54,
			z = 77.66
		},
	},
	
	position  = vector3(1536.64, 820.54, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = false, distance = 1.5,size = 0.6, can = false, draw = true},

	[74] = { objects = {
		[1] = {
			object = -584365942,
			x = 1535.97,
			y = 819.41,
			z = 77.66
		},
	},
	
	position  = vector3(1535.97, 819.41, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = false, distance = 1.5,size = 0.6, can = false, draw = true},

	[75] = { objects = {
		[1] = {
			object = -344890090,
			x = 1548.47,
			y = 814.45,
			z = 77.66
		},
	},
	
	position  = vector3(1548.47, 814.45, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[76] = { objects = {
		[1] = {
			object = -344890090,
			x = 1551.84,
			y = 820.28,
			z = 77.66
		},
	},
	
	position  = vector3(1551.84, 820.28, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[77] = { objects = {
		[1] = {
			object = 1040797377,
			x = 1555.73,
			y = 838.56,
			z = 77.66
		},
	},
	
	position  = vector3(1555.73, 838.56, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[78] = { objects = {
		[1] = {
			object = -1671593055,
			x = 1553.1,
			y = 833.9,
			z = 77.66
		},
	},
	
	position  = vector3(1553.1, 833.9, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[79] = { objects = {
		[1] = {
			object = -1671593055,
			x = 1560.68,
			y = 832.96,
			z = 77.66
		},
	},
	
	position  = vector3(1560.34, 832.96, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[80] = { objects = {
		[1] = {
			object = -1671593055,
			x = 1559.46,
			y = 831.22,
			z = 77.66
		},
	},
	
	position  = vector3(1559.46, 831.22, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[81] = { objects = {
		[1] = {
			object = -1671593055,
			x = 1564.61,
			y = 830.72,
			z = 77.66
		},
	},
	
	position  = vector3(1564.61, 830.72, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},
	
	[82] = { objects = {
		[1] = {
			object = -1671593055,
			x = 1563.62,
			y = 828.81,
			z = 77.66
		},
	},
	
	position  = vector3(1563.62, 828.81, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[83] = { objects = {
		[1] = {
			object = 1040797377,
			x = 1539.24,
			y = 820.25,
			z = 77.66
		},
	},
	
	position  = vector3(1539.24, 820.25, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[84] = { objects = {
		[1] = {
			object = 1040797377,
			x = 1541.39,
			y = 812.93,
			z = 77.66
		},
	},
	
	position  = vector3(1541.39, 812.93, 77.66),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[85] = { objects = {
		[1] = {
			object = 199005365,
			x = 1855.28,
			y = 3683.14,
			z = 34.27
		},
	},
	
	position  = vector3(1855.28, 3683.14, 34.27),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[86] = { objects = {
		[1] = {
			object = 'gabz_mrpd_reception_entrancedoor',
			x = 0.23, 
			y = -982.55,
			z = 30.71
		},
		
		[2] = {
			object = 'gabz_mrpd_reception_entrancedoor',
			x = 0.23, 
			y = -981.48,
			z = 30.71
		},
		
	},
	position  = vector3(0.24, -981.92, 30.71),jobs = {['police'] = true},locked = false, distance = 1.5,size = 0.6, can = false, draw = true},

	[87] = { objects = {
		[1] = {
			object = 'gabz_mrpd_reception_entrancedoor',
			x = 0.45, 
			y = -0.26,
			z = 30.73
		},
		
		[2] = {
			object = 'gabz_mrpd_reception_entrancedoor',
			x = 0.51, 
			y = -0.26,
			z = 30.73
		},
		
	},
	position  = vector3(0.76, -999.09, 30.73),jobs = {['police'] = true},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[88] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_05',
			x = 0.16,
			y = -90.71,
			z = 30.69
		},
	},
	
	position  = vector3(0.16, -985.71, 30.69),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[89] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_05',
			x = 0.07,
			y = -978.13,
			z = 30.69
		},
	},
	
	position  = vector3(0.07, -978.13, 30.69),jobs = { ['police'] = true,  ['offpolice'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

	[90] = { objects = {
		[1] = {
			object = 'gabz_mrpd_reception_entrancedoor',
			x = 434.7444, 
			y = -980.7556, 
			z = 30.8153
		},
		[2] = {
			object = 'gabz_mrpd_reception_entrancedoor',
			x = 434.7444, 
			y = -983.0781, 
			z = 30.8153
		},
	},
	position = vector3(434.7548, -981.9033, 30.88926),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = true,},locked = false,distance = 1.45,size = 0.6, can = false, draw = true},


	[91] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_05',
			x = 440.5201, 
			y = -986.2335, 
			z = 30.82319
		},
	},
	position = vector3(441.7201, -986.2335, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},

	[92] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 440.5201, 
			y = -977.6011,
			z = 30.82319
		},
	},
	position = vector3(441.5201, -977.6011, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},	

	[93] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 445.4067, 
			y = -984.2014,
			z = 30.82319
		},
	},
	position = vector3(445.4067, -983.2014, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},		

	[94] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_01',
			x = 438.1971, 
			y = -993.9113,
			z = 30.82319
		},
		[2] = {
			object = 'gabz_mrpd_door_01',
			x = 438.1971, 
			y = -996.3167,
			z = 30.82319
		},
	},
	position = vector3(438.1971, -995.1113, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},
	
	[95] = { objects = {
		[1] = {
			object = 'gabz_mrpd_reception_entrancedoor',
			x = 440.7392,
			y = -998.7462,
			z = 30.8153
		},
		[2] = {
			object = 'gabz_mrpd_reception_entrancedoor',
			x = 443.0618,
			y = -998.7462,
			z = 30.8153
		},
	},
	position = vector3(441.9392, -998.7462, 30.8753),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},

	[96] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_05',
			x = 452.2663,
			y = -995.5254,
			z = 30.82319
		},
	},
	position = vector3(453.0863, -996.3454, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},	
	
	[97] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_02',
			x = 458.0894,
			y = -995.5247,
			z = 30.82319
		},
	},
	position = vector3(457.2894, -996.3247, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},

	[9] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_05',
			x = 458.6543,
			y = -990.6498,
			z = 30.82319
		},
	},
	position = vector3(458.6543, -989.5498, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},

	[98] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 458.6543,
			y = -976.8864,
			z = 30.82319
		},
	},
	position = vector3(458.6543, -977.9864, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},

	[99] = { objects = {
		[1] = {
			object = 'gabz_mrpd_reception_entrancedoor',
			x = 455.8862,
			y = -972.2543,
			z = 30.81531
		},
		[2] = {
			object = 'gabz_mrpd_reception_entrancedoor',
			x = 458.2087,
			y = -972.2543,
			z = 30.81531
		},
	},
	position = vector3(457.0562, -972.2543, 30.87531),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},

	[100] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_01',
			x = 469.4406,
			y = -985.0313,
			z = 30.82319
		},
		[2] = {
			object = 'gabz_mrpd_door_01',
			x = 469.4406,
			y = -987.4377,
			z = 30.82319
		},
	},

	position = vector3(469.4406, -986.2477, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},

	[101] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_02',
			x = 472.9781,
			y = -984.3722,
			z = 30.82319
		},
		[2] = {
			object = 'gabz_mrpd_door_02',
			x = 475.3837,
			y = -984.3722,
			z = 30.82319
		},
	},
	position = vector3(474.1781, -984.3722, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,},locked = true,distance = 1.45,size = 0.6, can = false, draw = true},	
	
	[102] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 475.3837,
			y = -989.8247,
			z = 30.82319
		},
		[2] = {
			object = 'gabz_mrpd_door_05',
			x = 472.9777,
			y = -989.8247,
			z = 30.82319
		},
	},
	position = vector3(474.1877, -989.8247, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[103] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 476.7512,
			y = -999.6307,
			z = 30.82319
		},
	},
	position = vector3(476.7512, -998.5307, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},	
	
	[104] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_03',
			x = 479.7507,
			y = -999.629,
			z = 30.78917
		},
	},
	position = vector3(479.7507, -998.5307, 30.86917),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},	

	[105] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_03',
			x = 487.4378,
			y = -1000.189,
			z = 30.78697
		},
	},
	position = vector3(486.2378, -1000.189, 30.86697),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},	
	
	[106] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_03',
			x = 488.0184,
			y = -1002.902,
			z = 30.78697
		},
		[2] = {
			object = 'gabz_mrpd_door_03',
			x = 485.6133,
			y = -1002.902,
			z = 30.78697
		},
	},
	position = vector3(486.8133, -1002.902, 30.86697),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[107] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 479.7534,
			y = -986.2151,
			z = 30.82319
		},
		[2] = {
			object = 'gabz_mrpd_door_05',
			x = 479.7534,
			y = -988.6204,
			z = 30.82319
		},
	},
	position = vector3(479.7534, -987.4151, 30.88319),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[108] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_01',
			x = 469.9274,
			y = -1000.544,
			z = 26.40548
		},
		[2] = {
			object = 'gabz_mrpd_door_01',
			x = 467.5222,
			y = -1000.544,
			z = 26.40548
		},
	},
	position = vector3(468.7274, -1000.544, 26.48548),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},
	
	[109] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_02',
			x = 471.3679,
			y = -1007.7930,
			z = 26.40548
		},
		[2] = {
			object = 'gabz_mrpd_door_02',
			x = 471.3758,
			y = -1010.198,
			z = 26.40548
		},
	},
	position = vector3(471.3679, -1008.9930, 26.48548),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[110] = { objects = {
		[1] = {
			object = 'gabz_mrpd_cells_door',
			x = 476.6157,
			y = -1008.875,
			z = 26.48005
		},
	},
	position = vector3(476.6157, -1007.6750, 26.56005),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[111] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_01',
			x = 475.9539, 
			y = -1006.938,
			z = 26.40639
		},
	},
	position = vector3(474.7539, -1006.938, 26.48639),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[112] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 475.9539,
			y = -1010.819,
			z = 26.40639
		},
	},
	position = vector3(474.7539, -1010.819, 26.48639),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[113] = { objects = {
		[1] = {
			object = 'gabz_mrpd_cells_door',
			x = 477.9126, 
			y = -1012.189,
			z = 26.48005
		},
	},
	position = vector3(476.7126, -1012.189, 26.56005),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[114] = { objects = {
		[1] = {
			object = 'gabz_mrpd_cells_door',
			x = 480.9128, 
			y = -1012.189,
			z = 26.48005
		},
	},
	position = vector3(479.7128, -1012.189, 26.56005),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},
	
	[115] = { objects = {
		[1] = {
			object = 'gabz_mrpd_cells_door',
			x = 483.9127, 
			y = -1012.189,
			z = 26.48005
		},
	},
	position = vector3(482.7127, -1012.189, 26.56005),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},
	
	[116] = { objects = {
		[1] = {
			object = 'gabz_mrpd_cells_door',
			x = 486.9131, 
			y = -1012.189,
			z = 26.48005
		},
	},
	position = vector3(485.7137, -1012.189, 26.56005),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},
	
	[117] = { objects = {
		[1] = {
			object = 'gabz_mrpd_cells_door',
			x = 484.1764, 
			y = -1007.734,
			z = 26.48005
		},
	},
	position = vector3(485.3764, -1007.734, 26.56005),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},
	
	[118] = { objects = {
		[1] = {
			object = 'gabz_mrpd_cells_door',
			x = 481.0084,
			y = -1004.118,
			z = 26.48005
		},
	},
	position = vector3(482.2084, -1004.118, 26.56005),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},
	
	[119] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_01',
			x = 479.0600, 
			y = -1003.173,
			z = 26.4065
		},
	},
	position = vector3(479.0600, -1001.973, 26.48650),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[120] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_02',
			x = 479.6638,
			y = -997.91,
			z = 26.4065,
		},
		[2] = {
			object = 'gabz_mrpd_door_02',
			x = 482.0686,
			y = -997.91,
			z = 26.4065,
		}
	},
	position = vector3(480.8638, -997.91, 26.4865),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},
	
	[121] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 482.6703,
			y = -995.7285,
			z = 26.40548
		},
	},
	position = vector3(482.6703, -996.9285, 26.48548),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},
	
	[122] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 482.6699,
			y = -992.2991,
			z = 26.40548 
		},
	},
	position = vector3(482.6703, -993.4991, 26.48548),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[123] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 482.6701, 
			y = -987.5792,
			z = 26.40548
		},
	},
	position = vector3(482.6701, -988.7792, 26.48548),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[124] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_04',
			x = 482.6701, 
			y = -983.9868,
			z = 26.40548
		},
	},
	position = vector3(482.6701, -985.1868, 26.48548),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[125] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_02',
			x = 479.0624, 
			y = -985.0323,
			z = 26.40548
		},
		[2] = {
			object = 'gabz_mrpd_door_02',
			x = 479.0624, 
			y = -987.4376,
			z = 26.40548
		},
	},
	position = vector3(479.0624, -986.2376, 26.48548),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},
	
	[126] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_03',
			x = 475.8323,
			y = -990.4839,
			z = 26.40548
		},
	},
	position = vector3(475.0323, -989.6839, 26.48548),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},	

	[127] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_02',
			x = 478.2892,
			y = -997.9101,
			z = 26.40548
		},
	},
	position = vector3(477.0892, -997.9101, 26.48548),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[128] = { objects = {
		[1] = {
			object = 'gabz_mrpd_door_05',
			x = 471.3753,
			y = -987.4374,
			z = 26.40548
		},
		[2] = {
			object = 'gabz_mrpd_door_04',
			x = 471.3753,
			y = -985.0319,
			z = 26.40548 
		},
	},
	position = vector3(471.3753, -986.2319, 26.48548),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[129] = { objects = {
		[1] = {
			object = 'gabz_mrpd_room13_parkingdoor',
			x = 464.1566,
			y = -997.5093,
			z = 26.3707
		},
	},
	position = vector3(464.1566, -996.3093, 26.4507),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[130] = { objects = {
		[1] = {
			object = 'gabz_mrpd_room13_parkingdoor',
			x = 464.1591,
			y = -974.6656,
			z = 26.3707 
		},
	},
	position = vector3(464.1591, -975.8656, 26.4507),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

	[131] = { objects = { 
		[1] = {
			object = 'gabz_mrpd_garage_door',
			x = 452.3005,
			y = -1000.772,
			z = 26.69661
		} 
	},
	position = vector3(452.3005, -1000.772, 26.69661),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = true,}, locked = true, distance = 4.00,size = 1.5, can = false, draw = true, gate = true},


[132] = { objects = { 
	[1] = {
		object = 'gabz_mrpd_bollards2',
		x = 410.0258,
		y = -1032.423,
		z = 29.25253
	},
	[2] = {
		object = 'gabz_mrpd_bollards1',
		x = 410.0258,
		y = -1024.226,
		z = 29.22022
	} 
},
position = vector3(411.48, -1024.27, 29.46),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = true,}, locked = true, distance = 8.00,size = 1.5, can = false, draw = true, gate = true},

[133] = { objects = { 
	[1] = {
		object = 'gabz_mrpd_garage_door',
		x = 452.3005,
		y = -1000.772,
		z = 26.69661
	} 
},
position = vector3(452.3005, -1000.772, 26.69661),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = true,}, locked = true, distance = 4.00,size = 1.5, can = false, draw = true, gate = true},

[134] = { objects = { 
	[1] = {
		object = 'gabz_mrpd_garage_door',
		x = 431.4119,
		y = -1000.772,
		z = 26.69661
	} 
},
position = vector3(431.4119, -1000.772, 26.69661),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = true,}, locked = true, distance = 4.00,size = 1.5, can = false, draw = true, gate = true},

[135] = { objects = { 
	[1] = {
		object = 'gabz_mrpd_bollards1',
		x = 466.6598,
		y = -1028.592,
		z = 28.11831
	} 
},
position = vector3(466.48, -1024.53, 28.27),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = true,}, locked = true, distance = 4.00,size = 1.5, can = false, draw = true, gate = true},

[136] = { objects = {
	[1] = {
		object = 'gabz_mrpd_door_03',
		x = 469.7743,
		y = -1014.406,
		z = 26.48382
	},
	[2] = {
		object = 'gabz_mrpd_door_03',
		x = 467.3686,
		y = -1014.406,
		z = 26.48382
	}
},
position = vector3(468.5743, -1014.406, 26.56382),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[137] = { objects = {
	[1] = {
		object = 'gabz_mrpd_door_05',
		x = 459.9454,
		y = -990.7053,
		z = 35.10398
	},
},
position = vector3(458.7454, -990.7053, 35.18398),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[138] = { objects = {
	[1] = {
		object = 'gabz_mrpd_door_04',
		x = 459.9454,
		y = -981.0742,
		z = 35.10398
	},
},
position = vector3(458.7454, -981.0742, 35.18398),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[139] = { objects = {
	[1] = {
		object = 'gabz_mrpd_door_04',
		x = 448.9868,
		y = -990.2007,
		z = 35.18376
	},
},
position = vector3(449.7868, -989.4007, 35.18376),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[140] = { objects = {
	[1] = {
		object = 'gabz_mrpd_door_05',
		x = 448.9868,
		y = -981.5785,
		z = 35.10376
	},
},
position = vector3(449.7868, -982.3785, 35.18376),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[141] = { objects = {
	[1] = {
		object = 'gabz_mrpd_door_05',
		x = 448.9846,
		y = -995.5264,
		z = 35.10376
	},
},
position = vector3(449.7846, -996.3264, 35.18376),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[142] = { objects = {
	[1] = {
		object = 'gabz_mrpd_door_03',
		x = 464.3086,
		y = -984.5284,
		z = 43.77124
	},
},
position = vector3(464.3086, -983.3284, 43.85124),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[143] = { objects = { 
	[1] = {
		object = 'hei_prop_station_gate',
		x = 488.8948,
		y = -1017.212,
		z = 27.14935
	} 
},
position = vector3(488.47, -1019.89, 28.89),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = true,}, locked = true, distance = 4.00,size = 1.5, can = false, draw = true, gate = true},

[144] = { objects = { 
	[1] = {
		object = 'prop_strip_door_01',
		x = 128.7,
		y = -1298.56,
		z = 29.26
	} 
},
position = vector3(129.20, -1298.10, 29.26),jobs = { ['vanilla'] = true,}, locked = false, distance = 4.00,size = 1.5, can = false, draw = true},

[145] = { objects = { 
	[1] = {
		object = 634417522,
		x = 127.54,
		y = -1278.7,
		z = 29.26
	} 
},
position = vector3(127.99, -1279.13, 29.26),jobs = { ['vanilla'] = true,}, locked = true, distance = 4.00,size = 1.5, can = false, draw = true},

[146] = { objects = { 
	[1] = {
		object = 634417522,
		x = 103.07,
		y = -1301.83,
		z = 29.25
	} 
},
position = vector3(103.07, -1301.83, 29.25),jobs = { ['vanilla'] = true,}, locked = true, distance = 4.00,size = 1.5, can = false, draw = true},

[147] = { objects = { 
	[1] = {
		object = -1515131612,
		x = -51.61,
		y = 6395.46,
		z = 31.49
	} 
},
position = vector3(-51.61, 6395.46, 31.49),jobs = { ['ssa'] = true,}, locked = true, distance = 4.00,size = 1.5, can = false, draw = true, gate = true},

[148] = { objects = { 
	[1] = {
		object = 'prop_com_gar_door_01',
		x = 88.38,
		y = -1288.33,
		z = 29.33
	} 
},
position = vector3(88.38, -1288.33, 29.33),jobs = { ['vanilla'] = true,}, locked = true, distance = 4.00,size = 1.5, can = false, draw = true, gate = true},

[149] = { objects = { 
	[1] = {
		object = 'prop_lrggate_01_r',
		x = -1161.69,
		y = 312.88,
		z = 68.44
	},
	[2] = {
		object = 'prop_lrggate_01_l',
		x = -1160.49,
		y = 310.49,
		z = 68.45
	} 
},
position = vector3(-1160.55, 312.29, 68.49),jobs = { ['org'] = true,}, locked = true, distance = 8.00,size = 1.5, can = false, draw = true, gate = true},

[150] = { objects = { 
	[1] = {
		object = -1006857058,
		x = 160.86,
		y = 2285.52,
		z = 94.12
	},
	[2] = {
		object = -1006857058,
		x = 161.87,
		y = 2288.08,
		z = 94.14
	} 
},
position = vector3(161.06, 2286.7, 94.13),jobs = { ['amigos'] = true,}, locked = true, distance = 8.00,size = 1.5, can = false, draw = true, gate = true},


[151] = { objects = { 
	[1] = {
		object = 'v_ilev_bl_shutter2',
		x = 829.43,
		y = 2190.97,
		z = 52.30
	}
},
position = vector3(829.43, 2190.97, 52.30),jobs = { ['pocahontas'] = true,}, locked = true, distance = 8.00,size = 1.5, can = false, draw = true, gate = true},

[152] = { objects = { 
	[1] = {
		object = 1033441082,
		x = -1536.94,
		y = 130.59,
		z = 57.37
	}
},
position = vector3(-1536.94, 130.59, 57.37),jobs = { ['rdf'] = true,}, locked = true, distance = 8.00,size = 1.5, can = false, draw = true},

[153] = { objects = { 
	[1] = {
		object = 'v_ilev_mm_door',
		x = -1500.96,
		y = 103.4,
		z = 55.67
	}
},
position = vector3(-1500.96, 103.4, 55.67),jobs = { ['rdf'] = true,}, locked = true, distance = 8.00,size = 1.5, can = false, draw = true},

[154] = { objects = { 
	[1] = {
		object = 'v_ilev_mm_door',
		x = -1522.35,
		y = 143.59,
		z = 55.65
	}
},
position = vector3(-1522.35, 143.59, 55.65),jobs = { ['rdf'] = true,}, locked = true, distance = 8.00,size = 1.5, can = false, draw = true},

[155] = { objects = {
	[1] = {
		object = 'ball_fridge_mafia_l',
		x = -1864.1,  
		y = 2060.7,
		z = 141.1
	},
	[2] = {
		object = 'ball_fridge_mafia_r',
		x = -1864.1,  
		y = 2060.7,
		z = 141.1
	},
},
			
position = vector3(-1864.1, 2060.55, 141.1),jobs = { ['rdf'] = true, ['cbd'] = true,}, locked = true, distance = 1.50,size = 0.6, can = false, draw = true},

[156] = { objects = {
	[1] = {
		object = 1077118233,
		x = -1888.44, 
		y = 2051.73,
		z = 140.03
	},
	
	[2] = {
		object = 1077118233,
		x = -1889.54, 
		y = 2052.00,
		z = 140.05
	},
	
},
position  = vector3(-1889.02, 2051.83, 141.05),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[157] = { objects = {
	[1] = {
		object = 1077118233,
		x = -1885.72, 
		y = 2050.64,
		z = 140.03
	},
	
	[2] = {
		object = 1077118233,
		x = -1886.87, 
		y = 2050.98,
		z = 140.05
	},
	
},
position  = vector3(-1886.30, 2050.90, 141.05),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[158] = { objects = {
	[1] = {
		object = 1077118233,
		x = -1860.9155, 
		y = 2053.9917,
		z = 140.06
	},
	
	[2] = {
		object = 1077118233,
		x = -1859.97, 
		y = 2054.13,
		z = 140.06
	},
	
},
position  = vector3(-1860.43, 2054.08, 141.05),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[159] = { objects = {
	[1] = {
		object = 1077118233,
		x = -1873.86, 
		y = 2069.29,
		z = 140.04
	},
	
	[2] = {
		object = 1077118233,
		x = -1875.02, 
		y = 2069.90,
		z = 140.05
	},
	
},
position  = vector3(-1874.47, 2069.62, 141.04),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[160] = { objects = {
	[1] = {
		object = 1077118233,
		x = -1885.57, 
		y = 2073.60,
		z = 140.04
	},
	
	[2] = {
		object = 1077118233,
		x = -1886.73, 
		y = 2074.04,
		z = 140.04
	},
	
},
position  = vector3(-1886.13, 2073.83, 141.04),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[161] = { objects = {
	[1] = {
		object = 1077118233,
		x = -1893.31, 
		y = 2074.70,
		z = 140.05
	},
	
	[2] = {
		object = 1077118233,
		x = -1894.27, 
		y = 2075.59,
		z = 140.06
	},
	
},
position  = vector3(-1893.90, 2075.03, 141.05),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[162] = { objects = {
	[1] = {
		object = 1843224684,
		x = -1899.03, 
		y = 2083.23,
		z = 139.45
	},
	
	[2] = {
		object = 1843224684,
		x = -1899.95, 
		y = 2084.14,
		z = 139.45
	},
	
},
position  = vector3(-1899.51, 2083.66, 140.45),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[163] = { objects = {
	[1] = {
		object = 1843224684,
		x = -1901.41, 
		y = 2085.34,
		z = 139.45
	},
	
	[2] = {
		object = 1843224684,
		x = -1902.51, 
		y = 2086.01,
		z = 139.45
	},
	
},
position  = vector3(-1901.94, 2085.74, 140.45),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[164] = { objects = {
	[1] = {
		object = 1843224684,
		x = -1906.33, 
		y = 2085.07,
		z = 139.45
	},
	
	[2] = {
		object = 1843224684,
		x = -1907.07, 
		y = 2084.07,
		z = 139.45
	},
	
},
position  = vector3(-1906.72, 2084.64, 140.45),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[165] = { objects = {
	[1] = {
		object = 1843224684,
		x = -1910.56, 
		y = 2080.04,
		z = 139.45
	},
	
	[2] = {
		object = 1843224684,
		x = -1911.33, 
		y = 2079.22,
		z = 139.45
	},
	
},
position  = vector3(-1910.99, 2079.76, 140.45),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},


[166] = { objects = {
	[1] = {
		object = 1843224684,
		x = -1911.56, 
		y = 2075.16,
		z = 139.45
	},
	
	[2] = {
		object = 1843224684,
		x = -1910.54, 
		y = 2074.24,
		z = 139.44
	},
	
},
position  = vector3(-1911.07, 2074.74, 140.45),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[167] = { objects = {
	[1] = {
		object = 1843224684,
		x = -1909.04, 
		y = 2073.24,
		z = 139.45
	},
	
	[2] = {
		object = 1843224684,
		x = -1908.11, 
		y = 2072.33,
		z = 139.45
	},
	
},
position  = vector3(-1908.60, 2072.75, 140.45),jobs = { ['rdf'] = true, ['cbd'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[168] = { objects = { 
	[1] = {
		object = 'prop_lrggate_02_ld',
		x = -1615.89000000,
		y = 79.91300000,
		z = 61.28017000
	} 
},
position = vector3(-1613.53300000, 78.91300000, 61.28017000),jobs = { ['rdf'] = true, ['cbd'] = true,}, locked = true, distance = 15.0,size = 1.5, can = false, draw = true, gate = true},

[169] = { objects = { 
	[1] = {
		object = 'prop_lrggate_02_ld',
		x = -1473.62000000,
		y = 68.31300000,
		z = 53.28017000
	} 
},
position = vector3(-1471.53300000, 67.78300000, 53.28017000),jobs = { ['rdf'] = true, ['cbd'] = true,}, locked = true, distance = 15.0,size = 1.5, can = false, draw = true, gate = true},

[170] = { objects = {
	[1] = {
		object = 'V_ILev_RA_Door1_R',
		x = 1400.21100000,
		y = 1128.51510000,
		z = 114.71796000
	},
	[2] = {
		object = 'V_ILev_RA_Door1_L',
		x = 1401.07600000,
		y = 1128.31950000,
		z = 114.71796000
	},
},

position  = vector3(1400.57600000, 1128.31950000, 114.71796000),jobs = {['mafia'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[171] = { objects = {
	[1] = {
		object = 'V_ILev_RA_Door1_R',
		x = 1390.21100000,
		y = 1131.71510000,
		z = 114.71796000
	},
	[2] = {
		object = 'V_ILev_RA_Door1_L',
		x = 1390.07600000,
		y = 1132.31950000,
		z = 114.71796000
	},
},

position  = vector3(1390.57600000, 1132.31950000, 114.71796000),jobs = {['mafia'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[172] = { objects = {
	[1] = {
		object = 'v_ilev_ra_door4l',
		x = 1395.86100000,
		y = 1142.35510000,
		z = 114.71796000
	},
	[2] = {
		object = 'v_ilev_ra_door4r',
		x = 1395.98600000,
		y = 1141.410000,
		z = 114.71796000
	},
},

position  = vector3(1395.86600000, 1141.93950000, 114.71796000),jobs = {['mafia'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[173] = { objects = {
	[1] = {
		object = 'V_ILev_RA_Door1_R',
		x = 1390.54100000,
		y = 1161.83510000,
		z = 114.71796000
	},
	[2] = {
		object = 'V_ILev_RA_Door1_L',
		x = 1390.98600000,
		y = 1162.410000,
		z = 114.71796000
	},
},

position  = vector3(1390.54100000, 1162.38510000, 114.71796000),jobs = {['mafia'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[174] = { objects = {
	[1] = {
		object = 'V_ILev_RA_Door1_R',
		x = 1408.54100000,
		y = 1159.83510000,
		z = 114.71796000
	},
	[2] = {
		object = 'V_ILev_RA_Door1_L',
		x = 1408.98600000,
		y = 1160.410000,
		z = 114.71796000
	},
},

position  = vector3(1408.54100000, 1160.28510000, 114.71796000),jobs = {['mafia'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[175] = { objects = {
	[1] = {
		object = 'V_ILev_RA_Door1_R',
		x = 1408.54100000,
		y = 1164.83510000,
		z = 114.71796000
	},
	[2] = {
		object = 'V_ILev_RA_Door1_L',
		x = 1408.98600000,
		y = 1165.410000,
		z = 114.71796000
	},
},

position  = vector3(1408.54100000, 1164.78510000, 114.71796000),jobs = {['mafia'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true},

[176] = { objects = {
	[1] = {
		object = 'prop_lrggate_01_r',
		x = -1064.46,
		y = 314.96,
		z = 65.87
	},
	[2] = {
		object = 'prop_lrggate_01_l',
		x = -1064.19,
		y = 317.42,
		z = 65.95
	},
},

position  = vector3(-1064.7, 316.2, 65.9),jobs = {['org6'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true, gate = true},

[177] = { objects = {
	[1] = {
		object = 'prop_lrggate_01_r',
		x = -1038.08,
		y = 328.73,
		z = 68.03
	},
	[2] = {
		object = 'prop_lrggate_01_l',
		x = -1035.14,
		y = 328.58,
		z = 68.06
	},
},

position  = vector3(-1036.55, 328.75, 68.03),jobs = {['org6'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true, gate = true},

[178] = { objects = {
	[1] = {
		object = 'prop_lrggate_01_l',
		x = -954.25,
		y = 301.71,
		z = 70.75
	},
	[2] = {
		object = 'prop_lrggate_01_r',
		x = -952.5,
		y = 299.61,
		z = 70.77
	},
},

position  = vector3(-953.55, 300.58, 70.73),jobs = {['org6'] = true,},locked = true, distance = 1.5,size = 0.6, can = false, draw = true, gate = true},

[179] = { objects = { 
	[1] = {
		object = 893692758,
		x = -1037.47,
		y = 312.18,
		z = 67.27
	},
	[2] = {
		object = 893692758,
		x = -1038.8,
		y = 310.64,
		z = 67.27
	},
},
position = vector3(-1038.31, 311.93, 67.27),jobs = { ['org6'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[180] = { objects = { 
	[1] = {
		object = 395669496,
		x = -1052.35,
		y = 304.82,
		z = 67.01
	},
	[2] = {
		object = 395669496,
		x = -1052.36,
		y = 304.27,
		z = 67.01
	},
},
position = vector3(-1052.36, 304.27, 67.01),jobs = { ['org6'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[181] = { objects = { 
	[1] = {
		object = 1123731138,
		x = -1042.17,
		y = 297.43, 
		z = 66.91
	},
	[2] = {
		object = 1123731138,
		x = -1041.52,
		y = 297.61,
		z = 66.91
	},
},
position = vector3(-1041.52, 297.61, 66.91),jobs = { ['org6'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[182] = { objects = { 
	[1] = {
		object = 395669496,
		x = -1026.65,
		y = 313.0,
		z = 67.01
	},
	[2] = {
		object = 395669496,
		x = -1026.94,
		y = 313.83,
		z = 67.01
	},
},
position = vector3(-1026.94, 313.83, 67.01),jobs = { ['org6'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[183] = { objects = { 
	[1] = {
		object = 1123731138,
		x = -1025.95,
		y = 303.85,
		z = 66.99
	},
	[2] = {
		object = 1123731138,
		x = -1026.83,
		y = 303.55,
		z = 66.99
	},
},
position = vector3(-1026.83, 303.55, 66.99),jobs = { ['org6'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[184] = { objects = { 
	[1] = {
		object = 'prop_lrggate_02_ld',
		x = -844.0,
		y = 158.9,
		z = 66.8
	}
},
position = vector3(-843.62, 159.03, 66.84),jobs = { ['ko'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true, gate = true},

[185] = { objects = { 
	[1] = {
		object = 'prop_ld_garaged_01',
		x = -815.4,
		y = 185.87,
		z = 72.48
	}
},
position = vector3(-815.4, 185.87, 72.48),jobs = { ['ko'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[186] = { objects = { 
	[1] = {
		object = 'v_ilev_mm_doorm_l',
		x = -817.03,
		y = 178.55,
		z = 72.23
	},
	[2] = {
		object = 'v_ilev_mm_doorm_r',
		x = -816.65,
		y = 177.84,
		z = 72.23
	},
},
position = vector3(-816.65, 177.84, 72.23),jobs = { ['ko'] = true,}, locked = true, distance =1.5,size = 1.5, can = false, draw = true},

[187] = { objects = { 
	[1] = {
		object = 'prop_bh1_48_backdoor_l',
		x = -795.83,
		y = 177.06,
		z = 72.84
	},
	[2] = {
		object = 'prop_bh1_48_backdoor_r',
		x = -794.88,
		y = 177.4,
		z = 72.84
	},
},
position = vector3(-794.88, 177.4, 72.84),jobs = { ['ko'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[188] = { objects = { 
	[1] = {
		object = 'prop_bh1_48_backdoor_l',
		x = -793.19,
		y = 181.22,
		z = 72.84
	},
	[2] = {
		object = 'prop_bh1_48_backdoor_r',
		x = -793.66,
		y = 182.34,
		z = 72.84
	},
},
position = vector3(-793.66, 182.34, 72.84),jobs = { ['ko'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[189] = { objects = { 
	[1] = {
		object = 'prop_lrggate_01c_r',
		x = -1801.22,
		y = 473.88,
		z = 133.68
	},
	[2] = {
		object = 'prop_lrggate_01c_l',
		x = -1800.02,
		y = 471.422,
		z = 133.68
	},
},
position = vector3(-1800.6, 472.8, 133.68),jobs = { ['org7'] = true,}, locked = true, distance = 9.5,size = 1.5, can = false, draw = true, gate = true},

[190] = { objects = { 
	[1] = {
		object = 'prop_lrggate_03b_ld',
		x = -1798.23,
		y = 469.69,
		z = 133.7
	},
},
position = vector3(-1798.23, 469.69, 133.7),jobs = { ['org7'] = true,}, locked = true, distance = 5.5,size = 1.5, can = false, draw = true},

[191] = { objects = { 
	[1] = {
		object = -1688423265,
		x = -1786.84,
		y = 463.41,
		z = 128.31,
	},
},
position = vector3(-1786.84, 463.41, 128.31),jobs = { ['org7'] = true,}, locked = true, distance = 5.5,size = 1.5, can = false, draw = true, gate = true},


[192] = { objects = { 
	[1] = {
		object = 2074032093,
		x = -1804.63,
		y = 436.78,
		z = 128.83
	},
	[2] = {
		object = 2074032093,
		x = -1805.32,
		y = 436.71,
		z = 128.83
	},
},
position = vector3(-1804.88, 436.67, 128.83),jobs = { ['org7'] = true,}, locked = true, distance = 5.5,size = 1.5, can = false, draw = true},

[193] = { objects = { 
	[1] = {
		object = 149328230,
		x = -1792.27,
		y = 411.83,
		z = 113.45
	},
	[2] = {
		object = 149328230,
		x = -1788.99,
		y = 434.31,
		z = 128.3
	},
},
position = vector3(-1792.27, 411.83, 113.45),jobs = { ['org7'] = true,}, locked = true, distance = 9.5,size = 1.5, can = false, draw = true, gate = true},

[194] = { objects = { 
	[1] = {
		object = 451680698,
		x = -1816.62,
		y = 423.22,
		z = 128.31
	},
	[2] = {
		object = 451680698,
		x = -1815.05,
		y = 423.18,
		z = 128.31
	},
},
position = vector3(-1815.84, 423.24, 128.31),jobs = { ['org7'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[195] = { objects = { 
	[1] = {
		object = 1826999110,
		x = -1805.1,
		y = 428.51,
		z = 128.73
	},
	[2] = {
		object = 1826999110,
		x = -1804.36,
		y = 428.51,
		z = 128.73
	},
},
position = vector3(-1804.7, 428.54, 128.73),jobs = { ['org7'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[196] = { objects = { 
	[1] = {
		object = 'prop_lrggate_01c_l',
		x = -136.71,
		y = 972.78,
		z = 235.85
	},
	[2] = {
		object = 'prop_lrggate_01c_r',
		x = -134.03,
		y = 971.61,
		z = 235.84
	},
},
position = vector3(-135.41, 972.50, 235.88),jobs = { ['kdb'] = true,}, locked = true, distance = 5.5,size = 1.5, can = false, draw = true, gate = true},

[197] = { objects = { 
	[1] = {
		object = 'apa_p_mp_yacht_door_01',
		x = -112.76,
		y = 985.93,
		z = 235.75
	},
},
position = vector3(-112.76, 986.44, 235.90),jobs = { ['kdb'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[198] = { objects = { 
	[1] = {
		object = 'apa_p_mp_yacht_door_01',
		x = -61.98,
		y = 998.88,
		z = 234.41
	},
},
position = vector3(-62.50, 999.06, 234.53),jobs = { ['kdb'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[199] = { objects = { 
	[1] = {
		object = 854291622,
		x = 307.68,
		y = -570.28,
		z = 43.28
	},
},
position = vector3(307.68, -570.28, 43.28),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[200] = { objects = { 
	[1] = {
		object = -434783486,
		x = 312.59,
		y = -572.02,
		z = 43.28
	},
	[2] = {
		object = -1700911976,
		x = 313.66,
		y = -572.46,
		z = 43.28
	},
},
position = vector3(313.08, -572.2, 43.28),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[201] = { objects = { 
	[1] = {
		object = -434783486,
		x = 318.35,
		y = -574.2,
		z = 43.28
	},
	[2] = {
		object = -1700911976,
		x = 319.49,
		y = -574.61,
		z = 43.28
	},
},
position = vector3(318.86, -574.49, 43.28),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[202] = { objects = { 
	[1] = {
		object = -434783486,
		x = 323.79,
		y = -576.26,
		z = 43.28
	},
	[2] = {
		object = -1700911976,
		x = 324.96,
		y = -576.56,
		z = 43.28
	},
},
position = vector3(324.24, -576.34, 43.28),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[203] = { objects = { 
	[1] = {
		object = 854291622,
		x = 339.66,
		y = -586.42,
		z = 43.28
	},
},
position = vector3(339.66, -586.42, 43.28),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[204] = { objects = { 
	[1] = {
		object = 854291622,
		x = 337.62,
		y = -592.26,
		z = 43.28
	},
},
position = vector3(337.62, -592.26, 43.28),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[205] = { objects = { 
	[1] = {
		object = 854291622,
		x = 313.78,
		y = -596.29,
		z = 43.28
	},
},
position = vector3(313.78, -596.29, 43.28),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[206] = { objects = { 
	[1] = {
		object = 854291622,
		x = 308.66,
		y = -597.07,
		z = 43.28
	},
},
position = vector3(308.66, -597.07, 43.28),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[207] = { objects = { 
	[1] = {
		object = 854291622,
		x = 347.82,
		y = -585.77,
		z = 28.8
	},
},
position = vector3(347.82, -585.77, 28.8),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[208] = { objects = { 
	[1] = {
		object = -434783486,
		x = 339.1,
		y = -589.56,
		z = 28.8
	},
	[2] = {
		object = -1700911976,
		x = 339.31,
		y = -589.05,
		z = 28.8
	},
},
position = vector3(339.21, -589.12, 28.8),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[209] = { objects = { 
	[1] = {
		object = -820650556,
		x = 330.15,
		y = -561.83,
		z = 28.8
	},
},
position = vector3(330.15, -561.83, 28.8),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 6.5,size = 1.5, can = false, draw = true, gate = true},

[210] = { objects = { 
	[1] = {
		object = -820650556,
		x = 337.29,
		y = -564.49,
		z = 28.8
	},
},
position = vector3(337.29, -564.49, 28.8),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 6.5,size = 1.5, can = false, draw = true, gate = true},

[211] = { objects = { 
	[1] = {
		object = 'v_ilev_ct_doorl',
		x = 319.46,
		y = -561.08,
		z = 28.8
	},
	[2] = {
		object = 'v_ilev_ct_doorr',
		x = 320.78,
		y = -560.66,
		z = 28.8
	},
},
position = vector3(320.16, -560.82, 28.8),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[212] = { objects = { 
	[1] = {
		object = 'v_ilev_ph_gendoor002',
		x = -1828.78,
		y = -3671.27,
		z = 34.27
	},
},
position = vector3(01828.78, 03671.27, 34.27),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[213] = { objects = { 
	[1] = {
		object = 'v_ilev_ph_gendoor002',
		x = -1842.85,
		y = -3683.4,
		z = 34.27
	},
},
position = vector3(-1842.85, -3683.4, 34.27),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[214] = { objects = { 
	[1] = {
		object = 'v_ilev_ph_gendoor002',
		x = -1838.66,
		y = -3687.15,
		z = 34.27
	},
},
position = vector3(-1838.66, -3687.15, 34.27),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[215] = { objects = { 
	[1] = {
		object = 'v_ilev_ph_gendoor002',
		x = -1836.42,
		y = -3691.73,
		z = 34.27
	},
},
position = vector3(-1836.42, -3691.73, 34.27),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[216] = { objects = { 
	[1] = {
		object = 854291622,
		x = -808.41,
		y = -1213.64,
		z = 7.34
	},
},
position = vector3(-808.41, -1213.64, 7.34),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[217] = { objects = { 
	[1] = {
		object = 854291622,
		x = -783.8,
		y = -1239.82,
		z = 7.34
	},
},
position = vector3(-783.8, -1239.82, 7.34),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[218] = { objects = { 
	[1] = {
		object = 854291622,
		x = -787.59,
		y = -1244.54,
		z = 7.34
	},
},
position = vector3(-787.59, -1244.54, 7.34),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[219] = { objects = { 
	[1] = {
		object = 854291622,
		x = -811.54,
		y = -1240.08,
		z = 7.34
	},
},
position = vector3(-811.54, -1240.08, 7.34),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[220] = { objects = { 
	[1] = {
		object = 854291622,
		x = -816.56,
		y = -1239.21,
		z = 7.34
	},
},
position = vector3(-816.56, -1239.21, 7.34),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[221] = { objects = { 
	[1] = {
		object = -434783486,
		x = -804.33,
		y = -1217.01,
		z = 7.34
	},
	[2] = {
		object = -1700911976,
		x = -803.37,
		y = -1217.82,
		z = 7.34
	},
},
position = vector3(803.94, -1217.32, 7.34),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[222] = { objects = { 
	[1] = {
		object = -434783486,
		x = -799.6,
		y = -1221.02,
		z = 7.34
	},
	[2] = {
		object = -1700911976,
		x = -798.67,
		y = -1221.83,
		z = 7.34
	},
},
position = vector3(-799.25, -1221.26, 7.34),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[223] = { objects = { 
	[1] = {
		object = -434783486,
		x = -795.27,
		y = -1224.54,
		z = 7.34
	},
	[2] = {
		object = -1700911976,
		x = -794.36,
		y = -1225.41,
		z = 7.34
	},
},
position = vector3(-794.89, -1224.96, 7.34),jobs = { ['ambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[224] = { objects = { 
	[1] = {
		object = 'v_ilev_cd_door2',
		x = 1131.92,
		y = -1537.81,
		z = 34.87
	},
},
position = vector3(1131.92, -1537.81, 34.87),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[225] = { objects = { 
	[1] = {
		object = 'v_ilev_cd_door2',
		x = 1141.02,
		y = -1544.96,
		z = 35.38
	},
},
position = vector3(1141.02, -1544.96, 35.38),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[226] = { objects = { 
	[1] = {
		object = 'v_ilev_cd_door2',
		x = 1145.56,
		y = -1549.15,
		z = 35.38
	},
},
position = vector3(1145.56, -1549.15, 35.38),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[227] = { objects = { 
	[1] = {
		object = 'v_ilev_cd_door',
		x = 1145.5,
		y = -1562.54,
		z = 35.38
	},
	[2] = {
		object = 'v_ilev_cd_door',
		x = 1144.3,
		y = -1562.54,
		z = 35.38
	},
},
position = vector3(1144.96, -1562.61, 35.38),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[228] = { objects = { 
	[1] = {
		object = 'v_ilev_fib_door3',
		x = 1130.15,
		y = -1575.68,
		z = 35.38
	},
},
position = vector3(1130.15, -1575.68, 35.38),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[229] = { objects = { 
	[1] = {
		object = 'v_ilev_fib_door3',
		x = 1130.15,
		y = -1578.2,
		z = 35.38
	},
},
position = vector3(1130.15, -1578.2, 35.38),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[230] = { objects = { 
	[1] = {
		object = 'v_ilev_cor_doorglassa',
		x = 1131.05,
		y = -1559.35,
		z = 35.38
	},
	[2] = {
		object = 'v_ilev_cor_doorglassa',
		x = 1132.2,
		y = -1559.41,
		z = 35.38
	},
},
position = vector3(1131.5, -1559.31, 35.38),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[231] = { objects = { 
	[1] = {
		object = 'v_ilev_cor_doorglassa',
		x = 1132.2,
		y = -1562.58,
		z = 35.38
	},
	[2] = {
		object = 'v_ilev_cor_doorglassa',
		x = 1131.07,
		y = -1562.63,
		z = 35.38
	},
},
position = vector3(1131.63, -1562.6, 35.38),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[232] = { objects = { 
	[1] = {
		object = 'v_ilev_cor_doorglassa',
		x = 1121.2,
		y = -1559.24,
		z = 35.38
	},
	[2] = {
		object = 'v_ilev_cor_doorglassa',
		x = 1122.36,
		y = -1559.34,
		z = 35.38
	},
},
position = vector3(1121.71, -1559.33, 35.38),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[233] = { objects = { 
	[1] = {
		object = 'v_ilev_cor_doorglassa',
		x = -251.55,
		y = 6319.74,
		z = 32.43
	},
	[2] = {
		object = 'v_ilev_cor_doorglassa',
		x = -252.52,
		y = 6318.9,
		z = 32.43
	},
},
position = vector3(-252.04, 6319.39, 32.43),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[234] = { objects = { 
	[1] = {
		object = 'v_ilev_cor_firedoor',
		x = -257.31,
		y = 6313.99,
		z = 32.43
	},
},
position = vector3(-257.31, 6313.99, 32.43),jobs = { ['ambulance'] = true, ['offambulance'] = true,}, locked = true, distance = 1.5,size = 1.5, can = false, draw = true},

[235] = { objects = {
	[1] = {
		object = 'int_vinewood_police_maindoor',
		x = 637.1759,
		y = 0.7189798,
		z = 83.00891
	},
	[2] = {
		object = 'int_vinewood_police_maindoor',
		x = 638.143,
		y = 3.354939,
		z = 83.00891
	},
},
position = vector3(637.65, 2.05, 82.79),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = false, distance = 1.45,size = 0.6, can = false, draw = true},

[236] = { objects = {
	[1] = {
		object = 'int_vinewood_police_door_l',
		x = 621.1563,
		y = 16.03793,
		z = 88.646
	},
	[2] = {
		object = 'int_vinewood_police_door_l',
		x = 618.1277,
		y = 17.18625,
		z = 88.646
	},
},
position = vector3(619.66, 16.40, 87.82),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[237] = { objects = {
	[1] = {
		object = 'v_ilev_roc_door2',
		x = 619.5421,
		y =  3.72195,
		z =  82.92089
	},
},
position = vector3(619.51, 4.48, 82.78),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[238] = { objects = {
	[1] = {
		object = 'v_ilev_ph_cellgate',
		x = 614.6944,
		y = -2.389629,
		z = 82.93158
	},
},
position = vector3(613.98, -2.19, 82.78),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[239] = { objects = {
	[1] = {
		object = 'v_ilev_ph_cellgate',
		x = 611.9668,
		y = -11.26786,
		z = 82.92802
	},
},
position = vector3(612.65, -11.35, 82.78),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[240] = { objects = {
	[1] = {
		object = 'v_ilev_ph_cellgate',
		x = 608.1331,
		y = -9.864241,
		z = 82.92802
	},
},
position = vector3(608.80, -9.95, 82.78),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[241] = { objects = {
	[1] = {
		object = 'v_ilev_ph_cellgate',
		x = 604.2855,
		y = -8.464458,
		z = 82.92802
	},
},
position = vector3(604.90, -8.73, 82.78),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[242] = { objects = {
	[1] = {
		object = 'v_ilev_ph_cellgate',
		x = 600.4366,
		y = -7.060292,
		z = 82.92802
	},
},
position = vector3(601.05, -7.25, 82.78),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[243] = { objects = {
	[1] = {
		object = 'v_ilev_rc_door2',
		x = -1633.85,
		y = -1028.68,
		z = 13.15
	},
},
position = vector3(-1633.85, -1028.68, 13.15),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[244] = { objects = {
	[1] = {
		object = 'v_ilev_rc_door2',
		x = -1629.12,
		y = -1023.56,
		z = 13.15
	},
},
position = vector3(-1629.12, -1023.56, 13.15),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[245] = { objects = {
	[1] = {
		object = 'v_ilev_rc_door2',
		x = -1623.59,
		y = -1029.05,
		z = 13.15
	},
},
position = vector3(-1623.59, -1029.05, 13.15),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[246] = { objects = {
	[1] = {
		object = 'v_ilev_rc_door2',
		x = -1625.93,
		y = -1031.9,
		z = 13.15
	},
},
position = vector3(-1625.93, -1031.9, 13.15),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[247] = { objects = {
	[1] = {
		object = 'v_ilev_rc_door2',
		x = -1622.51,
		y = -1019.28,
		z = 13.15
	},
},
position = vector3(-1622.51, -1019.28, 13.15),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[248] = { objects = {
	[1] = {
		object = 'v_ilev_rc_door2',
		x = -1614.15,
		y = -1027.48,
		z = 13.15
	},
},
position = vector3(-1614.15, -1027.48, 13.15),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[249] = { objects = {
	[1] = {
		object = 'v_ilev_fingate',
		x = -1623.59,
		y = -1022.7,
		z = 13.15
	},
},
position = vector3(-1623.59, -1022.7, 13.15),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[250] = { objects = {
	[1] = {
		object = 'v_ilev_fingate',
		x = -1615.44,
		y = -1021.48,
		z = 13.15
	},
},
position = vector3(-1615.44, -1021.48, 13.15),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[251] = { objects = {
	[1] = {
		object = 'v_ilev_fingate',
		x = -1616.99,
		y = -1023.07,
		z = 13.15
	},
},
position = vector3(-1616.99, -1023.07, 13.15),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[252] = { objects = {
	[1] = {
		object = 'v_ilev_fingate',
		x = -1610.84,
		y = -1023.63,
		z = 13.15
	},
},
position = vector3(-1610.84, -1023.63, 13.15),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[253] = { objects = {
	[1] = {
		object = 'v_ilev_ph_gendoor002',
		x = -557.36,
		y = -123.79,
		z = 37.88
	},
	[2] = {
		object = 'v_ilev_ph_gendoor002',
		x = -557.7,
		y = -122.74,
		z = 37.88
	},
},
position = vector3(-557.55, -123.31, 37.88),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[254] = { objects = {
	[1] = {
		object = 'v_ilev_ph_gendoor003',
		x = -542.58,
		y = -108.0,
		z = 33.86
	},
	[2] = {
		object = 'v_ilev_ph_gendoor003',
		x = -543.65,
		y = -108.48,
		z = 33.86
	},
},
position = vector3(-542.95, -108.19, 33.86),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[255] = { objects = {
	[1] = {
		object = 'v_ilev_gc_door01',
		x = -547.23,
		y = -101.61,
		z = 33.86
	},
	[2] = {
		object = 'v_ilev_gc_door01',
		x = -547.63,
		y = -100.54,
		z = 33.86
	},
},
position = vector3(-547.38, -101.04, 33.86),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[256] = { objects = {
	[1] = {
		object = 'v_ilev_ph_gendoor002',
		x = -547.69,
		y = -121.46,
		z = 33.86
	},
},
position = vector3(-547.69, -121.46, 33.86),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[257] = { objects = {
	[1] = {
		object = 'v_ilev_ph_gendoor002',
		x = -550.22,
		y = -115.37,
		z = 33.86
	},
},
position = vector3(-550.22, -115.37, 33.86),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[258] = { objects = {
	[1] = {
		object = 'v_ilev_gc_door01',
		x = -572.07,
		y = -114.17,
		z = 33.86
	},
},
position = vector3(-572.07, -114.17, 33.86),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[259] = { objects = {
	[1] = {
		object = 'v_ilev_gc_door01',
		x = -575.16,
		y = -112.92,
		z = 33.86
	},
},
position = vector3(-575.16, -112.92, 33.86),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[260] = { objects = {
	[1] = {
		object = 'v_ilev_gc_door01',
		x = -577.39,
		y = -122.53,
		z = 33.75
	},
	[2] = {
		object = 'v_ilev_gc_door01',
		x = -577.89,
		y = -121.21,
		z = 33.75
	},
},
position = vector3(-577.72, -121.85, 33.75),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[261] = { objects = {
	[1] = {
		object = 'v_ilev_ph_cellgate',
		x = -562.94,
		y = -119.93,
		z = 33.87
	},
},
position = vector3(-562.94, -119.93, 33.87),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[262] = { objects = {
	[1] = {
		object = 'v_ilev_ph_cellgate',
		x = -564.58,
		y = -120.5,
		z = 33.87
	},
},
position = vector3(-564.58, -120.5, 33.87),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[263] = { objects = {
	[1] = {
		object = 'v_ilev_ph_cellgate',
		x = -570.41,
		y = -123.06,
		z = 33.87
	},
},
position = vector3(-570.41, -123.06, 33.87),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[264] = { objects = {
	[1] = {
		object = 'v_ilev_ph_cellgate',
		x = -571.93,
		y = -123.61,
		z = 33.87
	},
},
position = vector3(-571.93, -123.61, 33.87),jobs = { ['sheriff'] = true, ['offsheriff'] = true, ['police'] = true, ['offpolice'] = true, ['offpolice'] = false,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[265] = { objects = {
	[1] = {
		object = -2076929163,
		x = 936.0,
		y = -1489.81,
		z = 30.3
	},
},
position = vector3(936.0, -1489.81, 30.3),jobs = { ['muertos'] = true,}, locked = true, distance = 5.45,size = 0.6, can = false, draw = true, gate = true},

[266] = { objects = {
	[1] = {
		object = -2076929163,
		x = 943.59,
		y = -1489.91,
		z = 30.3
	},
},
position = vector3(943.59, -1489.91, 30.3),jobs = { ['muertos'] = true,}, locked = true, distance = 5.45,size = 0.6, can = false, draw = true, gate = true},

[267] = { objects = {
	[1] = {
		object = 1052098579,
		x = 939.67,
		y = -1489.94,
		z = 30.16
	},
},
position = vector3(939.67, -1489.94, 30.16),jobs = { ['muertos'] = true,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[268] = { objects = {
	[1] = {
		object = 1252997920,
		x = -1842.24,
		y = 4544.03,
		z = 6.31
	},
	[2] = {
		object = 1252997920,
		x = -1844.89,
		y = 4543.07,
		z = 6.31
	},
},
position = vector3(-1843.39, 4543.46, 6.31),jobs = { ['dca'] = true,}, locked = true, distance = 5.45,size = 0.6, can = false, draw = true, gate = true},

[269] = { objects = {
	[1] = {
		object = 396555103,
		x = -1570.33,
		y = 22.1,
		z = 59.55
	},
	[2] = {
		object = -780638473,
		x = -1571.25,
		y = 22.34,
		z = 59.55
	},
},
position = vector3(-1570.33, 22.1, 59.55),jobs = { ['alzheimer'] = true,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[270] = { objects = {
	[1] = {
		object = 396555103,
		x = -1578.49,
		y = 14.89,
		z = 61.2
	},
	[2] = {
		object = -780638473,
		x = -1579.35,
		y = 14.99,
		z = 61.2
	},
},
position = vector3(-1578.49, 14.89, 61.2),jobs = { ['alzheimer'] = true,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[271] = { objects = {
	[1] = {
		object = 396555103,
		x = -1587.26,
		y = 16.78,
		z = 61.21
	},
	[2] = {
		object = -780638473,
		x = -1587.89,
		y = 16.92,
		z = 61.21
	},
},
position = vector3(-1587.26, 16.78, 61.21),jobs = { ['alzheimer'] = true,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[272] = { objects = {
	[1] = {
		object = -467265479,
		x = -1558.55,
		y = 17.56,
		z = 58.65
	},
},
position = vector3(-1558.55, 17.56, 58.65),jobs = { ['alzheimer'] = true,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true, gate = true},

[273] = { objects = {
	[1] = {
		object = -1438552720,
		x = -1828.29,
		y = 418.05,
		z = 121.32
	},
	[2] = {
		object = -1438552720,
		x = -1816.64,
		y = 428.08,
		z = 132.32
	},
},
position = vector3(-1828.29, 418.05, 121.32),jobs = { ['org7'] = true,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[274] = { objects = {
	[1] = {
		object = -782244720,
		x = -1785.65,
		y = 419.92,
		z = 116.83
	},
	[2] = {
		object = -782244720,
		x = -1816.64,
		y = 428.08,
		z = 132.32
	},
},
position = vector3(-1785.65, 419.92, 116.83),jobs = { ['org7'] = true,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[275] = { objects = {
	[1] = {
		object = -801817937,
		x = -1787.77,
		y = 411.25,
		z = 113.45
	},
	[2] = {
		object = -801817937,
		x = -1816.64,
		y = 428.08,
		z = 132.32
	},
},
position = vector3(-1787.77, 411.25, 113.45),jobs = { ['org7'] = true,}, locked = true, distance = 1.45,size = 0.6, can = false, draw = true},

[276] = { objects = { 
	[1] = {
		object = -1688423265,
		x = -1785.63,
		y = 456.24,
		z = 128.31,
	},
},
position = vector3(-1785.63, 456.24, 128.31),jobs = { ['org7'] = true,}, locked = true, distance = 5.5,size = 1.5, can = false, draw = true, gate = true},

[277] = { objects = {
	[1] = {
		object = 'prop_lrggate_01_l',
		x = -826.4,
		y = -30.53,
		z = 38.65
	},
	[2] = {
		object = 'prop_lrggate_01_r',
		x = -825.53,
		y = -32.66,
		z = 38.63
	},
},
position = vector3(-825.97, -31.28, 38.65),jobs = { ['drab'] = true,}, locked = true, distance = 6.45,size = 0.6, can = false, draw = true, gate = true},

[278] = { objects = { 
	[1] = {
		object = 1073566574,
		x = -842.71,
		y = -25.16,
		z = 40.31,
	},
},
position = vector3(-842.71, -25.16, 40.31),jobs = { ['drab'] = true,}, locked = true, distance = 5.5,size = 1.5, can = false, draw = true},

[279] = { objects = { 
	[1] = {
		object = -116678456,
		x = -854.64,
		y = -26.9,
		z = 40.31,
	},
},
position = vector3(-854.64, -26.9, 40.31),jobs = { ['drab'] = true,}, locked = true, distance = 5.5,size = 1.5, can = false, draw = true},

[280] = { objects = {
	[1] = {
		object = -1925605774,
		x = -855.22,
		y = -34.97,
		z = 44.15
	},
	[2] = {
		object = -1452880180,
		x = -855.86,
		y = -34.11,
		z = 44.15
	},
},
position = vector3(-855.52, -34.14, 44.15),jobs = { ['drab'] = true,}, locked = true, distance = 3.45,size = 0.6, can = false, draw = true,},



[281] = { objects = {
	[1] = {
		object = 736699661,
		x = -629.8,
		y = 228.99,
		z = 82.05
	},
},
position = vector3(0, 0, 0),jobs = { ['cafe'] = false,}, locked = false, distance = 3.45,size = 0.6, can = false, draw = true,},



-- [282] = { objects = {
-- 	[1] = {
-- 		object = -1516927114,
-- 		x = -1123.09,
-- 		y = 486.76,
-- 		z = 82.53
-- 	},
-- },
-- position = vector3(-1122.42, 486.76, 82.36),jobs = { ['org21'] = true,}, locked = true, distance = 2.5,size = 0.6, can = false, draw = true,},



-- [283] = { objects = {
-- 	[1] = {
-- 		object = 1647181300,
-- 		x = -1112.27,
-- 		y = 503.0,
-- 		z = 82.51
-- 	},
-- 	[2] = {
-- 		object = 1647181300,
-- 		x = -1114.82,
-- 		y = 503.48,
-- 		z = 82.51
-- 	},
-- },
-- position = vector3(-1113.61, 503.24, 82.36),jobs = { ['org21'] = true,}, locked = true, distance = 2.5,size = 0.6, can = false, draw = true,},






-- [284] = { objects = {
-- 	[1] = {
-- 		object = 1647181300,
-- 		x = -1116.68,
-- 		y = 503.83,
-- 		z = 82.51
-- 	},
-- 	[2] = {
-- 		object = 1647181300,
-- 		x = -1119.24,
-- 		y = 504.31,
-- 		z = 82.51
-- 	},
-- },
-- position = vector3(-1117.93, 504.15, 82.36),jobs = { ['org21'] = true,}, locked = true, distance = 2.5,size = 0.6, can = false, draw = true,},



[285] = { objects = {
	[1] = {
		object = -1563799200,
		x = 1385.26,
		y = -2079.96,
		z = 52.69
	},
},
position = vector3(1384.75, -2080.38, 52.65),jobs = { ['org17'] = true,}, locked = true, distance = 2.5,size = 0.6, can = false, draw = true,},


[286] = { objects = {
	[1] = {
		object = -1259801187,
		x = 1384.29,
		y = -2087.87,
		z = 52.75
	},
	[2] = {
		object = -1563799200,
		x = 1382.63,
		y = -2085.86,
		z = 52.75
	},
},
position = vector3(1383.54, -2086.8, 52.66),jobs = { ['org17'] = true,}, locked = true, distance = 2.5,size = 0.6, can = false, draw = true,},


[287] = { objects = {
	[1] = {
		object = -1563799200,
		x = 1377.59,
		y = -2094.22,
		z = 48.7
	},
	[2] = {
		object = -1259801187,
		x = 1379.25,
		y = -2096.22,
		z = 48.7
	},
},
position = vector3(1378.45, -2095.16, 48.62),jobs = { ['org17'] = true,}, locked = true, distance = 2.5,size = 0.6, can = false, draw = true,},



[288] = { objects = {
	[1] = {
		object = -528397888,
		x = -1101.13,
		y = 439.82,
		z = 75.8
	},
},
position = vector3(-1101.23, 440.31, 75.5),jobs = { ['org23'] = true,}, locked = true, distance = 4,size = 0.6, can = false, draw = true,gate=true,},






[289] = { objects = {
	[1] = {
		object = 85780744,
		x = -1112.34,
		y = 440.98,
		z = 75.63
	},
},
position = vector3(-1112.48, 440.2, 75.48),jobs = { ['org23'] = true,}, locked = true, distance = 2.5,size = 0.6, can = false, draw = true,},





[290] = { objects = {
	[1] = {
		object = -1800832569,
		x = -1104.65,
		y = 429.33,
		z = 75.9
	},
},
position = vector3(-1104.47, 430.04, 75.89),jobs = { ['org23'] = true,}, locked = true, distance = 2.5,size = 0.6, can = false, draw = true,},

[291] = { objects = {
	[1] = {
		object = -1800832569,
		x = -1095.18,
		y = 428.08,
		z = 75.9
	},
},
position = vector3(-1095.21, 427.49, 75.89),jobs = { ['org23'] = true,}, locked = true, distance = 2.5,size = 0.6, can = false, draw = true,},



[292] = { objects = {
	[1] = {
		object = 1585071339,
		x = -1102.57,
		y = 417.62,
		z = 76.07
	},
	[2] = {
		object = 1585071339,
		x = -1100.95,
		y = 417.45,
		z = 76.07
	},
},
position = vector3(-1101.8, 417.49, 75.78),jobs = { ['org23'] = true,}, locked = true, distance = 1,size = 0.6, can = false, draw = true,},



[293] = { objects = {
	[1] = {
		object = 1585071339,
		x = -1100.44,
		y = 417.4,
		z = 76.07
	},
	[2] = {
		object = 1585071339,
		x = -1098.82,
		y = 417.23,
		z = 76.07
	},
},
position = vector3(-1099.46, 417.46, 75.79),jobs = { ['org23'] = true,}, locked = true, distance = 1,size = 0.6, can = false, draw = true,},


}
	cb(doors)
end)

function IsAuthorized(jobName, doorID)
	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == jobName then
			return true
		end
	end
	return false
end