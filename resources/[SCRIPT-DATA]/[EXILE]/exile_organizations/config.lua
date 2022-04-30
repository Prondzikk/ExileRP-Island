Config                            = {}
Config.Locale                     = 'pl'

Config.DrawDistance               = 10.0

Config.AuthorizedWeapons = {
    { 
        name = 'clip', 
        tableName = 'pistolmk2', 
        price = 2000, 
        ammo = 1000
    },
    { 
        name = 'WEAPON_SNSPISTOL', 
        tableName = 'snspistol', 
        price = 50000, 
        ammo = 1000
    },
}

Config.JobLocation = {
    {x = 1982.78, y = 5175.08, z = 47.63-0.94, h = 129.82},
}

Config.JobPed = 's_m_m_doctor_01'
Config.QuestPed = 's_m_m_doctor_01' 
Config.PackagingPed = 's_m_m_doctor_01'

Config.EnableNPC = true

Config.Blips = {
    ['org1'] = vector3(691.26, 604.86, 128.9),
    ['org2'] = vector3(579.06, 134.62, 98.04),
    ['org3'] = vector3(189.95, 308.91, 105.39),
    ['org4'] = vector3(-1855.01, -313.34, 49.14),
    ['org5'] = vector3(-2956.52, 58.79, 11.6),
    ['org6'] = vector3(-84.14, 1880.37, 197.28), 
    ['org7'] = vector3(1206.82, 1857.49, 78.91), 
    ['org8'] = vector3(-2231.94, 2420.56, 12.18),
    ['org9'] = vector3(-511.59, -1737.12, 19.23),
    ['org10'] = vector3(1651.1696, 4829.5596, 41.9),
    ['org11'] = vector3(1720.68, 4670.11, 43.22),
    ['org12'] = vector3(-680.26, 5797.82, 17.33),
    ['org13'] = vector3(735.84, 2533.59, 73.18),
    ['org14'] = vector3(-896.88, -985.09, 2.16),
    ['org15'] = vector3(-106.35, 2796.28, 53.34),
    ['org16'] = vector3(348.64, 3392.09, 36.4),
    ['org17'] = vector3(919.43, 3658.91, 32.5),
    ['org18'] = vector3(1948.63, 3823.39, 32.1), --36
    ['org19'] = vector3(201.7238, 2462.0781, 54.73),
    ['org20'] = vector3(1409.12, 3620.06, 34.89),
    ['org21'] = vector3(2888.1, 4383.1, 50.3),
    ['org22'] = vector3(2934.44, 4631.88, 48.54),
    ['org23'] = vector3(2465.08, 4100.46, 38.06), --35

}

