function DrawText3D(coords, text, text2, scale, r, g, b, alpha)
	scale = scale or 1

	r = r or 255
	g = g or 255
	b = b or 255

	SetDrawOrigin(coords)

	SetTextScale(0.3 * scale, 0.3 * scale)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(r, g, b, math.floor(alpha))
	SetTextOutline()
	SetTextCentre(1)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentString(text)
	EndTextCommandDisplayText(0, 0)

	if text2 then
		SetTextScale(0.25 * scale, 0.25 * scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 150, 0, math.floor(alpha))
		SetTextOutline()
		SetTextCentre(1)

		BeginTextCommandDisplayText("STRING")
		AddTextComponentString(text2)
		EndTextCommandDisplayText(0, -0.015)
	end

	ClearDrawOrigin()
end

function getPedHeadCoords(ped)
	local coords = GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, 31086))
	if coords == vector3(0, 0, 0) then
		coords = GetEntityCoords(ped) + vector3(0, 0, 0.9)
	else
		coords = coords + vector3(0, 0, 0.3)
	end

	local frameTime = GetFrameTime()
	local vel = GetEntityVelocity(ped)

	coords = vector3(coords.x + vel.x * frameTime, coords.y + vel.y * frameTime, coords.z + vel.z * frameTime)

	return coords
end
