-- Table of rarityTypes for use with `findString()` from `lib.cmd.common`
return
{
	{function (str) return str:find("^[pP]ur")  or str:find("^[lL]eg") end, 5, "Legendary"},
	{function (str) return str:find("^[rR]ed")  or str:find("^[eE]xo") end, 4, "Exotic"},
	{function (str) return str:find("^[yY]el")  or str:find("^[eE]xc") end, 3, "Exceptional"},
	{function (str) return str:find("^[bB]lu")  or str:find("^[rR]ar") end, 2, "Rare"},
	{function (str) return str:find("^[gG]ree") or str:find("^[uU]nc") end, 1, "Uncommon"},
	{function (str) return str:find("^[wW]hi")  or str:find("^[cC]om") end, 0, "Common"},
	{function (str) return str:find("^[gG]r[ae]y") or str:find("^[pP]et") end, -1, "Petty"},
}