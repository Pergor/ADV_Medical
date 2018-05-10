class CfgPatches
{
    class adv_aceRefill
    {
        units[] = {
			"adv_aceRefill_MediKitItem"
		};
        weapons[] = {
			"adv_aceRefill_MediKit"
		};
        requiredVersion = 1.82;
        requiredAddons[] = {
			"ace_common"
			,"ace_medical"
		};
		version = "1.0.0";
		versionStr = "1.0.0";
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
			class itemCheck {};
			class init { postInit = 1; };
		};
	};
};

class cfgWeapons {
	class ACE_ItemCore;
	class CBA_MiscItem_ItemInfo;
	
    class adv_aceRefill_MediKit: ACE_ItemCore {
        scope = 2;
		scopeCurator = 2;
        displayName = "Medical Refill Kit";
        picture = "\A3\Weapons_F\Items\data\UI\gear_Medikit_CA.paa";
		editorPreview = "\A3\EditorPreviews_F_Orange\Data\CfgVehicles\Land_FirstAidKit_01_closed_F.jpg";
		model = "\A3\Weapons_F\Items\Medikit";
        descriptionShort = "Will refill your medical items.";
        descriptionUse = "Refill medical items";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 30;
        };
	};
};

class cfgVehicles {
	class Item_Base_F;
	
	class adv_aceRefill_MediKitItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Medical Refill Kit";
        author = "[SeL] Belbo";
        vehicleClass = "Items";
		model = "\A3\Weapons_F\Items\Medikit";
        class TransportItems {
            MACRO_ADDITEM(adv_aceRefill_MediKit,1);
        };
	};
};