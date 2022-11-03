/obj/vehicle/has_interior/controller
	/*=================================================================
	Explaination:
		This is the core of the vehicle's code. It handles multi-tile movement,
		running things over, etc. Players that click the vehicle can enter it
		from whatever tile is specific as the entrance tile. They will be teleported
		to the 'interior_area' specified, at the 'vehicle_interior/entrypos' landmark
		in that area.

		This 'interior_area' also scans for certain seats and consoles defined
		in this file. Each child object of this controller can have different
		seat and console requirements, such as driver, gunner, maingun, loader, etc.
		For example, an APC wouldn't have a maingun, but instead multiple gunners.
		Placing a main gun inside it would not work, as the child object itself does
		not have a main gun defined on the exterior of the vehicle. The vehicle itself
		also requires every seat and console for each gunner present.
	=================================================================*/

	name = "interior capable vehicle controller"

	desc = "If you can read this, something is wrong."
	icon = 'icons/obj/vehicles_vr.dmi'	//VOREStation Edit
	description_info = "Use ctrl-click to quickly toggle the engine if you're adjacent (only when vehicle is stationary). Alt-click will grab the keys, if present."
	icon_state = "cargo_engine"
	on = 0
	powered = 1
	locked = 0

	load_item_visible = 1
	load_offset_x = 0
	mob_offset_y = 7

	// area needed for each unique vehicle interior!
	// Cannot share map locations either.
	// DO NOT SET IN CHILD OBJECTS, this is for MAPPERS to set!
	var/interior_area = null

	// set AUTOMAGICALLY by init! DO NOT SET
	var/area/intarea = null
	var/camera_network = "armored vehicles"
	var/turf/entrypos = null // where to place atoms that enter the interior
	var/turf/exitpos = null // where to place atoms that enter the interior

	var/driver_seat = null // should only be one
	var/gunner_seats = list() // dakkas
	var/maingun_seats = list() // guns that are fed by...
	var/feed_machine = null // ammo is put into this and used up by mainguns

//-------------------------------------------
// Standard procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/Initialize()
	// set exit pos
	exitpos = src.loc

	// find interior entrypos
	for(var/area/A)
		if(istype( A, interior_area))
			intarea = A // become reference...
			for(var/turf/T in intarea.get_contents())
				if(istype(T))
					// scan for interior drop location
					if(istype( locate(/obj/effect/landmark/vehicle_interior/entrypos) in T.contents, /obj/effect/landmark/vehicle_interior/entrypos))
						entrypos = T
					// scan for exit triggers
					for(var/obj/effect/step_trigger/vehicle_interior/exit_trigger/R in T.contents)
						R.interior_controller = src // set controller so we can leave this vehicle!


	if(!istype(intarea))
		log_debug("Interior vehicle [name] was missing a defined area! Could not init...")
	else
		// load all interior parts as components of vehicle!
		log_debug("Interior vehicle [name] setting up...")

	. = ..()

/obj/vehicle/has_interior/controller/Move()
	. = ..()
	// update location
	exitpos = src.loc

/obj/vehicle/has_interior/controller/Bump(atom/Obstacle)
	if(!istype(Obstacle, /atom/movable))
		return

	var/atom/movable/A = Obstacle
	var/turf/T = get_step(A, dir)
	if(isturf(T))
		if(istype(A, /obj))//Then we check for regular obstacles.
			/* I'm not sure if this works with portals at all due to chaining shenanigans, I'm only fixing stairs here, TODO?
			if(istype(A, /obj/effect/portal))	//derpfix
				src.anchored = 0				// Portals can only move unanchored objects.
				A.Crossed(src)
				spawn(0)//countering portal teleport spawn(0), hurr
					src.anchored = 1
			*/
			if(A.anchored)
				A.Bumped(src) //bonk
			else
				A.Move(T)	//bump things away when hit

	if(istype(A, /mob/living))
		var/mob/living/M = A
		visible_message("<font color='red'>[src] knocks over [M]!</font>")
		M.apply_effects(5, 5)				//knock people down if you hit them
		M.apply_damages(22 / move_delay)	// and do damage according to how fast the train is going
		if(istype(load, /mob/living/carbon/human))
			var/mob/living/D = load
			to_chat(D, "<font color='red'>You hit [M]!</font>")
			add_attack_logs(D,M,"Ran over with [src.name]")

//trains are commonly open topped, so there is a chance the projectile will hit the mob riding the train instead
/obj/vehicle/has_interior/controller/bullet_act(var/obj/item/projectile/Proj)
	. = ..()

/obj/vehicle/has_interior/controller/update_icon()
	. = ..()

//-------------------------------------------
// Vehicle procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/explode()
	. = ..()

//-------------------------------------------
// Interaction procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/relaymove(mob/user, direction)
	if(user != load)
		return 0
	if(Move(get_step(src, direction)))
		return 1
	return 0

/obj/vehicle/has_interior/controller/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	if(user.buckled || user.stat || user.restrained() || !Adjacent(user) || !user.Adjacent(C) || !istype(C) || (user == C && !user.canmove))
		return
	enter_interior(user)
	/*
	if(!load(C, user))
		to_chat(user, "<font color='red'>You were unable to load [C] on [src].</font>")
	*/

/obj/vehicle/has_interior/controller/attack_hand(mob/user as mob)
	if(user.stat || user.restrained() || !Adjacent(user))
		return 0
	enter_interior(user)
	/*
	if(user != load && (user in src))
		user.forceMove(loc)			//for handling players stuck in src
	else if(load)
		unload(user)			//unload if loaded
	else if(!load && !user.buckled)
		load(user, user)				//else try climbing on board
	else
		return 0
	*/

/obj/vehicle/has_interior/controller/proc/enter_interior(var/atom/movable/C)
	// moves atom to interior access point of tank
	if(istype(entrypos,/turf/))
		C.forceMove(entrypos)
	else
		C.visible_message("<span class='notice'>Interior inaccessible...</span>")

/obj/vehicle/has_interior/controller/proc/exit_interior(var/atom/movable/C)
	// moves atom to interior access point of tank
	if(istype(exitpos,/turf/))
		C.forceMove(exitpos)
	else
		C.visible_message("<span class='notice'>Exterior inaccessible...</span>")

/obj/vehicle/has_interior/controller/load(var/atom/movable/C, var/mob/user)
	if(!istype(C, /mob/living/carbon/human))
		return 0

	return ..()


// interior area objects
/obj/effect/landmark/vehicle_interior/entrypos // where mobs are placed on entering the tank
	name = "interior entrypos"

/obj/effect/step_trigger/vehicle_interior/exit_trigger // exit the vehicle through any means! NEEDS TO BE INSIDE THE VEHICLES INTERIOR AREA!
	name = "vehicle exit"
	affect_ghosts = TRUE // bad ectoplasms
	var/obj/vehicle/has_interior/controller/interior_controller = null

/obj/effect/step_trigger/vehicle_interior/exit_trigger/Trigger(var/atom/movable/A)
	interior_controller.exit_interior(A)