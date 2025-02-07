fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'A \"social housing\" script created mainly for italian crime-based roleplay servers.'
author 'https://github.com/Trickwire-Labs/'
version '1.0.0'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*'

}

client_scripts {
  'client/*'
}

shared_scripts {
  'shared/*',
  '@es_extended/imports.lua',
  '@ox_lib/init.lua'
}