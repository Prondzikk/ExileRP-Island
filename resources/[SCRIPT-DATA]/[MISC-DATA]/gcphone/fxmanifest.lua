fx_version 'bodacious'
lua54 'yes'
game 'gta5'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/static/css/app.css',
	'html/static/js/app.js',
	'html/static/js/manifest.js',
	'html/static/js/vendor.js',

	'html/static/config/config.json',

	-- Coque
	'html/static/img/coque/s8.png',
	'html/static/img/coque/iphonex.png',
	'html/static/img/coque/huawei.png',
	'html/static/img/coque/iphone5s.png',

	-- Background
	'html/static/img/background/*.png',
	'html/static/img/background/*.jpg',

	'html/static/img/icons_app/*.png',

	'html/static/img/app_bank/logo_mazebank.jpg',

	'html/static/img/app_tchat/splashtchat.png',

	'html/static/img/twitter/bird.png',
	'html/static/img/twitter/default_profile.png',
	'html/static/sound/Twitter_Sound_Effect.ogg',

	'html/static/img/courbure.png',
	'html/static/fonts/fontawesome-webfont.ttf',
	'html/static/fonts/fontawesome-webfont.svg',
	
	'html/static/sound/ring.ogg',
	'html/static/sound/tchatNotification.ogg',
	'html/static/sound/Phone_Call_Sound_Effect.ogg',
}

client_script {
	"@es_extended/locale.lua",
	"locales/en.lua",
	"locales/es.lua",
	"config.lua",
	"client/animation.lua",
	"client/client.lua",
	"client/photo.lua",
	"client/app_tchat.lua",
	"client/bank.lua",
	"client/twitter.lua",
	"client/addon.lua",
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	"@es_extended/locale.lua",
	"locales/en.lua",
	"locales/es.lua",
	"config.lua",
	"server/server.lua",
	"server/app_tchat.lua",
	"server/twitter.lua",
	"server/addon.lua",
}

exports {
	'DisplayingStreet',
	'PhoneIsOpened',
	'menuIsOpen',
	'TooglePhone',
	'getMenuIsOpen'
 }
 