local playerNames = {}
local joinTimes = {}

CreateThread(function()
	local result = MySQL.query.await("SHOW COLUMNS FROM `users` LIKE 'firstJoin'")
	if not result or #result <= 0 then
		MySQL.query([[
      ALTER TABLE `users`
      ADD COLUMN `firstJoin` INT(11) NULL DEFAULT UNIX_TIMESTAMP()
    ]])
	end

	for _, player in pairs(GetPlayers()) do
		local xPlayer = ESX.GetPlayerFromId(player)

		playerNames[tonumber(player)] = xPlayer.getName()
	end
end)

function getPlayerFirstJoin(player)
	local xPlayer = ESX.GetPlayerFromId(player)
	if not xPlayer then
		return
	end

	local result = MySQL.query.await("SELECT firstJoin FROM users WHERE identifier = ?", { xPlayer.identifier })
	return (result and #result > 0) and result[1].firstJoin or 0
end
exports("getPlayerFirstJoin", getPlayerFirstJoin)

function updateNametag(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	playerNames[playerId] = xPlayer.getName()
	if not joinTimes[playerId] then
		joinTimes[playerId] = getPlayerFirstJoin(playerId)
	end

	TriggerClientEvent("receivePlayerNames", -1, playerNames, joinTimes)
end

RegisterNetEvent("requestPlayerNames", function()
	updateNametag(source)
end)

AddEventHandler("esx_identity:characterUpdated", function(playerId)
	Wait(1000)
	updateNametag(playerId)
end)
