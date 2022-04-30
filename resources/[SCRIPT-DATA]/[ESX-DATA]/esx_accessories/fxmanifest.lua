fx_version 'bodacious'
lua54 'yes'
game 'gta5'

server_scripts {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
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

