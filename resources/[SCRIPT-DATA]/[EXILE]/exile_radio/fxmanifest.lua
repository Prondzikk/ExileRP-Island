fx_version 'cerulean'
games { 'gta5' }

client_scripts {
    "config.lua",
    "utils/client.lua",
    "client/*.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",

    "config.lua",
    "utils/server.lua",
    "server/*.lua",
}

dependencies {
    'xsound'
}

shared_script '@es_extended/imports.lua'

ui_page "html/index.html"

files {
	"html/*.html",
	"html/scripts/*.js",
	"html/css/*.css",
	"html/css/img/*.png",
}
