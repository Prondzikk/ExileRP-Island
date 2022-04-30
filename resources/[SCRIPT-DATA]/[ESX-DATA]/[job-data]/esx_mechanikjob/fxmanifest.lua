fx_version 'bodacious'
lua54 'yes'
game 'gta5'

version '1.1.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/exile.lua',
	'config.lua',
	'client/main.lua',
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/exile.lua',
	'config.lua',
	'server/main.lua',
}

exports {
	'OpenMobileMecanoActionsMenu',
	'RepairEngine'
}








