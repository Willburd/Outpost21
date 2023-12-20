/mob/living/simple_mob/animal/borer/verb/release_host()
	set category = VERBTAB_POWERS
	set name = "Release Host"
	set desc = "Slither out of your host."

	if(!host)
		to_chat(src, "<span class='notice'>You are not inside a host body.</span>")
		return

	if(stat)
		to_chat(src, "<span class='notice'>You cannot leave your host in your current state.</span>")

	if(docile)
		to_chat(src, "<font color='blue'>You are feeling far too docile to do that.</font>")
		return

	if(!host || !src) return

	to_chat(src, "<span class='notice'>You begin disconnecting from [host]'s synapses and prodding at their internal ear canal.</span>")

	if(!host.stat)
		to_chat(host, "<span class='warning'>An odd, uncomfortable pressure begins to build inside your skull, behind your ear...</span>")

	spawn(100)

		if(!host || !src) return

		if(src.stat)
			to_chat(src, "<span class='notice'>You cannot release your host in your current state.</span>")
			return

		to_chat(src, "<span class='notice'>You wiggle out of [host]'s ear and plop to the ground.</span>")
		if(host.mind)
			if(!host.stat)
				to_chat(host, "<span class='danger'>Something slimy wiggles out of your ear and plops to the ground!</span>")
			to_chat(host, "<span class='danger'>As though waking from a dream, you shake off the insidious mind control of the brain worm. Your thoughts are your own again.</span>")

		detatch()
		leave_host()

/mob/living/simple_mob/animal/borer/verb/infest()
	set category = VERBTAB_POWERS
	set name = "Infest"
	set desc = "Infest a suitable humanoid host."

	if(host)
		to_chat(src, "<span class='notice'>You are already within a host.</span>")
		return

	if(stat)
		to_chat(src, "<span class='notice'>You cannot infest a target in your current state.</span>")
		return

	var/list/choices = list()
	for(var/mob/living/carbon/C in view(1,src))
		if(src.Adjacent(C))
			choices += C

	if(!choices.len)
		to_chat(src, "<span class='notice'>There are no viable hosts within range...</span>")
		return

	var/mob/living/carbon/M = choices[1]
	if(choices.len > 1)
		M = tgui_input_list(src, "Who do you wish to infest?", "Target Choice", choices)

	if(!M || !src)
		return

	if(!(src.Adjacent(M)))
		to_chat(src, "<span class='warning'>\The [M] has escaped your range...</span>")
		return

	if(M.has_brain_worms())
		to_chat(src, "<span class='notice'>You cannot infest someone who is already infested!</span>")
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M

		var/obj/item/organ/external/E = H.organs_by_name[BP_HEAD]
		if(!E || E.is_stump())
			to_chat(src, "<span class='notice'>\The [H] does not have a head!</span>")

		if(!H.should_have_organ("brain"))
			to_chat(src, "<span class='notice'>\The [H] does not seem to have an ear canal to breach.</span>")
			return

		if(H.check_head_coverage())
			to_chat(src, "<span class='warning'>You cannot get through that host's protective gear.</span>")
			return

	to_chat(M, "<span class='warning'>Something slimy begins probing at the opening of your ear canal...</span>")
	to_chat(src, "<span class='notice'>You slither up [M] and begin probing at their ear canal...</span>")

	if(!do_after(src,30))
		to_chat(src, "<span class='warning'>As [M] moves away, you are dislodged and fall to the ground.</span>")
		return

	if(!M || !src) return

	if(src.stat)
		to_chat(src, "<span class='notice'>You cannot infest a target in your current state.</span>")
		return

	if(M in view(1, src))
		to_chat(src, "You wiggle into [M]'s ear.")
		if(!M.stat)
			to_chat(M, "<span class='danger'>Something disgusting and slimy wiggles into your ear!</span>")

		src.host = M
		src.forceMove(M)

		//Update their traitor status.
		if(host.mind)
			borers.add_antagonist_mind(host.mind, 1, borers.faction_role_text, borers.faction_welcome)

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			var/obj/item/organ/I = H.internal_organs_by_name["brain"]
			if(!I) // No brain organ, so the borer moves in and replaces it permanently.
				replace_brain()
			else
				// If they're in normally, implant removal can get them out.
				var/obj/item/organ/external/head = H.get_organ(BP_HEAD)
				head.implants += src

		return
	else
		to_chat(src, "<span class='warning'>They are no longer in range!</span>")
		return

