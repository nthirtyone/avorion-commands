if onServer() then

function initialize()
	player = Player()

	-- Check if the player meets the requirements.
	local hasConsent = true
	local x, y = Sector():getCoordinates()
	local faction = Galaxy():getControllingFaction(x, y) or Galaxy():getLocalFaction(x, y) or Galaxy():getNearestFaction(x, y)
	local factionHomeX, factionHomeY = faction:getHomeSectorCoordinates()

	if x ~= factionHomeX or y ~= factionHomeY then
		if hasConsent then player:sendChatMessage("Server", 0, "You can only do that in a home sector.") end
		hasConsent = false
	end
	if faction:getRelations(player.index) < 15000 then
		if hasConsent then player:sendChatMessage("Server", 0, string.format("Your standing is too low with: %s", faction.name)) end
		hasConsent = false
	end

	-- Now come exceptions:
	for _, station in pairs({Sector():getEntitiesByType(EntityType.Station)}) do
		if station.factionIndex == player.index then
			player:sendChatMessage("Server", 0, "Your own station is here, which takes precedence.")
			hasConsent = true
			break
		end
		if station.title == "Resistance Outpost"%_t then
			player:sendChatMessage("Server", 0, "But yes, the resistance will give you shelter.")
			hasConsent = true
			break
		end
		local stationOwner = Faction(station.factionIndex)
		if stationOwner.isPlayer and stationOwner:getRelations(player.index) >= 15000 then
			player:sendChatMessage("Server", 0, "Your friend's station is here, which heals that.")
			hasConsent = true
			break
		end
	end

	-- Do the actual work.
	if hasConsent then
		player:setHomeSectorCoordinates(Sector():getCoordinates())
		player:sendChatMessage("Server", 0, "Home sector has been set to current sector.")
	end
	terminate()
end

end
