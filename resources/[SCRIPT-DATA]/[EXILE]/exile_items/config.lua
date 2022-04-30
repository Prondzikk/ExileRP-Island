Config              = {}
Config.MarkerType   = 1
Config.DrawDistance = 25.0
Config.ZoneSize     = {x = 3.0, y = 3.0, z = 0.5}
Config.MarkerColor  = {r = 0, g = 255, b = 0}
Config.TimeToFarm    = 2 * 2000

Config.Zones = {
	JablkaField = {
		x = 378.95,
		y = 6517.04, 
		z = 28.34-0.90
	},
	JablkaField2 = {
		x = 370.65,  
		y = 6517.13, 
		z = 28.37-0.90
	},
	JablkaField3 = { 
		x = 363.25,  
		y = 6517.17, 
		z = 28.28-0.90
	},
	JablkaProcessing = { 
		x = -247.69,  
		y = 6067.45, 
		z = 32.34
	}
}

Config.Blipy = {
	{
		Pos     = vector3(408.0822, 6496.9277, 26.8827),
		Sprite  = 486,
		Display = 4,
		Scale   = 1.0,
		Colour  = 2,
		Label 	= "Sad Jabłek"
	},
	{
		Pos     = vector3(-247.69, 6067.45, 32.34),
		Sprite  = 740,
		Display = 4,
		Scale   = 1.0,
		Colour  = 32,
		Label 	= "Przetwarzanie Jabłek"
	}
}