Config.Zones = {
    ['org1'] = {
        Cloakroom = {
            coords = vector3(1072.014, -3178.99, -98.39491),
        },
        Inventory = {
            coords = vector3(1074.351, -3182.993, -98.98985),
            from = 1
        },
		Licenses = {
			coords = vector3(1076.626, -3185.84, -98.98986),
			from = 3
		},
        MainMenu = {
            coords = vector3(1077.122, -3187.545, -98.98986),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org2'] = {
        Cloakroom = {
            coords = vector3(2291.022, -1726.448, -98.39494),
        },
        Inventory = {
            coords = vector3(2293.505, -1730.559, -98.98981),
            from = 1
        },
		Licenses = {
			coords = vector3(2280.706, -1743.281, -98.98994),
			from = 3
		},
        MainMenu = {
            coords = vector3(2280.872, -1746.049, -98.98992),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org3'] = {
        Cloakroom = {
            coords = vector3(1087.867, -1659.314, -98.39484),
        },
        Inventory = {
            coords = vector3(1090.297, -1663.613, -98.98985),
            from = 1
        },
		Licenses = {
			coords = vector3(1092.616, -1665.799, -98.98985),
			from = 3
		},
        MainMenu = {
            coords = vector3(1093.263, -1667.902, -98.98985),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org4'] = {
        Cloakroom = {
            coords = vector3(1892.795, -1908.675, -98.39494),
        },
        Inventory = {
            coords = vector3(1895.078, -1913.012, -98.98995),
            from = 1
        },
		Licenses = {
			coords = vector3(1882.431, -1925.371, -98.98992),
			from = 3
		},
        MainMenu = {
            coords = vector3(1882.524, -1928.155, -98.98992),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org5'] = {
        Cloakroom = {
            coords = vector3(1029.637, -2434.909, -98.39491),
        },
        Inventory = {
            coords = vector3(1032.313, -2439.189, -98.98986),
            from = 1
        },
		Licenses = {
			coords = vector3(1019.216, -2451.821, -98.98986),
			from = 3
		},
        MainMenu = {
            coords = vector3(1019.383, -2454.708, -98.98986),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org6'] = {
        Cloakroom = {
            coords = vector3(-472.1938, -966.2918, -98.39475),
        },
        Inventory = {
            coords = vector3(-469.8222, -970.8028, -98.98986),
            from = 1
        },
		Licenses = {
			coords = vector3(-467.5654, -973.0975, -98.98986),
			from = 3
		},
        MainMenu = {
            coords = vector3(-467.1024, -975.1728, -98.98986),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org7'] = {
        Cloakroom = {
            coords = vector3(1532.865, -2115.376, -98.39475),
        },
        Inventory = {
            coords = vector3(1535.375, -2119.51, -98.98991),
            from = 1
        },
		Licenses = {
			coords = vector3(1537.962, -2122.058, -98.98981),
			from = 3
		},
        MainMenu = {
            coords = vector3(1538.623, -2124.483, -98.98985),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org8'] = {
        Cloakroom = {
            coords = vector3(1160.93, -2404.968, -98.39494),
        },
        Inventory = {
            coords = vector3(1163.291, -2409.066, -98.98985),
            from = 1
        },
		Licenses = {
			coords = vector3(1150.473, -2421.64, -98.98985),
			from = 3
		},
        MainMenu = {
            coords = vector3(1150.286, -2424.225, -98.98985),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org9'] = {
        Cloakroom = {
            coords = vector3(1169.967, -3145.867, -98.39495),
        },
        Inventory = {
            coords = vector3(1172.573, -3150.344, -98.98982),
            from = 1
        },
		Licenses = {
			coords = vector3(1159.917, -3162.879, -98.98982),
			from = 3
		},
        MainMenu = {
            coords = vector3(1159.754, -3165.519, -98.98982),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org10'] = {
        Cloakroom = {
            coords = vector3(-472.2398, -966.0674, -98.39493),
        },
        Inventory = {
            coords = vector3(-469.8036, -970.305, -98.98981),
            from = 1
        },
		Licenses = {
			coords = vector3(-467.5526, -972.7853, -98.98983),
			from = 3
		},
        MainMenu = {
            coords = vector3(-467.0984, -975.2034, -98.98986),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org11'] = {
        Cloakroom = {
            coords = vector3(1656.072, -1547.496, -98.39494),
        },
        Inventory = {
            coords = vector3(1658.625, -1551.523, -98.98981),
            from = 1
        },
		Licenses = {
			coords = vector3(1645.713, -1564.294, -98.98982),
			from = 3
		},
        MainMenu = {
            coords = vector3(1645.757, -1567.095, -98.98982),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org12'] = {
        Cloakroom = {
            coords = vector3(2066.403, -282.5866, -98.39493),
        },
        Inventory = {
            coords = vector3(2068.719, -286.9826, -98.98982),
            from = 1
        },
		Licenses = {
			coords = vector3(2055.923, -299.5582, -98.98984),
			from = 3
		},
        MainMenu = {
            coords = vector3(2056.085, -302.5019, -98.98984),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org13'] = {
        Cloakroom = {
            coords = vector3(2003.971, -994.8846, -98.39481),
        },
        Inventory = {
            coords = vector3(2006.608, -999.0333, -98.98982),
            from = 1
        },
		Licenses = {
			coords = vector3(1993.78, -1011.511, -98.98982),
			from = 3
		},
        MainMenu = {
            coords = vector3(1993.81, -1014.29, -98.98985),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org14'] = {
        Cloakroom = {
            coords = vector3(1826.475, -1758.328, -98.39483),
        },
        Inventory = {
            coords = vector3(1828.945, -1762.752, -98.98981),
            from = 1
        },
		Licenses = {
			coords = vector3(1830.873, -1764.862, -98.98981),
			from = 3
		},
        MainMenu = {
            coords = vector3(1831.645, -1767.632, -98.98981),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org15'] = {
        Cloakroom = {
            coords = vector3(1224.328, -1776.498, -98.3949),
        },
        Inventory = {
            coords = vector3(1226.782, -1780.766, -98.98981),
            from = 1
        },
		Licenses = {
			coords = vector3(1229.189, -1783.365, -98.98981),
			from = 3
		},
        MainMenu = {
            coords = vector3(1229.525, -1785.472, -98.98982),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org16'] = {
        Cloakroom = {
            coords = vector3(952.9147, -1978.109, -98.39481),
        },
        Inventory = {
            coords = vector3(955.4283, -1982.375, -98.98982),
            from = 1
        },
		Licenses = {
			coords = vector3(957.7736, -1985.207, -98.98983),
			from = 3
		},
        MainMenu = {
            coords = vector3(958.0517, -1986.596, -98.98983),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org17'] = {
        Cloakroom = {
            coords = vector3(1383.974, -2479.617, -98.39493),
        },
        Inventory = {
            coords = vector3(1386.417, -2483.785, -98.98983),
            from = 1
        },
		Licenses = {
			coords = vector3(1388.678, -2486.743, -98.98983),
			from = 3
		},
        MainMenu = {
            coords = vector3(1389.301, -2488.282, -98.98983),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org18'] = {
        Cloakroom = {
            coords = vector3(1369.372, -2064.76, -98.39483),
        },
        Inventory = {
            coords = vector3(1371.963, -2069.138, -98.98982),
            from = 1
        },
		Licenses = {
			coords = vector3(1359.138, -2081.824, -98.98992),
			from = 3
		},
        MainMenu = {
            coords = vector3(1358.878, -2084.371, -98.98992),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org19'] = {
        Cloakroom = {
            coords = vector3(1126.606, -3057.235, -98.39493),
        },
        Inventory = {
            coords = vector3(1129.074, -3061.322, -98.98985),
            from = 1
        },
		Licenses = {
			coords = vector3(1131.235, -3063.893, -98.98985),
			from = 3
		},
        MainMenu = {
            coords = vector3(1131.964, -3066.071, -98.98985),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org20'] = {
        Cloakroom = {
            coords = vector3(1144.923, -2966.828, -98.39481),
        },
        Inventory = {
            coords = vector3(1147.46, -2971.128, -98.98982),
            from = 1
        },
		Licenses = {
			coords = vector3(1149.933, -2973.928, -98.98983),
			from = 3
		},
        MainMenu = {
            coords = vector3(1150.24, -2975.626, -98.98983),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org21'] = {
        Cloakroom = {
            coords = vector3(982.3237, -3108.286, -98.39493),
        },
        Inventory = {
            coords = vector3(984.9222, -3112.615, -98.9898),
            from = 1
        },
		Licenses = {
			coords = vector3(987.2502, -3115.05, -98.98981),
			from = 3
		},
        MainMenu = {
            coords = vector3(987.5747, -3117.168, -98.98983),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org22'] = {
        Cloakroom = {
            coords = vector3(1213.899, -3217.521, -98.39493),
        },
        Inventory = {
            coords = vector3(1216.355, -3221.653, -98.98983),
            from = 1
        },
		Licenses = {
			coords = vector3(1203.541, -3234.423, -98.98981),
			from = 3
		},
        MainMenu = {
            coords = vector3(1203.48, -3236.553, -98.98983),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
    ['org23'] = {
        Cloakroom = {
            coords = vector3(1084.199, -1503.836, -98.39494),
        },
        Inventory = {
            coords = vector3(1086.6, -1508.467, -98.98985),
            from = 1
        },
		Licenses = {
			coords = vector3(1073.945, -1520.777, -98.98985),
			from = 3
		},
        MainMenu = {
            coords = vector3(1074.022, -1523.169, -98.98985),
            from = 4
        },
        Barabasz = {
            coords = vector3(1873.23, 3338.97, 43.53)
        }
    },
}


Config.OpiumMenu = {
	coords = vector3(1398.7175, 1158.5896, 113.3857),
	owner = 'orgkurwaniewiem',
	from = 3
}

Config.ExctasyMenu = {
	coords = vector3(1400.1356, 1152.6506, 113.3857),
	owner = 'orgkurwaniewiem',
	from = 3
}