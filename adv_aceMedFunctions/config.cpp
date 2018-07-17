class CfgPatches
{
    class adv_aceMedFunctions
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.82;
        requiredAddons[] = {
			"ace_medical"
		};
		version = "1.0.1";
		versionStr = "1.0.1";
		author = "[SeL] Belbo // Adrian";
		authorUrl = "http://spezialeinheit-luchs.de/";
    };
};
	
class cfgFunctions {
	//a little trick for the stupid ace-itemCheck:
	class ace_medical
	{
		tag = "ace_medical";
		class ace_medical
		{
			class actionRemoveTourniquet
			{
				file = "adv_aceMedFunctions\functions\fn_actionRemoveTourniquet.sqf";
			};
			class itemCheck
			{
				file = "adv_aceMedFunctions\functions\fn_itemCheck.sqf";
			};
			class useItem
			{
				file = "adv_aceMedFunctions\functions\fn_useItem.sqf";
			};
		};
	};	
};