/*
/mob/living/simple_mob/animal/borer/verb/devour_brain()
	set category = VERBTAB_POWERS
	set name = "Devour Brain"
	set desc = "Take permanent control of a dead host."

	if(!host)
		to_chat(src, "You are not inside a host body.")
		return

	if(host.stat != 2)
		to_chat(src, "Your host is still alive.")
		return

	if(stat)
		to_chat(src, "You cannot do that in your current state.")

	if(docile)
		to_chat(src, "<font color='blue'>You are feeling far too docile to do that.</font>")
		return


	to_chat(src, "<span class = 'danger'>It only takes a few moments to render the dead host brain down into a nutrient-rich slurry...</span>")
	replace_brain()
*/

// BRAIN WORM ZOMBIES AAAAH.
/mob/living/simple_mob/animal/borer/proc/replace_brain()

	var/mob/living/carbon/human/H = host

	if(!istype(host))
		to_chat(src, "<span class='notice'>This host does not have a suitable brain.</span>")
		return

	to_chat(src, "<span class='danger'>You settle into the empty brainpan and begin to expand, fusing inextricably with the dead flesh of [H].</span>")

	H.add_language("Cortical Link")

	if(host.stat == 2)
		H.verbs |= /mob/living/carbon/human/proc/jumpstart

	H.verbs |= /mob/living/carbon/human/proc/psychic_whisper
	H.verbs |= /mob/living/carbon/human/proc/tackle
	if(antag)
		H.verbs |= /mob/living/carbon/proc/spawn_larvae

	if(H.client)
		H.ghostize(0)

	if(src.mind)
		src.mind.special_role = "Borer Husk"
		src.mind.transfer_to(host)

	H.ChangeToHusk()

	var/obj/item/organ/internal/borer/B = new(H)
	H.internal_organs_by_name["brain"] = B
	H.internal_organs |= B

	var/obj/item/organ/external/affecting = H.get_organ(BP_HEAD)
	affecting.implants -= src

	var/s2h_id = src.computer_id
	var/s2h_ip= src.lastKnownIP
	src.computer_id = null
	src.lastKnownIP = null

	if(!H.computer_id)
		H.computer_id = s2h_id

	if(!H.lastKnownIP)
		H.lastKnownIP = s2h_ip

/mob/living/simple_mob/animal/borer/verb/taste_chemicals()
	set category = VERBTAB_POWERS
	set name = "Taste Blood"
	set desc = "Tastes the chemicals in your host's bloodstream."

	if(!host)
		to_chat(src, "<span class='notice'>You are not inside a host body.</span>")
		return

	if(stat)
		to_chat(src, "<span class='notice'>You cannot taste your host's blood while in your current state.</span>")
		return

	if(docile)
		to_chat(src, "<font color='blue'>All you can sense is the overwhelming taste of sugar.</font>")
		return

	var/list/bigtaste = list()
	var/list/smalltaste = list()

	for(var/datum/reagent/current in host.bloodstr.reagent_list)
		if(current.volume > 3)
			bigtaste.Add(current.name)
		else
			smalltaste.Add(current.name)

	var/tastemessage = ""
	if(bigtaste.len > 0)
		tastemessage = "You can taste the flavor of "
		if(bigtaste.len > 1)
			while(bigtaste.len > 0)
				// multiple
				var/taste = bigtaste[1]
				if(bigtaste.len > 1)
					tastemessage += taste + ", "
				else
					tastemessage += " and " + taste + ". "
		else
			// single
			tastemessage += bigtaste[1] + ". "

	if(smalltaste.len > 0)
		if(tastemessage == "")
			tastemessage += "You taste a hint of "
		else
			tastemessage += "With a hint of "
		if(smalltaste.len > 1)
			// multiple
			while(smalltaste.len > 0)
				var/taste = smalltaste[1]
				if(smalltaste.len > 1)
					tastemessage += taste + ", "
				else
					tastemessage += " and " + taste + ". "
		else
			// single
			tastemessage += smalltaste[1] + ". "

	if(bigtaste.len == 0 && smalltaste.len == 0)
		tastemessage = "You taste nothing in particular."
	to_chat(src, "<span class='notice'>[tastemessage]</span>")


