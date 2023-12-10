/datum/power/changeling/transform
	name = "Transform"
	desc = "We take on the appearance and voice of one we have absorbed."
	ability_icon_state = "ling_transform"
	genomecost = 0
	verbpath = /mob/proc/changeling_transform

//Change our DNA to that of somebody we've absorbed.
/mob/proc/changeling_transform()
	set category = VERBTAB_POWERS
	set name = "Transform (5)"

	var/datum/changeling/changeling = changeling_power(5,1,0)
	if(!changeling)	return

	if(!isturf(loc))
		to_chat(src, "<span class='warning'>Transforming here would be a bad idea.</span>")
		return 0

	var/list/names = list()
	for(var/datum/absorbed_dna/DNA in changeling.absorbed_dna)
		names += "[DNA.name]"

	var/S = tgui_input_list(src, "Select the target DNA:", "Target DNA", names)
	if(!S)	return

	var/datum/absorbed_dna/chosen_dna = changeling.GetDNA(S)
	if(!chosen_dna)
		return

	changeling.chem_charges -= 5
	src.visible_message("<span class='warning'>[src] transforms!</span>")
	changeling.geneticdamage = 5

	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		var/newSpecies = chosen_dna.speciesName
		H.set_species(newSpecies,1)

	src.dna = chosen_dna.dna.Clone()
	src.dna.b_type = "AB+" //This is needed to avoid blood rejection bugs.  The fact that the blood type might not match up w/ records could be a *FEATURE* too.
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		H.b_type = "AB+" //For some reason we have two blood types on the mob.
		//Basically all the VORE stuff
		H.appearance_flags = chosen_dna.appearance_flags ? chosen_dna.appearance_flags : null
		H.weight = chosen_dna.weight ? chosen_dna.weight : null
		H.transfer_mental_traits( chosen_dna.identifying_gender, chosen_dna.flavour_texts ? chosen_dna.flavour_texts.Copy() : null, chosen_dna.ooc_notes ? chosen_dna.ooc_notes : null, null)
		H.UpdateAppearance()
		H.ApplySpeciesAndTraits(GENE_INITIAL_ACTIVATION)
		if(H.dna)
			H.dna.UpdateSE()
			H.dna.UpdateUI()
		H.sync_organ_dna()
		H.resize(chosen_dna.sizemult, TRUE)
	else
		src.UpdateAppearance()
		src.ApplySpeciesAndTraits(GENE_INITIAL_ACTIVATION)
	src.real_name = chosen_dna.name ? chosen_dna.name : null

	domutcheck(src, null)
	changeling_update_languages(changeling.absorbed_languages)
	if(chosen_dna.genMods)
		var/mob/living/carbon/human/self = src
		for(var/datum/modifier/mod in self.modifiers)
			self.modifiers.Remove(mod.type)

		for(var/datum/modifier/mod in chosen_dna.genMods)
			self.modifiers.Add(mod.type)

	// appearance controls
	src.regenerate_icons()

	src.verbs -= /mob/proc/changeling_transform
	spawn(10)
		src.verbs += /mob/proc/changeling_transform

	feedback_add_details("changeling_powers","TR")
	return 1
