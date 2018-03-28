/*
ADV-aceSplint - by Belbo
*/

params ["_selectionNumber"];

private _return = call {
	if ( _selectionNumber isEqualTo 2 ) exitWith { ["hithands","hitleftarm","hand_l",localize "STR_ADV_ACESPLINT_ARM"] };
	if ( _selectionNumber isEqualTo 3 ) exitWith { ["hithands","hitrightarm","hand_r",localize "STR_ADV_ACESPLINT_ARM"] };
	if ( _selectionNumber isEqualTo 4 ) exitWith { ["hitlegs","hitleftleg","leg_l",localize "STR_ADV_ACESPLINT_LEG"] };
	if ( _selectionNumber isEqualTo 5 ) exitWith { ["hitlegs","hitrightleg","leg_r",localize "STR_ADV_ACESPLINT_LEG"] };
	["","",_selection]
};

_return