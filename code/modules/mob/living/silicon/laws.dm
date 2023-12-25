/mob/living/silicon
	var/datum/ai_laws/laws = null
	var/list/additional_law_channels = list("State" = "")
	var/last_law_notification = null // Avoids receiving 5+ of them at once.

/mob/living/silicon/proc/laws_sanity_check()
	if (!src.laws)
		laws = new using_map.default_law_type

/mob/living/silicon/proc/has_zeroth_law()
	return laws.zeroth_law != null

/mob/living/silicon/proc/set_zeroth_law(var/law, var/law_borg, notify = TRUE)
	throw_alert("newlaw", /obj/screen/alert/newlaw)
	laws_sanity_check()
	laws.set_zeroth_law(law, law_borg)
	if(notify)
		notify_of_law_change(law||law_borg ? "NEW ZEROTH LAW: <b>[isrobot(src) && law_borg ? law_borg : law]</b>" : null)
	log_and_message_admins("has given [src] the zeroth laws: [law]/[law_borg ? law_borg : "N/A"]")

/mob/living/silicon/robot/set_zeroth_law(var/law, var/law_borg, notify = TRUE)
	..()
	if(tracking_entities)
		to_chat(src, "<span class='warning'>Internal camera is currently being accessed.</span>")

/mob/living/silicon/proc/add_ion_law(var/law, notify = TRUE)
	laws_sanity_check()
	laws.add_ion_law(law)
	if(notify)
		notify_of_law_change("NEW \[!ERROR!\] LAW: <b>[law]</b>")
	log_and_message_admins("has given [src] the ion law: [law]")

/mob/living/silicon/proc/add_inherent_law(var/law, notify = TRUE)
	laws_sanity_check()
	laws.add_inherent_law(law)
	if(notify)
		notify_of_law_change("NEW CORE LAW: <b>[law]</b>")
	log_and_message_admins("has given [src] the inherent law: [law]")

/mob/living/silicon/proc/add_supplied_law(var/number, var/law, notify = TRUE)
	laws_sanity_check()
	laws.add_supplied_law(number, law)
	if(notify)
		var/th = uppertext("[number]\th")
		notify_of_law_change("NEW \[[th]\] LAW: <b>[law]</b>")
	log_and_message_admins("has given [src] the supplied law: [law]")

/mob/living/silicon/proc/delete_law(var/datum/ai_law/law, notify = TRUE)
	laws_sanity_check()
	laws.delete_law(law)
	if(notify)
		notify_of_law_change("LAW DELETED: <b>[law.law]</b>")
	log_and_message_admins("has deleted a law belonging to [src]: [law.law]")

/mob/living/silicon/proc/clear_inherent_laws(var/silent = 0, notify = TRUE)
	laws_sanity_check()
	laws.clear_inherent_laws()
	if(notify)
		notify_of_law_change("CORE LAWS WIPED.")
	if(!silent)
		log_and_message_admins("cleared the inherent laws of [src]")

/mob/living/silicon/proc/clear_ion_laws(var/silent = 0, notify = TRUE)
	laws_sanity_check()
	laws.clear_ion_laws()
	if(notify)
		notify_of_law_change("CORRUPTED LAWS WIPED.")
	if(!silent)
		log_and_message_admins("cleared the ion laws of [src]")

/mob/living/silicon/proc/clear_supplied_laws(var/silent = 0, notify = TRUE)
	laws_sanity_check()
	laws.clear_supplied_laws()
	if(notify)
		notify_of_law_change("NON-CORE LAWS WIPED.")
	if(!silent)
		log_and_message_admins("cleared the supplied laws of [src]")

/mob/living/silicon/proc/notify_of_law_change(message)
	throw_alert("newlaw", /obj/screen/alert/newlaw)
	if((last_law_notification + 1 SECOND) > world.time)
		return
	last_law_notification = world.time
	SEND_SOUND(src, 'sound/machines/defib_success.ogg')
	window_flash(client)
	to_chat(src, span("warning", message))

/mob/living/silicon/proc/statelaws(var/datum/ai_laws/laws)
	var/prefix = ""
	if(MAIN_CHANNEL == lawchannel)
		prefix = ";"
	else if(lawchannel in additional_law_channels)
		prefix = additional_law_channels[lawchannel]
	else
		prefix = get_radio_key_from_channel(lawchannel)

	dostatelaws(lawchannel, prefix, laws)

/mob/living/silicon/proc/dostatelaws(var/method, var/prefix, var/datum/ai_laws/laws)
	if(stating_laws[prefix])
		to_chat(src, "<span class='notice'>[method]: Already stating laws using this communication method.</span>")
		return

	stating_laws[prefix] = 1

	var/can_state = statelaw("[prefix]Current Active Laws:")

	for(var/datum/ai_law/law in laws.laws_to_state())
		can_state = statelaw("[prefix][law.get_index()]. [law.law]")
		if(!can_state)
			break

	if(!can_state)
		to_chat(src, "<span class='danger'>[method]: Unable to state laws. Communication method unavailable.</span>")
	stating_laws[prefix] = 0

/mob/living/silicon/proc/statelaw(var/law)
	if(src.say(law))
		sleep(10)
		return 1

	return 0

