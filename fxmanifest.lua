-- FXVersion Version
fx_version 'adamant'
games {"rdr3","gta5"}
name 'SHM-Sounds'
description 'A resource for handling sounds in SHM-Sounds'
version '1.0.1'
author 'SkyHigh Modifications'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

shared_scripts {
    'config.lua',
}

ui_page 'html/index.html'

-- Files needed for NUI
-- DON'T FORGET TO ADD THE SOUND FILES TO THIS!
files {
    'html/index.html',
 -- 'html/sounds/demo.ogg', (.ogg | .mp3)
    'html/sounds/demo.ogg'
    -- Add other sound files here...
}
