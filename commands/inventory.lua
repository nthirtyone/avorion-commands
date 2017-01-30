package.path = package.path .. ";data/scripts/lib/?.lua"

require "randomext"
require "galaxy"

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

-- Types tables.
weapons = 
{
	{function (str) return str:find("^[cC]ha") end,  0}, -- ChainGun
	{function (str) return str:find("^[lL]as") end,  1}, -- Laser
	{function (str) return str:find("^[mM]in") end,  2}, -- MiningLaser
	{function (str) return str:find("^[pP]la") end,  3}, -- PlasmaGun
	{function (str) return str:find("^[rR]oc") end,  4}, -- RocketLauncher
	{function (str) return str:find("^[cC]an") end,  5}, -- Cannon
	{function (str) return str:find("^[rR]ai") end,  6}, -- RailGun
	{function (str) return str:find("^[rR]ep") end,  7}, -- RepairBeam
	{function (str) return str:find("^[bB]ol") end,  8}, -- Bolter
	{function (str) return str:find("^[lL]ig") end,  9}, -- LightningGun
	{function (str) return str:find("^[tT]es") end, 10}, -- TeslaGun
	{function (str) return str:find("^[fF]or") end, 11}, -- ForceGun
	{function (str) return str:find("^[sS]al") end, 12}, -- SalvagingLaser
}
rarities =
{
	{function (str) return str:find("^[pP]ur")  or str:find("^[lL]eg") end, 5}, -- Legendary
	{function (str) return str:find("^[rR]ed")  or str:find("^[eE]xo") end, 4}, -- Exotic
	{function (str) return str:find("^[yY]el")  or str:find("^[eE]xc") end, 3}, -- Exceptional
	{function (str) return str:find("^[bB]lu")  or str:find("^[rR]ar") end, 2}, -- Rare
	{function (str) return str:find("^[gG]ree") or str:find("^[uU]nc") end, 1}, -- Uncommon
	{function (str) return str:find("^[wW]hi")  or str:find("^[cC]om") end, 0}, -- Common
	{function (str) return str:find("^[gG]r[ae]y") or str:find("^[pP]et") end, -1}, -- Petty
}
materials =
{
	{function (str) return str:find("^[aA]vo") end, 6}, -- Avorion
	{function (str) return str:find("^[oO]go") end, 5}, -- Ogonite
	{function (str) return str:find("^[xX]an") end, 4}, -- Xanion
	{function (str) return str:find("^[tT]ri") end, 3}, -- Trinium
	{function (str) return str:find("^[nN]ao") end, 2}, -- Naonite
	{function (str) return str:find("^[tT]it") end, 1}, -- Titanium
	{function (str) return str:find("^[iI]ro") end, 0}, -- Iron
}
scripts = 
{
	{function (str) return str:find("^arb") or str:find("^atcs") end, "arbitrarytcs"},
	{function (str) return str:find("^bat") end, "batterybooster"},
	{function (str) return str:find("^car") end, "cargoextension"},
	{function (str) return str:find("^civ") or str:find("^ctcs") end, "civiltcs"},
	{function (str) return str:find("^energyb") end, "energybooster"},
	{function (str) return str:find("^eng") end, "enginebooster"},
	{function (str) return str:find("^hyp") end, "hyperspacebooster"},
	{function (str) return str:find("^mil") or str:find("^mtcs") end, "militarytcs"},
	{function (str) return str:find("^min") end, "miningsystem"},
	{function (str) return str:find("^rad") end, "radarbooster"},
	{function (str) return str:find("^sca") end, "scannerbooster"},
	{function (str) return str:find("^shi") end, "shieldbooster"},
	{function (str) return str:find("^tra") end, "tradingoverview"},
	{function (str) return str:find("^vel") end, "velocitybypass"},
	{function (str) return str:find("^energyt") end, "energytoshieldconverter"},
	{function (str) return str:find("^val") end, "valuablesdetector"},
}

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
		weapontype = checkTable(weapons, w)
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
		rarity = checkTable(rarities, r)
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
		material = checkTable(materials, m)
	end
	if material then
		return Material(material)
	end
	return nil, string.format("Could not identify materialType: %s", m)
end
-- Identifies script from a string. No, this time only from a string.
function getScript(s)
	local script = checkTable(scripts, s)
	if script then
		return string.format("data/scripts/systems/%s.lua", script)
	end
	return nil, string.format("Could not identify upgradeScript: %s", s)
end

-- Following two functions are used to seek in types tables.
-- Searches table for patterns.
function checkTable(table, str)
	for _,item in pairs(table) do
		if item[1](str) then return item[2] end
	end
end
-- Limits range of a number.
function limit(n, max, min)
	return math.min(max, math.max(min, n))
end

-- Functions used directly by Avorion.
-- Returns short description of a command.
function getDescription()
	return "Modifies inventory of a player."
end
-- This is printed when player use /help <command>.
function getHelp()
	return "Modifies inventory of a player.\nTurret: /inventory turret <type> [rarity] [material] [tech] [amount]\nUpgrade: /inventory upgrade <script> [rarity] [amount]"
end
