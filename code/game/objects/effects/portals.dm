GLOBAL_LIST_BOILERPLATE(all_portals, /obj/effect/portal)

/obj/effect/portal
	name = "portal"
	desc = "Looks unstable. Best to test it with the clown."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "portal"
	density = TRUE
	unacidable = TRUE//Can't destroy energy portals.
	var/failchance = 5
	var/obj/item/target = null
	var/creator = null
	var/redchance = 1 //outpost 21 edit - what have you done... default 1%
	anchored = TRUE

/obj/effect/portal/Bumped(mob/M as mob|obj)
	if(istype(M,/mob) && !(isliving(M)))
		return	//do not send ghosts, zshadows, ai eyes, etc
	spawn(0)
		src.teleport(M)
		return
	return

/obj/effect/portal/Crossed(atom/movable/AM as mob|obj)
	if(AM.is_incorporeal())
		return
	if(istype(AM,/mob) && !(isliving(AM)))
		return	//do not send ghosts, zshadows, ai eyes, etc
	spawn(0)
		src.teleport(AM)
		return
	return

/obj/effect/portal/attack_hand(mob/user as mob)
	if(istype(user) && !(isliving(user)))
		return	//do not send ghosts, zshadows, ai eyes, etc
	spawn(0)
		src.teleport(user)
		return
	return

/obj/effect/portal/Initialize()
	. = ..()
	QDEL_IN(src, 30 SECONDS)

/obj/effect/portal/proc/teleport(atom/movable/M as mob|obj)
	if(istype(M, /obj/effect)) //sparks don't teleport
		return
	if (M.anchored&&istype(M, /obj/mecha))
		return
	if (icon_state == "portal1")
		return
	if (!( target ))
		qdel(src)
		return
	if (istype(M, /atom/movable))
		//VOREStation Addition Start: Prevent taurriding abuse
		if(isliving(M))
			var/mob/living/L = M
			if(LAZYLEN(L.buckled_mobs))
				var/datum/riding/R = L.riding_datum
				for(var/rider in L.buckled_mobs)
					R.force_dismount(rider)
		//VOREStation Addition End: Prevent taurriding abuse

		// outpost 21 addition begin - OH NO
		if(redchance < 0)
			// lazy magic number return portal if -1
			var/list/redexitlist = list()
			for(var/obj/effect/landmark/R in landmarks_list)
				if(R.name == "redexit")
					redexitlist += R

			if(redexitlist.len > 0)
				do_teleport(M,pick( redexitlist).loc, 0,local = FALSE)
			else
				do_teleport(M, target, 1)  // fail...

			// passout on return to reality
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				H.AdjustSleeping(15)
				H.AdjustWeakened(3)
				H.adjustHalLoss(-9)
			return

		else if(prob(redchance))
			var/list/redlist = list()
			for(var/obj/effect/landmark/R in landmarks_list)
				if(R.name == "redentrance")
					redlist += R

			if(redlist.len > 0)
				// if teleport worked, drop out... otherwise just teleport normally, it means there was no redspace spawns!
				do_teleport(M,pick( redlist).loc, 0,local = FALSE)
				return
		// outpost 21 addition end

		if(prob(failchance)) //oh dear a problem, put em in deep space
			src.icon_state = "portal1"
			do_teleport(M, locate(rand(5, world.maxx - 5), rand(5, world.maxy -5), 3), 0)
		else
			do_teleport(M, target, 1) ///You will appear adjacent to the beacon




/obj/effect/portal/redspace_returner
	icon = 'icons/effects/effects.dmi'
	icon_state = "rift"
	redchance = -1 // lazy flag
