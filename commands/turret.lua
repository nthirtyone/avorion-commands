package.path = package.path .. ";data/scripts/lib/?.lua"

require "randomext"
require "galaxy"

local weapons = {
	chaingun = WeaponType.ChainGun,
	laser = WeaponType.Laser,
	mining = WeaponType.MiningLaser,
	plasma = WeaponType.PlasmaGun,
	rocket = WeaponType.RocketLauncher,
	cannon = WeaponType.Cannon,
	rail = WeaponType.RailGun,
	repair = WeaponType.RepairBeam,
	bolter = WeaponType.Bolter,
	lightning = WeaponType.LightningGun,
	tesla = WeaponType.TeslaGun,
	force = WeaponType.ForceGun,
	salvage = WeaponType.SalvagingLaser
}

function execute(sender, commandName, w, r, t, m, a, n, ...) -- weapontype, rarity, tech, material, amount, name
	local name = n or sender
	if w and name then
		local player = Player(Galaxy():findFaction(name).index)
		local weapon = weapons[w]
		local rarity = Rarity(math.min(math.max(-1, tonumber(r) or 0), 5))
		local tech = math.max(1, tonumber(t) or 6)
		local amount = math.max(1, tonumber(a) or 1)
		local dps = Balancing_TechWeaponDPS(tech)
		local material = Material(math.min(math.max(0, tonumber(m) or 1), 6))
		local o = GenerateTurretTemplate(random():createSeed(), weapon, dps, tech, rarity, material)
		player:sendChatMessage("Server", 0, "You have been given (a) weapon(s).")
		for i=1,amount do
			player:getInventory():add(InventoryTurret(o))
		end
	end
	return 0, "", ""
end

function getDescription()
	return "Gives generic turret to a player."
end

function getHelp()
	return "Gives generic turret to a player. Usage: /turret <type> [rarity=0] [tech=6] [material=1] [amount=1] [player]"
end
