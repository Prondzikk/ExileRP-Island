Config                            = {}
Config.Locale                     = 'pl'

Config.DrawDistance               = 10.0

Config.Blips = {
	{
        coords = vector3(932.25, 41.13, 80.29),
        sprite = 439,
        color = 5,
        scale = 1.0,
        label  = "Casino Royale"
    },
	{
		coords = vector3(-803.82, -1356.79, 5.22),
        sprite = 410,
        color = 38,
        scale = 1.0,
        label  = "Extreme Sports - Biuro & Port"
	},
	{
		coords = vector3(2129.29, 4790.39, 41.0),
        sprite = 481,
        color = 38,
        scale = 1.0,
        label  = "Extreme Sports - Lotnisko"
	},
	{
		coords = vector3(-20.81, 239.80, 108.60),
        sprite = 279,
        color = 8,
        scale = 0.8,
        label  = "Bahama Mamas"
	},
	{
		coords = vector3(-1013.67, -481.0, 39.32),
        sprite = 205,
        color = 7,
        scale = 0.8,
        label  = "Psycholog"
	},
}

Config.Zones = {
	['casino'] = {
		Hiddenjob = false,
        Cloakroom = {
            coords = vector3(964.46, 17.43, 74.84),
            jobCloakroom = true
        },
        Inventory = {
            coords = vector3(963.35, 18.58, 74.84),
            from = 1
        },
		Shops = {
			coords = vector3(963.52, 52.17, 74.09)
		},
        Vehicles = {
            coords = vector3(953.61, 48.18, 80.06),
            heading = 237.28,
            from = 4
        },
        BossMenu = {
            coords = vector3(958.59, 19.29, 74.84),
            from = 4
        }
    },
    ['cardealer'] = {
		Hiddenjob = false,
        Cloakroom = {
            coords = vector3(130.33, -1506.93, 29.26-0.90),
            jobCloakroom = false
        },
        Inventory = {
            coords = vector3(136.95, -1498.56, 29.26-0.90),
            from = 2
        },
        Vehicles = {
            coords = vector3(118.63, -1513.41, 29.48-0.90),
            heading = 320.8,
            from = 2
        },
        BossMenu = {
            coords = vector3(112.44, -1523.28, 29.26-0.90),
            from = 2
        }
	},
	['galaxy'] = {
		Hiddenjob = false,
        Cloakroom = {
            coords = vector3(15.5299, 221.69, 99.5547),
            jobCloakroom = false
        },
        Inventory = {
            coords = vector3(-17.8312, 220.5537, 98.7536),
            from = 2
        },
        Vehicles = {
            coords = vector3(-30.4309, 212.2391, 105.6036),
            heading = 75.36,
            from = 2
        },
        BossMenu = {
            coords = vector3(17.3116, 212.7539, 99.5557),
            from = 2
        }
    },
	['doj'] = {
		Hiddenjob = false,
        Cloakroom = {
            coords = vector3(-541.2093, -193.1614, 46.473),
            jobCloakroom = false
        },
        Inventory = {
            coords = vector3(-534.6276, -192.5183, 46.473),
            from = 2
        },
        BossMenu = {
            coords = vector3(-544.5891, -201.8222, 46.465),
            from = 2
        }
    },
	['psycholog'] = {
		Hiddenjob = true,
        Cloakroom = {
            coords = vector3(-1004.25, -476.89, 49.13),
            jobCloakroom = false
        },
        Inventory = {
            coords = vector3(-1006.44, -473.8, 49.13),
            from = 3
        },
        BossMenu = {
            coords = vector3(-1008.27, -475.14, 49.13),
            from = 5
        }
    },
	['extreme'] = {
		Hiddenjob = false,
        Cloakroom = {
            coords = vector3(-786.86, -1351.29, 4.31),
            jobCloakroom = true
        },
        Inventory = {
            coords = vector3(-789.53, -1349.58, 4.31),
            from = 1
        },
        Vehicles = {
            coords = vector3(-777.61, -1336.11, 4.10),
			heading = 79.63,
            from = 2
        },
		Planes = {
			coords = vector3(2142.42, 4783.86, 40.07),
			spawn = vector3(2122.99, 4805.55, 40.3),
            heading = 111.81,
            from = 2
		},
		Boats = {
			coords = vector3(-848.85, -1367.66, 0.71),
			spawn = vector3(-863.44, -1373.47, 0.4),
            heading = 112.17,
            from = 2
		},
		Shops = {
			coords = vector3(-786.98, -1349.36, 4.31)
		},
		DeleteBoats = {
			coords = vector3(-863.44, -1373.47, 0.02),
		},
		DeleteVehicles = {
			coords = vector3(2122.99, 4805.55, 40.3),
		},
        BossMenu = {
            coords = vector3(-804.27, -1368.97, 4.32),
            from = 3
        }
    },
	['sheriff'] = {
		Hiddenjob = true,
		BossMenu = {
			coords = vector3(1852.5, 3689.62, 33.37),
			from = 10
		}
	},
}

