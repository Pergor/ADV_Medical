/*
ADV-aceSplint - by Belbo
*/

//register the eventhandlers:
//evh for the splinting:
["adv_aceSplint_evh_splint", { _this call adv_aceSplint_fnc_splint_local }] call CBA_fnc_addEventHandler;

//for diagnostic purposes only:
["adv_aceSplint_evh_log", { diag_Log (format ["%1",_this]) }] call CBA_fnc_addEventHandler;

missionNamespace setVariable ["adv_aceSplint_diag",false];

//set the chance for the splint to 'fall off':
//missionNamespace setVariable ["adv_aceSplint_reopenChance",0];
//set the time for the splint to 'fall off':
//missionNamespace setVariable ["adv_aceSplint_reopenTime",600];

nil