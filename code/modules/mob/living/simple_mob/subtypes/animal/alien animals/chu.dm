/datum/category_item/catalogue/fauna/chu
	name = "Chu"
	desc = "TODO - chu description"
	value = CATALOGUER_REWARD_SUPERHARD

/mob/living/simple_mob/vore/alienanimals/chu
	name = "chu"
	real_name = "chu"
	desc = "A \"friendly\" creature that wanders maintenance."
	tt_desc = "Chitter"

	icon = 'icons/mob/animal_op.dmi'
	icon_state = "jil"
	icon_living = "jil"
	icon_dead = "jil_dead"
	icon_rest = "jil_sleep"
	kitchen_tag = "rodent"

	faction = "chu"

	// durable...
	maxHealth = 85
	health = 85
	enzyme_affect = FALSE

	universal_understand = 1

	melee_damage_lower = 4
	melee_damage_upper = 8
	base_attack_cooldown = 1 SECOND
	attacktext = list("bit", "chomped", "scratched")

	movement_cooldown = 1
	animate_movement = SLIDE_STEPS

	layer = MOB_LAYER

	vore_default_mode = DM_ABSORB
	vore_active = TRUE
	has_hands = FALSE
	response_help  = "pets"
	response_disarm = "pushes aside"
	response_harm   = "stamps on"

	catalogue_data = list(/datum/category_item/catalogue/fauna/chu)

	has_langs = list(LANGUAGE_CHU)
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat

	say_list_type = /datum/say_list/chu
	ai_holder_type = /datum/ai_holder/simple_mob/melee/evasive
	melee_attack_delay = 0	// For some reason, having a delay makes item pick-up not work.

	var/isinfesting = FALSE

/mob/living/simple_mob/vore/alienanimals/chu/Initialize()
	. = ..()
	verbs += /mob/living/proc/ventcrawl
	verbs += /mob/living/proc/hide
	verbs += /mob/living/simple_mob/vore/alienanimals/chu/proc/infest

/mob/living/simple_mob/vore/alienanimals/chu/proc/infest()
	set category = VERBTAB_POWERS
	set name = "Infest Prey"

	// select bellied prey one by one!
	if(stat == DEAD)
		to_chat(src, "<span class='warning'>You are too dead to be infesting anything!</span>")
		return

	if(isinfesting)
		to_chat(src, "<span class='warning'>You are already infesting someone!</span>")
		return

	var/obj/belly/foundbelly = null
	var/foundprey = null
	if(!isnull(vore_organs) || vore_organs.len == 0)
		for(var/B in vore_organs)
			for(var/mob/living/L in B)
				if(L.stat < DEAD && ishuman(L) && !L.isSynthetic())
					foundprey = L
					foundbelly = B
					break
			// allow us to still give feedback! Attempt loop again but with no restrictions
			if(isnull(foundprey))
				for(var/mob/living/L in B)
					foundprey = L
					foundbelly = B
					break
	else
		to_chat(src, "<span class='warning'>Remember to set your bellies! A chu can only infest things they have eaten!</span>")
		return

	if(isnull(foundprey) || isnull(foundbelly))
		to_chat(src, "<span class='warning'>You must have prey inside you to infest them!</span>")
		return

	if(istype(foundprey,/mob/living/simple_mob/vore/alienanimals/chu))
		to_chat(src, "<span class='warning'>\The [foundprey] is already a chu!</span>")
		return

	var/mob/living/carbon/human/T = foundprey
	if(!istype(T) || T.isSynthetic())
		to_chat(src, "<span class='warning'>\The [T] is not compatible with our biology.</span>")
		return

	if(T.stat == DEAD)
		to_chat(src, "<span class='warning'>\The [T] is dead!</span>")
		return

	isinfesting = TRUE
	for(var/stage = 1, stage<=3, stage++)
		switch(stage)
			if(1)
				to_chat(src, "<span class='notice'>[T] is being infested. Hold still...</span>")
			if(2)
				to_chat(src, "<span class='notice'>You begin to press close to [T].</span>")
				src.visible_message("<span class='warning'>[src] presses uncomfortably close!</span>")
				T.emote("gasp")
			if(3)
				to_chat(src, "<span class='notice'>You begin to sink into [T]!</span>")
				src.visible_message("<span class='danger'>[src] sinks into [T] with a sickening crunch!</span>")
				to_chat(T, "<span class='danger'>Begins to sink into your body!</span>")
				T.emote("scream")
				add_attack_logs(src,T,"Infest (chu)")
				var/obj/item/organ/external/affecting = T.get_organ(BP_TORSO)
				if(affecting.take_damage(39,0,1,0,"infesting mass"))
					T:UpdateDamageIcon()

		if(!do_mob(src, T, 150))
			to_chat(src, "<span class='warning'>Your infestation of [T] has been interrupted!</span>")
			isinfesting = FALSE
			return

	isinfesting = FALSE
	if(T.loc != foundbelly)
		to_chat(src, "<span class='warning'>[T] has escaped our belly, your infestation has been interrupted!</span>")
		return

	var/hostname = T.name
	to_chat(src, "<span class='notice'>You have infested [T]!</span>")
	src.visible_message("<span class='danger'>[src] merges with [T] and converts them into more of itself!</span>")
	to_chat(T, "<span class='danger'>You have been infested by the chu!</span>")

	// don't forget to add to antags!
	if(!isnull(T.mind))
		chus.add_antagonist(T.mind)
	var/mob/living/simple_mob/vore/alienanimals/chu/CC = T.chuify()
	if(!isnull(CC))
		// setup sprites and flavor
		foundbelly.release_specific_contents(CC)
		CC.tt_desc = "Reminds you of [hostname]..."
		CC.desc = "A \"friendly\" creature that wanders maintenance. Has a superficial resemblance to [hostname]..."
		CC.update_icon()
		// emote a bit
		sleep(rand(2,6))
		CC.emote(pick("choke","gasp"))
	else
		// SOMETHING happened?
		foundbelly.release_specific_contents(T)

/mob/living/simple_mob/vore/alienanimals/chu/update_icons()
	..()
	if(stat == DEAD)
		// leave icon as is, set by death
	else if(lying || resting || sleeping > 0)
		icon_state = icon_rest
	else
		icon_state = icon_living

// Chu noises
/datum/say_list/chu
	speak = list()
	emote_hear = list("hiss","giggles","hiss","hiss")
	emote_see = list("twitches")
