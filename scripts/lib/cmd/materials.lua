-- Table of materialTypes for use with `findString()` from `lib.cmd.common`
return
{
	{function (str) return str:find("^[aA]vo") end, 6, "Avorion"},
	{function (str) return str:find("^[oO]go") end, 5, "Ogonite"},
	{function (str) return str:find("^[xX]an") end, 4, "Xanion"},
	{function (str) return str:find("^[tT]ri") end, 3, "Trinium"},
	{function (str) return str:find("^[nN]ao") end, 2, "Naonite"},
	{function (str) return str:find("^[tT]it") end, 1, "Titanium"},
	{function (str) return str:find("^[iI]ro") end, 0, "Iron"},
}