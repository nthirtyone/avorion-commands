if onServer() then

function initialize()
	player = Player()
	local distanceFromCenter = length(vec2(Sector():getCoordinates()))
	player:sendChatMessage("Server", 0, "Distance from core : "..math.ceil(distanceFromCenter*10)*.1)
	terminate()
end

end