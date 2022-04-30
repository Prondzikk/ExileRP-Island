fx_version "adamant"
game "gta5"
version "2.2.1"

dependencies {
	"mumble-voip",
}

client_scripts {
	"config.lua",
	"client.lua",
}

server_scripts {
	"server.lua",
}

files {
	"files/index.html",
	"files/on.ogg",
	"files/off.ogg",
}

ui_page "files/index.html"

