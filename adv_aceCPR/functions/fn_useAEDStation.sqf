/*
ADV-aceCPR - by Belbo
*/

_this spawn {
	params [
		"_caller"
	];
	
	if !(_caller getVariable ["adv_aceCPR_usedAEDStation",false]) then {
	
		playsound3d ["adv_aceCPR\ui\load.ogg", _caller,false,getPosASL _caller,8,1,15];

		_caller setVariable ["adv_aceCPR_usedAEDStation",true];
		[localize "STR_ADV_ACECPR_AED_STATION_HINT_ON", 2] call ace_common_fnc_displayTextStructured;
	
		sleep 12;
		
		if (_caller getVariable "adv_aceCPR_usedAEDStation") then {
			_caller setVariable ["adv_aceCPR_usedAEDStation",false];
			[localize "STR_ADV_ACECPR_AED_STATION_HINT_OFF", 2] call ace_common_fnc_displayTextStructured;
		};
	};
};

nil