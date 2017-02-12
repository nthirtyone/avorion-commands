if onServer() then

function initialize()
	player = Player()
	player:setHomeSectorCoordinates(Sector():getCoordinates())
	player:sendChatMessage("Server", 0, "Home sector has been set to current sector.")
	terminate()
end

end
