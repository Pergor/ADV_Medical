/*
ADV-aceCPR - by Belbo
*/

params [
	"_caller"
	,"_target"
	,"_selectionName"
	,"_className"
	,"_items"
];

playsound3d ["adv_aceCPR\ui\bump.ogg", _caller,false,getPosASL _caller,8,1,15];	

_this call adv_aceCPR_fnc_AED_action;

_caller setVariable ["adv_aceCPR_usedAEDStation",false];

nil