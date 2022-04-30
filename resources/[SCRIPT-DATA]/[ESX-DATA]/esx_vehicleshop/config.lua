Config                            = {}
Config.DrawDistance               = 15.0
Config.MarkerColor                = { r = 130, g = 0, b = 255 }

Config.RequiredResselJobGrade			= 3
Config.ResellPercentage           = 65

Config.Locale                     = 'pl'

Config.PlateLetters  = 3
Config.PlateNumbers  = 4
Config.PlateUseSpace = true

Config.Blips = {
}
Config.Zones = {
	
	ShopEntering = {
		Pos   = { x = 105.0928, y = -1498.8033, z = 28.3058 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 1
	},

	ShopInside = {
		Pos     = { x = 111.8378, y = -1494.3519, z = 29.0231 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 41.56,
		Type    = -1
	},

	ShopOutside = {
		Pos     = { x = 128.0077, y = -1502.6136, z = 28.3058 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 318.82,
		Type    = -1
	},

	ResellVehicle = {
		Pos   = { x = 0, y = 0, z = 0 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = 1
	}


}
