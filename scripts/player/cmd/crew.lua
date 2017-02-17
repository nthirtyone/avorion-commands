if onServer() then
package.path = package.path .. ";data/scripts/lib/cmd/?.lua"
require "common"
professions = require "professions"

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

-- Identifies script from a string. No, this time only from a string.
function getProfession(p)
	local profession = findString(professions, p)
	if profession then
		return CrewProfession(profession)
	end
	return nil, string.format("Could not identify professionType: %s", s)
end

end
