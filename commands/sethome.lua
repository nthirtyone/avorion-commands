function execute(sender, commandName, ...)
   	Player(sender):addScriptOnce("cmd/sethome.lua")
    return 0, "", ""
end

function getDescription()
    return "Sets players home in current sector."
end

function getHelp()
    return "Sets players home in current sector. Usage: /sethome"
end
