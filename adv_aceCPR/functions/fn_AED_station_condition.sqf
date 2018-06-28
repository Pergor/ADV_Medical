/*
ADV-aceCPR - by Belbo
*/

params [
	"_caller"
	,"_target"
];

private _items = missionNamespace getVariable ["adv_aceCPR_AED_stationType","Land_Defibrillator_F"];
private _items_array = [_items,"CfgVehicles"] call adv_aceCPR_fnc_getList;

private _return = !([_target] call ace_common_fnc_isAwake) && {missionNamespace getVariable ['adv_aceCPR_enable',true] && count (_target nearEntities [_items_array, 5]) > 0 && _caller getVariable ['adv_aceCPR_usedAEDStation',false]};

_return