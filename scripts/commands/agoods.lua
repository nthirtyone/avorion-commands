function execute(sender, commandName, action, ...)
   	Player(sender):addScriptOnce("cmd/agoods.lua", action, ...)
    return 0, "", ""
end

function getDescription()
    return "Adds goods to currently boarded ship."
end

function getHelp()
    return "Adds goods currently boarded ship. Usage:\n/agoods <good name with _(underscore) instead of spaces> <quantity>"
end
