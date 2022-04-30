Config = {}
Config.DrawDistance = 5
Config.Size = { x = 1.0, y = 1.0, z = 0.5 }
Config.Color = { r = 56, g = 197, b = 201 }
Config.Type = 27
Config.Locale = 'exile'
Config.MarkerType = 1
Config.MarkerSize = { x = 1.5, y = 1.5, z = 0.5 }
Config.Marker = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor = { r = 57, g = 197 , b = 201 }
Config.Marker = {Type = 27, r = 56, g = 197, b = 201}
Config.EnableLicense = true
Config.LicenseEnable = true

Config.Prices = {
	[1] = 70000,
	[2] = 10000,
	[3] = 1500,
	[4] = 6000,
	[5] = 8000
}

Config.Zones = {
	GunShop = {
		legal = true,
		Items = {
			{title = 'Pistolet', item = 'pistol', price = 70000, limit = 5},
			{title = 'Nóż', item = 'knife', price = 15000, limit = 5},
			{title = 'Magazynek', item = 'clip', price = 1500, limit = 10},
			{title = 'Uchwyt', item = 'grip', price = 8000, limit = 3},
			{title = 'Latarka', item = 'flashlight', price = 6000, limit = 3},
		},
		Pos   = {
			{ x = -662.180,   y = -934.961,   z = 21.829 },
            { x = 810.25,     y = -2157.60,   z = 29.62 },
            { x = 1693.44,    y = 3760.16,    z = 32.71 },
            { x = -330.24,    y = 6083.88,    z = 31.45 },
            { x = 252.63,     y = -50.00,     z = 69.94 },
            { x = 22.09,      y = -1107.28,   z = 29.80 },
            { x = 2567.69,    y = 294.38,     z = 108.73 },
            { x = -1117.58,   y = 2698.61,    z = 18.55 },
            { x = 842.44,     y = -1033.42,   z = 28.19 },
			{ x = -1306.239,   y = -394.018,  z = 36.695 }
		}
	},
	ashgdfhdfhgjdofihonjksgfhujsdBGJDBYGDFGOUIYIY348967RTB8T034WEQGFAISUGFBYNH8IHg = {
		legal = false,
		Items = {
			{title = 'Pistolet Vintage', item = 'vintagepistol', price = 130000, limit = 5},
			{title = 'Pistolet', item = 'pistol', price = 110000, limit = 5},
			{title = 'Kij bejsbolowy', item = 'bat', price = 15000, limit = 2},
			{title = 'Maczeta', item = 'machete', price = 8000, limit = 2},
			{title = 'Magazynek', item = 'clip', price = 5000, limit = 4},
		},
		Pos   = {
			{ x = -279.26,   y = 2206.24,   z = 129.84 }
		}
	}
}
