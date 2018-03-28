/*
ADV_aceCPR_fnc_addTime - by Belbo
*/

params ["_caller", "_target"];

private _inState = _target getVariable ["ace_medical_inReviveState",false];
private _reviveStartTime = _target getVariable ["ace_medical_reviveStartTime",nil];
private _addTimeSetting = missionNamespace getVariable ["adv_aceCPR_addTime",15];
private _timeAdded = 0;

if (_addTimeSetting > 40) then {_addTimeSetting = 40};
if (_addTimeSetting < 15) then {_addTimeSetting = 15};

//if target is in reviveState it will gain _addTimeSetting additional seconds of revive time:
if (!isNil "_reviveStartTime") then {
	_timeAdded = _reviveStartTime + _addTimeSetting + (round random 6) - 3;
	_target setVariable ["ace_medical_reviveStartTime", _timeAdded min CBA_missionTime];
};

_return = _target getVariable "ace_medical_reviveStartTime";

//diagnostics:
[_target,format ["added time was %1. New reviveStartTime was %2, with a difference to cba_missiontime of %3 seconds.",_timeAdded-_reviveStartTime, _return, (CBA_missionTime - _return)]] call adv_aceCPR_fnc_diag;

//return:
_return;