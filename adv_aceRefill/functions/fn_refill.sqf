/*
ADV-aceRefill - by Belbo
*/

params [["_unit",player],["_param",2],["_item","adv_aceRefill_manualKit"]];

if ( _param > 2 && ( _unit getVariable ["ACE_medical_medicClass", 0] isEqualTo 0 || ({_x == "adv_aceRefill_autoKit"} count items _unit) isEqualTo 0 ) ) exitWith {nil};

private _mAFAK = round (missionNamespace getVariable ["adv_aceRefill_FAK_minAmount",3]);
private _mAMK = round (missionNamespace getVariable ["adv_aceRefill_manualKit_minAmount",10]);
private _refills = [_unit, _param] call adv_aceRefill_fnc_getRefill;
private _litter = objNull;

private _add = {
	params ["_unit","_type","_amount"];
	if  ( _param > 1 && !(backpack _unit isEqualTo "") ) exitWith {
		private _mediBack = unitBackpack _unit;
		_mediBack addItemCargoGlobal [_type, _amount];
	};
	for "_i" from 1 to _amount do { _unit addItem _type };
};

private _remove = {
	params ["_target"];
	sleep 60;
	deleteVehicle _target;
};

private _drop = {
	params ["_unit","_type"];
	private _litter = createVehicle ["WeaponHolderSimulated", _unit modelToWorldVisual ((_unit selectionPosition "leftHand") vectorAdd [0,-0.45,-0.05]), [], 0, "CAN_COLLIDE"];
	_litter setdir (getDir _unit -90);
	_litter addWeaponCargoGlobal [_type, 1];
	_litter setVelocity [sin(getdir _unit+90)*2,cos(getdir _unit+90)*2,0];
	_litter
};

if ( _param < 3 ) then {
	_unit removeItem _item;
} else {
	_unit removeItems "ADV_ACEREFILL_AUTOKIT";
};

if ( _param < 2 ) then {
	_litter = createVehicle ["MedicalGarbage_01_FirstAidKit_F", getPos _unit, [], 0, "CAN_COLLIDE"];
} else {
	_litter = [_unit,"adv_aceRefill_Kit_empty"] call _drop;
};

private _success = 0;
{
	_x params ["_type","_max"];
	if !(_type isEqualTo "") then {
		private _count = {_x == _type} count items _unit;
		private _amount = _max-_count;
		[_unit,_type,_amount] call _add;
		_success = _success+_amount;
	};
	nil
} count _refills;

if ( ( _success < (_mAFAK+1) && _param < 2 ) || ( _success < (_mAMK+1) && _param > 1 ) ) exitWith {
	_unit addItem _item;
	private _str = if (_success > 0) then {
		(localize "STR_ADV_REFILL_REFILLED_NEW");
	} else {
		(localize "STR_ADV_REFILL_REFILLED_NOT");
	};
	systemChat _str;
	deleteVehicle _litter;
	nil
};

systemChat (localize "STR_ADV_REFILL_REFILLED");
[_litter] spawn _remove;

nil