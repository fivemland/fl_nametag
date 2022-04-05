STREAM_DISTANCE = 40

NEWBIE_TIME = 60 * 60 --Seconds / Másodpercek
NEWBIE_TEXT = "** Új a városban **"

SPEAK_ICON = "🔊"

ADMIN_RANKS = {
	["admin"] = true,
}

function output(text, target)
	if IsDuplicityVersion() then --Server Side
		TriggerClientEvent("chat:addMessage", target or -1, {
			color = { 255, 0, 0 },
			multiline = true,
			args = { "Server", text },
		})
	else
		TriggerEvent("chat:addMessage", {
			color = { 255, 0, 0 },
			multiline = true,
			args = { "Server", text },
		})
	end
end
