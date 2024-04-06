/obj/effect/landmark/redspacestart
	name = "redentrance" // places in redspace where mobs are placed when they enter it
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"

/obj/effect/landmark/redspaceexit
	name = "redexit" // places in realspace that are legal to eject mobs to
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"



/obj/effect/landmark/redspacemonsterspawn
	name = "redmonster"

/obj/effect/landmark/redspacemonsterspawn/New()
	. = ..()

	if(prob(80))
		return // leave redspace mostly empty, so it feels dangerous when you do find something, not just insane and cruel

	if(!isturf(src.loc))
		return

	switch(rand(1,7))
		if(1)
			// clowns are the most complex, taken right from the clune infestation event
			var/spawncount = pick(1,2)
			while((spawncount >= 1))
				// normal ones...
				var/subcount = pick(2,3)
				while((subcount >= 1))
					var/mob/living/simple_mob/mobs_monsters/clowns/normal/C = new /mob/living/simple_mob/mobs_monsters/clowns/normal()
					C.loc = src.loc
					subcount--

				// what in gods name.
				subcount = pick(1,2)
				while((subcount >= 1))
					var/chosen_clown = pick(
					list(/mob/living/simple_mob/mobs_monsters/clowns/big/honkling
					, /mob/living/simple_mob/mobs_monsters/clowns/big/blob
					, /mob/living/simple_mob/mobs_monsters/clowns/big/mutant
					, /mob/living/simple_mob/mobs_monsters/clowns/big/flesh
					, /mob/living/simple_mob/mobs_monsters/clowns/big/scary
					, /mob/living/simple_mob/mobs_monsters/clowns/big/giggles
					, /mob/living/simple_mob/mobs_monsters/clowns/big/longface
					, /mob/living/simple_mob/mobs_monsters/clowns/big/hulk
					, /mob/living/simple_mob/mobs_monsters/clowns/big/thin
					, /mob/living/simple_mob/mobs_monsters/clowns/big/wide
					, /mob/living/simple_mob/mobs_monsters/clowns/big/perm
					, /mob/living/simple_mob/mobs_monsters/clowns/big/thicc
					, /mob/living/simple_mob/mobs_monsters/clowns/big/punished
					, /mob/living/simple_mob/mobs_monsters/clowns/big/cluwne
					, /mob/living/simple_mob/mobs_monsters/clowns/big/honkmunculus))

					var/mob/living/simple_mob/mobs_monsters/clowns/big/C = new chosen_clown()
					C.loc = src.loc
					subcount--
				spawncount--
		if(2)
			var/mob/living/simple_mob/shadekin/red/dark/C = new /mob/living/simple_mob/shadekin/red/dark()
			C.loc = src.loc

		if(3)
			var/mob/living/simple_mob/vore/alienanimals/synx/C = new /mob/living/simple_mob/vore/alienanimals/synx/ai()
			C.loc = src.loc

		if(4)
			var/mob/living/simple_mob/animal/space/jelly/C = new /mob/living/simple_mob/animal/space/jelly()
			C.loc = src.loc

		if(5)
			var/mob/living/simple_mob/vore/demon/engorge/C = new /mob/living/simple_mob/vore/demon/engorge()
			C.loc = src.loc

		if(6)
			var/mob/living/simple_mob/vore/alienanimals/chu/C = new /mob/living/simple_mob/vore/alienanimals/chu()
			C.loc = src.loc

		if(7)
			var/mob/living/simple_mob/creature/C = new /mob/living/simple_mob/creature()
			C.loc = src.loc


/obj/effect/landmark/hostile_xenobio
	name = "dangerous xenobio spawner"

