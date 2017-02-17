package.path = package.path .. ";data/scripts/lib/?.lua"
require ("galaxy")
require "randomext"

if onServer() then
	function initialize(action, ...)
		local flag, msg = false, ""
		player = Player()
		if action == "add" then
			flag, msg = addFighter(player, ...)
		elseif action == "available" then
			local option = ...
			if option:find("weapons?") then flag, msg = printAvailable(weapons)
			elseif option:find("materials?") then flag, msg = printAvailable(materials)
			elseif option:find("rarity") or option:find("rarities") then flag, msg = printAvailable(rarities)
			else flag, msg = false, string.format("Unknown available option: %s", option) end
		elseif action == "help" then
			flag,msg = true, "Adds fighters to players hangar. Usage:\n/fighter add <weapon> [rarity] [material] [tech]\n/fighter available <weapons|materials|rarities>"
		else
			flag, msg = false, string.format("Unknown action: %s", action)
		end
		player:sendChatMessage("Fighter", 0, msg)
		terminate()
	end

	function addFighter(player, weapontype, rarity, material, tech, amount)
		local err
		local ship = Entity(player.craftIndex)

		if ship:hasComponent(ComponentType.Hangar) then		
			weapontype, err = getWeaponType(weapontype)
			if weapontype then
				rarity, err = getRarity(rarity or 0)
				if rarity then
					material, err = getMaterial(material or 0)
					if material then
						local tech = math.max(1, tonumber(tech) or 6)
						local dps = Balancing_TechWeaponDPS(tech)
						local fighter = GenerateFighterTemplate(random():createSeed(), weapontype, dps, tech, rarity, material)
						
						local hangar = Hangar(ship.index);
						
						-- check if there is enough space in ship
						if hangar.freeSpace < fighter.volume then
							return false, "You don't have enough space in your hangar."
						end
						
						-- find a squad that has space for a fighter
						local squads = {hangar:getSquads()}

						local squad
						for _, i in pairs(squads) do
							local fighters = hangar:getSquadFighters(i)
							local space = hangar:getSquadMaxFighters(i)

							local free = space - fighters

							if free > 0 then
								squad = i
								break
							end
						end

						if squad == nil then
							return false, "There is no free squad to place the fighter in."
						end

						hangar:addFighter(squad, fighter)

						return true, "Fighter added to inventory"
					end --end if material
				end --end if rarity
			end --end if weapon type
		end --end if has hangar
		return false, err
	end

	-- Returns available properties from a selected table.
	function printAvailable(table)
		local str = "Available:"
		for _,item in ipairs(table) do
			str = str .. "\n" .. item[3]
		end
		return true, str
	end

	-- Types tables.
	weapons = 
	{
		{function (str) return str:find("^[cC]ha") end,  0, "ChainGun"},
		{function (str) return str:find("^[lL]as") end,  1, "Laser"},
		{function (str) return str:find("^[mM]in") end,  2, "MiningLaser"},
		{function (str) return str:find("^[pP]la") end,  3, "PlasmaGun"},
		{function (str) return str:find("^[rR]oc") end,  4, "RocketLauncher"},
		{function (str) return str:find("^[cC]an") end,  5, "Cannon"},
		{function (str) return str:find("^[rR]ai") end,  6, "RailGun"},
		{function (str) return str:find("^[rR]ep") end,  7, "RepairBeam"},
		{function (str) return str:find("^[bB]ol") end,  8, "Bolter"},
		{function (str) return str:find("^[lL]ig") end,  9, "LightningGun"},
		{function (str) return str:find("^[tT]es") end, 10, "TeslaGun"},
		{function (str) return str:find("^[fF]or") end, 11, "ForceGun"},
		{function (str) return str:find("^[sS]al") end, 12, "SalvagingLaser"},
	}
	rarities =
	{
		{function (str) return str:find("^[pP]ur")  or str:find("^[lL]eg") end, 5, "Legendary"},
		{function (str) return str:find("^[rR]ed")  or str:find("^[eE]xo") end, 4, "Exotic"},
		{function (str) return str:find("^[yY]el")  or str:find("^[eE]xc") end, 3, "Exceptional"},
		{function (str) return str:find("^[bB]lu")  or str:find("^[rR]ar") end, 2, "Rare"},
		{function (str) return str:find("^[gG]ree") or str:find("^[uU]nc") end, 1, "Uncommon"},
		{function (str) return str:find("^[wW]hi")  or str:find("^[cC]om") end, 0, "Common"},
		{function (str) return str:find("^[gG]r[ae]y") or str:find("^[pP]et") end, -1, "Petty"},
	}
	materials =
	{
		{function (str) return str:find("^[aA]vo") end, 6, "Avorion"},
		{function (str) return str:find("^[oO]go") end, 5, "Ogonite"},
		{function (str) return str:find("^[xX]an") end, 4, "Xanion"},
		{function (str) return str:find("^[tT]ri") end, 3, "Trinium"},
		{function (str) return str:find("^[nN]ao") end, 2, "Naonite"},
		{function (str) return str:find("^[tT]it") end, 1, "Titanium"},
		{function (str) return str:find("^[iI]ro") end, 0, "Iron"},
	}

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
end