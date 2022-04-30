fx_version 'cerulean'
game 'gta5'

author 'k0sseK'

client_scripts {
   '@es_extended/locale.lua',
   'config.lua',
   'client/zones.lua',
   'client/airdrops.lua',
   'client/utils.lua'
}

server_scripts {
   '@oxmysql/lib/MySQL.lua',
   '@es_extended/locale.lua',
   'config.lua',
   'server/server.lua',
}

dependencies {
	'cron'
}