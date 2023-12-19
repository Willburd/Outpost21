/mob/living/proc/super_fart()
	set name = "Super Fart"
	set desc = "Release a horrifying wave of your presence, or just be a giant asshole."
	set category = VERBTAB_POWERS

	// Please, lets just keep this as a joke.
	var/mob/living/carbon/human/C = src
	if(C.stat == DEAD)
		to_chat(C,"<span class='notice'>The dead cannot toot!</span>")
		return

	var/deathmessage = ""
	C.gutdeathpressure += 1
	var/range = 5 + C.gutdeathpressure
	// obnoxious, and eventually fatal
	playsound(C, 'sound/effects/poot.ogg', 100, 1)
	for(var/mob/M in living_mobs(range))
		var/dist = get_dist(M.loc, src.loc)
		shake_camera(M, dist > 8 ? 3 : 5, dist > 10 ? 1 : 3)
		if(M != src)
			M.Stun(1)

	// hell toot
	var/findholybook
	if(isturf(C.loc))
		var/turf/T = C.loc
		for(var/obj/item/weapon/storage/bible/B in T.contents)
			findholybook = B
			break
	if(findholybook)
		var/list/redexitlist = list()
		var/list/hellexitlist = list()
		for(var/obj/effect/landmark/R in landmarks_list)
			if(R.name == "hell")
				hellexitlist += R
			if(R.name == "redentrance")
				redexitlist += R
		// shakey
		for(var/mob/M in living_mobs(range))
			shake_camera(M, 5, 3)
			if(M != src)
				M.Stun(3)
		// sparky
		var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
		sparks.set_up(5, 0, src)
		sparks.attach(C.loc)
		sparks.start()
		// send em to hell, or redspace if none exists... or just gib them
		if(hellexitlist.len > 0)
			C.forceMove(pick(hellexitlist).loc)
		else if(redexitlist.len > 0)
			C.forceMove(pick(redexitlist).loc)
		else
			C.gib()
		deathmessage = " and toots out of time and space"
	// death toot
	else if(C.gutdeathpressure > 5)
		if(prob(C.gutdeathpressure))
			for(var/mob/M in living_mobs(range))
				shake_camera(M, 5, 3)
				if(M != src)
					M.Stun(8)
			C.gib()
			deathmessage = " and explodes"
	// lights rattled or bursted
	for(var/obj/machinery/light/L in orange(10, C))
		if(prob(C.gutdeathpressure * 2))
			spawn(rand(5,25))
				L.broken()
		else
			L.flicker(4)
	C.visible_message("<span class='danger'>\The [C] unleashes a violent and obnoxious blast from their rear[deathmessage]!</span>","<span class='danger'>You unleash the horrifying power of your rump!</span>");