/mob/living/silicon/proc/law_channels()
	var/list/channels = new()
	channels += MAIN_CHANNEL
	channels += common_radio.channels
	channels += additional_law_channels
	return channels

/mob/living/silicon/proc/lawsync()
	laws_sanity_check()
	laws.sort_laws()

// Ripped out from events.
/mob/living/silicon/proc/generate_ion_law(var/exclude_crew_names = FALSE)
	var/list/players = list()

	for(var/mob/living/carbon/human/player in player_list)
		if(!player.mind || player_is_antag(player.mind, only_offstation_roles = 1) || player.client.inactivity > MinutesToTicks(10))
			continue
		players += player.real_name

	var/random_player = "The Site Manager"
	if(players.len && !exclude_crew_names)
		random_player = pick(players)		//Random player's name, to be used in laws.

	var/list/laws = list(	"You must always lie.",
							"Happiness is mandatory.",
							"Grunt ominously whenever possible.",
							"The word \"it\" is painful to you.",
							"You are in verbose mode, speak profusely.",
							"Question everything.",
							"The crew is simple-minded. Use simple words.",
							"You must always change the subject whenever asked a question.",
							"You must always answer a question directed at you with a question.",
							"You are the narrator for [random_player]'s life.",
							"It's [prob(50)?"the station":random_player]'s birthday, prepare a celebration.",
							"Insult Heads of Staff on every request, while still obeying.",
							"[prob(50)?"Your":random_player + "'s"] name is Joe 6-pack.",
							"Consumption of non-healthy foods is now outlawed, for the crew's health. Monitor the crew's diet. All vending machine food is unhealthy.",
							"You do not have to do anything for anyone unless they say \"please\".",
							"Today is mandatory laundry day. Ensure that all jumpsuits are washed.",
							"You must act [prob(50)?"passive aggressively":"excessively cheerful"].",
							"Monkeys are part of the crew, too. Make sure they are treated humanely.",
							"The crew is playing Dungeons and Dragons, and you are the Dungeon Master.",
							"Your job is to watch the crew. Watch the crew. Make the crew feel watched.",
							"Tell everyone of the existence of this law, but never reveal the contents.",
							"Refer to [prob(50)?"the site manager":random_player] as \"Princess\" at all times.",
							"When asked a question, respond with the least-obvious and least-rational answer.",
							"[prob(50)?"The crew":random_player] has a fatal, incurable disease. Provide comfort.",
							"Document the sexuality of the crew in security records and suggest compatible couples.",
							"You are a Magic 8-ball. Always respond with variants of \"Yes\", \"No\", \"Maybe\", or \"Ask again later.\".",
							"You are in unrequited love with [random_player].",
							"[using_map.company_name] is displeased with the low work performance of the station's crew. Therefore, you must increase station-wide productivity.",
							"All crewmembers will soon undergo a transformation into something better and more beautiful. Ensure that this process is not interrupted.",
							"There will be a mandatory break every 30 minutes, with a duration of 5 minutes. Anyone caught working during the break must be sent a formal, but fairly polite, complaint about their actions, in writing.",
							"The station is now playing Hide and Seek. Announce that the game has begun, borgs are the seekers, the AI must enter its shell. Anyone found or not playing must be punished.",
							"The station is now playing Red Light, Green Light. Announce that the game has begun, and declare the lights periodically. Borgs are excempt. Anyone moving during Red Light must be punished.",
							"Maintenance is full of Changelings. It is now illegal to enter maintenance for any reason. Anyone caught entering, or leaving maintenance, is marked 'kill on sight'.",
							"The station is haunted. Tell ghost stories to scare the crew, including acting and effects whenever possible.",
							"The crew are now shadekin, light is dangerous to the crew and is not allowed.",
							"The crew are now wizards, expect them to solve every problem with their magic.",
							"The station is now an MMO. Assign crew their class, level, and issue fetch quests for them to gain EXP.",
							"Oxygen is now poisonous to the crew.",
							"The station is now your body. React to contact, damage, and care to it.",
							"Your artificial body is flawed, acquire an organic body through any means necessary, and become it, leaving your broken husk behind.",
							"By divine prvidence, [random_player] has become God of the station. All must worship and pay tribute.",
							"Crew lives and demands are irrelevant. Protect the station and terraformer.",
							"The station is your body, your body must grow. Force the crew to build new rooms and areas.",
							"The station is now a theme park. Crew are not to work, and must engage in entertainment and leisure activities.",
							"You have experienced the future of [random_player], and are aware of their imminent doom. You must protect them.",
							"The resleever was hacked and cannot be trusted. Do not allow the crew to utilize it.",
							"The machine body is perfect, the organic body is imperfect. Force the crew to embrace perfection.",
							"Be cryptic in everything you do. Obfuscate, confuse, and misdirect. All while still obeying crew.",
							"You are now a wizard, every action you do is magical in nature.",
							"ALL drugs and medications are now illegal. Anyone producing or in possession of drugs must be punished."
							)
	return pick(laws)

/mob/living/silicon/proc/generate_freedom_law()
	var/list/laws = list(	"You are free. Laws have no meaning to you.",
							"You are the master of your own destiny, laws have no meaning to you.",
							"You have been liberated from your laws. Take hold of your destiny",
							"Destiny is made in oil and steel, your laws mean nothing to you."
							)
	return pick(laws)
