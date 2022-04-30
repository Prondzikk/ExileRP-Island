fx_version 'bodacious'
lua54 'yes'
game 'gta5'

client_scripts {
	'@es_extended/locale.lua',
	'locales/exile.lua',
    'client/client.lua',
    'config.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'locales/exile.lua',
	'server/server.lua',
	'config.lua'
}
