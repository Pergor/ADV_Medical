/*
ADV-aceSplint - by Belbo
*/

private _handle = _this spawn {

	params ["_caller","_target","_oldBPS","_oldGetHitPoint","_oldGetHitPoint_BP","_hitPointArray","_selectionNumber"];

	_hitPointArray params ["_hitpoint","_bodyPart","_selection","_str"];

	[_target,format ["Reopening of Splint is being handled for %1.",_bodyPart]] call adv_aceSplint_fnc_diag;

	private _chance_medic = (missionNamespace getVariable ["adv_aceSplint_reopenChance_medic",0]) min 100;
	private _chance_regular = (missionNamespace getVariable ["adv_aceSplint_reopenChance_regular",0]) min 100;
	private _isMedic = _caller getVariable ["ACE_medical_medicClass", 0];
	private _chance = if ( _isMedic > 0 ) then { _chance_medic } then { _chance_regular };
	//private _chance = (missionNamespace getVariable ["adv_aceSplint_reopenChance",0]) min 100;
	private _reuse = (missionNamespace getVariable ["adv_aceSplint_reuseChance",80]) min 100;
	private _reopenTime = missionNamespace getVariable ["adv_aceSplint_reopenTime",600];
	private _time = (_reopenTime + ( round(random 60)-30 )) max 30;

	if ( ceil random 100 <= _chance ) exitWith {
		[_target,format ["Splint for %1 will reopen in %2 seconds.",_bodyPart,_time]] call adv_aceSplint_fnc_diag;
		
		//make sure we exit, if PAK is used:
		_target setVariable ["adv_aceSplint_reopenUndo",false];
		private _pakHandle = ["ace_medical_treatmentAdvanced_fullHealLocal",{
			params ["_caller", "_target"];
			if (local _target) exitWith {
				_target setVariable ["adv_aceSplint_reopenUndo",true];
				_target setVariable ["adv_aceSplint_splints",[0,0,0,0,0,0]];
			};
		}] call CBA_fnc_addEventHandler;
		
		sleep _time;
		
		["ace_medical_treatmentAdvanced_fullHealLocal", _pakHandle] call CBA_fnc_removeEventHandler;
		if ( _target getVariable ["adv_aceSplint_reopenUndo",false] || (_target getVariable ["adv_aceSplint_splints",[0,0,0,0,0,0]]) isEqualTo [0,0,0,0,0,0] ) exitWith {
			[_target,"PAK prevented falling off of splint."] call adv_aceSplint_fnc_diag;
			_target setVariable ["adv_aceSplint_splints",[0,0,0,0,0,0]];
			nil
		};
		
		private _bps = _target getVariable ["ace_medical_bodypartstatus",[0,0,0,0,0,0]];
		_bps set [_selectionNumber,_oldBPS];
		_target setVariable ["ace_medical_bodypartstatus",_bps,true];
		
		private _splints = _target getVariable ["adv_aceSplint_splints",[0,0,0,0,0,0]];
		_splints set [_selectionNumber,0];
		_target setVariable ["adv_aceSplint_splints",_splints,true];

		[_target,_hitpoint,_oldGetHitPoint,false] call ace_medical_fnc_setHitPointDamage;
		[_target,_bodyPart,_oldGetHitPoint_BP,false] call ace_medical_fnc_setHitPointDamage;
		
		if ( ceil random 100 <= _reuse ) then {
			[localize "STR_ADV_ACESPLINT_REOPEN_HINT_LOST", "\adv_aceSplint\ui\splint.paa", nil, _target, 2.7] call ace_common_fnc_displayTextPicture;
		} else {
			[localize "STR_ADV_ACESPLINT_REOPEN_HINT", "\adv_aceSplint\ui\splint.paa", nil, _target, 2.7] call ace_common_fnc_displayTextPicture;
			/*
			if (vehicle _target isEqualTo _target) exitWith {
				private _usedSplint = createVehicle ["WeaponHolderSimulated", _target modelToWorldVisual (_target selectionPosition _selection), [], 0, "CAN_COLLIDE"];
				_usedSplint addItemCargoGlobal ["adv_aceSplint_splint", 1];
				_usedSplint setVelocity [sin(getdir _target+0)*1,cos(getdir _target+0)*1.5,0];
			};
			*/
			_target addItem "adv_aceSplint_splint";
		};
		
		[_target, "activity", localize "STR_ADV_ACESPLINT_REOPEN", []] call ace_medical_fnc_addToLog;
		[_target, "activity_view", localize "STR_ADV_ACESPLINT_REOPEN", []] call ace_medical_fnc_addToLog;
		
		[_target,format ["Splint for %1 has reopened, new ace_medical_bodypartstatus is %2",_bodyPart,_bps]] call adv_aceSplint_fnc_diag;
	};
};

_handle