if onServer() then

function initialize()
	player = Player()
	ship = Entity(Player().craftIndex)
	if ship then
		local prices = {ship:getUndamagedPlanMoneyValue(), ship:getUndamagedPlanResourceValue()}
		local str = "Boarded ship's value is:"
		for i,price in ipairs(prices) do
			if price > 0 then
				str = str .. "\n" .. currencies[i] .. ": " .. math.ceil(price)
			end
		end
		player:sendChatMessage("Price", 0, str)
	else
		player:sendChatMessage("Price", 0, "Could not get Entity object.")
	end
	terminate()
end

currencies =
{
	"Credits",
	"Iron",
	"Titanium",
	"Naonite",
	"Trinium",
	"Xanion",
	"Ogonite",
	"Avorion",
}

end
