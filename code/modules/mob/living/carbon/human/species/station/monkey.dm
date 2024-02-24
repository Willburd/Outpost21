/datum/species/monkey
	name = SPECIES_MONKEY
	name_plural = "Monkeys"
	blurb = "Ook."

	icobase = 'icons/mob/human_races/monkeys/r_monkey.dmi'
	deform = 'icons/mob/human_races/monkeys/r_monkey.dmi'
	damage_overlays = 'icons/mob/human_races/masks/dam_monkey.dmi'
	damage_mask = 'icons/mob/human_races/masks/dam_mask_monkey.dmi'
	blood_mask = 'icons/mob/human_races/masks/blood_monkey.dmi'
	language = null
	default_language = LANGUAGE_ANIMAL
	greater_form = SPECIES_HUMAN
	mob_size = MOB_SMALL
	has_fine_manipulation = 0
	show_ssd = null
	health_hud_intensity = 2

	gibbed_anim = "gibbed-m"
	dusted_anim = "dust-m"
	death_message = "lets out a faint chimper as it collapses and stops moving..."
	tail = "chimptail"
	fire_icon_state = "monkey"

	unarmed_types = list(/datum/unarmed_attack/bite, /datum/unarmed_attack/claws)
	inherent_verbs = list(/mob/living/proc/ventcrawl)
	hud_type = /datum/hud_data/monkey
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/monkey

	rarity_value = 0.1
	total_health = 75
	brute_mod = 1.5
	burn_mod = 1.5

	spawn_flags = SPECIES_IS_RESTRICTED

	bump_flag = MONKEY
	swap_flags = MONKEY|SLIME|SIMPLE_ANIMAL
	push_flags = MONKEY|SLIME|SIMPLE_ANIMAL|ALIEN

	pass_flags = PASSTABLE

	has_limbs = list(
		BP_TORSO =  list("path" = /obj/item/organ/external/chest),
		BP_GROIN =  list("path" = /obj/item/organ/external/groin),
		BP_HEAD =   list("path" = /obj/item/organ/external/head/no_eyes),
		BP_L_ARM =  list("path" = /obj/item/organ/external/arm),
		BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right),
		BP_L_LEG =  list("path" = /obj/item/organ/external/leg),
		BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right),
		BP_L_HAND = list("path" = /obj/item/organ/external/hand),
		BP_R_HAND = list("path" = /obj/item/organ/external/hand/right),
		BP_L_FOOT = list("path" = /obj/item/organ/external/foot),
		BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right)
		)

/datum/species/monkey/handle_npc(var/mob/living/carbon/human/H)
	if(istype(H,/mob/living/carbon/human/monkey/auto_doc))
		// autodoc disgusting code
		return
	if(H.stat != CONSCIOUS)
		return
	if(isturf(H.loc))
		if(!H.pulledby && H.canmove) //won't move if being pulled
			if(prob(33))
				step(H, pick(cardinal))
			if(prob(5))
				// Handle gene expression emotes
				var/geneexpression
				if(H.dna)
					var/i = 0
					while(i++ < 10)
						// try random genes
						var/gene_index = rand(1,DNA_SE_LENGTH)
						var/datum/dna/gene/gene = dna_genes_by_block[gene_index]
						if(gene && H.dna.GetSEState(gene_index))
							// we have a gene, try to express it!
							if(gene.primitive_expression_messages.len)
								geneexpression = pick(gene.primitive_expression_messages)
							break // lets not be too desperate...

				if(!geneexpression)
					H.emote(pick("scratch","jump","roll","tail"))
				else
					H.custom_emote(VISIBLE_MESSAGE, "[geneexpression]")
		// More... intense, expressions.
		if(prob(5) && H.mutations.len)
			if((LASER in H.mutations))
				// zappy monkeys
				var/list/targs = list()
				for(var/atom/X in orange(7, H))
					targs.Add(X)
				if(targs.len)
					H.LaserEyes(pick(targs))
		if(prob(3) && H.dna && H.dna.GetSEState(FARTBLOCK))
			H.super_fart()
	..()

/datum/species/monkey/get_random_name()
	return "[lowertext(name)] ([rand(100,999)])"

/datum/species/monkey/tajaran
	name = SPECIES_MONKEY_TAJ
	name_plural = "Farwa"

	icobase = 'icons/mob/human_races/monkeys/r_farwa.dmi'
	deform = 'icons/mob/human_races/monkeys/r_farwa.dmi'

	greater_form = SPECIES_TAJ
	default_language = LANGUAGE_ANIMAL
	flesh_color = "#AFA59E"
	base_color = "#333333"
	tail = "farwatail"

/datum/species/monkey/skrell
	name = SPECIES_MONKEY_SKRELL
	name_plural = "Neaera"

	icobase = 'icons/mob/human_races/monkeys/r_neaera.dmi'
	deform = 'icons/mob/human_races/monkeys/r_neaera.dmi'

	greater_form = SPECIES_SKRELL
	default_language = LANGUAGE_ANIMAL
	flesh_color = "#8CD7A3"
	blood_color = "#1D2CBF"
	reagent_tag = IS_SKRELL
	tail = null

/datum/species/monkey/unathi
	name = SPECIES_MONKEY_UNATHI
	name_plural = "Stok"

	icobase = 'icons/mob/human_races/monkeys/r_stok.dmi'
	deform = 'icons/mob/human_races/monkeys/r_stok.dmi'

	tail = "stoktail"
	greater_form = SPECIES_UNATHI
	default_language = LANGUAGE_ANIMAL
	flesh_color = "#34AF10"
	base_color = "#066000"
	reagent_tag = IS_UNATHI
