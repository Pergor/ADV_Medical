/*
ADV-aceRefill - by Belbo
*/

if !(hasInterface) exitWith {};

["loadout", { params ["_unit","_loadout"]; [_unit,3,"adv_aceRefill_manualKit"] call adv_aceRefill_fnc_refill }] call CBA_fnc_addPlayerEventHandler;

private _manualKitAction = ["aceRefill_MKaction",localize "STR_ADV_REFILL_OPEN","\z\ace\addons\medical\UI\icons\medical_cross.paa",{

	[player,2,"adv_aceRefill_manualKit"] call adv_aceRefill_fnc_refill;
	
},{ (_player getVariable ["ACE_medical_medicClass", 0] > 0) && ( ({_x == "adv_aceRefill_manualKit"} count items _player) > 0 ) }] call ace_interact_menu_fnc_createAction;

private _FAKAction = ["aceRefill_FAKaction",localize "STR_ADV_REFILL_OPEN_FAK","\z\ace\addons\medical\UI\icons\medical_cross.paa",{

	[player,1,"adv_aceRefill_FAK"] call adv_aceRefill_fnc_refill;
	
},{ ({_x == "adv_aceRefill_FAK"} count items _player) > 0 }] call ace_interact_menu_fnc_createAction;

[player , 1, ["ACE_SelfActions","ACE_Equipment"],_manualKitAction] call ace_interact_menu_fnc_addActionToObject;
[player , 1, ["ACE_SelfActions","ACE_Equipment"],_FAKAction] call ace_interact_menu_fnc_addActionToObject;