class CfgPatches
{
    class adv_aceCPR
    {
        units[] = {
			"adv_aceCPR_AEDItem"
			//,"adv_aceCPR_AEDStation"
		};
        weapons[] = {
			"adv_aceCPR_AED"
		};
        requiredVersion = 1.88;
        requiredAddons[] = {
			"ace_medical"
			,"cba_settings"
		};
		version = "1.5.5";
		versionStr = "1.5.5";
		author = "[SeL] Belbo // Adrian";
		authorUrl = "http://spezialeinheit-luchs.de/";
    };
};

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
}

#define MACRO_AED_STATION class ACE_Actions { \
	class ACE_MainActions { \
		condition = "true"; \
		displayName = "Interactions"; \
		distance = 2; \
		selection = ""; \
		class adv_aceCPR_aed_station { \
			priority = -1; \
			showDisabled = 0; \
			displayName = "$STR_ADV_ACECPR_AED_STATION_ACTION"; \
			condition = "missionNamespace getVariable ['adv_aceCPR_enable',true] && !(_player getVariable ['adv_aceCPR_usedAEDStation',false]) && (_player getVariable ['ace_medical_medicClass',0]) > 0"; \
			statement = "[_player,_target] call adv_aceCPR_fnc_useAEDStation"; \
			exceptions[] = {"isNotInside"}; \
			icon = "\adv_aceCPR\ui\defib_action.paa"; \
		};\
	};\
};

class CfgFunctions {
	class adv_aceCPR {
		tag = "adv_aceCPR";
		class init {
			file = "adv_aceCPR\functions";
			class addTime {};
			class AED_action {};
			//class AED_countUses {};
			class AED_local {};
			class AED_sound {};
			class AED_station {};
			class AED_station_condition {};
			class CPR_action {};
			class CPR_local {};
			class createAEDstations {};
			class diag {};
			class getBloodLoss {};
			class getList {};
			class init { postInit = 1; };
			class isResurrectable {};
			class probability {};
			class registerSettings {};
			class useAEDStation {};
		};
	};
	class adv_aceCPR_ace_medical
	{
		tag = "ace_medical";
		class ace_medical
		{
			class actionCheckPulseLocal
			{
				file = "adv_aceCPR\functions\fn_actionCheckPulseLocal.sqf";
			};
		};
	};	
};

class Extended_PreInit_EventHandlers {
	class adv_aceCPR_preInit {
		init = "call adv_aceCPR_fnc_registerSettings";
	};
};

class Extended_PostInit_EventHandlers {
    class adv_aceCPR_postInit {
        init = "nul = [] spawn adv_aceCPR_fnc_createAEDstations";
    };
};

class cfgWeapons {
	class ACE_ItemCore;
	class CBA_MiscItem_ItemInfo;
	
    class adv_aceCPR_AED: ACE_ItemCore {
        scope = 2;
        displayName = "$STR_ADV_ACECPR_AED_DISPLAYNAME";
        picture = "\adv_aceCPR\ui\defib.paa";
		model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
        descriptionShort = "$STR_ADV_ACECPR_AED_DESCRIPTION";
        descriptionUse = "$STR_ADV_ACECPR_AED_DESCRIPTION";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 30;
        };
	};	
    class adv_aceCPR_AED_used: ACE_ItemCore {
        scope = 1;
        displayName = "$STR_ADV_ACECPR_AED_USED_DISPLAYNAME";
        picture = "\adv_aceCPR\ui\defib.paa";
		model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
        descriptionShort = "$STR_ADV_ACECPR_AED_DESCRIPTION";
        descriptionUse = "$STR_ADV_ACECPR_AED_DESCRIPTION";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 30;
        };
	};
};

class cfgVehicles {
	class Item_Base_F;
	
