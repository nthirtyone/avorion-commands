function execute(sender, commandName, ...)
   	Player(sender):addScriptOnce("cmd/sethome.lua")
    return 0, "", ""
end

function getDescription()
    return "Allows player to change home sector to current if friendly or own station is present."
end

function getHelp()
    return "Allows player to change home sector to current if friendly or own station is present. Usage: /sethome"
end
