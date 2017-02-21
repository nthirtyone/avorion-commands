package.path = package.path .. ";data/scripts/lib/?.lua"

require ("galaxy")
require ("randomext")
require ("tooltipmaker")
require "cmd.common"
FighterGenerator = require("fightergenerator")
weapons = require "cmd.weapons"
rarities = require "cmd.rarities"
materials = require "cmd.materials"

if onServer() then
	function initialize(action, ...)
		local flag, msg = false, ""

		player = Player()

		if action == "add" then
			flag, msg = addFighter(player, ...)
		elseif action == "help" or action == nil then
			flag,msg = true, "Adds a fighter to the players hangar. Usage:\n/fighter add <weapon> [rarity] [material] [tech]\n"
		else
			flag, msg = false, string.format("Unknown action: %s", action)
		end

		player:sendChatMessage("Fighter", 0, msg)
		terminate()
	end

	function addFighter(player, weapontype, rarity, material, tech, amount)
		local err
		local ship = Entity(player.craftIndex)

		if not ship:hasComponent(ComponentType.Hangar) then
			return false, "Ship must have a hangar"
		end	

		weapontype, err = getType(weapons, weapontype, 0)
		if not weapontype then 
			return false, err
		end

		rarity, err = getType(rarities, rarity or 0, -1)
		if not rarity then
			return false, err
		end

		material, err = getType(materials, material or 0, 0)
		if not material then
			return false, err
		end
		
		local tech = math.max(1, tonumber(tech) or 6)
		local dps = Balancing_TechWeaponDPS(tech)
		
		local fighter = GenerateFighterTemplate(random():createSeed(), weapontype, dps, tech, Rarity(rarity), Material(material))
		
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
	end

	-- Returns available properties from a selected table.
	function printAvailable(table)
		local str = "Available:"
		for _,item in ipairs(table) do
			str = str .. "\n" .. item[3]
		end
		return true, str
	end

	-- Following four functions are almost the same; consider merging them.
	-- Identifies type based on the specified table from a string or a number.
	function getType(tbl, item, min)
		local _item
		if tonumber(item) then
			_item = limit(tonumber(item), #tbl-min, min)
		else
			_item = findString(tbl, item)
		end

		if _item then
			return _item
		end

		return nil, string.format("Could not identify type: %s", item)
	end
end