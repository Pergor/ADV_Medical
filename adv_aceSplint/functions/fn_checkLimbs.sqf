/*
ADV-aceSplint - by Belbo
*/

params ["_caller","_target","_selection","_treatment","_item"];


private _genericMessages = [localize "STR_ADV_ACESPLINT_CHECKLIMBS_MESSAGE",[_target] call ace_common_fnc_getName];

if ( _target getHitPointDamage "HitLegs" < 0.5 ) then {
	_genericMessages pushBack (format [localize "STR_ADV_ACESPLINT_CHECKLIMBS_NOTHIT",localize "STR_ADV_ACESPLINT_LEGS"]);
} else {
	_genericMessages pushBack (format [localize "STR_ADV_ACESPLINT_CHECKLIMBS_HIT",localize "STR_ADV_ACESPLINT_LEGS"]);
};

if ( _target getHitPointDamage "HitHands" < 0.5 ) then {
	_genericMessages pushBack (format [localize "STR_ADV_ACESPLINT_CHECKLIMBS_NOTHIT",localize "STR_ADV_ACESPLINT_ARMS"]);
} else {
	_genericMessages pushBack (format [localize "STR_ADV_ACESPLINT_CHECKLIMBS_HIT",localize "STR_ADV_ACESPLINT_ARMS"]);
};

["ace_common_displayTextStructured", [_genericMessages, 3.0, _caller], [_caller]] call CBA_fnc_targetEvent;