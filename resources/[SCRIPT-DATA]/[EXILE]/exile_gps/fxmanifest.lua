fx_version 'adamant'
games { 'gta5' }
lua54 'yes'
client_script 'config.lua'
client_script 'client/main.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/main.lua'
}
