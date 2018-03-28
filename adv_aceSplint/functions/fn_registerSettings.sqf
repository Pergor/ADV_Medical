/*
ADV-aceSplint - by Belbo
*/

#define CBA_SETTINGS_CAT "ADV - ACE Splint"

//Reopen Chance
[
	"adv_aceSplint_reopenChance"
	,"SLIDER"
	,localize "STR_ADV_ACESPLINT_SETTING_CHANCE"
	,CBA_SETTINGS_CAT
	,[0,100,0,0]
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