package.path = package.path .. ";data/scripts/lib/?.lua"

require "randomext"

local upgrades = {
	arbitrarytcs = "data/scripts/systems/arbitrarytcs.lua",
	batterybooster = "data/scripts/systems/batterybooster.lua",
	cargo = "data/scripts/systems/cargoextension.lua",
	civiltcs = "data/scripts/systems/civiltcs.lua",
	energy = "data/scripts/systems/energybooster.lua",
	engine = "data/scripts/systems/enginebooster.lua",
	hyper = "data/scripts/systems/hyperspacebooster.lua",
	militarytcs = "data/scripts/systems/militarytcs.lua",
	mining = "data/scripts/systems/miningsystem.lua",
	radar = "data/scripts/systems/radarbooster.lua",
	scanner = "data/scripts/systems/scannerbooster.lua",
	shield = "data/scripts/systems/shieldbooster.lua",
	trading = "data/scripts/systems/tradingoverview.lua",
	velocity = "data/scripts/systems/velocitybypass.lua",
	energycoil = "data/scripts/systems/energytoshieldconverter.lua",
	detector = "data/scripts/systems/valuablesdetector.lua",
}

function execute(sender, commandName, s, r, a, n, ...) -- script, rarity, amount, name
	local name = n or sender
	if s and name then
		local player = Player(Galaxy():findFaction(name).index)
		local script = upgrades[s]
		local rarity = Rarity(math.min(math.max(-1, tonumber(r) or 0), 5))
		local amount = math.max(1, tonumber(a) or 1)
		local o = SystemUpgradeTemplate(script, rarity, random():createSeed())
		player:sendChatMessage("Server", 0, "You have been given (a) system upgrade(s).")
		for i=1,amount do
			player:getInventory():add(o)
		end
	end
	return 0, "", ""
end

function getDescription()
	return "Gives system upgrade to a player."
end

function getHelp()
	return "Gives system upgrade to a player. Usage: /system <system_name> [rarity=0] [amount=1] [player]"
end
