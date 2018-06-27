/*
ADV-aceCPR - by Belbo
*/

//register the eventhandlers:
//evh for the CPR:
["adv_aceCPR_evh_CPR_local", { _this call adv_aceCPR_fnc_CPR_local }] call CBA_fnc_addEventHandler;
//evh for the addition of revive time:
["adv_aceCPR_evh_addTime", { _this call adv_aceCPR_fnc_addTime }] call CBA_fnc_addEventHandler;
//evh for showing the pulse after AED:
["adv_aceCPR_evh_showPulse", { _this call ace_medical_fnc_actionCheckPulse }] call CBA_fnc_addEventHandler;
//evh for the AED:
["adv_aceCPR_evh_AED_local", { _this call adv_aceCPR_fnc_AED_local }] call CBA_fnc_addEventHandler;

//for diagnostic purposes only:
["adv_aceCPR_evh_log", { diag_Log (format ["%1",_this]) }] call CBA_fnc_addEventHandler;

missionNamespace setVariable ["adv_aceCPR_diag",false];

//getting adv_aceCPR_AED_stationType:
private _items = missionNamespace getVariable ["adv_aceCPR_AED_stationType","""Land_Defibrillator_F"""];
private _items_array = [_items,"CfgVehicles"] call adv_aceCPR_fnc_getList;

//create action for adv_aceCPR_AED_stationType
adv_aceCPR_aed_stationAction = [
	"adv_aceCPR_AED_stationary",
	localize "STR_ADV_ACECPR_AED_STATION_ACTION",
	"\adv_aceCPR\ui\defib_action.paa",
	{
		params ["_target","_caller","_arguments"];
		[_caller] call adv_aceCPR_fnc_useAEDStation
	},
	{
		params ["_target","_caller"];
		missionNamespace getVariable ['adv_aceCPR_enable',true] && !(_caller getVariable ['adv_aceCPR_usedAEDStation',false]) && (_caller getVariable ['ace_medical_medicClass',0]) > 0
	},
	nil,[]
] call ace_interact_menu_fnc_createAction;

//adding the action to all adv_aceCPR_AED_stationType:
{
	[_x, "InitPost", {
		[(_this select 0) , 0, ["ACE_MainActions"],adv_aceCPR_aed_stationAction] call ace_interact_menu_fnc_addActionToObject;
	}, false, nil, true] call CBA_fnc_addClassEventHandler;
	nil
} count _items_array;