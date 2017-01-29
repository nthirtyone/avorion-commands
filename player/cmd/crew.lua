if onServer() then

function initialize(action)
	player = Player()
	if action == "fill" then
		local ship = Entity(Player().craftIndex)
		ship.crew = ship.minCrew
		ship:addCrew(1, CrewMan(CrewProfessionType.Captain))
		player:sendChatMessage("Server", 0, "Minimal crew has boarded the ship!")
	elseif action == "clear" then
		Entity(Player().craftIndex).crew = Crew()
		player:sendChatMessage("Server", 0, "Current ship's crew has been cleared.")
	else
		player:sendChatMessage("Server", 0, "Unknown action: "..action)
	end
	terminate()
end

end
