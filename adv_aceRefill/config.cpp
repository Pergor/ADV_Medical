class CfgPatches
{
    class adv_aceRefill
    {
        units[] = {
			"adv_aceRefill_autoKitItem"
			,"adv_aceRefill_manualKitItem"
			,"adv_aceRefill_FAKItem"
		};
        weapons[] = {
			"adv_aceRefill_autoKit"
			,"adv_aceRefill_manualKit"
			,"adv_aceRefill_FAK"
		};
        requiredVersion = 1.82;
        requiredAddons[] = {
			"ace_common"
			,"ace_medical"
			,"cba_common"
			,"cba_xeh"
		};
		version = "1.0.2";
		versionStr = "1.0.2";
		author = "[SeL] Belbo // Adrian";
		authorUrl = "http://spezialeinheit-luchs.de/";
    };
};

#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
}

class cfgFunctions {
	class adv_aceRefill {
		tag = "adv_aceRefill";
		class init
		{
			file = "adv_aceRefill\functions";
			class init { postInit = 1; };
			class getRefill {};
			class refill {};
		};
	};
};

class Extended_PreInit_EventHandlers {
	class anomaly_settings {
		init = "call adv_aceRefill_fnc_registerSettings";
	};
};

class cfgWeapons {
	class CBA_MiscItem;
	class CBA_MiscItem_ItemInfo;
	
    class adv_aceRefill_manualKit: CBA_MiscItem {
        scope = 2;
		scopeCurator = 2;
        displayName = "$STR_ADV_REFILL_NAME";
        picture = "\adv_aceRefill\ui\Land_FirstAidKit_01_closed_F.paa";
		model = "\A3\Weapons_F\Items\Medikit";
        descriptionShort = "$STR_ADV_REFILL_DESCRIPTION";
        descriptionUse = "$STR_ADV_REFILL_DESCRIPTIONUSE";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 120;
        };
	};
	
    class adv_aceRefill_autoKit: adv_aceRefill_manualKit {
        displayName = "$STR_ADV_REFILL_NAME_AUTO";
		descriptionShort = "$STR_ADV_REFILL_DESCRIPTION_AUTO";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 80;
        };
	};
	class adv_aceRefill_Kit_empty: adv_aceRefill_manualKit {
		scope = 1;
		scopeCurator = 1;
		displayName = "$STR_ADV_REFILL_NAME_EMPTY";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 10;
        };
	};
	
    class adv_aceRefill_FAK: adv_aceRefill_manualKit {
        displayName = "$STR_ADV_REFILL_NAME_FAK";
		picture = "\adv_aceRefill\ui\FAK.paa";
		model = "\a3\Weapons_F\Ammo\mag_FirstAidkit.p3d";
        descriptionShort = "$STR_ADV_REFILL_DESCRIPTION_FAK";
        descriptionUse = "$STR_ADV_REFILL_DESCRIPTIONUSE";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 18;
        };
	};
};

class cfgVehicles {
	class Item_Base_F;
	
	class adv_aceRefill_manualKitItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_ADV_REFILL_NAME";
        author = "[SeL] Belbo";
        vehicleClass = "Items";
		model = "\A3\Weapons_F\Items\Medikit";
		editorPreview = "\A3\EditorPreviews_F_Orange\Data\CfgVehicles\Land_FirstAidKit_01_open_F.jpg";
        class TransportItems {
            MACRO_ADDITEM(adv_aceRefill_manualKit,1);
        };
	};
	class adv_aceRefill_autoKitItem: adv_aceRefill_manualKitItem {
		displayName = "$STR_ADV_REFILL_NAME_AUTO";
        class TransportItems {
            MACRO_ADDITEM(adv_aceRefill_autoKit,1);
        };
	};
	
	class adv_aceRefill_FAKItem: adv_aceRefill_manualKitItem {
		displayName = "$STR_ADV_REFILL_NAME_FAK";
		model = "\A3\Weapons_F\Items\FirstAidkit";
		editorPreview = "\adv_aceRefill\ui\FAK.jpg";
        class TransportItems {
            MACRO_ADDITEM(adv_aceRefill_FAK,1);
        };
	};
};