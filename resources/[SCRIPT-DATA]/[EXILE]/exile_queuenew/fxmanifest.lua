fx_version 'adamant'
game 'gta5'

lua54 'yes'

client_script 'client.lua'

server_export 'GetRocadePlayers'

server_script { 
	'@oxmysql/lib/MySQL.lua',
	'adaptives.lua',
	'functions.lua',
	'server.lua',
}