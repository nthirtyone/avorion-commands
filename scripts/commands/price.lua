function execute(sender, commandName, ...)
	Player(sender):addScriptOnce("cmd/price.lua")
    return 0, "", ""
end

function getDescription()
    return "Prints price of currently boarded ship."
end

function getHelp()
    return "Prints price of currently boarded ship. Usage: /price"
end