/obj/effect/landmark/hostile_xenobio/New()
	. = ..()

	if(prob(60))
		return // most likely to be empty, so xenobio doesn't need to clear it out any time they want to do stuff

	if(!isturf(src.loc))
		return

	switch(rand(1,8))
		if(1)
			var/mob/living/simple_mob/vore/alienanimals/synx/C = new /mob/living/simple_mob/vore/alienanimals/synx/ai()
			C.loc = src.loc

		if(2)
			var/mob/living/simple_mob/animal/space/jelly/C = new /mob/living/simple_mob/animal/space/jelly()
			C.loc = src.loc

		if(3)
			var/mob/living/simple_mob/vore/alienanimals/chu/C = new /mob/living/simple_mob/vore/alienanimals/chu()
			C.loc = src.loc

		if(4)
			var/mob/living/simple_mob/animal/space/carp/C = new /mob/living/simple_mob/animal/space/carp()
			C.loc = src.loc

		if(5)
			var/mob/living/simple_mob/animal/passive/gaslamp/G = new /mob/living/simple_mob/animal/passive/gaslamp()
			G.loc = src.loc

		if(6)
			var/mob/living/simple_mob/animal/giant_spider/S = new /mob/living/simple_mob/animal/giant_spider()
			S.loc = src.loc

		if(7)
			var/mob/living/simple_mob/vore/leopardmander/M = new /mob/living/simple_mob/vore/leopardmander()
			M.loc = src.loc

		if(8)
			var/mob/living/simple_mob/animal/space/goose/G = new /mob/living/simple_mob/animal/space/goose()
			G.loc = src.loc




/obj/effect/landmark/dangerous_situation
	name = "dangerous situation spawner"

/obj/effect/landmark/dangerous_situation/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/dangerous_situation/LateInitialize()
	. = ..()

	if(!isturf(src.loc))
		return

	// creates stuff like ruptured gas tanks, and landmines
	switch(rand(1,4))
		if(1)
			var/newpath = pick(/obj/machinery/portable_atmospherics/canister/carbon_dioxide/broken,/obj/machinery/portable_atmospherics/canister/nitrous_oxide/broken,/obj/machinery/portable_atmospherics/canister/phoron/broken)
			var/obj/machinery/portable_atmospherics/canister/tank = new newpath()
			tank.loc = src.loc

		if(2)
			var/newpath = pick(prob(30);/obj/effect/mine,
				prob(25);/obj/effect/mine/frag,
				prob(25);/obj/effect/mine/emp,
				prob(10);/obj/effect/mine/stun,
				prob(10);/obj/effect/mine/incendiary)
			var/obj/effect/mine/M = new newpath()
			M.loc = src.loc

		if(3)
			var/obj/structure/largecrate/animal/pred/crate = new /obj/structure/largecrate/animal/pred()
			crate.name = "Kobby Friend Crate [rand(999,9999)]"
			crate.loc = src.loc

		if(4)
			var/obj/structure/largecrate/animal/dangerous/crate = new /obj/structure/largecrate/animal/dangerous()
			crate.name = "Super Kobby Friend Crate [rand(999,9999)]"
			crate.loc = src.loc




/obj/effect/landmark/step_trap
	name = "step trap spawner"

/obj/effect/landmark/step_trap/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/step_trap/LateInitialize()
	. = ..()

	if(prob(40))
		return;

	if(!isturf(src.loc))
		return

	// creates stuff like ruptured gas tanks, and landmines
	switch(rand(1,4))
		if(1)
			var/newpath = pick(
				/obj/effect/mine/emp,
				/obj/effect/mine/stun,
				/obj/effect/mine/training,
				/obj/effect/mine/lasertag/red,
				/obj/effect/mine/lasertag/blue,
				/obj/effect/mine/lasertag/omni,
				/obj/effect/mine/lasertag/all)
			var/obj/effect/mine/M = new newpath()
			M.loc = src.loc

		if(2)
			var/obj/item/device/assembly/mousetrap/armed/M = new /obj/item/device/assembly/mousetrap/armed();
			M.loc = src.loc

		if(3)
			var/obj/item/weapon/beartrap/M = new /obj/item/weapon/beartrap();
			M.deployed = TRUE
			M.update_icon();
			M.loc = src.loc
