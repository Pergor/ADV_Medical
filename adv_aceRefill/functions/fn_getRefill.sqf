/*
ADV-aceRefill - by Belbo
*/

params ["_unit","_param"];

private _ML = missionnamespace getVariable ["ace_medical_level",2];
private _SK = missionnamespace getVariable ["ace_medical_consumeItem_SurgicalKit",0];
private _hHPAAB = missionnamespace getVariable ["ace_medical_healHitPointAfterAdvBandage",true];
private _splint = isClass(configFile >> "CfgWeapons" >> "adv_aceSplint_splint");
private _isMedic = _unit getVariable ["ACE_medical_medicClass", 0];
private _return = [["",0]];

if (_param isEqualTo "ADV_ACEREFILL_FAK") exitWith {
	_return = if (_ML > 1 ) then {
		[
			["ACE_fieldDressing",10]
			,["ACE_elasticBandage",2]
			,["ACE_morphine",1]
			,["ACE_tourniquet",2]
			,["ACE_salineIV_500",1]
		];
	} else {
		[
			["ACE_fieldDressing",12]
			,["ACE_morphine",2]
		];
	};
	_return
};

call {
	if (_ML > 1 && _isMedic > 1) exitWith {
		_return = [
			["ACE_fieldDressing",32]
			,["ACE_elasticBandage",32]
			,["ACE_packingBandage",24]
			,["ACE_epinephrine",12]
			,["ACE_morphine",12]
			,["ACE_tourniquet",6]
			,["ACE_plasmaIV_500",12]
		];
		if ( _SK > 0 ) then {
			_return pushBack ["ACE_surgicalKit",5];
		};
		if ( _splint && !_hHPAAB ) then {
			_return pushBack ["adv_aceSplint_splint",12];
		};
	};
	if (_ML > 1 && _isMedic isEqualTo 1) exitWith {
		_return = [
			["ACE_fieldDressing",6]
			,["ACE_elasticBandage",24]
			,["ACE_packingBandage",24]
			,["ACE_epinephrine",6]
			,["ACE_morphine",6]
			,["ACE_tourniquet",3]
			,["ACE_plasmaIV_500",8]
		];
		if ( _SK > 0 ) then {
			_return pushBack ["ACE_surgicalKit",5];
		};
		if ( _splint && !_hHPAAB ) then {
			_return pushBack ["adv_aceSplint_splint",4];
		};
	};
	if (_isMedic > 1) exitWith {
		_return = [
			["ACE_fieldDressing",64]
			,["ACE_epinephrine",12]
			,["ACE_morphine",12]
			,["ACE_bloodIV_500",12]
		];
	};
	if (_isMedic isEqualTo 1) exitWith {
		_return = [
			["ACE_fieldDressing",48]
			,["ACE_epinephrine",6]
			,["ACE_morphine",6]
			,["ACE_bloodIV_500",8]
		];	
	};
};

_return