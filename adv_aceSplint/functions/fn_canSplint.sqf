/*
ADV-aceSplint - by Belbo
*/

params ["_target","_selection"];

private _hhpaab = missionNamespace getVariable ["ace_medical_healHitPointAfterAdvBandage",false];

if ( _hhpaab ) exitWith { false };

private _hitPoint = call {
	if ( (toLower _selection) in ["hand_l","hand_r"] ) exitWith {"HitHands"};
	if ( (toLower _selection) in ["leg_l","leg_r"] ) exitWith {"HitLegs"};
	_selection
};

if ((_target getHitPointDamage _hitPoint) < 0.5) exitWith { false };

//if !([_target] call ace_medical_fnc_isInStableCondition) exitWith { false };

true