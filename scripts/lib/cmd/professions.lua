-- Table of crew professionTypes for use with `findString()` from `lib.cmd.common`
return
{
	{function (str) return str:find("^[nN]on") end,  0, "None"},
	{function (str) return str:find("^[eE]ng") end,  1, "Engine"},
	{function (str) return str:find("^[gG]un") end,  2, "Gunner"},
	{function (str) return str:find("^[mM]in") end,  3, "Miner"},
	{function (str) return str:find("^[mM]ec") or str:find("^[rR]ep") end,  4, "Mechanic (Repair)"},
	{function (str) return str:find("^[pP]il") end,  5, "Pilot"},
	{function (str) return str:find("^[sS]ec") end,  6, "Security"},
	{function (str) return str:find("^[aA]tt") end,  7, "Attacker"},
	{function (str) return str:find("^[sS]er") end,  8, "Sergeant"},
	{function (str) return str:find("^[lL]ie") end,  9, "Lieutenant"},
	{function (str) return str:find("^[cC]om") end, 10, "Commander"},
	{function (str) return str:find("^[gG]en") end, 11, "General"},
	{function (str) return str:find("^[cC]ap") end, 12, "Captain"},
}