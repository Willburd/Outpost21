/obj/machinery/transhuman/autoresleever
	name = "automatic resleever"
	desc = "Uses advanced ID scanning technology to detect when someone needs to be resleeved, and automatically prints and sleeves them into a new body. It even generates its own biomass, kinda. How environmentally friendly!"
	icon = 'icons/obj/machines/autoresleever.dmi'
	icon_state = "autoresleever"
	density = TRUE
	anchored = TRUE
	var/releaseturf
	var/throw_dir = WEST
	var/ghost_spawns = FALSE			//If true, allows ghosts who haven't been spawned yet to spawn

/obj/machinery/transhuman/autoresleever/update_icon()
	. = ..()
	if(stat)
		icon_state = "autoresleever-o"
	else
		icon_state = "autoresleever"

/obj/machinery/transhuman/autoresleever/power_change()
	. = ..()
	update_icon()

/obj/machinery/transhuman/autoresleever/attack_ghost(mob/observer/dead/user as mob)
	return

/obj/machinery/transhuman/autoresleever/attackby( var/item/O, var/mob/user)
	return

/obj/machinery/transhuman/autoresleever/proc/autoresleeve(var/obj/item/weapon/card/id/D)
	if(stat)
		return

	// what even happened?
	if(isnull(D))
		src.visible_message("[src] flashes 'Invalid ID!', and lets out a loud incorrect sounding beep!")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)

	//Name matching is ugly but mind doesn't persist to look at.
	var/datum/transcore_db/db = SStranscore.db_by_mind_name(D.registered_name)
	if(isnull(db))
		src.visible_message("[src] flashes 'No records detected!', and lets out a loud incorrect sounding beep!")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		return

	var/datum/transhuman/mind_record/recordM = db.backed_up[D.registered_name]
	var/datum/transhuman/body_record/recordB = db.body_scans[D.registered_name]

	if(isnull(recordM))
		src.visible_message("[src] flashes 'No mind records detected!', and lets out a loud incorrect sounding beep!")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		return

	if(isnull(recordB) || isnull(recordB.mydna) || isnull(recordB.mydna.dna))
		src.visible_message("[src] flashes 'No body records detected, or dna was corrupted!', and lets out a loud incorrect sounding beep!")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		return

	var/datum/species/chosen_species = GLOB.all_species[recordB.mydna.dna.species]
	if(chosen_species.flags && NO_SCAN) // Sanity. Prevents species like Xenochimera, Proteans, etc from rejoining the round via resleeve, as they should have their own methods of doing so already, as agreed to when you whitelist as them.
		src.visible_message("[src] flashes 'Invalid species!', and lets out a loud incorrect sounding beep!")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		if((world.time - recordM.last_notification) < 30 MINUTES)
			global_announcer.autosay("[D.registered_name] was unable to be resleeved by the automatic resleeving system.", "TransCore Oversight", "Medical")
		return

	// solve the ghost from mind refs
	var/mob/ghost
	var/client/ghost_client
	for(var/client/C in GLOB.clients)
		if(C.ckey == recordM.ckey)
			ghost_client = C
			ghost = ghost_client.mob
			break

	//For logging later
	var/player_key = ghost_client.key
	var/picked_ckey = ghost_client.ckey
	var/picked_slot = ghost_client.prefs.default_slot

	//Did we actually get a loc to spawn them?
	if(isnull(releaseturf))
		releaseturf = get_turf(src)
	var/spawnloc = get_step( releaseturf, throw_dir)
	if(!spawnloc)
		return

	if(tgui_alert(ghost, "Autoresleever has received the ID of '[D.registered_name]' for processing. Would you like to be resleeved? Remember to have that character loaded, or it will fail! This is your only chance to change slots!", "Resleeve", list("No","Yes")) == "No")
		if(istype(ghost,/mob/living))
			src.visible_message("[src] flashes 'Was unable to resleeve [D.registered_name]. Potential ethical violation detected!', and lets out a loud incorrect sounding beep!")
			playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
			if((world.time - recordM.last_notification) < 30 MINUTES)
				global_announcer.autosay("[D.registered_name] was unable to be resleeved by the automatic resleeving system. Resleeving may potentially be in progress at [using_map.dock_name]. Avoiding ethical violation.", "TransCore Oversight", "Medical")
		return

	//We were able to spawn them, right?
	var/mob/living/carbon/human/new_character = new(src)
	if(!new_character)
		to_chat(ghost, "Something went wrong and spawning failed.")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		if((world.time - recordM.last_notification) < 30 MINUTES)
			global_announcer.autosay("[D.registered_name] was unable to be resleeved by the automatic resleeving system.", "TransCore Oversight", "Medical")
		return
	if(new_character.isSynthetic())
		to_chat(ghost, "Unable to produce synthetic bodies.")
		src.visible_message("[src] flashes 'Unable to produce synthetic bodies!', and lets out a loud incorrect sounding beep!")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		new_character.Destroy()
		if((world.time - recordM.last_notification) < 30 MINUTES)
			global_announcer.autosay("[D.registered_name] was unable to be resleeved by the automatic resleeving system.", "TransCore Oversight", "Medical")
		return

	// Write the appearance and whatnot out to the character
	ghost_client.prefs.copy_to(new_character)
	if(new_character.dna)
		new_character.dna.ResetUIFrom(new_character)
		new_character.sync_organ_dna()

	// validate if this is legal
	if(new_character.name != D.registered_name)
		to_chat(ghost, "Character slot loaded did not match character being resleeved. Could not resleeve!")
		src.visible_message("[src] flashes 'Database desyncronization detected! Was unable to resleeve [D.registered_name]. Potential ethical violation detected!', and lets out a loud incorrect sounding beep!")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		new_character.Destroy()
		if((world.time - recordM.last_notification) < 30 MINUTES)
			global_announcer.autosay("[D.registered_name] was unable to be resleeved by the automatic resleeving system.", "TransCore Oversight", "Medical")
		return

	// Finish off setup!
	if(ghost.mind)
		ghost.mind.transfer_to(new_character)
	new_character.key = player_key

	// Were they any particular special role? If so, copy.
	if(new_character.mind)
		new_character.mind.loaded_from_ckey = picked_ckey
		new_character.mind.loaded_from_slot = picked_slot
		var/datum/antagonist/antag_data = get_antag_data(new_character.mind.special_role)
		if(antag_data)
			antag_data.add_antagonist(new_character.mind)
			antag_data.place_mob(new_character)

	for(var/lang in ghost_client.prefs.alternate_languages)
		var/datum/language/chosen_language = GLOB.all_languages[lang]
		if(chosen_language)
			if(is_lang_whitelisted(src,chosen_language) || (new_character.species && (chosen_language.name in new_character.species.secondary_langs)))
				new_character.add_language(lang)
	for(var/key in ghost_client.prefs.language_custom_keys)
		if(ghost_client.prefs.language_custom_keys[key])
			var/datum/language/keylang = GLOB.all_languages[ghost_client.prefs.language_custom_keys[key]]
			if(keylang)
				new_character.language_keys[key] = keylang

	//A redraw for good measure
	new_character.regenerate_icons()
	new_character.update_transform()

	var/confuse_amount = rand(8,26)
	var/blur_amount = rand(8,56)
	var/sickness_duration = rand(20,30) MINUTES

	// apply state
	new_character.confused = max(new_character.confused, confuse_amount)
	new_character.eye_blurry = max(new_character.eye_blurry, blur_amount)
	if(new_character.mind?.vore_death)
		new_character.add_modifier(/datum/modifier/resleeving_sickness, sickness_duration) //YW Edit: you git vored you still get the same debuff
		new_character.mind.vore_death = FALSE
	// Normal ones get a normal modifier to nerf charging into combat
	else
		new_character.add_modifier(/datum/modifier/resleeving_sickness, sickness_duration)

	// intentionally a bit bad to get resleeved in
	new_character.adjustOxyLoss( rand(5,25))
	new_character.adjustBruteLoss( rand(1,8), FALSE)
	new_character.adjustToxLoss( rand(0,12))
	new_character.adjustFireLoss( rand(0,8), FALSE)
	new_character.adjustCloneLoss( rand(0,6))
	new_character.sleeping = rand(4,6)

	log_admin("[new_character.ckey]'s character [new_character.real_name] has been auto-resleeved.")
	message_admins("[new_character.ckey]'s character [new_character.real_name] has been auto-resleeved.")

	if((world.time - recordM.last_notification) < 30 MINUTES)
		global_announcer.autosay("[new_character.name] has been resleeved by the automatic resleeving system.", "TransCore Oversight", "Medical")

	playsound(src, 'sound/machines/defib_charge.ogg', 50, 0)
	spawn(1 SECONDS)
		playsound(src, "bodyfall", 50, 1)
		playsound(src, 'sound/machines/defib_zap.ogg', 50, 1, -1)

		//Inform them and make them a little dizzy.
		if(confuse_amount + blur_amount <= 16)
			to_chat(new_character, "<span class='notice'>Your eyes open as you wake up in the tube, remembering only your last scan. Your new body feels comfortable, however.</span>")
		else
			to_chat(new_character, "<span class='warning'>Your eyes wince at the light as you try to remember what happened, weren't you just in the lobby? It's disorienting.</span>")

	spawn(5 SECONDS)
		new_character.forceMove(spawnloc)
		new_character.throw_at( get_edge_target_turf(src.loc, throw_dir), 1,5)
