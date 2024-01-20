///////////////////////////////////////////////
/////////////////// Stage 1 ///////////////////

/datum/disease2/effect/merp
	name = "Jillington's Syndrome"
	stage = 1
	chance_maxm = 15

/datum/disease2/effect/merp/activate(var/mob/living/carbon/mob,var/multiplier)
	mob.say("*merp")

/datum/disease2/effect/ough
	name = "Puffington's Syndrome"
	stage = 1
	chance_maxm = 15

/datum/disease2/effect/ough/activate(var/mob/living/carbon/mob,var/multiplier)
	mob.say("*ough")

/datum/disease2/effect/dropper
	name = "Aching Joints"
	stage = 1
	chance_maxm = 5

/datum/disease2/effect/dropper/activate(var/mob/living/carbon/mob,var/multiplier)
	to_chat(mob, "<span class='warning'>Your joints feel agonizingly stiff.</span>")
	if(prob(70))
		mob.drop_l_hand()
		mob.drop_r_hand()
		mob.stop_pulling()

/datum/disease2/effect/ragescree
	name = "Shreiker Syndrome"
	stage = 1
	chance_maxm = 5

/datum/disease2/effect/ragescree/activate(var/mob/living/carbon/mob,var/multiplier)
	mob.say("*ragescree")

/datum/disease2/effect/mentalgnat
	name = "Mental Gnat"
	stage = 1
	chance_maxm = 15

/datum/disease2/effect/mentalgnat/activate(var/mob/living/carbon/mob,var/multiplier)
	if(prob(70))
		to_chat(mob, "<span class='warning'>You hear an incessant buzzing, like a small fly is dive bombing your ears!</span>")
	else
		to_chat(mob, "<font size='15' color='red'><b>MMMMMMWWWWNNNNNNEEEEEEEEEEEEEEEEEEEEEEEE!</b></font>")

///////////////////////////////////////////////
/////////////////// Stage 2 ///////////////////

/datum/disease2/effect/cold_hypersensitivity
	name = "Cold Hypersensitivity"
	stage = 2
	chance_maxm = 12

/datum/disease2/effect/cold_hypersensitivity/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_ICE_BLOOD))
		mob.dna.SetSEState(TRAITBLOCK_ICE_BLOOD,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/eyeglow
	name = "Ocular Luminal Projection"
	stage = 2
	chance_maxm = 12

/datum/disease2/effect/eyeglow/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_EYEGLOW))
		mob.dna.SetSEState(TRAITBLOCK_EYEGLOW,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/drippy
	name = "Dermal Instability"
	stage = 2
	chance_maxm = 12

/datum/disease2/effect/drippy/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_DRIPPY))
		mob.dna.SetSEState(TRAITBLOCK_DRIPPY,1)
		domutcheck(mob, null, MUTCHK_FORCED)

///////////////////////////////////////////////
/////////////////// Stage 3 ///////////////////

/datum/disease2/effect/air_liver
	name = "Liver Hypersensitivity"
	stage = 3
	chance_maxm = 12

