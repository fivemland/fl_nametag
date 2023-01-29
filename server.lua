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
		if xPlayer then
			playerNames[tonumber(player)] = xPlayer.getName()
		end
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

RegisterNetEvent("requestPlayerNames", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	playerNames[source] = xPlayer.getName()
	if not joinTimes[source] then
		joinTimes[source] = getPlayerFirstJoin(source)
	end

	TriggerClientEvent("receivePlayerNames", -1, playerNames, joinTimes)
end)

CreateThread(function()
	Wait(1000)

	for _, xPlayer in pairs(ESX.GetExtendedPlayers()) do
		playerNames[xPlayer.source] = xPlayer.getName()

		if not joinTimes[xPlayer.source] then
			joinTimes[xPlayer.source] = getPlayerFirstJoin(xPlayer.source)
		end
	end

	TriggerClientEvent("receivePlayerNames", -1, playerNames, joinTimes)
end)

AddEventHandler("esx:playerLoaded", function(player, xPlayer)
	playerNames[player] = xPlayer.getName()

	if not joinTimes[player] then
		joinTimes[player] = getPlayerFirstJoin(player)
	end

	TriggerClientEvent("receivePlayerNames", -1, playerNames, joinTimes)
end)

RegisterCommand("changename", function(player, args, cmd)
	if player == 0 then
		return
	end

	local xPlayer = ESX.GetPlayerFromId(player)
	if not xPlayer or not ADMIN_RANKS[xPlayer.getGroup()] then
		return output("You do not have permission", player)
	end

	if #args < 2 then
		return output("/changename [targetId] [new name]", player)
	end

	local xTarget = ESX.GetPlayerFromId(args[1])
	if not xTarget then
		return output("Player not found!", player)
	end

	table.remove(args, 1)

	local oldName = xTarget.getName()
	local newName = table.concat(args, " ")
	local firstname, lastname = string.match(newName, "(.*)% (.*)")
	if newName:len() < 10 or not firstname or not lastname then
		return output("New name invalid!", player)
	end

	local exists = MySQL.scalar.await(
		"SELECT COUNT(1) FROM users WHERE firstname = ? AND lastname = ?",
		{ firstname, lastname }
	)
	if exists and exists == 1 then
		return output("Name is already in use!", player)
	end

	xTarget.setName(newName)
	exports.oxmysql:update(
		"UPDATE users SET firstname = ?, lastname = ? WHERE identifier = ?",
		{ firstname, lastname, xTarget.identifier }
	)

	playerNames[xTarget.source] = newName
	TriggerClientEvent("receivePlayerNames", -1, playerNames, joinTimes)

	output("Player name updated! old name: " .. oldName .. " new name: " .. newName, player)
	output(GetPlayerName(player) .. " has updated your name. New name: " .. newName, xTarget.source)
end, false)
