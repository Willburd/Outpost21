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

	switch(rand(1,5))
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
			var/mob/living/simple_mob/animal/synx/C = new /mob/living/simple_mob/animal/synx()
			C.loc = src.loc

		if(4)
			var/mob/living/simple_mob/animal/space/jelly/C = new /mob/living/simple_mob/animal/space/jelly()
			C.loc = src.loc

		if(5)
			var/mob/living/simple_mob/vore/demon/engorge/C = new /mob/living/simple_mob/vore/demon/engorge()
			C.loc = src.loc
