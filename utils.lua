function DrawText3D(coords, texts, scale, alpha)
	scale = scale or 1

	SetDrawOrigin(coords)

	for _, text in pairs(texts) do
		SetTextScale((text.scale or 0.3) * scale, (text.scale or 0.3) * scale)
		SetTextFont(0)

		local r, g, b = table.unpack(text.color or { 255, 255, 255, alpha })
		r = r or 255
		g = g or 255
		b = b or 255

		SetTextWrap(0.0, 1.0)
		SetTextColour(r, g, b, math.floor(alpha))
		SetTextOutline()
		SetTextCentre(1)
		BeginTextCommandDisplayText("STRING")
		AddTextComponentString(text.text)

		local x, y = table.unpack(text.pos or { 0, 0 })
		x = x or 0
		y = y or 0
		EndTextCommandDisplayText(x, y)
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
