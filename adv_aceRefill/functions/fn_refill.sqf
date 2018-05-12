/*
ADV-aceRefill - by Belbo
*/

params ["_unit"];

private _ML = missionnamespace getVariable ["ace_medical_level",2];
private _SK = missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0];
private _hHPAAB = missionnamespace getVariable ["ace_medical_healHitPointAfterAdvBandage",true];
private _splint = isClass(configFile >> "CfgWeapons" >> "adv_aceSplint_splint");
private _refills = [["NOTHING",0]];

private _add = {
	params ["_unit","_type","_amount"];
	if !(backpack _unit isEqualTo "") exitWith {
		private _mediBack = unitBackpack _unit;
		_mediBack addItemCargoGlobal [_type, _amount];
	};
	for "_i" from 1 to _amount do { _unit addItem _type };
};

_unit removeItem "adv_aceRefill_manualKit";

if (_ML > 1) then {
	_refills = [
		["ACE_fieldDressing",32]
		,["ACE_elasticBandage",32]
		,["ACE_packingBandage",32]
		,["ACE_packingBandage",24]
		,["ACE_epinephrine",12]
		,["ACE_morphine",12]
		,["ACE_tourniquet",6]
		,["ACE_plasmaIV_500",12]
	];
	if ( _SK > 0 ) then {
		_refills pushBack ["ACE_surgicalKit",5];
	};
	if ( _splint && !_hHPAAB ) then {
		_refills pushBack ["adv_aceSplint_splint",12];
	};	
} else {
	_refills = [
		["ACE_fieldDressing",64]
		,["ACE_epinephrine",12]
		,["ACE_morphine",12]
		,["ACE_bloodIV_500",12]
	];
};

{
	_x params ["_type","_max"];
	if !(_type isEqualTo "") then {
		private _count = {_x == _type} count items _unit;
		[_unit,_type,_max-_count] call _add;
	};
	nil
} count _refills;

nil