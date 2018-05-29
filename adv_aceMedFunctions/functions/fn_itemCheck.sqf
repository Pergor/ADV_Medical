/*
 * Author: KoffeinFlummi - modified by Belbo
 * Replaces vanilla items with ACE ones.
 *
 * Arguments:
 * 0: The unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call ace_medical_fnc_itemCheck
 *
 * Public: Yes
 */

params ["_unit"];

private _ML = missionnamespace getVariable ["ace_medical_level",2];
private _SK = missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0];
private _hHPAAB = missionnamespace getVariable ["ace_medical_healHitPointAfterAdvBandage",true];
private _splint = isClass(configFile >> "CfgWeapons" >> "adv_aceSplint_splint");

private _add = {
	params ["_unit","_type","_amount"];
	if !(backpack _unit isEqualTo "") exitWith {
		for "_i" from 1 to _amount do { _unit addItemToBackpack _type };
	};
	for "_i" from 1 to _amount do { _unit addItem _type };
};

while {({_x == "FirstAidKit"} count items _unit) > 0} do {
    _unit removeItem "FirstAidKit";
    if (_ML >= 2) then {
		[_unit,"ACE_fieldDressing",2] call _add;
		[_unit,"ACE_elasticBandage",2] call _add;
		[_unit,"ACE_tourniquet",1] call _add;
    } else {
		[_unit,"ACE_fieldDressing",3] call _add;
    };
	[_unit,"ACE_morphine",1] call _add;
};

while {({_x == "Medikit"} count items _unit) > 0} do {
    _unit removeItem "Medikit";
    if (_ML >= 2) then {
		[_unit,"ACE_packingBandage",3] call _add;
		[_unit,"ACE_elasticBandage",4] call _add;
		[_unit,"ACE_epinephrine",8] call _add;
		[_unit,"ACE_morphine",2] call _add;
		[_unit,"ACE_plasmaIV_500",4] call _add;
		[_unit,"ACE_tourniquet",1] call _add;
		if ( _SK > 0 ) then {
			[_unit,"ACE_surgicalKit",4] call _add;
		};
		if ( _splint && !_hHPAAB ) then {
			[_unit,"adv_aceSplint_splint",6] call _add;
		};
    } else {
		[_unit,"ACE_epinephrine",4] call _add;
		[_unit,"ACE_bloodIV",4] call _add;
    };
};

nil