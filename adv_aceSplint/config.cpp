class CfgPatches
{
    class adv_aceSplint
    {
        units[] = {
			"adv_aceSplint_splintItem"
			,"adv_aceSplint_splintItem_used"
		};
        weapons[] = {
			"adv_aceSplint_splint"
			,"adv_aceSplint_splint_used"
		};
        requiredVersion = 1.80;
        requiredAddons[] = {
			"ace_medical"
			,"cba_settings"
		};
		version = "1.1.3";
		versionStr = "1.1.3";
		author = "[SeL] Belbo // Adrian";
		authorUrl = "http://spezialeinheit-luchs.de/";
    };
};

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
}

class CfgFunctions {
	class adv_aceSplint {
		tag = "adv_aceSplint";
		class init {
			file = "adv_aceSplint\functions";
			class init { postInit = 1; };
			class canSplint {};
			class diag {};
			class getHitPoint {};
			class registerSettings {};
			class reopen {};
			class splint_local {};
			class splint {};
		};
	};
};

class Extended_PreInit_EventHandlers {
	class adv_aceSplint_Settings {
		init = "call adv_aceSplint_fnc_registerSettings";
	};
};

class cfgWeapons {
	class ACE_ItemCore;
	class CBA_MiscItem_ItemInfo;
	
    class adv_aceSplint_splint: ACE_ItemCore {
        scope = 2;
        displayName = "$STR_ADV_ACESPLINT_DISPLAYNAME";
        descriptionShort = "$STR_ADV_ACESPLINT_DESCRIPTION";
        descriptionUse = "$STR_ADV_ACESPLINT_DESCRIPTION";
        picture = "\adv_aceSplint\ui\splint.paa";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 3;
        };
	};
	class adv_aceSplint_splint_used: adv_aceSplint_splint {
		scope = 0;
        displayName = "$STR_ADV_ACESPLINT_DISPLAYNAME_USED";
	};
};

class cfgVehicles {
	class Item_Base_F;
	
	class adv_aceSplint_splintItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_ADV_ACESPLINT_DISPLAYNAME";
        author = "[SeL] Belbo";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(adv_aceSplint_splint,1);
        };
	};
	class adv_aceSplint_splintItem_USED: adv_aceSplint_splintItem {
        scope = 0;
        scopeCurator = 0;
        displayName = "$STR_ADV_ACESPLINT_DISPLAYNAME_USED";
        class TransportItems {
            MACRO_ADDITEM(adv_aceSplint_splint_used,1);
        };
	};
	
	//ace_medical_actions:
	class Man;
	class CAManBase: Man {
		class ACE_Actions {
			#define EXCEPTIONS exceptions[] = {};
			#include "ace_medical_actions.hpp"
			class ACE_MainActions {
				class Medical {
                    #undef EXCEPTIONS
                    #define EXCEPTIONS exceptions[] = {"isNotInside"};
					#include "ace_medical_actions.hpp"
				};
			};
		};
		class ACE_SelfActions {
			class Medical {
				#include "ace_medical_actions.hpp"
			};
		};
	};
	
	class NATO_Box_Base;
	class ACE_medicalSupplyCrate: NATO_Box_Base {
		class TransportItems;
	};
	class ACE_medicalSupplyCrate_advanced: ACE_medicalSupplyCrate {
		class TransportItems: TransportItems {
			MACRO_ADDITEM(adv_aceSplint_splint,20);
		};
	};
};

class ACE_Medical_Actions {
	class Advanced {
		class fieldDressing;
		class splint: fieldDressing {
            displayName = "$STR_ADV_ACESPLINT_ACTION";
			displayNameProgress = "$STR_ADV_ACESPLINT_PROGRESS";
			items[] = {"adv_aceSplint_splint"};
			allowedSelections[] = {"hand_l", "hand_r", "leg_l", "leg_r"};
			condition = "[_this select 1, _this select 2] call adv_aceSplint_fnc_canSplint";
			allowSelfTreatment = 1;
			patientStateCondition = 1;
			treatmentTime = 8;
			requiredMedic = 0;
			itemConsumed = 1;
			callbackSuccess = "adv_aceSplint_fnc_splint";
		};
	};
};