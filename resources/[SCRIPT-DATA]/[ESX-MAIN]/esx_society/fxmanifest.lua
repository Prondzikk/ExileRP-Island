fx_version "bodacious"
games {"gta5"}
description 'ESX Society'

version '1.0.4'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/exile.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/exile.lua',
	'config.lua',
	'client/main.lua'
}