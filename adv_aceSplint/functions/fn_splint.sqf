/*
ADV-aceSplint - by Belbo
*/

params ["_caller","_target","_selection","_treatment","_item"];

//diagnostics:
[_target,"splint action has been executed"] call adv_aceSplint_fnc_diag;

//execute custom splint local to the unit:
call {
	if (local _target) exitWith {
		//splint call:
		["adv_aceSplint_evh_splint", [_caller, _target, _selection]] call CBA_fnc_localEvent;
	};

	//splint call:
	["adv_aceSplint_evh_splint", [_caller, _target, _selection], _target] call CBA_fnc_targetEvent;
};

nil