-- Config.Interactions = {
-- 	['casino'] = {
-- 		Repair = 4,
-- 		Handcuff = 0
-- 	},
-- 	['cardealer'] = {
-- 		Repair = 2
-- 	},
-- 	['doj'] = {
-- 		Repair = 2,
-- 		Handcuff = 2
-- 	},
--     ['extreme'] = {
-- 		Repair = 3,
--         --License = 4
--     },
-- 	['psycholog'] = {
-- 		Repair = 5,
--         --License = 4
--     },
-- }

Config.Shops = {
	['casino'] = {
		{
			label = "Butelka piwa",
			value = "beer",
			from = 2,
			type = 'item',
			quantity = 10
		},
		{
			label = "100ml wódki",
			value = "vodka",
			from = 2,
			type = 'item',
			quantity = 10
		},
		{
			label = "100ml szkockiej whisky",
			value = "whisky",
			from = 2,
			type = 'item',
			quantity = 10
		},
		{
			label = "100ml tequili",
			value = "tequila",
			from = 2,
			type = 'item',
			quantity = 10
		},
		{
			label = "Szklanka burbonu",
			value = "burbon",
			from = 2,
			type = 'item',
			quantity = 10
		},
		{
			label = "Kieliszek aperitif",
			value = "aperitif",
			from = 2,
			type = 'item',
			quantity = 10
		},
		{
			label = "Butelka cydru",
			value = "cydr",
			from = 2,
			type = 'item',
			quantity = 10
		},
		{
			label = "200ml koniaku",
			value = "koniak",
			from = 2,
			type = 'item',
			quantity = 10
		},
	},
	['extreme'] = {
		{
			label = "Spadochron",
			value = "GADGET_PARACHUTE",
			from = 2,
			type = 'weapon',
			quantity = 1
		},
		{
			label = "Strój nurka - Czerwony",
			value = "nurek_1",
			from = 2,
			type = 'item',
			quantity = 1
		},
		{
			label = "Strój nurka - Zielony",
			value = "nurek_2",
			from = 2,
			type = 'item',
			quantity = 1
		},
		{
			label = "Strój nurka - Żółty",
			value = "nurek_3",
			from = 2,
			type = 'item',
			quantity = 1
		},
		{
			label = "Strój nurka - Panterka",
			value = "nurek_4",
			from = 2,
			type = 'item',
			quantity = 1
		},{
			label = "Strój nurka - Moro",
			value = "nurek_5",
			from = 2,
			type = 'item',
			quantity = 1
		},
		{
			label = "Strój nurka - Różowy",
			value = "nurek_6",
			from = 2,
			type = 'item',
			quantity = 1
		},
	}
}

Config.Planes = {
	['extreme'] = {
		{
            name = 'Supervolito2',
            label = "[HELI] Volito",
            from = 2
		},
		{
            name = 'volatus',
            label = "[HELI] Volatus",
            from = 2
        },
		{
            name = 'microlight',
            label = "[PLANE] Microlight",
            from = 2
        },
		{
            name = 'vestra',
            label = "[PLANE] Vestra",
            from = 2
        },
		{
            name = 'luxor',
            label = "[PLANE] Luxor",
            from = 2
        },
	}
}

Config.Boats = {
	['extreme'] = {
		{
            name = 'dinghy',
            label = "[BOAT] Dinghy",
            from = 2
        },
		{
            name = 'toro',
            label = "[BOAT] Toro",
            from = 2
        },
		{
            name = 'marquis',
            label = "[BOAT] Marquis",
            from = 2
        },
		{
            name = 'submersible',
            label = "[BOAT] Submersible",
            from = 2
        },
		{
            name = 'submersible2',
            label = "[BOAT] Submersible 2",
            from = 2
        }
	}
}

Config.Vehicles = {
	['casino'] = {
		{
			name = 'mb300sl',
			label = "Mercedes 300 SL",
			from = 5
		},
		{
			name = 'case63',
			label = "Mercedes E63 AMG",
			from = 5
		},
		{
			name = 'casgle',
			label = "Mercedes GLE53S AMG",
			from = 6
		}
	},
	['cardealer'] = {
		{ 
			name = 'mercedesw221',
			label = "Mercedes W221",
			from = 2
		}
	},
	['galaxy'] = {
		{ 
			name = 'pbus2',
			label = "PBus",
			from = 0
		},
		{ 
			name = 'stretch',
			label = "Stretch",
			from = 0
		}
	},
	['extreme'] = {
		{ 
			name = 'nero2',
			label = "Nero 2",
			from = 2
		}
	}
}

