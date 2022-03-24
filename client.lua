local playerNames = {}
local newbiePlayers = {}
local streamedPlayers = {}
local nameThread = false
local myName = true

local localPed = nil

RegisterCommand("togmyname", function()
	myName = not myName
end)

CreateThread(function()
	while not ESX.IsPlayerLoaded() do
		Wait(1)
	end

	Wait(1000)

	TriggerServerEvent("requestPlayerNames")

	CreateThread(playerStreamer)
end)

RegisterNetEvent("receivePlayerNames", function(names, newbies)
	playerNames = names
	newbiePlayers = newbies
end)

function playerStreamer()
	while true do
		streamedPlayers = {}

		localPed = PlayerPedId()
		local localCoords = GetEntityCoords(localPed)
		local localId = PlayerId()

		for _, player in pairs(GetActivePlayers()) do
			local playerPed = GetPlayerPed(player)

			if player == localId and myName or player ~= localId then
				if DoesEntityExist(playerPed) and HasEntityClearLosToEntity(localPed, playerPed, 17) then
					local playerCoords = GetEntityCoords(playerPed)
					if IsSphereVisible(playerCoords, 0.0099999998) then
						local distance = #(localCoords - playerCoords)

						local serverId = tonumber(GetPlayerServerId(player))
						if distance <= STREAM_DISTANCE and playerNames[serverId] then
							streamedPlayers[serverId] = {
								playerId = player,
								ped = playerPed,
								label = (playerNames[serverId] or "") .. " (" .. serverId .. ")",
								newbie = isNewbie(serverId),
								talking = MumbleIsPlayerTalking(player) or NetworkIsPlayerTalking(player),
							}
						end
					end
				end
			end
		end

		if next(streamedPlayers) and not nameThread then
			CreateThread(drawNames)
		end

		Wait(500)
	end
end

function drawNames()
	nameThread = true

	while next(streamedPlayers) do
		local myCoords = GetEntityCoords(localPed)

		for serverId, playerData in pairs(streamedPlayers) do
			local coords = getPedHeadCoords(playerData.ped)

			local dist = #(coords - myCoords)
			local scale = 1 - dist / STREAM_DISTANCE

			if scale > 0 then
				DrawText3D(coords, {
					{ text = playerData.label, color = { 255, 255, 255 } },
					playerData.newbie and {
						text = NEWBIE_TEXT,
						pos = { 0, -0.017 },
						color = { 255, 150, 0 },
						scale = 0.25,
					} or nil,
					playerData.talking and {
						text = SPEAK_ICON,
						pos = { 0, -0.05 },
						scale = 0.4,
					} or nil,
				}, scale, 200 * scale)
			end
		end

		Wait(0)
	end

	nameThread = false
end

function isNewbie(serverId)
	return (newbiePlayers[serverId] or 0) + NEWBIE_TIME > GetCloudTimeAsInt()
end

function setMyNameVisible(state)
	myName = state
end
exports("setMyNameVisible", setMyNameVisible)

function getMyNameVisible()
	return myName
end
exports("getMyNameVisible", getMyNameVisible)
