if onServer() then

function initialize(action, ...)
	local flag, msg = false, ""
	player = Player()
	if action == "fill" then
		local ship = Entity(Player().craftIndex)
		ship.crew = ship.minCrew
		ship:addCrew(1, CrewMan(CrewProfessionType.Captain))
		player:sendChatMessage("Crew", 0, "Minimal crew has boarded the ship!")
	elseif action == "add" then
		local ship = Entity(Player().craftIndex)
		flag, msg = addCrew(ship, ...)
		player:sendChatMessage("Crew", 0, msg)
	elseif action == "clear" then
		Entity(Player().craftIndex).crew = Crew()
		player:sendChatMessage("Crew", 0, "Current ship's crew has been cleared.")
	else
		player:sendChatMessage("Crew", 0, "Unknown action: "..action)
	end
	terminate()
end

function addCrew(ship, profession, amount)
	local amount = amount or 1
	local err
	profession, err = getProfession(profession)
	if profession then
		ship:addCrew(amount, CrewMan(profession))
		return true, string.format("%ix %s added.", amount, profession.name)
	end
	return false, err
end

professions =
{
	{function (str) return str:find("^[nN]on") end,  0, "None"},
	{function (str) return str:find("^[eE]ng") end,  1, "Engine"},
	{function (str) return str:find("^[gG]un") end,  2, "Gunner"},
	{function (str) return str:find("^[mM]in") end,  3, "Miner"},
	{function (str) return str:find("^[rR]ep") end,  4, "Repair"},
	{function (str) return str:find("^[pP]il") end,  5, "Pilot"},
	{function (str) return str:find("^[sS]ec") end,  6, "Security"},
	{function (str) return str:find("^[aA]tt") end,  7, "Attacker"},
	{function (str) return str:find("^[sS]er") end,  8, "Sergeant"},
	{function (str) return str:find("^[lL]ie") end,  9, "Lieutenant"},
	{function (str) return str:find("^[cC]om") end, 10, "Commander"},
	{function (str) return str:find("^[gG]en") end, 11, "General"},
	{function (str) return str:find("^[cC]ap") end, 12, "Captain"},
}

-- Identifies script from a string. No, this time only from a string.
function getProfession(p)
	local profession = checkTable(professions, p)
	if profession then
		return CrewProfession(profession)
	end
	return nil, string.format("Could not identify professionType: %s", s)
end

-- Searches table for patterns.
function checkTable(table, str)
	for _,item in pairs(table) do
		if item[1](str) then return item[2] end
	end
end

end