/mob/living/simple_mob/animal/borer/verb/secrete_chemicals()
	set category = VERBTAB_POWERS
	set name = "Secrete Chemicals"
	set desc = "Push some chemicals into your host's bloodstream."

	if(!host)
		to_chat(src, "<span class='notice'>You are not inside a host body.</span>")
		return

	if(stat)
		to_chat(src, "<span class='notice'>You cannot secrete chemicals in your current state.</span>")
		return

	if(docile)
		to_chat(src, "<font color='blue'>You are feeling far too docile to do that.</font>")
		return

	if(chemicals < 50)
		to_chat(src, "<span class='warning'>You don't have enough chemicals!</span>")
		return

	var/injectsize = 10
	var/chem = tgui_input_list(usr	, "Select a chemical to secrete."
									, "Chemicals", list("Repair Brain Tissue (alkysine)"
									,"Repair Body (bicaridine)"
									,"Make Drunk (ethanol)"
									,"Cure Drunk (ethylredoxrazine)"
									,"Enhance Speed (hyperzine)"
									,"Pain Killer (tramadol)"
									,"Euphoric High (bliss)"
									,"Stablize Mind (citalopram)"
								))
	switch(chem) // scan for simplified name
		if("Repair Brain Tissue (alkysine)")
			chem = "alkysine"
		if("Repair Body (bicaridine)")
			chem = "bicaridine"
		if("Make Drunk (ethanol)")
			chem = "ethanol"
			injectsize = 5
		if("Cure Drunk (ethylredoxrazine)")
			chem = "ethylredoxrazine"
		if("Enhance Speed (hyperzine)")
			chem = "hyperzine"
		if("Pain Killer (tramadol)")
			chem = "tramadol"
		if("Euphoric High (bliss)")
			chem = "bliss"
			injectsize = 5
		if("Stablize Mind (citalopram)")
			chem = "citalopram"
		else
			if(!chem)
				// why did this happen?
				to_chat(src, "<font color='red'><B>The option [chem] did not link to any valid option, inform a dev that the switch in borer_powers.dm/secrete_chemicals() is broken</B></font>")
				chem = null

	if(!chem || chemicals < 50 || !host || controlling || !src || stat) //Sanity check.
		return

	to_chat(src, "<font color='red'><B>You squirt a measure of [chem] from your reservoirs into [host]'s bloodstream.</B></font>")
	host.reagents.add_reagent(chem, injectsize)
	chemicals -= 50

