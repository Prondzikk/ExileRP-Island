fx_version 'adamant'

game 'gta5'

description 'ESX ClotheShop'

version '1.0.0'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/pl.lua',
    'config.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/pl.lua',
    'config.lua',
    'client/main.lua'
}

