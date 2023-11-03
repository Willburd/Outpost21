/datum/category_item/catalogue/fauna/chu
	name = "Chu'uraka Parasite"
	desc = "TODO - chu description"
	value = CATALOGUER_REWARD_SUPERHARD

// Chu noises
/datum/say_list/chu
	speak = list()
	emote_hear = list("hiss","giggles","hiss","hiss")
	emote_see = list("twitches")

/mob/living/simple_mob/vore/alienanimals/chu
	name = "chu"
	real_name = "chu"
	desc = "A \"friendly\" creature that wanders maintenance."
	tt_desc = "Chitter"
	player_msg = "Eat others, and infest them with your strange parasitic powers!"

	icon = 'icons/mob/animal_op.dmi'
	icon_state = "chu"
	icon_living = "chu"
	icon_dead = "chu_dead"
	icon_rest = "chu_rest"
	kitchen_tag = "rodent"

	faction = "chu"
	glow_range = 2
	glow_toggle = 1
	glow_color = "#75ebeb"

	// durable...
	maxHealth = 65
	health = 65
	enzyme_affect = FALSE

	universal_understand = 1
	melee_damage_lower = 4
	melee_damage_upper = 6
	base_attack_cooldown = 1 SECOND
	attacktext = list("bit", "chomped", "scratched")

	movement_cooldown = 2
	animate_movement = SLIDE_STEPS

	layer = MOB_LAYER

	vore_default_mode = DM_HOLD
	vore_active = TRUE
	has_hands = FALSE
	response_help  = "pets"
	response_disarm = "pushes aside"
	response_harm   = "stamps on"

	catalogue_data = list(/datum/category_item/catalogue/fauna/chu)

	has_langs = list(LANGUAGE_CHU)
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat

	say_list_type = /datum/say_list/chu
	ai_holder_type = /datum/ai_holder/simple_mob/melee/evasive/chu
	melee_attack_delay = 0	// For some reason, having a delay makes item pick-up not work.

	var/isinfesting = FALSE
	var/isOriginal = TRUE
	var/list/overlay_colors = list(
		"Body" = "#FFFFFF",
		"Eyes" = "#FFFFFF",
		"Blood" = "#FFFFFF"
	)

/mob/living/simple_mob/vore/alienanimals/chu/Initialize()
	. = ..()
	verbs += /mob/living/proc/ventcrawl
	verbs += /mob/living/proc/hide
	verbs += /mob/living/simple_mob/vore/alienanimals/chu/proc/infest
	update_icon()

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
	if(!isnull(vore_organs) && vore_organs.len > 0)
		for(var/obj/belly/B in vore_organs)
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
				to_chat(T, "<span class='danger'>You feel something strange begin to happen...</span>")
			if(2)
				to_chat(src, "<span class='notice'>You begin to press close to [T].</span>")
				src.visible_message("<span class='warning'>[src] presses uncomfortably close!</span>")
				T.emote("gasp")
			if(3)
				to_chat(src, "<span class='notice'>You begin to sink into [T]!</span>")
				src.visible_message("<span class='danger'>[src] sinks into [T] with a sickening crunch!</span>")
				to_chat(T, "<span class='danger'>\The [src] begins to sink into your body!</span>")
				T.emote("scream")
				add_attack_logs(src,T,"Infest (chu)")
				var/obj/item/organ/external/affecting = T.get_organ(BP_TORSO)
				if(affecting.take_damage(12,0,1,0,"infesting mass"))
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

/mob/living/simple_mob/vore/alienanimals/chu/update_icon()
	. = ..()
	cut_overlays()
	if(stat == DEAD)
		icon_state = icon_dead
	else if(lying || resting || sleeping > 0)
		icon_state = icon_rest
	else
		icon_state = icon_living

	// always handle belly overlay!
	if(stat != DEAD)
		var/hasbelly = FALSE
		if(!isnull(vore_organs) && vore_organs.len > 0)
			for(var/obj/belly/B in vore_organs)
				if(B.contents.len > 0)
					hasbelly = TRUE
					break
		if(hasbelly)
			var/mutable_appearance/I = mutable_appearance(icon,  "[icon_state]-belly")
			I.appearance_flags |= PIXEL_SCALE
			I.layer = MOB_LAYER
			I.plane = MOB_PLANE + 0.1
			add_overlay(I)

	// overlays for cursed players~
	if(isOriginal)
		return

	var/mutable_appearance/I = mutable_appearance(icon,  "[icon_state]-fur")
	I.color = overlay_colors["Body"]
	I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
	I.layer = MOB_LAYER
	I.plane = MOB_PLANE
	add_overlay(I)

	if(stat != DEAD)
		I = mutable_appearance(icon,  "[icon_state]-eyes")
		I.color = overlay_colors["Eyes"]
		I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
		I.plane = PLANE_LIGHTING_ABOVE
		I.blend_mode = BLEND_MULTIPLY
		add_overlay(I)
	else
		I = mutable_appearance(icon,  "[icon_state]-blood")
		I.color = overlay_colors["Blood"]
		I.appearance_flags |= (RESET_COLOR|PIXEL_SCALE)
		I.layer = MOB_LAYER
		I.plane = MOB_PLANE
		I.blend_mode = BLEND_MULTIPLY
		add_overlay(I)

/mob/living/simple_mob/vore/alienanimals/chu/Life()
	. = ..()
	// adjust sleep here, needs mind to sleep otherwise...
	// adding the check so this doesn't conflict with life/handle_regular_status_updates()
	// catslugs added simple mobs healing while resting... so i don't need to do that myself!
	if(sleeping > 0)
		AdjustSleeping(-1)
		resting = sleeping > 0
		if(sleeping <= 0)
			update_icon()

/datum/ai_holder/simple_mob/melee/evasive/chu
	hostile = TRUE
	can_flee = TRUE
	flee_when_outmatched = TRUE
	outmatched_threshold = 100
	max_home_distance = 50

/datum/ai_holder/simple_mob/melee/evasive/chu/handle_special_strategical()
	if(holder.sleeping > 0)
		return


	if(prob(5))
		var/turf/findhome = get_turf(holder)
		if(isturf(findhome))
			home_turf = findhome

	var/wantcorrupt = FALSE
	if(!target && prob(20))
		if(!isnull(holder.vore_organs) || holder.vore_organs.len == 0)
			for(var/obj/belly/B in holder.vore_organs)
				for(var/thing in B)
					if(ishuman(thing))
						var/mob/living/carbon/human/H = thing
						if(!H.isSynthetic() && H.stat != DEAD)
							wantcorrupt = TRUE
						else
							B.release_specific_contents(thing)
					else
						B.release_specific_contents(thing)

		if(wantcorrupt)
			var/mob/living/simple_mob/vore/alienanimals/chu/C = holder
			C.infest()
			C.Sleeping(40)
			holder.update_icon()
			var/turf/findhome = get_turf(C)
			if(isturf(findhome))
				home_turf = findhome
		else if(prob(20) && holder.health < 30 && get_dist(holder, home_turf) < 40)
			holder.Sleeping(50)
			holder.update_icon()
