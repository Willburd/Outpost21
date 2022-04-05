/turf/unsimulated/floor
	name = "floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "Floor3"

/turf/unsimulated/mask
	name = "mask"
	icon = 'icons/turf/walls.dmi'
	icon_state = "rockvault"

/turf/unsimulated/floor/shuttle_ceiling
	icon_state = "reinforced"

/turf/unsimulated/elevator_shaft
	name = "floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "elevatorshaft"

/turf/unsimulated/deathdrop
	// overridable, instantkill floors
	name = "floor"
	icon = 'icons/turf/open_space.dmi'
	icon_state = "black_open"
	var/death_message = "You fall to an unavoidable death."

/turf/unsimulated/deathdrop/Entered(atom/A)
	spawn(0)
		if(A.is_incorporeal())
			return
		if(istype( A, /atom/movable))
			var/atom/movable/AM = A
			if(!AM.can_fall()) // flying checks
				return
		if(ismob( A))
			to_chat( A, "<span class='danger'>[death_message]</span>")
		qdel(A)