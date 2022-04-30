fx_version "bodacious"
games {"gta5"}

description 'Queue by FluX Kurwo jebana'

version '1.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/server.lua'
}

client_script 'client/client.lua'

server_export 'GetRocadePlayers'