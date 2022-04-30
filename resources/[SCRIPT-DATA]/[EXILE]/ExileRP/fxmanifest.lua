fx_version "bodacious"
games {"gta5"}
lua54 'yes'

client_scripts {
	'client/*.lua',
	'scripts/**/client.lua',
}

server_scripts {
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
	'scripts/**/server.lua'
}

files {
	'data/mapzoomdata.meta',
	'data/pausemenu.xml'
}

exports {
	'DisplayingStreet',
	'DisableEffects',
	'EnableEffects',
	'isPlayerProne',
	'DrawProcent',
	'SetBlip',
	'WybijBlachyMenu',
	'blip_info',
}