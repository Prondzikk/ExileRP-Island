fx_version 'adamant'
lua54 'yes'
game 'gta5'

description 'ESX Car Wash'

version '1.0.0'

server_scripts {
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

dependency 'es_extended'

