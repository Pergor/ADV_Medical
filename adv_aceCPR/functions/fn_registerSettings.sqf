/*
ADV-aceCPR - by Belbo
*/

#define CBA_SETTINGS_CAT "ADV - ACE CPR"

missionNamespace setVariable ["adv_aceCPR_probabilities",[40,15,5,85]];

//Enable ADV - ACE CPR
[
	"adv_aceCPR_enable"
	,"CHECKBOX"
	,localize "STR_ADV_ACECPR_SETTING_ENABLE"
	,CBA_SETTINGS_CAT
	,[true]
	,true
] call CBA_Settings_fnc_init;

//Added time with CPR
[
	"adv_aceCPR_addTime"
	,"SLIDER"
	,localize "STR_ADV_ACECPR_SETTING_ADDTIME"
	,CBA_SETTINGS_CAT
	,[15,40,20,0]
	,true
] call CBA_Settings_fnc_init;

//CPR possible until
[
	"adv_aceCPR_maxTime"
	,"SLIDER"
	,localize "STR_ADV_ACECPR_SETTING_MAXTIME"
	,CBA_SETTINGS_CAT
	,[0,3600,1200,0]
	,true
] call CBA_Settings_fnc_init;

//Chance for medicClass == 2
[
	"adv_aceCPR_chance_2"
	,"SLIDER"
	,localize "STR_ADV_ACECPR_SETTING_CHANCE_2"
	,CBA_SETTINGS_CAT
	,[0,100,40,0]
	,true
    ,{
		params ["_value"];
        adv_aceCPR_probabilities set [0,round _value];
	}
] call CBA_Settings_fnc_init;

//Chance for medicClass == 1
[
	"adv_aceCPR_chance_1"
	,"SLIDER"
	,localize "STR_ADV_ACECPR_SETTING_CHANCE_1"
	,CBA_SETTINGS_CAT
	,[0,100,15,0]
	,true
    ,{
		params ["_value"];
        adv_aceCPR_probabilities set [1,round _value];
	}
] call CBA_Settings_fnc_init;

//Chance for medicClass == 0
[
	"adv_aceCPR_chance_0"
	,"SLIDER"
	,localize "STR_ADV_ACECPR_SETTING_CHANCE_0"
	,CBA_SETTINGS_CAT
	,[0,100,5,0]
	,true
    ,{
		params ["_value"];
        adv_aceCPR_probabilities set [2,round _value];
	}
] call CBA_Settings_fnc_init;

//Chance for AED
[
	"adv_aceCPR_chance_aed"
	,"SLIDER"
	,localize "STR_ADV_ACECPR_SETTING_CHANCE_AED"
	,CBA_SETTINGS_CAT
	,[0,100,85,0]
	,true
    ,{
		params ["_value"];
        adv_aceCPR_probabilities set [3,round _value];
	}
] call CBA_Settings_fnc_init;

[
	"adv_aceCPR_useLocation_AED"
	,"LIST"
	,[localize "STR_ADV_ACECPR_SETTING_LOCATION_AED",localize "STR_ADV_ACECPR_SETTING_LOCATION_AED_DESCRIPTION"]
	,CBA_SETTINGS_CAT
	,[[0,1,2,3],["STR_ACE_Medical_AdvancedMedicalSettings_anywhere","STR_ACE_Medical_AdvancedMedicalSettings_vehicle","STR_ACE_Medical_AdvancedMedicalSettings_facility","STR_ACE_Medical_AdvancedMedicalSettings_vehicleAndFacility"],0]
	,true
] call CBA_Settings_fnc_init;

/*
//Disable for certain classes
[
	"adv_aceCPR_onlyDoctors"
	,"LIST"
	,localize "STR_ADV_ACECPR_SETTING_DISABLE"
	,CBA_SETTINGS_CAT
	,[[0,1,2],["STR_ADV_ACECPR_SETTING_DISABLE_NONE","STR_ADV_ACECPR_SETTING_DISABLE_SOLDIERS","STR_ADV_ACECPR_SETTING_DISABLE_MEDICS"],0]
	,true
] call CBA_Settings_fnc_init;
*/

nil