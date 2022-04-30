Config = {}
Config.Locale = 'pl'
Config.MaxDistance = 20

Config.typeNapad = {
	['shop'] = {
		drill = false,
		secondsRemaining = 300,
		cops = 2,
		Animation = {
			scenario = false,
			tick = "grab",
			dict = "anim@heists@ornate_bank@grab_cash_heels"
		}
	},
	['sejf'] = {
		drill = true,
		secondsRemaining = 450,
		cops = 4,
		Animation = {
			scenario = true,
			scenariotick = "WORLD_HUMAN_CONST_DRILL"
		}
	},
	['bank'] = {
		drill = true,
		secondsRemaining = 600,
		cops = 6,
		Animation = {
			scenario = true,
			scenariotick = "WORLD_HUMAN_CONST_DRILL"
		}
	},
	['yacht'] = {
		drill = true,
		secondsRemaining = 600,
		cops = 8,
		Animation = {
			scenario = true,
			scenariotick = "WORLD_HUMAN_CONST_DRILL"
		}
	},
	['statua'] = {
		drill = true,
		secondsRemaining = 900,
		cops = 16,
		Animation = {
			scenario = true,
			scenariotick = "WORLD_HUMAN_CONST_DRILL"
		}
	},
	['magazyn'] = {
		drill2 = true,
		secondsRemaining = 900,
		cops = 16,
		Animation = {
			scenario = true,
			scenariotick = "WORLD_HUMAN_CONST_DRILL"
		}
	},
}

