fx_version 'cerulean'
game 'gta5'

author 'Vice Studios'
description 'Custom notification system'
version 'v1.1.3'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
    'html/assets/**.**'
}

shared_script 'config.lua'

client_scripts {
    'client/client.lua'
}

server_script {
    'server/update_check.lua'
}

exports {
    'notify'
}
