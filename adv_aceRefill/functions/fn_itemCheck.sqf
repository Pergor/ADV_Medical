/*
ADV-aceRefill - by Belbo
*/

params ["_unit"];

if !( _unit getVariable ["ACE_medical_medicClass", 0] > 0 ) exitWith {nil};

private _ML = missionnamespace getVariable ["ace_medical_level",2];
private _SK = missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0];
private _RI = ["ACE_fieldDressing","ACE_elasticBandage","ACE_packingBandage","ACE_epinephrine","ACE_morphine","ACE_tourniquet","ACE_plasmaIV_500","ACE_surgicalKit","adv_aceSplint_splint","ACE_bloodIV_500"];
private _hHPAAB = missionnamespace getVariable ["ace_medical_healHitPointAfterAdvBandage",true];
private _splint = isClass(configFile >> "CfgWeapons" >> "adv_aceSplint_splint");

private _add = {
	params ["_unit","_type","_amount"];
	if !(backpack _unit isEqualTo "") exitWith {
		for "_i" from 1 to _amount do { _unit addItemToBackpack _type };
	};
	for "_i" from 1 to _amount do { _unit addItem _type };
};

if ( ({_x == "adv_aceRefill_MediKit"} count items _unit) > 0 ) then {
	{ _unit removeItems _x; nil} count _RI;
};

while { ({_x == "adv_aceRefill_MediKit"} count items _unit) > 0 } do {
    _unit removeItem "adv_aceRefill_MediKit";
    if (_ML >= 2) then {
		[_unit, "ACE_fieldDressing", 12] call _add;
		[_unit, "ACE_elasticBandage", 24] call _add;
		[_unit, "ACE_packingBandage", 24] call _add;
		[_unit, "ACE_epinephrine", 8] call _add;
		[_unit, "ACE_morphine", 8] call _add;
		[_unit, "ACE_tourniquet", 4] call _add;
		[_unit, "ACE_plasmaIV_500", 8] call _add;
		if ( _SK > 0 ) then {
			[_unit, "ACE_surgicalKit", 4] call _add;
		};
		if ( _splint && !_hHPAAB ) then {
			[_unit, "adv_aceSplint_splint", 8] call _add;
		};
    } else {
		[_unit, "ACE_fieldDressing", 48] call _add;
		[_unit, "ACE_epinephrine", 8] call _add;
		[_unit, "ACE_morphine", 8] call _add;
		[_unit, "ACE_bloodIV_500", 8] call _add;
    };
};

nil