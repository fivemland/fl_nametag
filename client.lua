local playerNames = {}
local newbiePlayers = {}
local streamedPlayers = {}
local nameThread = false
local myName = true

local localPed = nil

local txd = CreateRuntimeTxd("adminsystem")
local tx = CreateRuntimeTextureFromImage(txd, "logo", "assets/logo.png")

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

AddEventHandler("esx_skin:playerRegistered", function()
	Wait(1000)
	TriggerServerEvent("requestPlayerNames")
end)

RegisterNetEvent("receivePlayerNames", function(names, newbies)
	playerNames = names
	newbiePlayers = newbies
end)

function playerStreamer()
	local adminPanel <const> = GetResourceState(ADMINPANEL_SCRIPT) == "started"

	while true do
		streamedPlayers = {}

		localPed = PlayerPedId()
		local localCoords <const> = GetEntityCoords(localPed)
		local localId <const> = PlayerId()

		for _, player in pairs(GetActivePlayers()) do
			local playerPed <const> = GetPlayerPed(player)

			if player == localId and myName or player ~= localId then
				if DoesEntityExist(playerPed) and HasEntityClearLosToEntity(localPed, playerPed, 17) then
					local playerCoords = GetEntityCoords(playerPed)
					if IsSphereVisible(playerCoords, 0.0099999998) then
						local distance <const> = #(localCoords - playerCoords)

						local serverId <const> = tonumber(GetPlayerServerId(player))
						if distance <= STREAM_DISTANCE and playerNames[serverId] then
							local adminDuty = adminPanel and exports[ADMINPANEL_SCRIPT]:isPlayerInAdminduty(serverId)

							streamedPlayers[serverId] = {
								playerId = player,
								ped = playerPed,
								label = (adminDuty and GetPlayerName(player) .. ' <font color="' .. ADMIN_COLOR .. '">(Admin)</font>' or (playerNames[serverId] or "")) .. " (" .. serverId .. ")",
								newbie = isNewbie(serverId),
								talking = MumbleIsPlayerTalking(player) or NetworkIsPlayerTalking(player),
								adminDuty = adminDuty
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
		local myCoords <const> = GetEntityCoords(localPed)

		for serverId, playerData in pairs(streamedPlayers) do
			local coords <const> = getPedHeadCoords(playerData.ped)

			local dist <const> = #(coords - myCoords)
			local scale <const> = 1 - dist / STREAM_DISTANCE

			if scale > 0 then
				local newbieVisible <const> = (playerData.newbie and not playerData.adminDuty)

				DrawText3D(coords, {
					{ text = playerData.label, color = { 255, 255, 255 } },
					newbieVisible and {
						text = NEWBIE_TEXT,
						pos = { 0, -0.017 },
						color = { 255, 150, 0 },
						scale = 0.25,
					} or nil,
					playerData.talking and {
						text = SPEAK_ICON,
						pos = { 0, 0.025 },
						scale = 0.4,
					} or nil,
				}, scale, 200 * scale)

				if ADMINLOGO.visible and playerData.adminDuty then 
					DrawMarker(
						43,
						coords + vector3(0, 0, 0.15),
						vector3(0, 0, 0),
						vector3(89.9, 180, 0),
						vector3(scale * ADMINLOGO.size, scale * ADMINLOGO.size, 0),
						255,
						255,
						255,
						255,
						false, --up-down anim
						true, --face cam
						0,
						ADMINLOGO.rotate, --rotate
						"adminsystem",
						"logo",
						false --[[drawon ents]]
					)
				end
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
