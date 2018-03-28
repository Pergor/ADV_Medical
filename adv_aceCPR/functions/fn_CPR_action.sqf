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

//if revive is enabled execute the custom cpr action:
if ( (missionNamespace getVariable ["ace_medical_enableRevive",0]) > 0 ) exitWith {
	//diagnostics:
	[_target,"custom CPR is being executed"] call adv_aceCPR_fnc_diag;

	if (local _target) exitWith {
		//cpr call:
		["adv_aceCPR_evh_CPR_local", [_caller, _target]] call CBA_fnc_localEvent;
	};

	//cpr call:
	["adv_aceCPR_evh_CPR_local", [_caller, _target], _target] call CBA_fnc_targetEvent;

	true;
};

//diagnostics:
[_target,"only regular CPR is being executed"] call adv_aceCPR_fnc_diag;

//execute the regular ace-cpr action:
[_caller,_target,_selectionName,_className,_items] call ace_medical_fnc_treatmentAdvanced_CPR;

//return:
false;
