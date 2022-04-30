Config                   = {}
Config.MarkerLegs        = { type = 21, x = 0.5, y = 0.5, z = 0.5, r = 56, g = 197, b = 201, a = 175, rotate = false }
Config.MarkerCar         = { type = 27, x = 3.0, y = 3.0, z = 1.0, r = 56, g = 197, b = 201, a = 175, rotate = true }
Config.MarkerLift         = { type = 21, x = 0.5, y = 0.5, z = 0.5, r = 56, g = 197, b = 201, a = 175, rotate = false }
Config.DrawDistance		 = 15.0
Config.Display			 = 2

Config.TeleportsLegs = {
	{
		From = vector3(-674.21, 352.55, 83.15),
		To = vector3(-652.92, 313.72, 140.15),
		Heading = 257.59,
		Visible = {'ambulance', 'police'}
	},
	{
		From = vector3(-652.92, 313.72, 140.15),
		To = vector3(-674.21, 352.55, 83.15),
		Heading = 257.59,
		Visible = {'ambulance', 'police'}
	},
	{
		From = vector3(-3132.2655, -1595.5985, 43.3341),
		To = vector3(341.44, -587.26, 74.17),
		Heading = 257.59,
		Visible = {'ambulance'}
	},
	{ --ZE SZPITALA NA HELIPAD SANDY
		From = vector3(1835.17, 3683.81, 34.27),
		To = vector3(1840.38, 3686.56, 39.37),
		Heading = 257.59,
		Visible = {'ambulance'}
	},
	{ --Z DACHU NA SZPITAL SANDY
		From = vector3(1840.38, 3686.56, 39.37),
		To = vector3(1835.17, 3683.81, 34.27),
		Heading = 257.59,
		Visible = {'ambulance'}
	},
	{
		From = vector3(-562.92, -171.59, 47.52),
		To = vector3(-562.42, -174.24, 44.31),
		Heading = 229.03,
		Visible = {'police', 'sheriff'}
	},
	{
		From = vector3(1837.1873, 3695.1284, 34.3184),
		To = vector3(1838.2053, 3692.2263, 38.7076),
		Heading = 121.68,
		Visible = {'police', 'sheriff'}
	},
	{
		From = vector3(1838.2053, 3692.2263, 38.7076),
		To = vector3(1837.1873, 3695.1284, 34.3184),
		Heading = 119.55,
		Visible = {'police', 'sheriff'}
	},
	{
		From = vector3(-562.42, -174.24, 44.31),
		To = vector3(-562.92, -171.59, 47.52),
		Heading = 229.03,
		Visible = {'police', 'sheriff'}
	},
	{
		From = vector3(-1011.39, -480.03, 39.97),
		To = vector3(-1002.94, -477.94, 49.13),
		Heading = 120.7
	},
	{
		From = vector3(-1002.94, -477.94, 50.03),
		To = vector3(-1011.39, -480.03, 39.07),
		Heading = 120.95
	},
	{
		From = vector3(-68.0209, -801.3398, 43.2773+0.5),
		To = vector3(-79.7134, -832.9268, 242.4357),
		Heading = 120.95
	},
	{
		From = vector3(-79.7134, -832.9268, 242.4357+0.5),
		To = vector3(-68.0209, -801.3398, 43.2773),
		Heading = 120.95
	},
	{
		From = vector3(-81.8073, -818.434, 35.0781+0.5),
		To = vector3(-73.1722, -824.1892, 242.436),
		Heading = 120.95
	},
	{
		From = vector3(-73.1722, -824.1892, 242.436+0.5),
		To = vector3(-81.8073,  -818.434, 35.0781+0.5),
		Heading = 120.95
	},

	{
		From = vector3(-296.9515, -2201.5569, 10.0491),
		To = vector3(997.34, -3200.62, -37.49),
		Heading = 270.03,
		Visible = {'org27'},
		License = 'opium_transform'
	},

	{
		From = vector3(997.34, -3200.62, -36.39),
		To = vector3(-296.9515, -2201.5569, 10.0491),
		Heading = 249.94
	},

	{
		From = vector3(753.3798, -3182.1404, 7.4558),
		To = vector3(1173.3013, -3196.6018, -39.9579),
		Heading = 270.03,
		Visible = {'org27'},
		License = 'opium_transform'
	},

	{
		From = vector3(1173.3013, -3196.6018, -38.9579),
		To = vector3(753.3798, -3182.1404, 7.4558),
		Heading = 249.94
	},

	{
		From = vector3(-1147.43, -1562.38, 4.4406),
		To = vector3(1088.76, -3188.01, -39.89),
		Heading = 180.7,
		Visible = {'org27'},
		License = 'exctasy_transform'
	},

	{
		From = vector3(1088.76, -3188.01, -38.999),
		To = vector3(-1147.43, -1562.38, 3.49),
		Heading = 130.22
	},

	{
		From = vector3(-673.0139, -981.7904, 22.3908),
		To = vector3(1087.9294, -3099.3589, -38.95),
		Heading = 180.7,
		Visible = {'org27'},
		License = 'exctasy_transform'
	},

	{
		From = vector3(1087.9294, -3099.3589, -38.95),
		To = vector3(-673.0139, -981.7904, 22.3908),
		Heading = 130.22
	},

	{
		From = vector3(138.2429, -137.2072, 54.9111),
		To = vector3(137.5044, -134.3136, 59.568),
		Heading = 160.28
	},
	{
		From = vector3(137.5044, -134.3136, 60.568),
		To = vector3(138.2429, -137.2072, 53.9111),
		Heading = 160.28
	},

	
	-- Kasyno

	{
        From = vector3(967.3875, 7.5064, 81.2),
        To = vector3(965.176, 58.5666, 112.603),
        Heading = 43.30,
    },
	{
        From = vector3(965.176, 58.5666, 112.603),
        To = vector3(967.3875, 7.5064, 81.2),
        Heading = 43.30,
    },

	--ORG 1
	{
		From = vector3(711.64, 590.55, 129.05),
		To = vector3(1061.37, -3186.93, -98.0),
		Heading = 66.75,
		Visible = {'org1'}
	},
	{
		From = vector3(1061.37, -3186.93, -98.0),
		To = vector3(711.64, 590.55, 129.05),
		Heading = 66.75,
		Visible = {'org1'}
	},
	--ORG 2
	{
		From = vector3(2280.22, -1734.47, -98.0),
		To = vector3(581.01, 139.08, 99.47),
		Heading = 66.75,
		Visible = {'org2'}
	},
	{
		From = vector3(581.01, 139.08, 99.47),
		To = vector3(2280.22, -1734.47, -98.0),
		Heading = 66.75,
		Visible = {'org2'}
	},
	--ORG 3
	{
		From = vector3(1077.08, -1667.32, -98.0),
		To = vector3(189.95, 308.91, 105.39),
		Heading = 66.75,
		Visible = {'org3'}
	},
	{
		From = vector3(189.95, 308.91, 105.39),
		To = vector3(1077.08, -1667.32, -98.0),
		Heading = 66.75,
		Visible = {'org3'}
	},
	--ORG 4
	{
		From = vector3(1882.03, -1916.78, -98.0),
		To = vector3(-1865.03, -307.72, 49.14),
		Heading = 66.75,
		Visible = {'org4'}
	},
	{
		From = vector3(-1865.03, -307.72, 49.14),
		To = vector3(1882.03, -1916.78, -98.0),
		Heading = 66.75,
		Visible = {'org4'}
	},
	--ORG 5
	{
		From = vector3(1018.89, -2442.77, -98.0),
		To = vector3(-2953.24, 49.89, 11.6),
		Heading = 66.75,
		Visible = {'org5'}
	},
	{
		From = vector3(-2953.24, 49.89, 11.6),
		To = vector3(1018.89, -2442.77, -98.0),
		Heading = 66.75,
		Visible = {'org5'}
	},
	--ORG 6
	{
		From = vector3(-483.02, -974.65, -98.0),
		To = vector3(-86.58, 1883.65, 197.37),
		Heading = 66.75,
		Visible = {'org6'}
	},
	{
		From = vector3(-86.58, 1883.65, 197.37),
		To = vector3(-483.02, -974.65, -98.0),
		Heading = 66.75,
		Visible = {'org6'}
	},
	--ORG 7
	{
		From = vector3(1522.33, -2123.32, -98.0),
		To = vector3(1211.03, 1857.76, 78.91),
		Heading = 66.75,
		Visible = {'org7'}
	},
	{
		From = vector3(1211.03, 1857.76, 78.91),
		To = vector3(1522.33, -2123.32, -98.0),
		Heading = 66.75,
		Visible = {'org7'}
	},
	--ORG 8
	{
		From = vector3(1149.98, -2412.96, -98.0),
		To = vector3(-2229.95, 2434.39, 12.14),
		Heading = 66.75,
		Visible = {'org8'}
	},
	{
		From = vector3(-2229.95, 2434.39, 12.14),
		To = vector3(1149.98, -2412.96, -98.0),
		Heading = 66.75,
		Visible = {'org8'}
	},
	--ORG 9
	{
		From = vector3(1159.21, -3154.12, -98.0),
		To = vector3(-499.42, -1714.36, 19.89),
		Heading = 66.75,
		Visible = {'org9'}
	},
	{
		From = vector3(-499.42, -1714.36, 19.89),
		To = vector3(1159.21, -3154.12, -98.0),
		Heading = 66.75,
		Visible = {'org9'}
	},
	--ORG 10
	{
		From = vector3(-483.03, -973.91, -98.0),
		To = vector3(1651.1696, 4829.5596, 41.9),
		Heading = 66.75,
		Visible = {'org10'}
	},
	{
		From = vector3(1651.1696, 4829.5596, 41.9),
		To = vector3(-483.03, -973.91, -98.0),
		Heading = 66.75,
		Visible = {'org10'}
	},
	--ORG11
	{
		From = vector3(1645.29, -1555.46, -98.0),
		To = vector3(1718.6, 4677.0, 43.65),
		Heading = 66.75,
		Visible = {'org11'}
	},
	{
		From = vector3(1718.6, 4677.0, 43.65),
		To = vector3(1645.29, -1555.46, -98.0),
		Heading = 66.75,
		Visible = {'org11'}
	},
	--ORG 12
	{
		From = vector3(2055.51, -290.81, -98.0),
		To = vector3(-688.66, 5788.95, 17.33),
		Heading = 269.26,
		Visible = {'org12'}
	},
	{
		From = vector3(-688.66, 5788.95, 17.33),
		To = vector3(2055.51, -290.81, -98.0),
		Heading = 269.26,
		Visible = {'org12'}
	},
	--ORG 13
	{
		From = vector3(1993.28, -1002.84, -98.0),
		To = vector3(733.82, 2523.21, 73.22),
		Heading = 269.26,
		Visible = {'org13'}
	},
	{
		From = vector3(733.82, 2523.21, 73.22),
		To = vector3(1993.28, -1002.84, -98.0),
		Heading = 269.26,
		Visible = {'org13'}
	},
	--ORG 14
	{
		From = vector3(1815.72, -1766.17, -98.0),
		To = vector3(-899.83, -981.87, 2.16),
		Heading = 269.26,
		Visible = {'org14'}
	},
	{
		From = vector3(-899.83, -981.87, 2.16),
		To = vector3(1815.72, -1766.17, -98.0),
		Heading = 269.26,
		Visible = {'org14'}
	},
	--ORG 15
	{
		From = vector3(1213.54, -1784.35, -98.0),
		To = vector3(-98.65, 2807.25, 53.15),
		Heading = 269.26,
		Visible = {'org15'}
	},
	{
		From = vector3(-98.65, 2807.25, 53.15),
		To = vector3(1213.54, -1784.35, -98.0),
		Heading = 269.26,
		Visible = {'org15'}
	},
	--ORG 16
	{
		From = vector3(942.1, -1986.01, -98.0),
		To = vector3(330.5, 3387.17, 36.4),
		Heading = 269.26,
		Visible = {'org16'}
	},
	{
		From = vector3(330.5, 3387.17, 36.4),
		To = vector3(942.1, -1986.01, -98.0),
		Heading = 269.26,
		Visible = {'org16'}
	},
	--ORG 17

	{
		From = vector3(1373.24, -2487.65, -98.0),
		To = vector3(917.48, 3654.94, 32.48),
		Heading = 269.26,
		Visible = {'org17'}
	},
	{
		From = vector3(917.48, 3654.94, 32.48),
		To = vector3(1373.24, -2487.65, -98.0),
		Heading = 269.26,
		Visible = {'org17'}
	},

	--ORG 18
	{
		From = vector3(1358.63, -2072.73, -98.0),
		To = vector3(1953.2, 3842.48, 32.18),
		Heading = 269.26,
		Visible = {'org18'}
	},
	{
		From = vector3(1953.2, 3842.48, 32.18),
		To = vector3(1358.63, -2072.73, -98.0),
		Heading = 269.26,
		Visible = {'org18'}
	},
	--ORG 19
	{
		From = vector3(201.79, 2462.08, 55.68),
		To = vector3(1115.82, -3065.0, -98.0),
		Heading = 269.26,
		Visible = {'org19'}
	},
	{
		From = vector3(1115.82, -3065.0, -98.0),
		To = vector3(201.79, 2462.08, 55.68),
		Heading = 269.26,
		Visible = {'org19'}
	},
	--ORG 20
	{
		From = vector3(1134.13, -2974.86, -98.0),
		To = vector3(1410.38, 3612.18, 35.02),
		Heading = 269.26,
		Visible = {'org20'}
	},
	{
		From = vector3(1410.38, 3612.18, 35.02),
		To = vector3(1134.13, -2974.86, -98.0),
		Heading = 269.26,
		Visible = {'org20'}
	},
	--ORG 21
	{
		From = vector3(971.61, -3116.37, -98.0),
		To = vector3(2890.37, 4391.32, 50.33),
		Heading = 269.26,
		Visible = {'org21'}
	},
	{
		From = vector3(2890.37, 4391.32, 50.33),
		To = vector3(971.61, -3116.37, -98.0),
		Heading = 269.26,
		Visible = {'org21'}
	},
	--ORG 22
	{
		From = vector3(1203.13, -3225.57, -98.0),
		To = vector3(2932.17, 4623.97, 48.72),
		Heading = 269.26,
		Visible = {'org22'}
	},
	{
		From = vector3(2932.17, 4623.97, 48.72),
		To = vector3(1203.13, -3225.57, -98.0),
		Heading = 269.26,
		Visible = {'org22'}
	},
	--ORG 23
	{
		From = vector3(1073.37, -1512.05, -98.0),
		To = vector3(2471.81, 4110.93, 38.06),
		Heading = 269.26,
		Visible = {'org23'}
	},
	{
		From = vector3(2471.81, 4110.93, 38.06),
		To = vector3(1073.37, -1512.05, -98.0),
		Heading = 269.26,
		Visible = {'org23'}
	},
}

