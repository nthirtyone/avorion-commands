package.path = package.path .. ";data/scripts/lib/?.lua"

require "randomext"
require "galaxy"

-- Main function of the command, called by game when command is used.
function execute(sender, commandName, ...) -- weapontype, rarity, tech, material, amount, name
	local name = n or sender
	local player = Player(Galaxy():findFaction(name).index)
	local flag, msg = false, ""
	if player then
		flag, msg = addTurrets(player, ...)
	else
		flag, msg = false, string.format("Player %s couldn't be found.", name)
	end
	player:sendChatMessage("Turret", 0, msg)
	return 0, "", ""
end

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

-- Add amount of items to the inventory of a faction (or player).
function addItems(faction, item, amount)
	local amount = amount or 1
	for i=1,amount do
		faction:getInventory():add(item)
	end
end

-- Identifies weaponType from a string or a number.
function getWeaponType(w)
	if tonumber(w) then return math.min(12, math.max(tonumber(w), 0)) end -- return it back if it is a number
	if w:find("^[cC]ha") then return  0 end -- ChainGun
	if w:find("^[lL]as") then return  1 end -- Laser
	if w:find("^[mM]in") then return  2 end -- MiningLaser
	if w:find("^[pP]la") then return  3 end -- PlasmaGun
	if w:find("^[rR]oc") then return  4 end -- RocketLauncher
	if w:find("^[cC]an") then return  5 end -- Cannon
	if w:find("^[rR]ai") then return  6 end -- RailGun
	if w:find("^[rR]ep") then return  7 end -- RepairBeam
	if w:find("^[bB]ol") then return  8 end -- Bolter
	if w:find("^[lL]ig") then return  9 end -- LightningGun
	if w:find("^[tT]es") then return 10 end -- TeslaGun
	if w:find("^[fF]or") then return 11 end -- ForceGun
	if w:find("^[sS]al") then return 12 end -- SalvagingLaser
	return nil, string.format("Could not identify weaponType: %s", w)
end

-- Identifies rarity from a string or a number.
function getRarity(r)
	if tonumber(r) then return Rarity(math.min(5, math.max(-1, tonumber(r)))) end -- from number
	if r:find("^[pP]ur")  or r:find("^[lL]eg") then return Rarity(5) end -- Legendary
	if r:find("^[rR]ed")  or r:find("^[eE]xo") then return Rarity(4) end -- Exotic
	if r:find("^[yY]el")  or r:find("^[eE]xc") then return Rarity(3) end -- Exceptional
	if r:find("^[bB]lu")  or r:find("^[rR]ar") then return Rarity(2) end -- Rare
	if r:find("^[gG]ree") or r:find("^[uU]nc") then return Rarity(1) end -- Uncommon
	if r:find("^[wW]hi")  or r:find("^[cC]om") then return Rarity(0) end -- Common
	if r:find("^[gG]r[ae]y") or r:find("^[pP]et") then return Rarity(-1) end -- Petty
	return nil, string.format("Could not identify rarityType: %s", r)
end

-- Identifies material from a string or a number.
function getMaterial(m)
	if tonumber(m) then return Material(math.min(6, math.max(0, tonumber(m)))) end -- from number
	if m:find("^[aA]vo") then return Material(6) end -- Avorion
	if m:find("^[oO]go") then return Material(5) end -- Ogonite
	if m:find("^[xX]an") then return Material(4) end -- Xanion
	if m:find("^[tT]ri") then return Material(3) end -- Trinium
	if m:find("^[nN]ao") then return Material(2) end -- Naonite
	if m:find("^[tT]it") then return Material(1) end -- Titanium
	if m:find("^[iI]ro") then return Material(0) end -- Iron
	return nil, string.format("Could not identify materialType: %s", m)
end

-- Returns short description of a command.
function getDescription()
	return "Gives generic turret to a player."
end

-- This is printed when player use /help <command>.
function getHelp()
	return "Gives generic turret to a player.\nUsage: /turret <type> [rarity] [material] [tech] [amount]\nExample: /turret chaingun exotic trinium 16 4"
end
