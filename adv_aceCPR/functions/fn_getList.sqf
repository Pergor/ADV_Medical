/*
ADV-aceCPR - by Belbo
*/

params [
	"_str"
	,["_cfg","CfgVehicles",[""]]
];

private _clipString = _str splitString ",""[]()'";
private _array = [];
{
	if (isClass(configFile >> _cfg >> _x)) then {
		_array pushBackUnique _x
	};
	nil
} count _clipString;

_array