Config.TeleportsCars = {
	--ORG 1
	{
		From = vector3(691.26, 604.86, 128.9-0.99),
		To = vector3(1062.82, -3190.29, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org1'}
	},
	{
		From = vector3(1062.82, -3190.29, -98.0-0.99),
		To = vector3(691.26, 604.86, 128.9-0.99),
		Heading = 269.26,
		Visible = {'org1'}
	},
	--ORG 2
	{
		From = vector3(2282.29, -1737.61, -98.0-0.99),
		To = vector3(579.06, 134.62, 98.04-0.99),
		Heading = 269.26,
		Visible = {'org2'}
	},
	{
		From = vector3(579.06, 134.62, 98.04-0.99),
		To = vector3(2282.29, -1737.61, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org2'}
	},
	--ORG 3
	{
		From = vector3(1079.0, -1670.59, -98.0-0.99),
		To = vector3(178.35, 304.45, 105.37-0.99),
		Heading = 269.26,
		Visible = {'org3'}
	},
	{
		From = vector3(178.35, 304.45, 105.37-0.99),
		To = vector3(1079.0, -1670.59, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org3'}
	},
	--ORG 4
	{
		From = vector3(-1855.01, -313.34, 49.14-0.99),
		To = vector3(1884.01, -1920.06, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org4'}
	},
	{
		From = vector3(1884.01, -1920.06, -98.0-0.99),
		To = vector3(-1855.01, -313.34, 49.14-0.99),
		Heading = 269.26,
		Visible = {'org4'}
	},
	--ORG 5
	{
		From = vector3(1021.2, -2446.42, -98.0-0.99),
		To = vector3(-2956.52, 58.79, 11.7-0.99),
		Heading = 269.26,
		Visible = {'org5'}
	},
	{
		From = vector3(-2956.52, 58.79, 11.7-0.99),
		To = vector3(1021.2, -2446.42, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org5'}
	},
	--ORG 6
	{
		From = vector3(-84.14, 1880.37, 197.28-0.99),
		To = vector3(-481.1, -977.3, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org6'}
	},
	{
		From = vector3(-481.1, -977.3, -98.0-0.99),
		To = vector3(-84.14, 1880.37, 197.28-0.99),
		Heading = 269.26,
		Visible = {'org6'}
	},
	--ORG 7
	{
		From = vector3(1206.82, 1857.49, 78.91-0.99),
		To = vector3(1523.51, -2126.73, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org7'}
	},
	{
		From = vector3(1523.51, -2126.73, -98.0-0.99),
		To = vector3(1206.82, 1857.49, 78.91-0.99),
		Heading = 269.26,
		Visible = {'org7'}
	},
	--ORG 8
	{
		From = vector3(1150.97, -2416.07, -98.0-0.99),
		To = vector3(-2231.94, 2420.56, 12.18-0.99),
		Heading = 269.26,
		Visible = {'org8'}
	},
	{
		From = vector3(-2231.94, 2420.56, 12.18-0.99),
		To = vector3(1150.97, -2416.07, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org8'}
	},
	--ORG 9
	{
		From = vector3(1160.84, -3157.37, -98.0-0.99),
		To = vector3(-511.59, -1737.12, 19.23-0.99),
		Heading = 269.26,
		Visible = {'org9'}
	},
	{
		From = vector3(-511.59, -1737.12, 19.23-0.99),
		To = vector3(1160.84, -3157.37, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org9'}
	},
	--ORG 10
	{
		From = vector3(-481.01, -977.39, -98.0-0.99),
		To = vector3(1643.6421, 4839.3052, 41.1),
		Heading = 269.26,
		Visible = {'org10'}
	},
	{
		From = vector3(1643.6421, 4839.3052, 41.1),
		To = vector3(-481.01, -977.39, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org10'}
	},
	--ORG 11
	{
		From = vector3(1646.48, -1558.95, -98.0-0.99),
		To = vector3(1718.78, 4668.95, 43.18-0.95),
		Heading = 269.26,
		Visible = {'org11'}
	},
	{
		From = vector3(1718.78, 4668.95, 43.18-0.95),
		To = vector3(1646.48, -1558.95, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org11'}
	},
	--ORG 12
	{
		From = vector3(2056.44, -294.11, -98.0-0.99),
		To = vector3(-680.26, 5797.82, 17.33-0.95),
		Heading = 269.26,
		Visible = {'org12'}
	},
	{
		From = vector3(-680.26, 5797.82, 17.33-0.95),
		To = vector3(2056.44, -294.11, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org12'}
	},
	--ORG 13
	{
		From = vector3(1994.99, -1006.2, -98.0-0.99),
		To = vector3(735.84, 2533.59, 73.18-0.95),
		Heading = 269.26,
		Visible = {'org13'}
	},
	{
		From = vector3(735.84, 2533.59, 73.18-0.95),
		To = vector3(1994.99, -1006.2, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org13'}
	},
	--ORG 14
	{
		From = vector3(1816.95, -1769.78, -98.0-0.99),
		To = vector3(-896.88, -985.09, 2.16-0.99),
		Heading = 269.26,
		Visible = {'org14'}
	},
	{
		From = vector3(-896.88, -985.09, 2.16-0.99),
		To = vector3(1816.95, -1769.78, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org14'}
	},
	--ORG 15
	{
		From = vector3(1215.2, -1787.9, -98.0-0.99),
		To = vector3(-106.35, 2796.28, 53.34-0.95),
		Heading = 269.26,
		Visible = {'org15'}
	},
	{
		From = vector3(-106.35, 2796.28, 53.34-0.95),
		To = vector3(1215.2, -1787.9, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org15'}
	},
	--ORG 16
	{
		From = vector3(943.07, -1989.35, -98.0-0.99),
		To = vector3(348.64, 3392.09, 36.4-0.95),
		Heading = 269.26,
		Visible = {'org16'}
	},
	{
		From = vector3(348.64, 3392.09, 36.4-0.95),
		To = vector3(943.07, -1989.35, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org16'}
	},
	--ORG 17

	{
		From = vector3(1375.01, -2491.05, -98.0-0.99),
		To = vector3(919.43, 3658.91, 32.5-0.95),
		Heading = 269.26,
		Visible = {'org17'}
	},
	{
		From = vector3(919.43, 3658.91, 32.5-0.95),
		To = vector3(1375.01, -2491.05, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org17'}
	},
	--ORG 18
	{
		From = vector3(1360.38, -2076.19, -98.0-0.99),
		To = vector3(1948.63, 3823.39, 32.1-0.95),
		Heading = 269.26,
		Visible = {'org18'}
	},
	{
		From = vector3(1948.63, 3823.39, 32.1-0.95),
		To = vector3(1360.38, -2076.19, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org18'}
	},
	--ORG 19
	{
		From = vector3(1117.3, -3068.35, -98.0-0.99),
		To = vector3(190.55, 2457.35, 55.7-0.95),
		Heading = 269.26,
		Visible = {'org19'}
	},
	{
		From = vector3(190.55, 2457.35, 55.7-0.95),
		To = vector3(1117.3, -3068.35, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org19'}
	},
	--ORG 20
	{
		From = vector3(1136.19, -2978.39, -98.0-0.99),
		To = vector3(1409.12, 3620.06, 34.89-0.95),
		Heading = 269.26,
		Visible = {'org20'}
	},
	{
		From = vector3(1409.12, 3620.06, 34.89-0.95),
		To = vector3(1136.19, -2978.39, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org20'}
	},
	--ORG 21
	{
		From = vector3(973.08, -3119.52, -98.0-0.99),
		To = vector3(2888.1, 4383.1, 50.3-0.95),
		Heading = 269.26,
		Visible = {'org21'}
	},
	{
		From = vector3(2888.1, 4383.1, 50.3-0.95),
		To = vector3(973.08, -3119.52, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org21'}
	},
	--ORG 22
	{
		From = vector3(1205.11, -3229.03, -98.0-0.99),
		To = vector3(2934.44, 4631.88, 48.54-0.95),
		Heading = 269.26,
		Visible = {'org22'}
	},
	{
		From = vector3(2934.44, 4631.88, 48.54-0.95),
		To = vector3(1205.11, -3229.03, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org22'}
	},
	--ORG 23
	{
		From = vector3(1074.91, -1515.28, -98.0-0.99),
		To = vector3(2465.08, 4100.46, 38.06-0.95),
		Heading = 269.26,
		Visible = {'org23'}
	},
	{
		From = vector3(2465.08, 4100.46, 38.06-0.95),
		To = vector3(1074.91, -1515.28, -98.0-0.99),
		Heading = 269.26,
		Visible = {'org23'}
	},
}


Config.Lifts = {
	{
		{
			Coords = vector3(335.76, -580.37, 28.9),
			Label = "Piętro 1",
			Heading = 164.97,
		},
		{
			Coords = vector3(-3135.76, -580.37, 43.29),
			Label = "Piętro 4",
			Heading = 335.33,
		},
		{
			Coords = vector3(335.76, -580.39, 48.24),
			Label = "Piętro 5",
			Heading = 164.97,
		},
		{
			Coords = vector3(335.76, -580.37, 74.07),
			Label = "Piętro 10",
			Heading = 164.97,
		},
	},
	{
		{
			Coords = vector3(332.38, -595.69, 43.28),
			Label = "Piętro 1",
			Heading = 164.97,
			custom = true
		},
		{
			Coords = vector3(338.89, -583.84, 74.28),
			Label = "Piętro 4",
			Heading = 335.33,
			custom = true
		}
	},
	{
		{
			Coords = vector3(-442.207, -343.2074, 35.0552),
			Label = "Lobby - Recepcja",
			Heading = 164.97
		},
		{
			Coords = vector3(-441.8999, -341.8568, 42.4813),
			Label = "I Piętro",
			Heading = 335.33
		}
	},
	{
		{
			Coords = vector3(-1215.897 , -204.1510, 39.3251),
			Label = "Recepcja",
			Heading = 62.8135,
			custom = true,
		},	

		{
			Coords = vector3(-1203.1069335938, -190.87379455566, 47.79),
			Label = "Piętro 1",
			Heading = 169.59108,
			custom = true,
		},	

		{
			Coords = vector3(-1203.1069335938, -190.87379455566, 51.79),
			Label = "Piętro 2",
			Heading = 169.59108,
			custom = true,
		},	

		{
			Coords = vector3(-1203.1069335938, -190.87379455566, 55.791 ),
			Label = "Piętro 3",
			Heading = 169.4608,
			custom = true,
		},	

		{
			Coords = vector3(-1203.1069335938, -190.87379455566, 59.79),
			Label = "Piętro 4",
			Heading = 169.4608,
			custom = true,
		},	

		{
			Coords = vector3(-1203.1069335938, -190.87379455566, 63.79),
			Label = "Piętro 5",
			Heading = 169.4608,
			custom = true,
		},	

		{
			Coords = vector3(-1203.1069335938, -190.87379455566, 67.79),
			Label = "Piętro 6",
			Heading = 169.4608,
			custom = true,
		},	

		{
			Coords = vector3(-1203.1069335938,-190.87379455566, 71.79),
			Label = "Piętro 7",
			Heading = 169.4608,
			custom = true,
		},	
	},
	{
		{
			Coords = vector3(-419.2288, -344.8389, 24.281),
			Label = "Parking",
			Heading = 108.46
		},
		{
			Coords = vector3(-436.0229, -359.6152, 34.99),
			Label = "Lobby - Recepcja",
			Heading = 350.41
		},
		{
			Coords = vector3(-490.5791, -327.4872, 69.55),
			Label = "II Piętro",
			Heading = 166.54
		}
	},
	{
		{
			Coords = vector3(511.08, 23.93, 69.49),
			Label = "Parking",
			Heading = 121.6,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(598.53, -22.11, 90.65),
			Label = "II Piętro",
			Heading = 335.33,
			Allow = {['police'] = true, ['ambulance'] = true}
		}
	},
	{
		{
			Coords = vector3(-1096.04, -850.57, 38.24),
			Label = "Dach",
			Heading = 35.81,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1096.04, -850.57, 34.36),
			Label = "Biuro szefa (V piętro)",
			Heading = 35.81,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1096.04, -850.57, 30.76),
			Label = "Biuro operacyjne (IV piętro)",
			Heading = 35.81,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1096.04, -850.57, 26.82),
			Label = "Siłownia (III piętro)",
			Heading = 35.81,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1096.04, -850.57, 23.03),
			Label = "Kawiarnia (II piętro)",
			Heading = 35.81,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1096.04, -850.57, 19.0),
			Label = "Lobby (I piętro)",
			Heading = 35.81,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1096.04, -850.57, 13.69),
			Label = "Szatnia (-III Piętro)",
			Heading = 35.81,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1096.04, -850.57, 10.28),
			Label = "Laboratorium (-II Piętro)",
			Heading = 35.81,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1096.04, -850.57, 4.88),
			Label = "Garaż dolny (-I Piętro)",
			Heading = 35.81,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
	},
	{
		{
			Coords = vector3(-1065.99, -833.78, 27.04),
			Label = "Siłownia (III Piętro)",
			Heading = 34.19,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1065.99, -833.78, 19.03),
			Label = "Lobby (I Piętro)",
			Heading = 34.19,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1065.99, -833.78, 14.88),
			Label = "Szatnia (-III Piętro)",
			Heading = 34.19,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1065.99, -833.78, 11.04),
			Label = "Zbrojownia (-II Piętro)",
			Heading = 34.19,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
		{
			Coords = vector3(-1065.99, -833.78, 5.48),
			Label = "Cele (-I Piętro)",
			Heading = 34.19,
			Allow = {['police'] = true, ['ambulance'] = true}
		},
	},
}

