/obj/effect/landmark/holiday_event_spawn
	name = "holiday item spawn"
	icon = 'icons/obj/flora/pumpkins.dmi'
	icon_state = "spawner-jackolantern"

/obj/effect/landmark/holiday_event_spawn/New()
	// get time from our own web domain, intentionally fails, we only want the time...
	Holiday_Event_Spawn_Object(src.loc)
	del(src)


//////////////////////////////////////////////////////////////////////////////
// Proc decides what spawns for all the holiday event objects ---------------------------------------------------------
/proc/Holiday_Event_Spawn_Object(var/turf/here)
	var/MM	=	text2num(time2text(world.timeofday, "MM")) 	// get the current month
	var/DD	=	text2num(time2text(world.timeofday, "DD")) 	// get the current day
	switch(MM)
		//if(1)	//Jan TODO
		//	switch(DD)
		//		if(1)
		//			return new /obj/item/toy/figure/clown(here)
		if(4)   //April
			switch(DD)
				if(1)
					return new /obj/item/toy/figure/clown(here)
				if(22)
					return new /obj/random/pottedplant(here)

		if(5)	//May
			switch(DD)
				if(18)
					return new /obj/structure/flora/pottedplant/small(here)

		if(9)	//Sep
			switch(DD)
				if(19)
					return new /obj/item/flag/pirate(here)

		if(10)	//Oct
			return new /obj/effect/landmark/carved_pumpkin_spawn(here)

		if(12)	//Dec
			if(DD < 26)
				return new /obj/item/toy/xmastree(here)

	// default plant spawn
	return new /obj/machinery/holoplant(here)
