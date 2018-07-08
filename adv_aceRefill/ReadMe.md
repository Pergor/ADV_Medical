//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	ADV - ACE Refill:
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

All this mod does is add two objects that should refill medical items according to SeL-medic mission standards.
"adv_aceRefill_autoKit" - like the MediKit this will open automatically as soon as you take it to your inventory and refill the medic's medic material.
"adv_aceRefill_manualKit" - carry it in your inventory and open it via ace self interaction-equipment menu to refill your medic material.
"adv_aceRefill_FAK" - carry it in your inventory and open it via ace self interaction-equipment menu to refill your medic material - this is what one soldier carries.
Only medics with ACE_medical_medicClass > 0 can use the manualKit and autoKit, so regular soldiers can carry around the refill kits for the medics until they need them.

Refilled items can be set with the following variables:
adv_aceRefill_FAK_var,
adv_aceRefill_CLS_var,
adv_aceRefill_SAN_var
The have to be defined in this format: ["CLASSNAME",NUMBER,"CLASSNAME",NUMBER,"CLASSNAME",NUMBER]
!!!!!!!!!!ANY DEVIATION IN THE FORMAT WILL BREAK THE REFILL-FUNCTIONS AND NO ITEMS WILL BE GIVEN!!!!!!!!!!

example:
adv_aceRefill_FAK_var = ["ACE_fieldDressing",5,"ACE_morphine",1,"ACE_tourniquet",1];	//this will give up to 5 FieldDressings, 1 morphine and 1 tourniquet, when the adv_aceRefill_FAK is used.