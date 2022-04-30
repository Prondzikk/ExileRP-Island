fx_version "cerulean"
games {"gta5"}
lua54 'yes'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
	'config.lua',
	'client.lua'
}

exports {
	'GeneratePlate',
	'getVehicles'
}

server_exports {
	'GetVehicle'
}