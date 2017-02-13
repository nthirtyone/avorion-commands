-- Returns Player of a given id or name.
-- Returns nil and an error message if not found.
function findPlayer(a)
	-- In case if player index is passed.
	local faction = Galaxy():findFaction(a)
	if not faction then
		-- Players have indices starting from 1. Their list ends with faction === nil.
		local i = 0
		repeat
			i = i + 1
			faction = Galaxy():findFaction(i)
			if faction and faction.name == a then break end
		until not faction
	end
	-- At this point we either have selected player's faction or nothing.
	if not faction then
		return nil, "Cannot find this player. (1)"
	end
	-- We have an index! For the unlikely case that it's not a player.
	if not faction.isPlayer then
		return nil, "Cannot find this player. (2)"
	end
	-- Return fresh Player object.
	return Player(faction.index), ""
end

-- Returns n limited between max and min.
function limit(n, max, min)
	return math.min(max, math.max(min, n))
end

-- Looks for a str(ing) in a formatted table. Returns nil if not found.
-- Format: item = {function that checks string, return value, list name}
function findString(table, str)
	for _,item in pairs(table) do
		if item[1](str) then return item[2] end
	end
end