	class adv_aceCPR_AEDItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_ADV_ACECPR_AED_DISPLAYNAME";
        author = "[SeL] Belbo";
        vehicleClass = "Items";
		model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
        class TransportItems {
            MACRO_ADDITEM(adv_aceCPR_AED,1);
        };
	};
	/*
	class adv_aceCPR_AEDStation: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_ADV_ACECPR_AEDSTATION_DISPLAYNAME";
        author = "[SeL] Belbo";
        vehicleClass = "Items";
		model = "\adv_aceCPR\ui\defi.p3d";
		MACRO_AED_STATION
		ace_dragging_canCarry = 1;
		ace_dragging_carryPosition[] = {0,1,1};
		ace_dragging_carryDirection = 270;
        ace_cargo_size = 1;
		ace_cargo_canLoad = 1;
	};
	*/
	
	//ace_medical_actions:
	class Man;
	class CAManBase: Man {
		class ACE_Actions {
			class ACE_Torso {
				class CPR;
				class adv_aceCPR_AED: CPR {
					displayName = "$STR_ADV_ACECPR_AED_ACTION";
					condition = "[_player, _target, 'body', 'Defibrillator'] call ace_medical_fnc_canTreatCached && (missionNamespace getVariable ['adv_aceCPR_enable',true])";
					statement = "[_player, _target, 'body', 'Defibrillator'] call ace_medical_fnc_treatment";
					exceptions[] = {""};
					icon = "\adv_aceCPR\ui\defib_action.paa";
				};
				class adv_aceCPR_AED_station: adv_aceCPR_AED {
					condition = "[_player, _target, 'body', 'Defibrillator_station'] call ace_medical_fnc_canTreatCached && (missionNamespace getVariable ['adv_aceCPR_enable',true])";
					statement = "[_player, _target, 'body', 'Defibrillator_station'] call ace_medical_fnc_treatment";
				};
			};
			class ACE_MainActions {
				class Medical {
					class ACE_Torso {
						class CPR;
						class adv_aceCPR_AED: CPR {
							displayName = "$STR_ADV_ACECPR_AED_ACTION";
							condition = "[_player, _target, 'body', 'Defibrillator'] call ace_medical_fnc_canTreatCached && (missionNamespace getVariable ['adv_aceCPR_enable',true])";
							statement = "[_player, _target, 'body', 'Defibrillator'] call ace_medical_fnc_treatment";
							exceptions[] = {"isNotInside"};
							icon = "\adv_aceCPR\ui\defib_action.paa";
						};
						class adv_aceCPR_AED_station: adv_aceCPR_AED {
							condition = "[_player, _target, 'body', 'Defibrillator_station'] call ace_medical_fnc_canTreatCached && (missionNamespace getVariable ['adv_aceCPR_enable',true])";
							statement = "[_player, _target, 'body', 'Defibrillator_station'] call ace_medical_fnc_treatment";
						};
					};
				};
			};
		};
	};

	class Items_base_F;
	class Land_Defibrillator_F: Items_base_F {
		//MACRO_AED_STATION
		ace_dragging_canCarry = 1;
		ace_dragging_carryPosition[] = {0,1,1};
		ace_dragging_carryDirection = 270;
        ace_cargo_size = 1;
		ace_cargo_canLoad = 1;
	};
	
	class NATO_Box_Base;
	class ACE_medicalSupplyCrate: NATO_Box_Base {
		class TransportItems;
	};
	class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
		class TransportItems: TransportItems {
			MACRO_ADDITEM(adv_aceCPR_AED,1);
		};
	};
};

class ACE_Medical_Actions {
	class Advanced {
		class fieldDressing;
		class CPR: fieldDressing {
			callbackSuccess = "adv_aceCPR_fnc_CPR_action";
			animationCaller = "AinvPknlMstpSnonWnonDr_medic0";
			animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
			animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
		};
		class Defibrillator: CPR {
            displayName = "$STR_ADV_ACECPR_AED_DISPLAYNAME";
			displayNameProgress = "$STR_ADV_ACECPR_AED_PROGRESS";
			items[] = {"adv_aceCPR_AED"};
			condition = "!([_target] call ace_common_fnc_isAwake) && missionNamespace getVariable ['adv_aceCPR_enable',true]";
			treatmentTime = 8;
			requiredMedic = 1;
			callbackSuccess = "adv_aceCPR_fnc_AED_action";
			callbackProgress = "adv_aceCPR_fnc_AED_sound";
			animationCaller = "AinvPknlMstpSnonWnonDnon_medic3";
			treatmentLocations[] = {"adv_aceCPR_useLocation_AED"};
		};
		class Defibrillator_station: Defibrillator {
			items[] = {};
			condition = "[_player,_target] call adv_aceCPR_fnc_AED_station_condition";
			callbackSuccess = "adv_aceCPR_fnc_AED_station";
			callbackProgress = "";
			animationCaller = "AinvPknlMstpSnonWnonDnon_medic3";
			treatmentLocations[] = {"All"};
		};
	};
};