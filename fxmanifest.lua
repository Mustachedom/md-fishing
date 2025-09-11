name "mustache-fishing"
author "mustache_dom"
description "fishing by mustache dom"
fx_version "cerulean"
game "gta5"
version '3.0.0'

client_scripts {
	'client/**.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/**.lua',
}

shared_scripts {
    'config.lua',
}

files {
	'locales/**.lua',
}

lua54 'yes'


