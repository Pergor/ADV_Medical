/*
ADV-aceCPR - by Belbo
*/

//register the eventhandlers:
//evh for the CPR:
["adv_aceCPR_evh_CPR_local", { _this call adv_aceCPR_fnc_CPR_local }] call CBA_fnc_addEventHandler;
//evh for the addition of revive time:
["adv_aceCPR_evh_addTime", { _this call adv_aceCPR_fnc_addTime }] call CBA_fnc_addEventHandler;
//evh for showing the pulse after AED:
["adv_aceCPR_evh_showPulse", { _this call ace_medical_fnc_actionCheckPulse }] call CBA_fnc_addEventHandler;
//evh for the AED:
["adv_aceCPR_evh_AED_local", { _this call adv_aceCPR_fnc_AED_local }] call CBA_fnc_addEventHandler;

//for diagnostic purposes only:
["adv_aceCPR_evh_log", { diag_Log (format ["%1",_this]) }] call CBA_fnc_addEventHandler;

missionNamespace setVariable ["adv_aceCPR_diag",false];

nil