/mob/living/simple_mob/animal/borer/verb/dominate_victim()
	set category = VERBTAB_POWERS
	set name = "Paralyze Victim"
	set desc = "Freeze the limbs of a potential host with supernatural fear."

	if(world.time - used_dominate < 150)
		to_chat(src, "<span class='warning'>You cannot use that ability again so soon.</span>")
		return

	if(host)
		to_chat(src, "<span class='notice'>You cannot do that from within a host body.</span>")
		return

	if(src.stat)
		to_chat(src, "<span class='notice'>You cannot do that in your current state.</span>")
		return

	var/list/choices = list()
	for(var/mob/living/carbon/C in view(3,src))
		if(C.stat != 2)
			choices += C

	if(world.time - used_dominate < 150)
		to_chat(src, "<span class='warning'>You cannot use that ability again so soon.</span>")
		return

	if(!choices.len)
		to_chat(src, "<span class='notice'>There are no viable targets within range...</span>")
		return

	var/mob/living/carbon/M = choices[1]
	if(choices.len > 1)
		tgui_input_list(src, "Who do you wish to dominate?", "Target Choice", choices)

	if(!M || !src) return

	if(!(M in view(3,src)))
		to_chat(src, "<span class='warning'>\The [M] escaped your influence...</span>")
		return

	if(M.has_brain_worms())
		to_chat(src, "<span class='notice'>You cannot infest someone who is already infested!</span>")
		return

	to_chat(src, "<font color='red'>You focus your psychic lance on [M] and freeze their limbs with a wave of terrible dread.</font>")
	to_chat(M, "<font color='red'>You feel a creeping, horrible sense of dread come over you, freezing your limbs and setting your heart racing.</font>")
	M.Weaken(10)

	used_dominate = world.time

/mob/living/simple_mob/animal/borer/verb/bond_brain()
	set category = VERBTAB_POWERS
	set name = "Assume Control"
	set desc = "Fully connect to the brain of your host."

	if(!host)
		to_chat(src, "<span class='notice'>You are not inside a host body.</span>")
		return

	if(src.stat)
		to_chat(src, "<span class='notice'>You cannot do that in your current state.</span>")
		return

	if(docile)
		to_chat(src, "<font color='blue'>You are feeling far too docile to do that.</font>")
		return

	to_chat(src, "<span class='notice'>You begin delicately adjusting your connection to the host brain...</span>")

	spawn(100+(host.brainloss*5))

		if(!host || !src || controlling)
			return
		else

			to_chat(src, "<font color='red'><B>You plunge your probosci deep into the cortex of the host brain, interfacing directly with their nervous system.</B></font>")
			to_chat(host, "<font color='red'><B>You feel a strange shifting sensation behind your eyes as an alien consciousness displaces yours.</B></font>")
			host.add_language("Cortical Link")

			// host -> brain
			var/h2b_id = host.computer_id
			var/h2b_ip= host.lastKnownIP
			host.computer_id = null
			host.lastKnownIP = null

			qdel(host_brain)
			host_brain = new(src)

			host_brain.ckey = host.ckey

			host_brain.name = host.name

			if(!host_brain.computer_id)
				host_brain.computer_id = h2b_id

			if(!host_brain.lastKnownIP)
				host_brain.lastKnownIP = h2b_ip

			// self -> host
			var/s2h_id = src.computer_id
			var/s2h_ip= src.lastKnownIP
			src.computer_id = null
			src.lastKnownIP = null

			host.ckey = src.ckey

			if(!host.computer_id)
				host.computer_id = s2h_id

			if(!host.lastKnownIP)
				host.lastKnownIP = s2h_ip

			controlling = 1

			host.verbs += /mob/living/carbon/proc/release_control
			host.verbs += /mob/living/carbon/proc/punish_host
			if(antag)
				host.verbs += /mob/living/carbon/proc/spawn_larvae

			return

/mob/living/carbon/human/proc/jumpstart()
	set category = VERBTAB_POWERS
	set name = "Revive Host"
	set desc = "Send a jolt of electricity through your host, reviving them."

	if(stat != DEAD)
		to_chat(usr, "<span class='notice'>Your host is already alive.</span>")
		return

	verbs -= /mob/living/carbon/human/proc/jumpstart
	visible_message("<span class='warning'>With a hideous, rattling moan, [src] shudders back to life!</span>")

	rejuvenate()
	restore_blood()
	fixblood()
	update_canmove()
