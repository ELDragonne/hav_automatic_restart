-- PARTIE CONFIG --
local MapName = "rp_jedivssith" -- Map du serveur
local RestartTime = "06:00" -- Heures du reboot
local WarningsReboot = { -- Messages d'avertissement du reboot
	"60", -- 60 Minutes
	"45", -- 45 Minutes
	"30", -- 30 Minutes
	"15", -- 15 Minutes
	"10", -- 10 Minutes
	"5", -- 5 Minutes
	"1" -- 1 Minute
}

Hav_AutoRestart = {} -- Touche pas à ça

-- PARTIE SCRIPT --
timer.Create("Hav_Auto_Restart_Timer", 1, 0, function()
	Timestamp = os.time()
	TimeString = os.date( "%H:%M" , Timestamp )
	Hav_AutoRestart:CheckDay()
end)

local warningsdelay = 0
local restartdelay = 0
local PlurielS = ""
function Hav_AutoRestart:CheckDay()
	if CurTime() > 60 then
		if CurTime() >= warningsdelay then
			for k, v in pairs(WarningsReboot) do
				local WarningsTime = Timestamp - (60 * 60 * -(v/60))
				local WarningsTime = (os.date("%H:%M", WarningsTime))
				if tonumber(v) > 1 then PlurielS = "s" else PlurielS = "" end
				if RestartTime == WarningsTime then BroadcastLua("chat.AddText(Color(255,60,60), '[Redemarrage du Serveur] ', Color(255,255,255), 'Le serveur redémarre dans " .. v .. " Minute" .. PlurielS .. ", préparez-vous!' )") warningsdelay = CurTime() + 60 end
			end
		end

		if CurTime() >= restartdelay then
			if TimeString == RestartTime then
				if file.Exists("data/ulx/config.txt", "GAME") then
					game.ConsoleCommand("ulx map " .. MapName .. "\n")
				else
					game.ConsoleCommand("changelevel " .. MapName .. "\n")
				end
				restartdelay = CurTime() + 60
			end
		end
	end
end
