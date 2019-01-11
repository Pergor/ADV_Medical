/*
ADV-aceCPR - by Belbo
*/

waitUntil {!isNil "adv_aceCPR_AED_stationType" && time > 1};
//getting adv_aceCPR_AED_stationType:
private _items = missionNamespace getVariable ["adv_aceCPR_AED_stationType","""Land_Defibrillator_F"""];
private _items_array = [_items,"CfgVehicles"] call adv_aceCPR_fnc_getList;
private _useOwnObject = {_x == "Land_Defibrillator_F"} count _items_array > 0;
if ( _useOwnObject ) then {
	_items_array pushBackUnique "adv_aceCPR_AEDItem";
};

//create action for adv_aceCPR_AED_stationType
adv_aceCPR_aed_stationAction = [
	"adv_aceCPR_AED_stationary",
	localize "STR_ADV_ACECPR_AED_STATION_ACTION",
	"\adv_aceCPR\ui\defib_action.paa",
	{
		params ["_target","_caller","_arguments"];
		[_caller,_target] call adv_aceCPR_fnc_useAEDStation
	},
	{
		params ["_target","_caller"];
		missionNamespace getVariable ['adv_aceCPR_enable',true] && {!(_caller getVariable ['adv_aceCPR_usedAEDStation',false]) && (_caller getVariable ['ace_medical_medicClass',0]) > 0}
	},
	nil,[],[0,0,0]
] call ace_interact_menu_fnc_createAction;

//adding the action to all adv_aceCPR_AED_stationType:
{
	[_x , 0, ["ACE_MainActions"],adv_aceCPR_aed_stationAction,false] call ace_interact_menu_fnc_addActionToClass;
	nil
} count _items_array;
/*
{
	[_x, "InitPost", {
		[(_this select 0) , 0, ["ACE_MainActions"],adv_aceCPR_aed_stationAction] call ace_interact_menu_fnc_addActionToObject;
	}, false, nil, true] call CBA_fnc_addClassEventHandler;
	nil
} count _items_array;
*/

//adding a put evh, so carryable AED get's action as well:
if ( hasInterface && _useOwnObject ) then {
	adv_aceCPR_EVH_aed_station = player addEventHandler ["Put", {
		params ["_unit", "_container", "_item"];
		if (typeOf _container == "GroundWeaponHolder" && _item == "adv_aceCPR_AED") exitWith {
			[_container,0,["ACE_MainActions","adv_aceCPR_AED_stationary"]] call ace_interact_menu_fnc_removeActionFromObject;
			
			[_container , 0, ["ACE_MainActions"],adv_aceCPR_aed_stationAction] call ace_interact_menu_fnc_addActionToObject;
			_container addEventHandler ["ContainerClosed", {
				params ["_container", "_unit"];
				if ( {_x == "adv_aceCPR_AED"} count (itemCargo _container) isEqualTo 0 ) exitWith {
					[_container,0,["ACE_MainActions","adv_aceCPR_AED_stationary"]] call ace_interact_menu_fnc_removeActionFromObject;
				};
			}];
		};
	}];
};

nil