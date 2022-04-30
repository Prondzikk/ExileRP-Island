fx_version 'bodacious'
lua54 'yes'
game 'gta5'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/**.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/**.lua',
	'config.lua',
	'client/**.lua',
	'okup/**.lua',
	'10-13/**.lua',
}

exports { 
	'IsCuffed',
	'OpenPoliceActionsMenu',
	'HandcuffMenu'
}