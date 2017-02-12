function execute(sender, commandName, otherPlayerName, ...)
	local requestor = Player(sender)

	-- Figure out the index number of the wanted player.
	local wantedFaction = Galaxy():findFaction(otherPlayerName)
	if not wantedFaction then
		-- Players have indices starting from 1. Their list ends with wantedFaction === nil.
		local i = 0
		repeat
			i = i + 1
			wantedFaction = Galaxy():findFaction(i)
			if wantedFaction and wantedFaction.name == otherPlayerName then break end
		until not wantedFaction
	end
	if not wantedFaction then
		requestor:sendChatMessage("Server", 0, "Cannot find this player. (1)")
		return 0, "", ""
	end
	-- We have an index! For the unlikely case that it's no player:
	local wantedPlayer = Player(wantedFaction.index)
	if not wantedPlayer then
		requestor:sendChatMessage("Server", 0, "Cannot find this player. (2)")
		return 0, "", ""
	end

	-- Push the applicable scripts to the clients.
	wantedPlayer:addScriptOnce("cmd/tellposition.lua", requestor.index)
	requestor:addScriptOnce("cmd/whereis.lua", wantedPlayer.index)
	
	return 0, "", ""
end

function getDescription()
	return "Gets the current positon of a player."
end

function getHelp()
	return "Gets the position of a player. Usage: /whereis <name>"
end
