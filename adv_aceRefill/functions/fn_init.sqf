/*
ADV-aceRefill - by Belbo
*/

if !(hasInterface) exitWith {};

["loadout", adv_aceRefill_fnc_itemCheck] call CBA_fnc_addPlayerEventHandler;

private _manualKitAction = ["aceRefill_action",localize "STR_ADV_REFILL_OPEN","",{

	[player] call adv_aceRefill_fnc_refill;
	
},{ (_player getVariable ["ACE_medical_medicClass", 0] > 0) && ( ({_x == "adv_aceRefill_manualKit"} count items _player) > 0 ) }] call ace_interact_menu_fnc_createAction;

[player , 1, ["ACE_SelfActions","ACE_Equipment"],_manualKitAction] call ace_interact_menu_fnc_addActionToObject;