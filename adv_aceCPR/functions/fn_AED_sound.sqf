/*
ADV-aceCPR - by Belbo
*/

(_this select 0) params [
	"_caller"
	,"_target"
	,"_selectionName"
	,"_className"
	,"_items"
];

if !(_caller getVariable ["adv_aceCPR_var_soundplayed",false]) then {
	_caller setVariable ["adv_aceCPR_var_soundplayed",true];
	(_this select 0) spawn {
		params [
			"_caller"
			,"_target"
			,"_selectionName"
			,"_className"
			,"_items"
		];
		sleep 5.4;
		playsound3d ["adv_aceCPR\ui\defib.ogg", _caller,false,getPosASL _caller,8,1,15];
		sleep 3;
		_caller setVariable ["adv_aceCPR_var_soundplayed",false];
	};
};

//return:

_return = if !( [_target] call ace_common_fnc_isAwake ) then {true} else {false};

_return;
