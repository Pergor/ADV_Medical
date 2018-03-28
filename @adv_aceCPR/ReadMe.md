adv_aceCPR: Giving you a second chance if your everyday CPR doesn't do squat.


With adv_aceCPR you can finally use ACE CPR to get someone out of the revive state without healing him completely, making gameplay much more interesting.
Of course ACE³ and CBA are required.

After successfully "stabilizing" the patient, he/she will have a basic pulse of at least 30bpm.
ACE-doctors have a 40% success rate and ACE-medics have a 15% success rate. 
Regular riflemen can resuscitate a patient, but they will have a much lower success rate.
They can still keep the patient from dying due to an expired revive timer though.
The success rate is lowered if the patient looses blood or has morphium in his blood system and is raised if the patient received Epinephrine right before CPR.
The minimum rate is always 2%, except if resuscitation has been disabled for the ace_medical_medicClass of the player (read below).

For mission builders:
If you want to limit the usability of CPR you can do so by setting adv_aceCPR_quotient to a value of your choice.
This way resuscitation by CPR is only available for a fraction of the ace_medical_maxReviveTime.
So let's say you set adv_aceCPR_quotient to 2, then you can only resuscitate a patient if his revive-timer
has not reached half of ace_medical_maxReviveTime, if you set it to 4 you can only resuscitate the patient
within the first quarter of the ace_medical_maxReviveTime, and so forth.
Values below 1 revert to 1.
Just put this in your init.sqf and change the 1 to a value of your liking:

adv_aceCPR_quotient = 1;

You can set the probabilities for successfull resuscitation individually depending on the value for ace_medical_medicClass a player's unit has.

adv_aceCPR_probabilities = [40,15,5,85];	//the first entry is for ace_medical_medicClass == 2, the second for == 1, the third for regular units with ace_medical_medicClass == 0 and the fourth one for the defibrillator.

So if you want to disable CPR for any player with less than ace_medical_medicClass below 2 just use something like this:
adv_aceCPR_probabilities = [40,0,0,85];

With version 1.4.0 a new item is added to adv_aceCPR: A defibrillator.
The defibrillator works almost like the CPR action, but you have to have a defibrillator in your inventory and it's much faster and the success rate is way higher.
Using the defibrillator will induce pain for people who stand too close to a patient when the defibrillator is used (except for the operator).
The classname is
"adv_aceCPR_AED"
It's recommended to use adv_aceCPR_probabilities to lower the success rates for the CPR action when handing out the defibrillator.