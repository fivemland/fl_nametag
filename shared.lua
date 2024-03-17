STREAM_DISTANCE = 40

NEWBIE_TIME = 60 * 60 --Seconds / Másodpercek
NEWBIE_TEXT = "** Új a városban **"

SPEAK_ICON = "🔊"

JOB_LABELS = true

ADMIN_RANKS = { --permission groups for /changename command
	["admin"] = true,
}


JOBS = {
	['police'] = "Rendörség",
	['ambulance'] = "Mentöszolgálat",
}

ADMINPANEL_SCRIPT = 'fl_adminpanel'
ADMIN_COLOR = "#7cc576"
ADMINLOGO = {
	visible = true,
	rotate = false,
	size = 0.3
}

JELVENY_COLOR = "FFF333"
JELVENY_COMMAND = "jelveny"


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
