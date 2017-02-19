-- Table of crew ranks for use with `findString()` from `lib.cmd.common`
return
{
	{function (str) return str:find("^[uU]nt") end,  0, "Untrained"},
	{function (str) return str:find("^[pP]ro") end,  1, "Professional"},
}