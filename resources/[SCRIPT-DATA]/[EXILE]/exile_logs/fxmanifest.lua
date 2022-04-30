fx_version "bodacious"
games {"gta5"}
lua54 'yes'

description 'Discord Bot By FluX'

server_script {						
	'@oxmysql/lib/MySQL.lua',
	'server/s_config.lua',
	'server/server.lua',
}

client_script {
	'client/weapons.lua',
	'client/client.lua',
}

server_exports {
	'discord'
}
