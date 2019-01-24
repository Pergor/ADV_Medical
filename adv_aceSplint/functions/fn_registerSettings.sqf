/*
ADV-aceSplint - by Belbo
*/

#define CBA_SETTINGS_CAT "ADV - ACE Splint"

//Reopen Chance
[
	"adv_aceSplint_enable"
	,"CHECKBOX"
	,localize "STR_ADV_ACESPLINT_SETTING_ENABLE"
	,CBA_SETTINGS_CAT
	,[true]
	,true
] call CBA_Settings_fnc_init;

//Patient Condition
[
	"adv_aceSplint_patientCondition"
	,"LIST"
	,localize "STR_ADV_ACESPLINT_SETTING_PATIENT_CONDITION"
	,CBA_SETTINGS_CAT
	,[[0,1],["STR_ADV_ACESPLINT_SETTING_PATIENT_CONDITION_NO","STR_ADV_ACESPLINT_SETTING_PATIENT_CONDITION_YES"],1]
	,true
] call CBA_Settings_fnc_init;

//Reopen Chance (MEDICS)
[
	"adv_aceSplint_reopenChance_medic"
	,"SLIDER"
	,localize "STR_ADV_ACESPLINT_SETTING_CHANCE_MED"
	,CBA_SETTINGS_CAT
	,[0,100,0,0]
	,true
] call CBA_Settings_fnc_init;

//Reopen Chance (REGULAR)
[
	"adv_aceSplint_reopenChance_regular"
	,"SLIDER"
	,localize "STR_ADV_ACESPLINT_SETTING_CHANCE_REG"
	,CBA_SETTINGS_CAT
	,[0,100,30,0]
	,true
] call CBA_Settings_fnc_init;

//Reopen Time
[
	"adv_aceSplint_reopenTime"
	,"SLIDER"
	,localize "STR_ADV_ACESPLINT_SETTING_TIME"
	,CBA_SETTINGS_CAT
	,[30,1200,600,0]
	,true
] call CBA_Settings_fnc_init;

//Reuse Chance
[
	"adv_aceSplint_reuseChance"
	,"SLIDER"
	,localize "STR_ADV_ACESPLINT_SETTING_REUSE"
	,CBA_SETTINGS_CAT
	,[0,100,80,0]
	,true
] call CBA_Settings_fnc_init;

nil