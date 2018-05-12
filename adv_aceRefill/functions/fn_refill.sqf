/*
ADV-aceRefill - by Belbo
*/

params ["_unit","_param"];

if ( _param isEqualTo "ADV_ACEREFILL_AUTOKIT" && ( _unit getVariable ["ACE_medical_medicClass", 0] isEqualTo 0 || ({_x == "adv_aceRefill_autoKit"} count items _unit) isEqualTo 0 ) ) exitWith {nil};

private _refills = [_unit, _param] call adv_aceRefill_fnc_getRefill;

private _add = {
	params ["_unit","_type","_amount"];
	if !( (backpack _unit isEqualTo "") || (_param isEqualTo "ADV_ACEREFILL_FAK") ) exitWith {
		private _mediBack = unitBackpack _unit;
		_mediBack addItemCargoGlobal [_type, _amount];
	};
	for "_i" from 1 to _amount do { _unit addItem _type };
};

private _drop = {
	_this spawn {
		params ["_unit","_type"];
		private _litter = createVehicle ["WeaponHolderSimulated", _unit modelToWorldVisual ((_unit selectionPosition "leftHand") vectorAdd [0,-0.45,-0.05]), [], 0, "CAN_COLLIDE"];
		_litter setdir (getDir _unit -90);
		_litter addWeaponCargoGlobal [_type, 1];
		_litter setVelocity [sin(getdir _unit+90)*2,cos(getdir _unit+90)*2,0];
		sleep 60;
		deleteVehicle _litter;
	};
};

if ( _param isEqualTo "ADV_ACEREFILL_AUTOKIT" ) then {
	_unit removeItems "adv_aceRefill_autoKit";
	[_unit,"adv_aceRefill_Kit_empty"] call _drop;
};
if ( _param isEqualTo "ADV_ACEREFILL_MANUALKIT" ) then {
	_unit removeItem "adv_aceRefill_manualKit";
	[_unit,"adv_aceRefill_Kit_empty"] call _drop;
};
if ( _param isEqualTo "ADV_ACEREFILL_FAK" ) then {
	_unit removeItem "adv_aceRefill_FAK";
	private _litter = createVehicle ["MedicalGarbage_01_FirstAidKit_F", getPos _unit, [], 0, "CAN_COLLIDE"];
};

private _success = 0;
{
	_x params ["_type","_max"];
	if !(_type isEqualTo "") then {
		private _count = {_x == _type} count items _unit;
		private _amount = _max-_count;
		[_unit,_type,_amount,_param] call _add;
		_success = _success+_amount;
	};
	nil
} count _refills;

if ( _success < 6 && _param isEqualTo "ADV_ACEREFILL_FAK" ) then {
	_unit addItem "ADV_ACEREFILL_FAK";
};
if ( _success < 30 && !(_param isEqualTo "ADV_ACEREFILL_FAK") ) then {
	_unit addItem "ADV_ACEREFILL_MANUALKIT";
};

systemChat (localize "STR_ADV_REFILL_REFILLED");

nil