/*
ADV-aceSplint - by Belbo
*/

params ["_caller","_target","_selection"];

private _selectionNumber = [_selection] call ace_medical_fnc_selectionNameToNumber;

private _hitPointArray = [_selectionNumber] call adv_aceSplint_fnc_getHitPoint;
_hitPointArray params ["_hitpoint","_bodyPart","_selection","_str"];

private _bps = _target getVariable ["ace_medical_bodypartstatus",[0,0,0,0,0,0]];
private _oldBPS = _bps select _selectionNumber;
private _oldGetHitPoint = _target getHitPointDamage _hitPoint;
private _oldGetHitPoint_BP = _target getHitPointDamage _bodyPart;

private _splints = _target getVariable ["adv_aceSplint_splints",[0,0,0,0,0,0]];

[_target,_hitpoint,0,false] call ace_medical_fnc_setHitPointDamage;
[_target,_bodyPart,0,false] call ace_medical_fnc_setHitPointDamage;

_bps set [_selectionNumber,0];
_splints set [_selectionNumber,1];

_target setVariable ["ace_medical_bodypartstatus",_bps,true];
_target setVariable ["adv_aceSplint_splints",_splints,true];

private _nameCaller = [_caller, false, true] call ace_common_fnc_getName;
private _nameTarget = [_caller, false, true] call ace_common_fnc_getName;

[_target, "activity", localize "STR_ADV_ACESPLINT_APPLIED", [_nameCaller,_nameTarget,_str]] call ace_medical_fnc_addToLog;
[_target, "activity_view", localize "STR_ADV_ACESPLINT_APPLIED", [_nameCaller,_nameTarget,_str]] call ace_medical_fnc_addToLog;

[_target,"Patient has been splinted"] call adv_aceSplint_fnc_diag;

private _chance = missionNamespace getVariable ["adv_aceSplint_reopenChance",0];
if (_chance > 0) then {
	[_target,_oldBPS,_oldGetHitPoint,_oldGetHitPoint_BP,_hitPointArray,_selectionNumber] call adv_aceSplint_fnc_reopen;
};

nil