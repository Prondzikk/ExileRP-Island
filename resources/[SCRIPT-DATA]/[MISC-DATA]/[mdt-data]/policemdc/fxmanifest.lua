fx_version 'bodacious'
lua54 'yes'
game 'gta5'

ui_page('client/html/index.html')

server_scripts {
	'config.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/server.lua'
}

client_scripts {
	'config.lua',
	'client/client.lua'
}

files {
	'client/html/index.html',
    'client/html/css/chunk-*.css',
    'client/html/js/chunk-*.js',
    'client/html/css/app.css',
    'client/html/js/app.js',
    'client/html/img/citizen-image-placeholder.png',
    'client/html/img/example-image.jpg',
    'client/html/img/*.png',
	'client/html/configs/config.json'
} 