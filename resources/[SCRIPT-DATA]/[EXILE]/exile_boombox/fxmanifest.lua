fx_version 'bodacious'
lua54 'yes'
game 'gta5'

server_scripts {
    '@es_extended/locale.lua',
    'locales/exile.lua',
    'server/main.lua',
    'config.lua'
}

client_script {
    '@es_extended/locale.lua',
    'client/main.lua',
    'locales/exile.lua',
    'config.lua'
}

ui_page('html/index.html')

files {
    'html/index.html',
    'html/app.js'
}