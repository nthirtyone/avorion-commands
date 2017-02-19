if onServer() then

function initialize(otherPlayerIndex)
	local requestor = Player()
	local wanted = Player(otherPlayerIndex)

	if wanted then
		local hx, hy = wanted:getHomeSectorCoordinates()
		requestor:sendChatMessage("Server", 0, "His or her home sector is \\s(%i:%i).", hx, hy)
	else
		requestor:sendChatMessage("Server", 0, "Cannot find this player.")
	end
	terminate()
end

end

