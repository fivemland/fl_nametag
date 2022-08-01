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
		EndTextCommandDisplayText(x or 0, y or 0)
	end

	ClearDrawOrigin()
end

function getPedHeadCoords(ped)
	local coords = GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, 31086))
	coords = coords == vector3(0, 0, 0) and GetEntityCoords(ped) + vector3(0, 0, 0.9) or coords + vector3(0, 0, 0.3)

	local frameTime <const> = GetFrameTime()
	local vel <const> = GetEntityVelocity(ped)

	coords = vector3(coords.x + vel.x * frameTime, coords.y + vel.y * frameTime, coords.z + vel.z * frameTime)

	return coords
end
