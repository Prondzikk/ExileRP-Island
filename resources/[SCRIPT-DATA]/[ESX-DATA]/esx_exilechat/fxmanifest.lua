fx_version "bodacious"
games {"gta5"}
lua54 'yes'
description 'ESX RP Chat'
version '1.2.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locates/sv.lua',
	'locates/en.lua',
	'locates/fi.lua',
	'locates/fr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locates/sv.lua',
	'locates/en.lua',
	'locates/fi.lua',
	'locates/fr.lua',
	'config.lua',
	'client/main.lua'
}

server_exports {
	'getIdentity'
}
