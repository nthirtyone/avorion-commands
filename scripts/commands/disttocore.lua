function execute(sender, commandName, ...)
   	Player(sender):addScriptOnce("cmd/disttocore.lua")
    return 0, "", ""
end

function getDescription()
    return "Display distance to galaxy core from current sector."
end

function getHelp()
    return "Display distance to galaxy core from current sector. Usage: /disttocore"
end