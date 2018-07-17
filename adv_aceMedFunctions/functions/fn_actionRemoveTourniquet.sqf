/*
 * Author: Glowbal
 * Action for removing the tourniquet on specified selection
 * ADDED BY BELBO: tourniquet is given back to target, not to caller!
 *
 * Arguments:
 * 0: The medic <OBJECT>
 * 1: The patient <OBJECT>
 * 2: SelectionName <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, kevin, "selection"] call ace_medical_fnc_actionRemoveTourniquet
 *
 * Public: Yes
 */

params ["_caller", "_target", "_selectionName"];
//TRACE_3("params",_caller,_target,_selectionName);

// grab the required data
private _part = [_selectionName] call ace_medical_fnc_selectionNameToNumber;
private _tourniquets = _target getVariable ["ace_medical_tourniquets", [0,0,0,0,0,0]];

// Check if there is a tourniquet on this bodypart
if ((_tourniquets select _part) == 0) exitWith {
    ["ace_common_displayTextStructured", ["STR_ACE_noTourniquetOnBodyPart", 1.5, _caller], [_caller]] call CBA_fnc_targetEvent;
};

// Removing the tourniquet
_tourniquets set [_part, 0];
_target setVariable ["ace_medical_tourniquets", _tourniquets, true];

// Adding the tourniquet item to the caller
//CHANGE BY BELBO - START
//_caller addItem "ACE_tourniquet";
//if ( [_target, "ACE_tourniquet"] call ace_common_fnc_hasItem ) then {
if ( ({_x == "ACE_tourniquet"} count (items _target)) > 1 ) then {
	_caller addItem "ACE_tourniquet";
} else {
	_target addItem "ACE_tourniquet";
};
//CHANGE BY BELBO - END

//Handle all injected medications now that blood is flowing:
private _delayedMedications = _target getVariable ["ace_medical_occludedMedications", []];
private _updatedArray = false;
//TRACE_2("meds",_part,_delayedMedications);
{
    _x params ["", "", "_medPartNum"];
    if (_part == _medPartNum) then {
        ["ace_medical_treatmentAdvanced_medicationLocal", _x, [_target]] call CBA_fnc_targetEvent;
        _delayedMedications set [_forEachIndex, -1];
        _updatedArray = true;
    };
} forEach _delayedMedications;

if (_updatedArray) then {
    _delayedMedications = _delayedMedications - [-1];
    _target setVariable ["ace_medical_occludedMedications", _delayedMedications, true];
};