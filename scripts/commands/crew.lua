function execute(sender, commandName, action, ...)
   	Player(sender):addScriptOnce("cmd/crew.lua", getHelp(), action, ...)
    return 0, "", ""
end

function getDescription()
    return "Adds or removes crew to currently boarded ship."
end

function getHelp()
    return "Adds or removes crew to currently boarded ship. Usage:\n/crew help\n/crew add <profession> [rank] [level] [amount]\n/crew fill\n/crew clear"
end
