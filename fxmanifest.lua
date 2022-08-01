fx_version("cerulean")
lua54('yes')
game("gta5")
author("Csoki")

dependency("es_extended")
dependency("oxmysql")

shared_script("@es_extended/imports.lua")
server_script("@oxmysql/lib/MySQL.lua")

shared_script("shared.lua")

client_script({
	"utils.lua",
	"client.lua",
})

server_script("server.lua")

files({
	'assets/*'
})