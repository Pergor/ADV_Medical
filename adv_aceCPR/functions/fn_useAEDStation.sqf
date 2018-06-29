/*
ADV-aceCPR - by Belbo
*/

_this spawn {
	params [
		"_caller"
		,"_target"
	];
	
	if !(_caller getVariable ["adv_aceCPR_usedAEDStation",false]) then {
		sleep 1;
		
		playsound3d ["adv_aceCPR\ui\load.ogg", _target,false,getPosASL _target,8,1,15];

		_caller setVariable ["adv_aceCPR_usedAEDStation",true];
		[localize "STR_ADV_ACECPR_AED_STATION_HINT_ON", 2] call ace_common_fnc_displayTextStructured;
	
		sleep 12;
		
		private _animState = toLower (animationState _caller);
		if ( _animState in ["ainvpknlmstpsnonwnondnon_medic3","ainvpknlmstpsnonwnondnon_medicend"] ) exitWith {};
		if ( _caller getVariable "adv_aceCPR_usedAEDStation" ) then {
			_caller setVariable ["adv_aceCPR_usedAEDStation",false];
			playsound3d ["adv_aceCPR\ui\fuse.ogg", _target,false,getPosASL _target,8,1,15];
			[localize "STR_ADV_ACECPR_AED_STATION_HINT_OFF", 2] call ace_common_fnc_displayTextStructured;
		};
	};
};

nil