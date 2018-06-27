/*
 * Author: Glowbal
 * Local callback for checking the pulse of a patient
 * SLIGHTLY edited by Belbo
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, kevin] call ACE_medical_fnc_actionCheckPulseLocal
 *
 * Public: No
 */

params ["_caller", "_unit", "_selectionName"];

private _heartRate = _unit getVariable ["ace_medical_heartRate", 80];
//EDITED BY BELBO:
private _inRevive = _unit getVariable ["ace_medical_inReviveState",false];
if (!alive _unit || _inRevive) then {
//END OF EDIT
    _heartRate = 0;
};
private _heartRateOutput = localize "STR_ACE_Medical_Check_Pulse_Output_5";
private _logOutPut = localize "STR_ACE_Medical_Check_Pulse_None";

if (_heartRate > 1.0) then {
    if ([_caller] call ace_medical_fnc_isMedic) then {
        _heartRateOutput = localize "STR_ACE_Medical_Check_Pulse_Output_1";
        _logOutPut = format["%1",round(_heartRate)];
    } else {
        // non medical personel will only find a pulse/HR
        _heartRateOutput = localize "STR_ACE_Medical_Check_Pulse_Output_2";
        _logOutPut = localize "STR_ACE_Medical_Check_Pulse_Weak";
        if (_heartRate > 60) then {
            if (_heartRate > 100) then {
                _heartRateOutput = localize "STR_ACE_Medical_Check_Pulse_Output_3";
                _logOutPut = localize "STR_ACE_Medical_Check_Pulse_Strong";
            } else {
                _heartRateOutput = localize "STR_ACE_Medical_Check_Pulse_Output_4";
                _logOutPut = localize "STR_ACE_Medical_Check_Pulse_Normal";
            };
        };
    };
};

if (_selectionName in ["hand_l","hand_r"] && {[_unit, _selectionName] call ace_medical_fnc_hasTourniquetAppliedTo}) then {
    _heartRateOutput = localize "STR_ACE_Medical_Check_Pulse_Output_5";
    _logOutPut = localize "STR_ACE_Medical_Check_Pulse_None";
};

//EDITED BY BELBO:
private _height = 1.5;
if (_inRevive) then {
	_heartRateOutput = format [_heartRateOutput+("%1"),".<br/>You need to use CPR or AED to resuscitate."];
	_height = 2.5;
};

["ace_common_displayTextStructured", [[_heartRateOutput, [_unit] call ace_common_fnc_getName, round(_heartRate)], _height, _caller], [_caller]] call CBA_fnc_targetEvent;
//END OF EDIT

if (_logOutPut != "") then {
    [_unit,"activity", localize "STR_ACE_Medical_Check_Pulse_Log",[[_caller] call ace_common_fnc_getName,_logOutPut]] call ace_medical_fnc_addToLog;
    [_unit,"quick_view", localize "STR_ACE_Medical_Check_Pulse_Log",[[_caller] call ace_common_fnc_getName,_logOutPut]] call ace_medical_fnc_addToLog;
};