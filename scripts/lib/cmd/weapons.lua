-- Table of weaponTypes for use with `findString()` from `lib.cmd.common`
return
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