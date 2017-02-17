-- Table of system upgrade scripts for use with `findString()` from `lib.cmd.common`
return
{
	{function (str) return str:find("^arb") or str:find("^atcs") end, "arbitrarytcs", "arbitrarytcs"},
	{function (str) return str:find("^bat") end, "batterybooster", "batterybooster"},
	{function (str) return str:find("^car") end, "cargoextension", "cargoextension"},
	{function (str) return str:find("^civ") or str:find("^ctcs") end, "civiltcs", "civiltcs"},
	{function (str) return str:find("^energyb") end, "energybooster", "energybooster"},
	{function (str) return str:find("^eng") end, "enginebooster", "enginebooster"},
	{function (str) return str:find("^hyp") end, "hyperspacebooster", "hyperspacebooster"},
	{function (str) return str:find("^mil") or str:find("^mtcs") end, "militarytcs", "militarytcs"},
	{function (str) return str:find("^min") end, "miningsystem", "miningsystem"},
	{function (str) return str:find("^rad") end, "radarbooster", "radarbooster"},
	{function (str) return str:find("^sca") end, "scannerbooster", "scannerbooster"},
	{function (str) return str:find("^shi") end, "shieldbooster", "shieldbooster"},
	{function (str) return str:find("^tra") end, "tradingoverview", "tradingoverview"},
	{function (str) return str:find("^vel") end, "velocitybypass", "velocitybypass"},
	{function (str) return str:find("^energyt") end, "energytoshieldconverter", "energytoshieldconverter"},
	{function (str) return str:find("^val") end, "valuablesdetector", "valuablesdetector"},
}