function execute(sender, commandName, action, ...)
   	Player(sender):addScriptOnce("cmd/crew.lua", action, ...)
    return 0, "", ""
end

function getDescription()
    return "Adds or removes crew to currently boarded ship."
end

function getHelp()
    return "Adds or removes crew to currently boarded ship. Usage:\n/crew <fill|clear|add>\n/crew add <profession> [amount]"
end
