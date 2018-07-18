/*
ADV-aceCPR - by Belbo
*/

params [
	"_unit"
];

_caller setVariable ["adv_aceCPR_aed_usedVar",0];
_caller setVariable ["adv_aceCPR_aed_items",[]];

_unit addEventHandler ["Take", {
	params ["_unit", "_container", "_item"];
	if (toLower _item isEqualTo "adv_acecpr_aed") exitWith {
		private _items = getVariable ["adv_aceCPR_aed_items",[]];
		_items pushBack _usesMax;
		private _removedNils = _items arrayIntersect _items;
		_unit setVariable ["adv_aceCPR_aed_items",_removedNils];
	};
	nil
}];

_unit addEventHandler ["Put", {
	params ["_unit", "_container", "_item"];
	if (toLower _item isEqualTo "adv_acecpr_aed") exitWith {
		private _items = getVariable ["adv_aceCPR_aed_items",[]];
		private _removedNils = _items arrayIntersect _items;
		_removedNils resize (count _removedNils)-1;
		_unit setVariable ["adv_aceCPR_aed_items",_removedNils];
	};
	nil
}];

/*
private _uses = _caller getVariable ["adv_aceCPR_aed_usedVar",0];
private _usesMax = missionNamespace getVariable ["adv_aceCPR_aed_maxUseVar",10];
_unit setVariable ["adv_aceCPR_aed_usedVar",_uses+_usesMax];
*/
		