Config.ItemsUniforms = {
	nurek_1 = {
		male = {
			['tshirt_1'] = 123,  ['tshirt_2'] = 0,
			['torso_1'] = 243,   ['torso_2'] = 3,
			['arms'] = 1,
			['pants_1'] = 94,   ['pants_2'] = 3,
			['shoes_1'] = 67,   ['shoes_2'] = 0,
			['glasses_1'] = 26, ['glasses_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 153,  ['tshirt_2'] = 0,
			['torso_1'] = 251,   ['torso_2'] = 3,
			['arms'] = 0,
			['pants_1'] = 97,   ['pants_2'] = 3,
			['shoes_1'] = 70,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['glasses_1'] = 28,	['glasses_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
		}
	},

	nurek_2 = {
		male = {
			['tshirt_1'] = 123,  ['tshirt_2'] = 0,
			['torso_1'] = 243,   ['torso_2'] = 5,
			['arms'] = 1,
			['pants_1'] = 94,   ['pants_2'] = 5,
			['shoes_1'] = 67,   ['shoes_2'] = 0,
			['glasses_1'] = 26, ['glasses_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 153,  ['tshirt_2'] = 0,
			['torso_1'] = 251,   ['torso_2'] = 5,
			['arms'] = 0,
			['pants_1'] = 97,   ['pants_2'] = 5,
			['shoes_1'] = 70,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['glasses_1'] = 28,	['glasses_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
		}
	},
	nurek_3 = {
		male = {
			['tshirt_1'] = 123,  ['tshirt_2'] = 0,
			['torso_1'] = 243,   ['torso_2'] = 7,
			['arms'] = 1,
			['pants_1'] = 94,   ['pants_2'] = 7,
			['shoes_1'] = 67,   ['shoes_2'] = 0,
			['glasses_1'] = 26, ['glasses_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 153,  ['tshirt_2'] = 0,
			['torso_1'] = 251,   ['torso_2'] = 7,
			['arms'] = 0,
			['pants_1'] = 97,   ['pants_2'] = 7,
			['shoes_1'] = 70,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['glasses_1'] = 28,	['glasses_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
		}
	},
	nurek_4 = {
		male = {
			['tshirt_1'] = 123,  ['tshirt_2'] = 0,
			['torso_1'] = 243,   ['torso_2'] = 16,
			['arms'] = 1,
			['pants_1'] = 94,   ['pants_2'] = 16,
			['shoes_1'] = 67,   ['shoes_2'] = 0,
			['glasses_1'] = 26, ['glasses_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 153,  ['tshirt_2'] = 0,
			['torso_1'] = 251,   ['torso_2'] = 16,
			['arms'] = 0,
			['pants_1'] = 97,   ['pants_2'] = 16,
			['shoes_1'] = 70,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['glasses_1'] = 28,	['glasses_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
		}
	},
	nurek_5 = {
		male = {
			['tshirt_1'] = 123,  ['tshirt_2'] = 0,
			['torso_1'] = 243,   ['torso_2'] = 18,
			['arms'] = 1,
			['pants_1'] = 94,   ['pants_2'] = 18,
			['shoes_1'] = 67,   ['shoes_2'] = 0,
			['glasses_1'] = 26, ['glasses_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 153,  ['tshirt_2'] = 0,
			['torso_1'] = 251,   ['torso_2'] = 18,
			['arms'] = 0,
			['pants_1'] = 97,   ['pants_2'] = 18,
			['shoes_1'] = 70,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['glasses_1'] = 28,	['glasses_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
		}
	},
	nurek_6 = {
		male = {
			['tshirt_1'] = 123,  ['tshirt_2'] = 0,
			['torso_1'] = 243,   ['torso_2'] = 25,
			['arms'] = 1,
			['pants_1'] = 94,   ['pants_2'] = 25,
			['shoes_1'] = 67,   ['shoes_2'] = 0,
			['glasses_1'] = 26, ['glasses_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 153,  ['tshirt_2'] = 0,
			['torso_1'] = 251,   ['torso_2'] = 25,
			['arms'] = 0,
			['pants_1'] = 97,   ['pants_2'] = 25,
			['shoes_1'] = 70,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bags_1'] = 0,	['bags_2'] = 0,
			['glasses_1'] = 28,	['glasses_2'] = 0,
			['mask_1'] = 0,	['mask_2'] = 0,
		}
	},
}

Config.Uniforms = {
    --[[['extreme'] = {
        {
            label = "Jebanko",
            values = {
				male = {
					['tshirt_1'] = 123,  ['tshirt_2'] = 0,
					['torso_1'] = 243,   ['torso_2'] = 18,
					['arms'] = 1,
					['pants_1'] = 94,   ['pants_2'] = 18,
					['shoes_1'] = 67,   ['shoes_2'] = 0,
					['glasses_1'] = 26, ['glasses_2'] = 0,
					['bags_1'] = 0,	['bags_2'] = 0,
					['bproof_1'] = 0,  ['bproof_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['mask_1'] = 0,	['mask_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
				},
				female = {
					['tshirt_1'] = 153,  ['tshirt_2'] = 0,
					['torso_1'] = 251,   ['torso_2'] = 18,
					['arms'] = 0,
					['pants_1'] = 97,   ['pants_2'] = 18,
					['shoes_1'] = 70,   ['shoes_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['bproof_1'] = 0,  ['bproof_2'] = 0,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['bags_1'] = 0,	['bags_2'] = 0,
					['glasses_1'] = 28,	['glasses_2'] = 0,
					['mask_1'] = 0,	['mask_2'] = 0,
				}
			},
            ranks = {0,1,2,3,4}
        },
    },]]
	['casino'] = {
		{
			label = 'Ubranie pracownika - Biała koszula',
			values = {
				male = {
					['tshirt_1'] = 15,  ['tshirt_2'] = 0,
					['torso_1'] = 3,   ['torso_2'] = 0,
					['arms'] = 4, 		['arms_2'] = 0,
					['pants_1'] = 24,   ['pants_2'] = 0,
					['shoes_1'] = 10,   ['shoes_2'] = 0,
					['glasses_1'] = 5, ['glasses_2'] = 1,
					['bags_1'] = 0,	['bags_2'] = 0,
					['bproof_1'] = 0,  ['bproof_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['mask_1'] = 0,	['mask_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
				},
				female = {
					['tshirt_1'] = 22,  ['tshirt_2'] = 4,
					['torso_1'] = 11,   ['torso_2'] = 1,
					['arms'] = 4, 		['arms_2'] = 0,
					['pants_1'] = 24,   ['pants_2'] = 0,
					['shoes_1'] = 10,   ['shoes_2'] = 0,
					['glasses_1'] = 5, ['glasses_2'] = 1,
					['bags_1'] = 0,	['bags_2'] = 0,
					['bproof_1'] = 0,  ['bproof_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['mask_1'] = 0,	['mask_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
				}
			},
			ranks = {0,1,2,3,4,5,6}
		},
		{
			label = 'Ubranie pracownika - Kamizelka',
			values = {
				male = {
					['tshirt_1'] = 22,  ['tshirt_2'] = 4,
					['torso_1'] = 11,   ['torso_2'] = 1,
					['arms'] = 4, 		['arms_2'] = 0,
					['pants_1'] = 24,   ['pants_2'] = 0,
					['shoes_1'] = 10,   ['shoes_2'] = 0,
					['glasses_1'] = 5, ['glasses_2'] = 1,
					['bags_1'] = 0,	['bags_2'] = 0,
					['bproof_1'] = 0,  ['bproof_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['mask_1'] = 0,	['mask_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
				},
				female = {
					['tshirt_1'] = 22,  ['tshirt_2'] = 4,
					['torso_1'] = 11,   ['torso_2'] = 1,
					['arms'] = 4, 		['arms_2'] = 0,
					['pants_1'] = 24,   ['pants_2'] = 0,
					['shoes_1'] = 10,   ['shoes_2'] = 0,
					['glasses_1'] = 5, ['glasses_2'] = 1,
					['bags_1'] = 0,	['bags_2'] = 0,
					['bproof_1'] = 0,  ['bproof_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['mask_1'] = 0,	['mask_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
				}
			},
			ranks = {2,3,4,5,6}
		},
		{
			label = 'Ubranie managera',
			values = {
				male = {
					['tshirt_1'] = 11,  ['tshirt_2'] = 2,
					['torso_1'] = 23,   ['torso_2'] = 3,
					['arms'] = 12, 		['arms_2'] = 0,
					['pants_1'] = 24,   ['pants_2'] = 5,
					['shoes_1'] = 20,   ['shoes_2'] = 3,
					['glasses_1'] = 5, ['glasses_2'] = 1,
					['bags_1'] = 0,	['bags_2'] = 0,
					['bproof_1'] = 0,  ['bproof_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['mask_1'] = 0,	['mask_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
				},
				female = {
					['tshirt_1'] = 22,  ['tshirt_2'] = 4,
					['torso_1'] = 11,   ['torso_2'] = 1,
					['arms'] = 4, 		['arms_2'] = 0,
					['pants_1'] = 24,   ['pants_2'] = 0,
					['shoes_1'] = 10,   ['shoes_2'] = 0,
					['glasses_1'] = 5, ['glasses_2'] = 1,
					['bags_1'] = 0,	['bags_2'] = 0,
					['bproof_1'] = 0,  ['bproof_2'] = 0,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['decals_1'] = 0,   ['decals_2'] = 0,
					['mask_1'] = 0,	['mask_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
				}
			},
			ranks = {4,5,6}
		},
	}
}
