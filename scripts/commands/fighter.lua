function execute(sender, commandName, action, ...)
	Player(sender):addScriptOnce("cmd/fighter.lua", action, ...)
	return 0, "", ""
end

function getDescription()
	return "Adds fighters to players hangar."
end

function getHelp()
	return "Adds fighters to players hangar. Usage:\n/fighter add <weapon> [rarity] [material] [tech]\n"
end
