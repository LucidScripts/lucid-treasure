fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'


author 'Lucid Scripts'
description 'Treasure map script'
version '1.0.0'

client_scripts { 'bridge/**/client.lua', 'client/*.lua'}

server_scripts {'bridge/**/server.lua', 'server/*.lua',}

ui_page 'ui/index.html'

shared_scripts { '@ox_lib/init.lua', 'config.lua' }

files {
    'ui/index.html',
    'ui/styles.css',
    'ui/script.js',
    'ui/*',
    'ui/**/*'
}
