package.path = package.path .. ";data/scripts/lib/?.lua"

require "randomext"
require "galaxy"
require "cmd.common"
weapons = require "cmd.weapons"
rarities = require "cmd.rarities"
materials = require "cmd.materials"
scripts = require "cmd.upgrades"

-- Main function of the command, called by game when command is used.
function execute(sender, commandName, action, ...) -- weapontype, rarity, tech, material, amount, name
	local name = n or sender
	local player = Player(Galaxy():findFaction(name).index)
	local flag, msg = false, ""
	if player then
		if action == "turret" then
			flag, msg = addTurrets(player, ...)
		elseif action == "upgrade" then
			flag, msg = addUpgrades(player, ...)
		elseif action == "help" or action == nil then
			flag, msg = true, getHelp()
		else
			flag, msg = false, string.format("Unknown action: %s", action)
		end
	else
		flag, msg = false, string.format("Player %s couldn't be found.", name)
	end
	player:sendChatMessage("Inventory", 0, msg)
	return 0, "", ""
end

-- Perform selected actions.
-- Adds turrets to selected faction inventory.
function addTurrets(faction, weapontype, rarity, material, tech, amount)
	local err
	weapontype, err = getWeaponType(weapontype)
	if weapontype then
		rarity, err = getRarity(rarity or 0)
		if rarity then
			material, err = getMaterial(material or 0)
			if material then
				local tech = math.max(1, tonumber(tech) or 6)
				local dps = Balancing_TechWeaponDPS(tech)
				local item = GenerateTurretTemplate(random():createSeed(), weapontype, dps, tech, rarity, material)
				item.flavorText = "Shamelessly added with a command."
				addItems(faction, InventoryTurret(item), amount)
				return true, string.format("%s added.", item.weaponName)
			end
		end
	end
	return false, err
end
-- Adds system upgrades to selected faction inventory.
function addUpgrades(faction, script, rarity, amount)
	local err
	script, err = getScript(script)
	if script then
		rarity, err = getRarity(rarity or 0)
		if rarity then
			local item = SystemUpgradeTemplate(script, rarity, random():createSeed())
			addItems(faction, item, amount)
			return true, string.format("%s added.", item.name)
		end
	end
	return false, err
end

-- Add amount of items to the inventory of a faction (or player).
function addItems(faction, item, amount)
	local amount = amount or 1
	for i=1,amount do
		faction:getInventory():add(item)
	end
end

-- Following four functions are almost the same; consider merging them.
-- Identifies weaponType from a string or a number.
function getWeaponType(w)
	local weapontype
	if tonumber(w) then 
		weapontype = limit(tonumber(w), 12, 0)
	else
		weapontype = findString(weapons, w)
	end
	if weapontype then
		return weapontype
	end
	return nil, string.format("Could not identify weaponType: %s", w)
end
-- Identifies rarity from a string or a number.
function getRarity(r)
	local rarity
	if tonumber(r) then 
		rarity = limit(tonumber(r), 5, -1)
	else
		rarity = findString(rarities, r)
	end
	if rarity then
		return Rarity(rarity)
	end
	return nil, string.format("Could not identify rarityType: %s", r)
end
-- Identifies material from a string or a number.
function getMaterial(m)
	local material
	if tonumber(m) then 
		material = limit(tonumber(m), 6, 0)
	else
		material = findString(materials, m)
	end
	if material then
		return Material(material)
	end
	return nil, string.format("Could not identify materialType: %s", m)
end
-- Identifies script from a string. No, this time only from a string.
function getScript(s)
	local script = findString(scripts, s)
	if script then
		return string.format("data/scripts/systems/%s.lua", script)
	end
	return nil, string.format("Could not identify upgradeScript: %s", s)
end

-- Functions used directly by Avorion.
-- Returns short description of a command.
function getDescription()
	return "Modifies inventory of a player."
end
-- This is printed when player use /help <command>.
function getHelp()
	return "Modifies inventory of a player. Usage:\n/inventory turret <type> [rarity] [material] [tech] [amount]\n/inventory upgrade <script> [rarity] [amount]"
end
