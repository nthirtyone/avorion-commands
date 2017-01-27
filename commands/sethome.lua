function execute(sender, commandName, ...)
	local player = Player(sender)
   	player:addScriptOnce("sethome.lua")
   	player:sendChatMessage("Server", 0, "Home sector has been set to current sector.")
    return 0, "", ""
end

function getDescription()
    return "Sets players home in current sector."
end

function getHelp()
    return "Sets players home in current sector. Usage: /sethome"
end
