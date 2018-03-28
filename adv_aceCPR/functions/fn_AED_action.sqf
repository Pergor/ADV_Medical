/*
ADV-aceCPR - by Belbo
*/

params [
	"_caller"
	,"_target"
	,"_selectionName"
	,"_className"
	,"_items"
];

private _inCardiac = _target getVariable ["ace_medical_inCardiacArrest",false];
private _inRevive = _target getVariable ["ace_medical_inReviveState",false];

//adds pain with each defib use:
[_target, 0.4] call ace_medical_fnc_adjustPainLevel;
//to units standing too close to _target as well:
private _bystanders = ( allUnits select {_x distance _target < 1.7} ) - [_caller];
{ [_x, 0.2] call ace_medical_fnc_adjustPainLevel; nil; } count _bystanders;

//if necessary execute the custom cpr action:
if ( _inCardiac || _inRevive ) exitWith {
	//execute aed treatment local to the target:
	if (local _target) exitWith {
		//diagnostics
		[_target,"target is local"] call adv_aceCPR_fnc_diag;
		
		//aed event:
		["adv_aceCPR_evh_AED_local", [_caller, _target]] call CBA_fnc_localEvent;
	};
	
	//diagnostics:
	[_target,"target is not local to the caller"] call adv_aceCPR_fnc_diag;
	
	//aed event:
	["adv_aceCPR_evh_AED_local", [_caller, _target], _target] call CBA_fnc_targetEvent;
};

//log the AED usage to the treatment log:
[_target, "activity", localize "STR_ADV_ACECPR_AED_EXECUTE", [[_caller, false, true] call ace_common_fnc_getName]] call ace_medical_fnc_addToLog;
[_target, "activity_view", localize "STR_ADV_ACECPR_AED_EXECUTE", [[_caller, false, true] call ace_common_fnc_getName]] call ace_medical_fnc_addToLog;

//return:
false;
