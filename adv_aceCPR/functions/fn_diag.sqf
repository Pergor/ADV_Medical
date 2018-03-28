/*
ADV-aceCPR - by Belbo
*/

params [
	"_target"
	,"_log"
];

//exit if diagnostics is not activated:
if !(missionNamespace getVariable ["adv_aceCPR_diag",false]) exitWith {false};

//log event local to the caller:
private _str = format ["adv_aceCPR - %1",_log];
systemChat _str;
if !(player diarySubjectExists "adv_aceCPR_log") then {
	player createDiarySubject ["adv_aceCPR_log","ADV - ACE CPR"];
};
player createDiaryRecord ["adv_aceCPR_log", ["Log", _str]];
call {
	if (local _target) exitWith {
		["adv_aceCPR_evh_log", [_str]] call CBA_fnc_localEvent;
	};
	["adv_aceCPR_evh_log", [_str]] call CBA_fnc_localEvent;
	["adv_aceCPR_evh_log", [_str], _target] call CBA_fnc_targetEvent;
};

true;