/*
    ADV_aceCPR_fnc_addTime - by Belbo
*/

params ["_caller", "_target"];

private _timeLeft = _target getVariable ["ace_medical_statemachine_cardiacArrestTimeLeft", nil];
private _timeAdded = 0;

//if target is in reviveState it will gain _addTimeSetting additional seconds of revive time:
if (!isNil "_timeLeft") then {
    private _addTimeSetting = (15 max (missionNamespace getVariable ["adv_aceCPR_addTime", 15])) min 45;
	_timeAdded = _timeLeft + _addTimeSetting + (round random 6) - 3;
    
    _target setVariable ["ace_medical_statemachine_cardiacArrestTimeLeft", _timeAdded];
    _target setVariable ["ace_medical_statemachine_cardiacArrestTimeLastUpdate", CBA_missionTime];
};

_return = _target getVariable "ace_medical_statemachine_cardiacArrestTimeLeft";

//diagnostics:
[
    _target,
    format [
        "cardiacArrestTimeLeft was %1. new is %2 added %3 seconds.",
        _timeLeft,
        _timeAdded,
        _timeAdded - _timeLeft
    ]
] call adv_aceCPR_fnc_diag;

//return:
_return;