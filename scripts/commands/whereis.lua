package.path = package.path .. ";data/scripts/lib/cmd/?.lua"
require "common"

function execute(sender, commandName, otherPlayerName, ...)
	local requestor = Player(sender)
	local wantedPlayer, err = findPlayer(otherPlayerName)
	if wantedPlayer then
		-- Push the applicable scripts to the clients.
		wantedPlayer:addScriptOnce("cmd/tellposition.lua", requestor.index)
		requestor:addScriptOnce("cmd/whereis.lua", wantedPlayer.index)
	else
		requestor:sendChatMessage("Server", 0, err)
	end
	
	return 0, "", ""
end

function getDescription()
	return "Gets the current positon of a player."
end

function getHelp()
	return "Gets the position of a player. Usage: /whereis <name>"
end
