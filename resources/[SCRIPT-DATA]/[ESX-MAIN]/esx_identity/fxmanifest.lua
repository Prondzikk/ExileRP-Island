fx_version 'adamant'
game 'gta5'

lua54 'yes'

description 'ESX Identity'

version '1.1.0'

server_scripts {
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/main.lua',
	'server/function.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'client/main.lua',
}

ui_page 'html/index.html'

files {
	'html/script.js',
	'html/index.html',
	'html/style.css',
	'html/bg.png'
}

dependency 'es_extended'