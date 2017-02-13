package.path = package.path .. ";data/scripts/lib/cmd/?.lua"
require "common"
lists = -- this is a list of lists, kek
{
	{function (str) return str:find("^[pP]ro") end, require("professions"), "Professions"},
	{function (str) return str:find("^[rR]an") end, require("ranks"), "Ranks"},
	{function (str) return str:find("^[mM]at") end, require("materials"), "Materials"},
	{function (str) return str:find("^[rR]ar") end, require("rarities"), "Rarities"},
	{function (str) return str:find("^[uU]pg") end, require("upgrades"), "Upgrades"},
	{function (str) return str:find("^[wW]ea") end, require("weapons"), "Weapons"}
}

function execute(sender, commandName, name, ...)
	local player = Player(sender)
	local msg = "You can't see this message. (An error)"
	if name then
		-- if name is present look for a type
		local list = findString(lists, name)
		if list then 
			_,msg = printAvailable(list)
		else
			msg = string.format("Type %s has not been found.", name)
		end
	else
		-- print all if no name present
		_,msg = printAvailable(lists)
	end
	player:sendChatMessage("List", 0, msg)
	return 0, "", ""
end

function printAvailable(table)
	local str = "Available:"
	for _,item in ipairs(table) do
		str = str .. "\n" .. item[3]
	end
	return true, str
end

function getDescription()
	return "Lists possible variables for /inventory or /crew."
end

function getHelp()
	return "Lists possible variables for /inventory or /crew. Usage: /list [type]. Use /list to print types."
end
