if onServer() then

function initialize()
	local player = Player()
	local x, y = Sector():getCoordinates()
	local hasConsent = false

	-- Check stations if there is a friendly or own station.
	for _,station in pairs({Sector():getEntitiesByType(EntityType.Station)}) do
		if station.factionIndex == player.index then
			hasConsent = true
			break
		end
		local stationOwner = Faction(station.factionIndex)
		-- "friendly" relation starts somewhere there
		if stationOwner:getRelations(player.index) >= 5000 then
			hasConsent = true
			break
		end
	end

	-- Change home sector
	if hasConsent then
		player:setHomeSectorCoordinates(x, y)
		player:sendChatMessage("Server", 0, "Home sector has been set to the current sector.")
	else
		player:sendChatMessage("Server", 0, "There is no friendly or own station present in the current sector, can't change home sector.")
	end
	terminate()
end

end
