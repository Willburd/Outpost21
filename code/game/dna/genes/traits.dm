// this file exists because of a decade of neglect done to the DNA system of this game.
// Mutations and gene definitions for all traits in the trait lists, including xenochimera!
// IMPORTANT: defines for blocks are in code\__defines\dna.dm
// and those defines are assigned by /proc/setupgenetics()
// Trait definitions are in code\modules\mob\living\carbon\human\species\station\traits_vr\XXX.dm

/datum/dna/gene/trait_linked
	name="Linked Trait"
	desc="Existance is pain! Contact a developer if you see this!"
	var/list/var_changes			// A list to apply to the custom species vars.
	var/list/exclude_blocks = list() // Store a list of gene blocks that suppress our own activation if they are enabled!
	var/datum/trait/linked_trait_path // this is init when genes are, used to solve for can_activate() conditions, like forbidden trait combinations

	// blind activators
	activation_messages=list("You feel something strange?")
	deactivation_messages=list("")

/datum/dna/gene/trait_linked/proc/init_exclusions()
	exclude_blocks = list()
	var/datum/trait/instance = all_traits[linked_trait_path]
	for(var/P in all_traits)
		var/datum/trait/instance_test = all_traits[P]
		if(instance_test.linked_gene_block) // if trait is gene linked! Otherwise we can't do this ingame anyway...
			if(linked_trait_path in instance_test.excludes)
				if(instance_test.linked_gene_block)
					exclude_blocks.Add(instance_test.linked_gene_block)
				continue

			for(var/V in instance.var_changes)
				if(V in instance_test.var_changes)
					if(instance_test.linked_gene_block)
						exclude_blocks.Add(instance_test.linked_gene_block)
						break

			for(var/V in instance.var_changes_pref)
				if(V in instance_test.var_changes_pref)
					if(instance_test.linked_gene_block)
						exclude_blocks.Add(instance_test.linked_gene_block)
						break

/datum/dna/gene/trait_linked/New()
	if(linked_trait_path)
		// VALIDATE
		var/datum/trait/instance_test = all_traits[linked_trait_path]
		// lazy name and descriptions
		name=instance_test.name
		desc=instance_test.desc
		instance_test.linked_gene_block = block // changes trait into actual gene trait!			<---- IMPORTANT
	. = ..()

/datum/dna/gene/trait_linked/can_activate(var/mob/M, var/flags)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.dna)
			return FALSE
		for(var/ex in exclude_blocks)
			if(H.dna.GetSEState(ex))
				return FALSE // any other blocker was on!
		return TRUE
	return FALSE

/datum/dna/gene/trait_linked/proc/disable_antigenes(var/mob/M, var/connected, var/flags)
	// used to disable anti-gene blocks so we're assured that we can stay active!
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		for(var/ex in exclude_blocks)
			H.dna.SetSEState(ex,FALSE,TRUE)

/datum/dna/gene/trait_linked/activate(var/mob/M, var/connected, var/flags)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/S = H.species
		var/datum/trait/Tr = all_traits[linked_trait_path]
		Tr.apply(S,H) // apply active traits!
		if(activation_messages.len)
			if(!(flags & GENE_INITIAL_ACTIVATION))
				var/msg = pick(activation_messages)
				to_chat(M, "<span class='notice'>[msg]</span>")
		else
			testing("[name] has no activation message.")

/datum/dna/gene/trait_linked/deactivate(var/mob/M, var/connected, var/flags)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/S = H.species
		var/datum/trait/Tr = all_traits[linked_trait_path]
		Tr.unapply(S,H) // apply active traits!
		if(deactivation_messages.len)
			if(!(flags & GENE_INITIAL_ACTIVATION))
				var/msg = pick(deactivation_messages)
				to_chat(M, "<span class='warning'>[msg]</span>")
		else
			testing("[name] has no deactivation message.")

// Abandon all hope ye who maintain genetics code
// For sanity sake... Define /datum/dna/gene/trait_linkeds next to their actual traits...
// Otherwise you'd need to add them to this file, making a new hellish maintanance nightmare!
