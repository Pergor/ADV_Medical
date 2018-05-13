/*
ADV-aceRefill - by Belbo
*/

#define CBA_SETTINGS_CAT "ADV - ACE Refill"

//FAK max Amount:
[
	"adv_aceRefill_FAK_minAmount"
	,"SLIDER"
	,["FAK - min amount for removal", "How many items can a player take from Individual First Aid Kit before it will be removed upon refill?"]
	,CBA_SETTINGS_CAT
	,[0, 6, 3, 0]
	,true
] call CBA_Settings_fnc_init;

//MediKit max Amount:
[
	"adv_aceRefill_manualKit_minAmount"
	,"SLIDER"
	,["Medical Refill Kit - min amount for removal", "How many items can a player take from Medical Refill Kit before it will be removed upon refill?"]
	,CBA_SETTINGS_CAT
	,[0, 40, 10, 0]
	,true
] call CBA_Settings_fnc_init;

nil