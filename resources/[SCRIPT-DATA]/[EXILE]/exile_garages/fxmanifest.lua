fx_version 'bodacious'
lua54 'yes'
game 'gta5'

ui_page 'client/html/ui.html'

files {
	'client/html/ui.html',
	'client/html/play.ttf',
	'client/html/playb.ttf',
	'client/html/styles.css',
	'client/html/scripts.js',
	'client/html/debounce.min.js'
}

server_scripts {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/main.lua'
}

exports {
	'ImpoundVehicle',
	'OpenSellCarMenu'
}

