fx_version 'bodacious'

game 'gta5'

description ''

client_scripts {
    'shared/_global.lua',

    'client/lib/AmongUsClientConfig.lua',

    'client/_global.lua',
    'client/client-thread.lua',
    'client/render-thread.lua',
}

server_scripts {
    'shared/_global.lua',

    'server/lib/GameState.lua',

    'server/_global.lua',
    'server/game-thread.lua',
}