/datum/disease2/effect/air_liver/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_AIRLIVER))
		mob.dna.SetSEState(TRAITBLOCK_AIRLIVER,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/colorblind_dark
	name = "Ocular Cone Degeneration"
	stage = 3
	chance_maxm = 12

/datum/disease2/effect/colorblind_dark/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_DARKBLIND))
		mob.dna.SetSEState(TRAITBLOCK_DARKBLIND,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/organgrow
	name = "Spontanious Organosis"
	stage = 3
	chance_maxm = 12

/datum/disease2/effect/organgrow/activate(var/mob/living/carbon/mob,var/multiplier)
	if(ishuman(mob))
		var/mob/living/carbon/human/H = mob
		H.malignant_organ_spawn(TRUE,FALSE)

/datum/disease2/effect/parasitegrow
	name = "Parasitic Gestation"
	stage = 3
	chance_maxm = 12

/datum/disease2/effect/parasitegrow/activate(var/mob/living/carbon/mob,var/multiplier)
	if(ishuman(mob))
		var/mob/living/carbon/human/H = mob
		H.malignant_organ_spawn(FALSE,TRUE)

///////////////////////////////////////////////
/////////////////// Stage 4 ///////////////////

/datum/disease2/effect/colorblind_mono
	name = "Ocular Degeneration Mono"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/colorblind_mono/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_COLORBLIND_MONO))
		mob.dna.SetSEState(TRAITBLOCK_COLORBLIND_MONO,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/colorblind_vulp
	name = "Ocular Degeneration Vulpakin"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/colorblind_vulp/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_COLORBLIND_VULP))
		mob.dna.SetSEState(TRAITBLOCK_COLORBLIND_VULP,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/colorblind_taj
	name = "Ocular Degeneration Tajaran"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/colorblind_taj/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_COLORBLIND_TAJ))
		mob.dna.SetSEState(TRAITBLOCK_COLORBLIND_TAJ,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/atrophy
	name = "Muscular Atrophy"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/atrophy/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_SLOWDOWNEX) || !mob.dna.GetSEState(TRAITBLOCK_WEAKEX))
		mob.dna.SetSEState(TRAITBLOCK_SLOWDOWNEX,1)
		mob.dna.SetSEState(TRAITBLOCK_WEAKEX,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/starving
	name = "Induced Hunger"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/starving/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_INSATIABLEEX))
		mob.dna.SetSEState(TRAITBLOCK_INSATIABLEEX,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/wingy
	name = "Wingding Disorder"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/wingy/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_WINGDINGS))
		mob.dna.SetSEState(TRAITBLOCK_WINGDINGS,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/keens
	name = "Keens Disorder"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/keens/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_DETERIORATE))
		mob.dna.SetSEState(TRAITBLOCK_DETERIORATE,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/breathe_phoron
	name = "Phoron Respiration"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/breathe_phoron/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_BREATH_PHORON))
		mob.dna.SetSEState(TRAITBLOCK_BREATH_PHORON,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/breathe_nitrogen
	name = "Nitrogen Respiration"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/breathe_nitrogen/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_BREATH_NITROGEN))
		mob.dna.SetSEState(TRAITBLOCK_BREATH_NITROGEN,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/breathe_carbon
	name = "Carbon Dioxide Respiration"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/breathe_nitrogen/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_BREATH_CARBON))
		mob.dna.SetSEState(TRAITBLOCK_BREATH_CARBON,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/darkvision
	name = "Ocular Lowlight Adaption"
	stage = 4
	chance_maxm = 12

/datum/disease2/effect/darkvision/activate(var/mob/living/carbon/mob,var/multiplier)
	if(!mob.dna.GetSEState(TRAITBLOCK_DARKSIGHT))
		mob.dna.SetSEState(TRAITBLOCK_DARKSIGHT,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/organgrow
	name = "Spontanious Multiple Organosis"
	stage = 4
	chance_maxm = 12


/datum/disease2/effect/organgrow/activate(var/mob/living/carbon/mob,var/multiplier)
	if(ishuman(mob))
		var/mob/living/carbon/human/H = mob
		H.malignant_organ_spawn(TRUE,FALSE)
		H.malignant_organ_spawn(TRUE,FALSE)
		H.malignant_organ_spawn(TRUE,FALSE)

/datum/disease2/effect/organgrow
	name = "Persistent Organosis"
	stage = 4
	chance_maxm = 2

/datum/disease2/effect/organgrow/activate(var/mob/living/carbon/mob,var/multiplier)
	if(ishuman(mob))
		var/mob/living/carbon/human/H = mob
		if(H.internal_organs.len < 25)
			H.malignant_organ_spawn(TRUE,FALSE)

/datum/disease2/effect/dnd
	name = "Advanced Diseases and Discomfort 2.5 Syndrome"
	stage = 4
	chance_maxm = 6

/datum/disease2/effect/dnd/activate(var/mob/living/carbon/mob,var/multiplier)
	var/rolldice = pick(list(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20))
	var/dc = pick(list(5,8,10,12,14,16))

	var/passed = rolldice >= dc

	var/savetext = "A voice inside your head proclaims "
	switch(rand(1,3))
		if(1)
			savetext += "ROLL FOR STRENGTH!"
			if(!passed)
				mob.drop_l_hand()
				mob.drop_r_hand()
				mob.stop_pulling()
		if(2)
			savetext += "ROLL FOR DEXTERITY!"
			if(!passed)
				mob.say("*collapse")

		if(3)
			savetext += "ROLL FOR CONSTITUTION!"
			if(!passed)
				mob.say("*vomit")

	savetext += " You rolled [rolldice] vs [dc]!"
	if(passed)
		savetext += " Success!"
	else
		savetext += " Failure!"

	to_chat(mob, "<span class='warning'>[savetext]</span>")
