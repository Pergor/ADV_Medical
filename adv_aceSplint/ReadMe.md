//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	ADV - ACE Splint:
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

ADV - ACE Splint offers you an item you can use to fix damaged arms and legs.

Of course the option to splint a damaged limbed will only be available with ace_medical_healHitPointAfterAdvBandage disabled.
Depending on your settings an applied splint might come off again. In that case you might be able to apply it again, or have to use a new one. 

Settings can be changed with CBA settings ( https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System ), or with the following variables:
adv_aceSplint_reopenChance_regular = 0;	//default 30, maximum value 100
adv_aceSplint_reopenChance_medic = 0;	//default 0, maximum value 100
adv_aceSplint_reopenTime = 300;			//default 600
adv_aceSplint_reuseChance = 80;			//default 90, maximum value 100

The classname for the splint item is:
"adv_aceSplint_splint"