Stores = {
	["paleto_twentyfourseven"] = {
		position = { x = 1736.32, y = 6419.47, z = 35.03 },
		reward = math.random(156000, 234000),
		name = "24/7. (Paleto Bay)",
		blip = {
			id = 628,
			scale = 0.6,
			color = 49,
			label = 'Napad na Sklep',
		},	
		type = 'shop',
		delay = {
			success = 500,
			failure = 60,
		},
	},
	["sandyshores_twentyfoursever"] = {
		position = { x = 1961.24, y = 3749.46, z = 32.34 },
		reward = math.random(156000, 234000),
		name = "24/7. (Sandy Shores)",
		blip = {
			id = 628,
			scale = 0.6,
			color = 49,
			label = 'Napad na Sklep',
		},	
		type = 'shop',
		delay = {
			success = 500,
			failure = 60,
		},
	},
	["littleseoul_twentyfourseven"] = {
		position = { x = -709.17, y = -904.21, z = 19.21 },
		reward = math.random(156000, 234000),
		name = "24/7. (Little Seoul)",
		blip = {
			id = 628,
			scale = 0.6,
			color = 49,
			label = 'Napad na Sklep',
		},	
		type = 'shop',
		delay = {
			success = 500,
			failure = 60,
		},
	},
	["bar_one"] = {
		position = { x = 1990.57, y = 3044.95, z = 47.21 },
		reward = math.random(156000, 234000),
		name = "Yellow Jack. (Sandy Shores)",
		blip = {
			id = 628,
			scale = 0.6,
			color = 49,
			label = 'Napad na Sklep',
		},	
		type = 'shop',
		delay = {
			success = 500,
			failure = 60,
		},
	},
	["ocean_liquor"] = {
		position = { x = -2959.33, y = 388.21, z = 14.00 },
		reward = math.random(156000, 234000),
		name = "Robs Liquor. (Great Ocean Highway)",
		blip = {
			id = 628,
			scale = 0.6,
			color = 49,
			label = 'Napad na Sklep',
		},	
		type = 'shop',
		delay = {
			success = 500,
			failure = 60,
		},
	},
	["rancho_liquor"] = {
		position = { x = 1126.80, y = -980.40, z = 45.41 },
		reward = math.random(156000, 234000),
		name = "Robs Liquor. (El Rancho Blvd)",
		blip = {
			id = 628,
			scale = 0.6,
			color = 49,
			label = 'Napad na Sklep',
		},	
		type = 'shop',
		delay = {
			success = 500,
			failure = 60,
		},
	},
	["sanandreas_liquor"] = {
		position = { x = -1219.85, y = -916.27, z = 11.32 },
		reward = math.random(156000, 234000),
		name = "Robs Liquor. (San Andreas Avenue)",
		blip = {
			id = 628,
			scale = 0.6,
			color = 49,
			label = 'Napad na Sklep',
		},	
		type = 'shop',
		delay = {
			success = 500,
			failure = 60,
		},
	},
	["grove_ltd"] = {
		position = { x = -43.40, y = -1749.20, z = 29.42 },
		reward = math.random(156000, 234000),
		name = "LTD Gasoline. (Grove Street)",
		blip = {
			id = 628,
			scale = 0.6,
			color = 49,
			label = 'Napad na Sklep',
		},	
		type = 'shop',
		delay = {
			success = 500,
			failure = 60,
		},
	},
	["mirror_ltd"] = {
		position = { x = 1160.67, y = -314.40, z = 69.20 },
		reward = math.random(156000, 234000),
		name = "LTD Gasoline. (Mirror Park Boulevard)",
		blip = {
			id = 628,
			scale = 0.6,
			color = 49,
			label = 'Napad na Sklep',
		},	
		type = 'shop',
		delay = {
			success = 500,
			failure = 60,
		},
	},
	["wschodniaautostrada"] = {
		position = { x = 2550.07, y = 386.73, z = 108.62 },
		reward = math.random(156000, 234000),
		name = "LTD Gasoline. (Palomino Freeway)",
		blip = {
			id = 628,
			scale = 0.6,
			color = 49,
			label = 'Napad na Sklep',
		},	
		type = 'shop',
		delay = {
			success = 500,
			failure = 60,
		},
	},
	
	
	--BANKI -- 60kk-90kk
	
	
	["fleeca"] = {
		position = { x = 147.04908752441, y = -1044.9448242188, z = 29.46802482605 },
		reward = math.random(1170000, 2080000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 180
			}
		},
		name = "Fleeca Bank (Plaza)",
		blip = {
			id = 500,
			scale = 0.6,
			color = 49,
			label = 'Napad na Bank',
		},	
		type = 'bank',
		delay = {
			success = 1000,
			failure = 60,
		},
	},
	["fleeca2"] = {
		position = { x = -2957.6674804688, y = 481.45776367188, z = 15.797026252747 },
		reward = math.random(1170000, 2080000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 180
			}
		},
		name = "Fleeca Bank (Great Ocean Highway)",
		blip = {
			id = 500,
			scale = 0.6,
			color = 49,
			label = 'Napad na Bank',
		},	
		type = 'bank',
		delay = {
			success = 1000,
			failure = 60,
		},
	},
	["fleeca3"] = {
		position = { x = 1648.2958, y = 4851.5972, z = 42.0599 },
		reward = math.random(1170000, 2080000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 180
			}
		},
		name = "Fleeca Bank (Great Ocean Highway)",
		blip = {
			id = 500,
			scale = 0.6,
			color = 49,
			label = 'Napad na Bank',
		},	
		type = 'bank',
		delay = {
			success = 1000,
			failure = 60,
		},
	},
	["blainecounty"] = {
		position = { x = -107.06505584717, y = 6474.8012695313, z = 31.72670135498 },
		reward = math.random(1170000, 2080000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 180
			}
		},
		name = "Blaine County Savings Bank",
		blip = {
			id = 500,
			scale = 0.6,
			color = 49,
			label = 'Napad na Bank',
		},	
		type = 'bank',
		delay = {
			success = 1000,
			failure = 60,
		},
	},
	["Route68Bank"] = {
		position = { x = 1176.77, y = 2711.82, z = 38.19 },
		reward = math.random(1170000, 2080000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 180
			}
		},
		name = "Fleeca Bank (Route 68)",
		blip = {
			id = 500,
			scale = 0.6,
			color = 49,
			label = 'Napad na Bank',
		},		
		type = 'bank',
		delay = {
			success = 1000,
			failure = 60,
		},
	},
	["RockfordBank"] = {
		position = { x = -1211.88, y = -336.17, z = 37.89 },
		reward = math.random(1170000, 2080000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 180
			}
		},
		name = "Fleeca Bank (Rockford Hills)",
		blip = {
			id = 500,
			scale = 0.6,
			color = 49,
			label = 'Napad na Bank',
		},	
		type = 'bank',
		delay = {
			success = 1000,
			failure = 60,
		},
	},
	["EVinewoodBank"] = {
		position = { x = 310.85, y = -283.32, z = 54.27 },
		reward = math.random(1170000, 2080000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 180
			}
		},
		name = "Fleeca Bank (East Vinewood)",
		blip = {
			id = 500,
			scale = 0.6,
			color = 49,
			label = 'Napad na Bank',
		},	
		type = 'bank',
		delay = {
			success = 1000,
			failure = 60,
		},
	},
	["WVinewoodBank2"] = {
		position = { x = -354.32, y = -54.02, z = 49.14 },
		reward = math.random(1170000, 2080000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 180
			}
		},
		name = "Fleeca Bank (West Vinewood)",
		blip = {
			id = 500,
			scale = 0.6,
			color = 49,
			label = 'Napad na Bank',
		},	
		type = 'bank',
		delay = {
			success = 1000,
			failure = 60,
		},
	},
	
	
	--SEJFY 50-80kk


	["jubiler"] = {
		position = { x = -190.8374, y = -593.1551, z = 37.8033 },
		reward = math.random(910000, 1820000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 150
			}
		},
		name = "Jubiler (ARCADIUS)",
		blip = {
			id = 605,
			scale = 0.6,
			color = 49,
			label = 'Napad na Jubilera',
		},	
		type = 'sejf',
		delay = {
			success = 1000,
			failure = 60,
		},
	},

	["jubiler2"] = {
		position = { x = -620.14, y = -229.27, z = 38.05 },
		reward = math.random(910000, 1820000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 150
			}
		},
		name = "Jubiler (Centrum Miasta)",
		blip = {
			id = 605,
			scale = 0.6,
			color = 49,
			label = 'Napad na Jubilera',
		},	
		type = 'sejf',
		delay = {
			success = 1000,
			failure = 60,
		},
	},

	["yacht1"] = {
		position = { x = -2345.42, y = -655.24, z = 13.41 },
		reward = math.random(2500000, 3600000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'nurek_2',
				label = "strój do nurkowania",
				count = 4
			},
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 200
			},
			{
				chance = 50,
				item = 'clip_extended',
				label = "powiększony magazynek",
				count = 2
			}
		},
		name = "Yacht",
		blip = {
			id = 755,
			scale = 0.8,
			color = 49,
			label = 'Napad na Yacht',
		},	
		type = 'yacht',
		delay = {
			success = 2000,
			failure = 60,
		},
	},
	
	["yacht"] = {
		position = { x = -2084.4868, y = -1014.0796, z = 5.9341 },
		reward = math.random(2500000, 3600000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'nurek_1',
				label = "strój do nurkowania",
				count = 4
			},
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 200
			},
			{
				chance = 50,
				item = 'kamzasmall',
				label = "mała kamizelka",
				count = 2
			}
		},
		name = "Yacht",
		blip = {
			id = 755,
			scale = 0.8,
			color = 49,
			label = 'Napad na Yacht',
		},	
		type = 'yacht',
		delay = {
			success = 2000,
			failure = 60,
		},
	},

	["statua"] = {
		position = { x = -2608.04, y = -1016.03, z = 20.63 },
		reward = math.random(3600000, 5000000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'kamzaduza',
				label = "duża kamizelka",
				count = 2
			},
			{
				chance = 100,
				item = 'nurek_3',
				label = "strój do nurkowania",
				count = 4
			},
			{
				chance = 100,
				item = 'suppressor',
				label = "tłumik",
				count = 2
			},
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 350
			},
			{
				chance = 50,
				item = 'clip_extended',
				label = "powiększony magazynek",
				count = 2
			}
		},
		name = "Statua",
		blip = {
			id = 409,
			scale = 0.8,
			color = 49,
			label = 'Napad na Statue',
		},	
		type = 'statua',
		delay = {
			success = 2000,
			failure = 60,
		},
	},

	["magazyn"] = {
		position = { x = 34.01, y = -2656.29, z = 12.04 },
		reward = math.random(2900000, 4100000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'kamzaduza',
				label = "duża kamizelka",
				count = 4
			},
			{
				chance = 100,
				item = 'scope',
				label = "celownik",
				count = 2
			},
			{
				chance = 100,
				item = 'suppressor',
				label = "tłumik",
				count = 2
			},
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 300
			},
			{
				chance = 50,
				item = 'clip_extended',
				label = "powiększony magazynek",
				count = 2
			}
		},
		name = "Magazyn",
		blip = {
			id = 549,
			scale = 1.0,
			color = 49,
			label = 'Napad na Magazyn',
		},	
		type = 'magazyn',
		delay = {
			success = 2000,
			failure = 60,
		},
	},
	
	--Human 1,4-2,1
	["HumaneLabs"] = {
		position = { x = 3537.7297, y = 3659.6885, z = 28.1719 },
		reward = math.random(2340000, 3640000),
		name = "Humane Labs",
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'kamzaduza',
				label = "duża kamizelka",
				count = 2
			},
			{
				chance = 50,
				item = 'drill2',
				label = "Wiertło II generacji",
				count = 1
			},
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 280
			},
			{
				chance = 50,
				item = 'suppressor',
				label = "tłumik",
				count = 2
			}
		},
		blip = {
			id = 499,
			scale = 0.8,
			color = 49,
			label = 'Napad na Humane Labs',
		},	
		type = 'yacht',
		delay = {
			success = 2000,
			failure = 60,
		},
	},

	["ZbrojowniaSASP"] = {
		position = { x = 569.08, y = -3124.75, z = 18.76 },
		reward = math.random(2340000, 3640000),
		name = "Zbrojownia",
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'kamzaduza',
				label = "kamza",
				count = 2
			},
			{
				chance = 45,
				item = 'clip_extended',
				label = "powiększany magazynek",
				count = 2
			},
			{
				chance = 50,
				item = 'drill2',
				label = "Wiertło II generacji",
				count = 1
			},
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 280
			},
			{
				chance = 45,
				item = 'scope',
				label = "celownik",
				count = 2
			}
		},
		blip = {
			id = 556,
			scale = 0.8,
			color = 49,
			label = 'Napad na Zbrojownie',
		},	
		type = 'yacht',
		delay = {
			success = 2000,
			failure = 60,
		},
	},
		
	--Maze
	["MazeBank"] = {
		position = { x = -1310.0148, y = -810.8741, z = 17.19 },
		reward = math.random(1300000, 2470000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 180
			}
		},
		name = "Maze Bank (Del Perro)",
		blip = {
			id = 500,
			scale = 0.6,
			color = 49,
			label = 'Napad na Bank',
		},
		type = 'bank',
		delay = {
			success = 1000,
			failure = 60,
		},
	},
	-- 50-75
	["Casino"] = {
		position = { x = 1000.7908, y = 66.3221, z = 59.87 },
		reward = math.random(910000, 1820000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 150
			}
		},
		name = "Casino",
		blip = {
			id = 674,
			scale = 0.8,
			color = 49,
			label = 'Napad na Casino Royale',
		},	
		type = 'sejf',
		delay = {
			success = 1000,
			failure = 60,
		},
	},
	
	--Pacyfik 800-1,115
	["Pacyfik"] = {
		position = { x = 254.238, y = 225.5682, z = 101.8257 },
		reward = math.random(1300000, 2470000),
		secondChance = 100,
		secondRewards = {
			{
				chance = 100,
				item = 'gwiazdki',
				label = "Gwiazdki",
				count = 180
			}
		},
		name = "Pacific Bank",
		blip = {
			id = 500,
			scale = 0.6,
			color = 49,
			label = 'Napad na Bank',
		},	
		type = 'bank',
		delay = {
			success = 1000,
			failure = 60,
		},
	},

}
