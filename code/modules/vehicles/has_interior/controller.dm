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
	description_info = "..."

	icon = 'icons/obj/vehicles_160x160.dmi'
	icon_state = "sec_apc"

	// lorge boi
	bound_width = 96
	bound_height = 96
	bound_x = -32
	bound_y = -32

	// graphics offset of lorge boi
	old_x = -64
	old_y = -64
	pixel_x = -64
	pixel_y = -64

	plane = MOB_PLANE
	layer = ABOVE_MOB_LAYER

	locked = 0
	load_item_visible = FALSE
	var/obj/item/weapon/key/key
	var/key_type = /obj/item/weapon/key/cargo_train // override me
	var/breakwalls = FALSE
	var/has_breaking_speed = TRUE // if becomes stopped by a wall, this becomes false, until we are able to free move again (including reversing)
	var/headlights_enabled = FALSE

	// area needed for each unique vehicle interior!
	// Cannot share map locations either.
	// DO NOT SET IN CHILD OBJECTS, this is for MAPPERS to set!
	var/interior_area = null
	var/exit_door_direction = SOUTH // if vehicle is facing north, what direction do things leaving it go in? They appear outside the collision box, and only if they can stand there.

	// set AUTOMAGICALLY by init! DO NOT SET
	var/area/intarea = null
	var/turf/entrypos = null // where to place atoms that enter the interior
	var/turf/exitpos = null // where to place atoms that enter the interior
	var/obj/machinery/door/vehicle_interior_hatch/entrance_hatch = null
	var/obj/structure/bed/chair/vehicle_interior_pilot/driver_seat = null // should only be one
	var/obj/machinery/computer/vehicle_interior_console/driver_console = null
	var/gunner_seat = null // dakka
	var/maingun_seat = null // gun that is fed by...
	var/feed_machine = null // ammo is put into this and used up by mainguns

//-------------------------------------------
// Standard procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/New()
	..()
	cell = new /obj/item/weapon/cell/high(src)
	key = new key_type(src)

/obj/vehicle/has_interior/controller/Initialize()
	// set exit pos
	update_exit_pos()

	// find interior entrypos
	for(var/area/A)
		if(istype( A, interior_area))
			intarea = A // become reference...
			for(var/turf/T in intarea.get_contents())
				if(istype(T))
					// TODO - make all one typechecking loop instead of 10 lol

					// scan for interior drop location
					if(istype( locate(/obj/effect/landmark/vehicle_interior/entrypos) in T.contents, /obj/effect/landmark/vehicle_interior/entrypos))
						entrypos = T
					// scan for exit door
					for(var/obj/machinery/door/vehicle_interior_hatch/R in T.contents)
						R.interior_controller = src // set controller so we can leave this vehicle!
						entrance_hatch = R
					// scan for consoles
					for(var/obj/machinery/computer/C in T.contents)
						if(istype( C, /obj/machinery/computer/vehicle_interior_console))
							driver_console = C
							driver_console.name = "[name]'s Helm"
							driver_console.desc = "Used to pilot the [name]. Use ctrl-click to quickly toggle the engine if you're adjacent. Alt-click will grab the keys, if present."
							driver_console.interior_controller = src
					// scan for pilot seat
					for(var/obj/structure/bed/chair/vehicle_interior_pilot/S in T.contents)
						driver_seat = S
						driver_seat.interior_controller = src
						turn_off()	//so engine verbs are correctly set

	if(!istype(intarea))
		log_debug("Interior vehicle [name] was missing a defined area! Could not init...")
	else
		// load all interior parts as components of vehicle!
		log_debug("Interior vehicle [name] setting up...")

	. = ..()

/obj/vehicle/has_interior/controller/relaymove(mob/user, direction)
	if(LAZYLEN(driver_console.viewers) > 0 && on) // only if driver is looking!
		// attempt destination
		var/hold_direction = dir
		var/could_move = FALSE
		var/turf/newloc = get_step(src, direction)

		if(user.stat || !user.canmove)
			// knocked out controller
		else
			// stairs check
			for(var/obj/structure/stairs/S in newloc)
				could_move = vehicle_move(newloc, direction) // move to pos,
				if(!could_move && dir == direction) // bumped back step...
					S.use_stairs(src, newloc) // ... so use stairs!
					return TRUE
				return could_move // stop movement here, do not break walls

			// standard move
			var/turf/checkm = get_step(newloc, direction)
			var/turf/checka = get_step(checkm, NORTH)
			var/turf/checkb = get_step(checkm, SOUTH)
			if(direction == NORTH || direction == SOUTH)
				checka = get_step(checkm, EAST)
				checkb = get_step(checkm, WEST)

			// tank only likes to turn if able to move, cannot 180!
			could_move = vehicle_move(newloc, direction)
			if(could_move)
				// restore breaking speed
				has_breaking_speed = TRUE

			// break things we run over, IS A WIDE BOY
			smash_at_loc(checkm) // at destination
			if(!could_move) crush_mobs_at_loc(checkm)
			smash_at_loc(checka) // and at --
			if(!could_move) crush_mobs_at_loc(checka)
			smash_at_loc(checkb) // -- each side
			if(!could_move) crush_mobs_at_loc(checkb)

			// update facing
			if(direction == reverse_direction(hold_direction))
				dir = hold_direction

			// UNRELENTING VIOLENCE
			for(var/turf/T in locs)
				crush_mobs_at_loc(T)

			return could_move
	return FALSE

/obj/vehicle/has_interior/controller/proc/shake_cab()
	for(var/mob/living/M in intarea)
		if(M.buckled)
			if(driver_seat.has_buckled_mobs() && driver_seat.buckled_mobs[1] == M)
				// do not shake driver
			else
				shake_camera(M, 0.5, 0.1)
		else
			shake_camera(M, 0.5, 0.2)

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
				A.Move(T)	  //bump things away when hit

//trains are commonly open topped, so there is a chance the projectile will hit the mob riding the train instead
/obj/vehicle/has_interior/controller/bullet_act(var/obj/item/projectile/Proj)
	. = ..()

/obj/vehicle/has_interior/controller/update_icon()
	. = ..()

//-------------------------------------------
// Violence!
//-------------------------------------------
/obj/vehicle/has_interior/controller/proc/smash_at_loc(var/newloc)
	if(istype(newloc,/turf/))
		var/turf/T = newloc
		for(var/atom/A in T.contents)
			smash_things(A) // what is in the turf
		smash_things(T) // turf itself

/obj/vehicle/has_interior/controller/proc/smash_things(var/target)
	var/severity = pick(2,2,3,3,3)
	if(has_breaking_speed)
		severity = 2 // first smash always best

	// shielded
	if(istype(target, /obj/effect/energy_field))
		if(has_breaking_speed)
			var/obj/effect/energy_field/EF = target
			if(EF.opacity)
				EF.visible_message("<span class='danger'>Something begins forcing itself through \the [EF]!</span>")
			else
				EF.visible_message("<span class='danger'>\The [src] begins forcing itself through \the [EF]!</span>")

			if(do_after(src, EF.strength * 5))
				EF.adjust_strength(rand(-8, -10))
				EF.visible_message("<span class='danger'>\The [src] crashes through \the [EF]!</span>")
			else
				EF.visible_message("<span class='danger'>\The [EF] reverberates as it returns to normal.</span>")

			// shakey time
			shake_cab()
			return 1

	// BREAK
	if(istype(target,/turf/simulated/wall))
		if(has_breaking_speed && breakwalls)
			var/turf/simulated/wall/W = target
			if(W.density)
				// stopped speed!
				has_breaking_speed = FALSE
				W.visible_message("<span class='danger'>Something crashes against \the [W]!</span>")
				W.ex_act(severity)

				// breaking stuff
				var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
				sparks.set_up(5, 0, W.loc)
				sparks.attach(W)
				sparks.start()

				// cab sounds
				playsound(driver_seat, get_sfx("vehicle_crush"), 50, 1)

				// shakey time
				shake_cab()
				return 1

	else if(istype(target,/atom/movable))
		if(istype(target, /obj/structure))
			var/obj/structure/S = target
			if(!S.unacidable)
				if(S.density || prob(1))
					S.visible_message("<span class='danger'>Something crashes against \the [S]!</span>")
					S.ex_act(severity)

					// breaking stuff
					var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
					sparks.set_up(5, 0, S.loc)
					sparks.attach(S)
					sparks.start()

					// cab sounds
					playsound(driver_seat, get_sfx("vehicle_crush"), 50, 1)

					// shakey time
					shake_cab()
					return 1

		if(istype(target, /obj/machinery/))
			var/obj/machinery/M = target
			if(M.density || prob(3))
				M.visible_message("<span class='danger'>Something crashes against \the [M]!</span>")
				M.ex_act(severity)

				// breaking stuff
				var/datum/effect/effect/system/spark_spread/sparks = new /datum/effect/effect/system/spark_spread()
				sparks.set_up(5, 0, M.loc)
				sparks.attach(M)
				sparks.start()

				// cab sounds
				playsound(driver_seat, get_sfx("vehicle_crush"), 50, 1)

				// shakey time
				shake_cab()
				return 1
	return 0

/obj/vehicle/has_interior/controller/proc/crush_mobs_at_loc(var/newloc)
	if(istype(newloc,/turf/))
		var/turf/T = newloc
		for(var/mob/M in T.contents)
			crush_mobs(M)

/obj/vehicle/has_interior/controller/proc/crush_mobs(var/target)
	var/move_damage = 33 / move_delay
	if(istype(target, /mob/living))
		var/mob/living/M = target
		if(!M.is_incorporeal())
			visible_message("<font color='red'>[src] runs over [M]!</font>")
			M.apply_effects(5, 5)				//knock people down if you hit them
			M.apply_damages(move_damage)	// and do damage according to how fast the train is going

			// cab sounds
			playsound(driver_seat, get_sfx("vehicle_crush"), 50, 1)
			return 1

//-------------------------------------------
// Vehicle procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/explode()
	. = ..()

//-------------------------------------------
// Interaction procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	if(user.buckled || user.stat || user.restrained() || !Adjacent(user) || !user.Adjacent(C) || !istype(C) || (user == C && !user.canmove))
		return 0
	if(entrance_hatch == null || !entrance_hatch.locked)
		user.visible_message("<span class='notice'>[user] begins to climb into \the [src].</span>", "<span class='notice'>You begin to climb into \the [src].</span>")
		if(do_after(user, 20))
			enter_interior(user)
	else
		entrance_hatch.do_animate("deny")
		playsound(src, entrance_hatch.denied_sound, 50, 0, 3)

/obj/vehicle/has_interior/controller/attack_hand(mob/user as mob)
	// nothing YET, used for attacks

/obj/vehicle/has_interior/controller/proc/enter_interior(var/atom/movable/C)
	// moves atom to interior access point of tank
	if(istype(entrypos,/turf/))
		C.forceMove(entrypos)
	else
		C.visible_message("<span class='notice'>Interior inaccessible...</span>")

/obj/vehicle/has_interior/controller/proc/update_exit_pos()
	var/ang = dir2angle(dir)
	ang += dir2angle(exit_door_direction)
	var/direx = angle2dir(ang)
	exitpos = get_step(get_step(loc,direx),direx)

/obj/vehicle/has_interior/controller/proc/exit_interior(var/atom/movable/C)
	// update location
	update_exit_pos()
	// moves atom to interior access point of tank
	if(istype(exitpos,/turf/))
		var/turf/T = exitpos
		if(!T.CanPass( C, exitpos))
			to_chat(C, "<span class='notice'>Exit is blocked!</span>")
			return
		for(var/atom/A in T.contents)
			if(!A.CanPass( C, exitpos))
				to_chat(C, "<span class='notice'>Exit is blocked!</span>")
				return
		C.forceMove(exitpos)
	else
		C.visible_message("<span class='notice'>Exterior inaccessible...</span>")

/obj/vehicle/has_interior/controller/load(var/atom/movable/C, var/mob/user)
	if(!istype(C, /mob/living/carbon/human))
		return 0

	return ..()

//-------------------------------------------
// Verb control, these are all responses to the verbs from the pilot seat!
//-------------------------------------------
/obj/vehicle/has_interior/controller/turn_on()
	if(!key)
		return
	if(!cell)
		return
	else
		..()
		update_stats()

		driver_seat.verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/stop_engine
		driver_seat.verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/start_engine
		driver_seat.verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_on
		driver_seat.verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_off

		if(on)
			driver_seat.verbs += /obj/structure/bed/chair/vehicle_interior_pilot/verb/stop_engine
		else
			driver_seat.verbs += /obj/structure/bed/chair/vehicle_interior_pilot/verb/start_engine

		if(headlights_enabled)
			driver_seat.verbs += /obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_off
		else
			driver_seat.verbs += /obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_on
	light_set()

/obj/vehicle/has_interior/controller/turn_off()
	..()
	driver_seat.verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/stop_engine
	driver_seat.verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/start_engine
	driver_seat.verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_on
	driver_seat.verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_off

	if(!on)
		driver_seat.verbs += /obj/structure/bed/chair/vehicle_interior_pilot/verb/start_engine
	else
		driver_seat.verbs += /obj/structure/bed/chair/vehicle_interior_pilot/verb/stop_engine

	if(!headlights_enabled)
		driver_seat.verbs += /obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_on
	else
		driver_seat.verbs += /obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_off
	light_set()

/obj/vehicle/has_interior/controller/proc/light_set()
	playsound(src, 'sound/machines/button.ogg', 100, 1, 0) // VOREStation Edit
	intarea.lightswitch = on
	intarea.updateicon()
	if(!on)
		light_range = 0
	if(!headlights_enabled)
		light_range = 3
	else
		light_range = 6
	intarea.power_change()
	GLOB.lights_switched_on_roundstat++


////////////////////////////////////////////////////////////////////////////////
// interior area objects
/obj/effect/landmark/vehicle_interior/entrypos 	// where mobs are placed on entering the tank
	name = "interior entrypos"


/obj/machinery/door/vehicle_interior_hatch			// click door to exit vehicle
	name = "vehicle exit"
	desc = "Hatch that leaves the vehicle."
	icon = 'icons/obj/doors/Doorele.dmi'
	icon_state = "door_closed"
	light_range = 1 // so visible in dark interiors
	var/obj/vehicle/has_interior/controller/interior_controller = null
	var/denied_sound = 'sound/machines/deniedbeep.ogg'
	var/bolt_up_sound = 'sound/machines/door/boltsup.ogg'
	var/bolt_down_sound = 'sound/machines/door/boltsdown.ogg'
	var/locked = FALSE

/obj/machinery/door/vehicle_interior_hatch/inoperable(var/additional_flags = 0)
    // always works
    return FALSE

/obj/machinery/door/vehicle_interior_hatch/Bumped(atom/AM)
    // do nothing

/obj/machinery/door/vehicle_interior_hatch/bullet_act(var/obj/item/projectile/Proj)
    // no damage

/obj/machinery/door/vehicle_interior_hatch/hitby(AM as mob|obj, var/speed=5)
    // no damage
    visible_message("<span class='danger'>[src.name] was hit by [AM], with no visible effect.</span>")

/obj/machinery/door/vehicle_interior_hatch/MouseDrop_T(var/atom/movable/C, mob/user as mob)
	attackby( null, user)

/obj/machinery/door/vehicle_interior_hatch/attackby(obj/item/I as obj, mob/user as mob)
	if(locked)
		do_animate("deny")
		return

	// successful, begin exit!
	user.visible_message("<span class='notice'>[user] starts leaving the [interior_controller].</span>", "<span class='notice'>You start leaving the [interior_controller].</span>")
	if(do_after(user, 20))
		interior_controller.exit_interior(user)

/obj/machinery/door/vehicle_interior_hatch/attack_ai(mob/user)
	// no behavior

/obj/machinery/door/vehicle_interior_hatch/emag_act(var/remaining_charges)
    // no behavior

/obj/machinery/door/vehicle_interior_hatch/emp_act(severity)
    // immune to

/obj/machinery/door/vehicle_interior_hatch/ex_act(severity)
    // immune to

/obj/machinery/door/vehicle_interior_hatch/blob_act()
    // even you bob

/obj/machinery/door/vehicle_interior_hatch/requiresID()
    return FALSE

/obj/machinery/door/vehicle_interior_hatch/examine(mob/user)
    src.health = src.maxhealth // force heal, never show status
    . = ..()

/obj/machinery/door/vehicle_interior_hatch/process()
	return PROCESS_KILL

/obj/machinery/door/vehicle_interior_hatch/update_icon()
	if(density)
		if(locked)
			icon_state = "door_locked"
		else
			icon_state = "door_closed"
	else
		icon_state = "door_open"
	return

/obj/machinery/door/vehicle_interior_hatch/do_animate(animation)
	switch(animation)
		if("deny")
			if(density)
				flick("door_deny", src)
				playsound(src, denied_sound, 50, 0, 3)
	return

/obj/machinery/door/vehicle_interior_hatch/proc/lock()
	if(locked)
		return 0

	src.locked = 1
	playsound(src, bolt_down_sound, 30, 0, 3, volume_channel = VOLUME_CHANNEL_DOORS)
	for(var/mob/M in range(1,src))
		M.show_message("You hear a click from the bottom of the door.", 2)
	update_icon()
	return 1

/obj/machinery/door/vehicle_interior_hatch/proc/unlock()
	if(!src.locked)
		return

	src.locked = 0
	playsound(src, bolt_up_sound, 30, 0, 3, volume_channel = VOLUME_CHANNEL_DOORS)
	for(var/mob/M in range(1,src))
		M.show_message("You hear a click from the bottom of the door.", 2)
	update_icon()
	return 1

/obj/machinery/door/vehicle_interior_hatch/ex_act(severity)
	// nothing

////////////////////////////////////////////////////////////////////////////////
// Helm console

/obj/machinery/computer/vehicle_interior_console
	name = "Vehicle Helm"
	desc = "Use ctrl-click to quickly toggle the engine if you're adjacent (only when vehicle is stationary). Alt-click will grab the keys, if present."

	icon_keyboard = "security_key"
	icon_screen = "cameras"
	light_color = "#a91515"
	circuit = /obj/item/weapon/circuitboard/security

	var/list/viewers // Weakrefs to mobs in direct-view mode.
	var/extra_view = 0 // how much the view is increased by when the mob is in tank view
	var/obj/vehicle/has_interior/controller/interior_controller = null


/obj/machinery/computer/vehicle_interior_console/Initialize()
	. = ..()

/obj/machinery/computer/vehicle_interior_console/Destroy()
	interior_controller.driver_console.clean_all_viewers()
	return ..()

/obj/machinery/computer/vehicle_interior_console/tgui_interact(mob/user, datum/tgui/ui = null)
	// nothing

/obj/machinery/computer/vehicle_interior_console/attack_robot(mob/user)
	if(isrobot(user))
		var/mob/living/silicon/robot/R = user
		if(!R.shell)
			return attack_hand(user)
	..()

/obj/machinery/computer/vehicle_interior_console/attack_ai(mob/user)
	if(isAI(user))
		to_chat(user, "<span class='notice'>This system in inaccessible to AI units.</span>")
		return
	attack_hand(user)

/obj/machinery/computer/vehicle_interior_console/attack_hand(mob/user)
	add_fingerprint(user)
	if(stat & (BROKEN|NOPOWER))
		return
	if(!interior_controller || !interior_controller.driver_seat || !interior_controller.driver_seat.has_buckled_mobs() || interior_controller.driver_seat.buckled_mobs[1] != user)
		to_chat(user, "<span class='notice'>You need to sit in the seat to pilot the [interior_controller.name].</span>")
		return
	if(user.blinded)
		to_chat(user, "<span class='notice'>You cannot see!</span>")
		return
	// remove all others...
	interior_controller.driver_console.clean_all_viewers()
	playsound(src, "keyboard", 40) // into console
	look(user)

/obj/machinery/computer/vehicle_interior_console/check_eye(var/mob/user)
	if(!get_dist(user, src) > 1)
		unlook(user)
		return -1
	else
		return 0

/obj/machinery/computer/vehicle_interior_console/proc/look(var/mob/user)
	if(interior_controller)
		apply_visual(user)
		user.reset_view(interior_controller)
	user.set_machine(src)
	if(isliving(user))
		var/mob/living/L = user
		L.looking_elsewhere = 1
		L.handle_vision()
	user.set_viewsize(world.view + extra_view)
	GLOB.moved_event.register(user, src, /obj/machinery/computer/vehicle_interior_console/proc/unlook)
	// TODO GLOB.stat_set_event.register(user, src, /obj/machinery/computer/vehicle_interior_console/proc/unlook)
	LAZYDISTINCTADD(viewers, weakref(user))

/obj/machinery/computer/vehicle_interior_console/proc/unlook(var/mob/user)
	user.reset_view()
	if(isliving(user))
		var/mob/living/L = user
		L.looking_elsewhere = 0
		L.handle_vision()
	user.set_viewsize() // reset to default
	GLOB.moved_event.unregister(user, src, /obj/machinery/computer/vehicle_interior_console/proc/unlook)
	// TODO GLOB.stat_set_event.unregister(user, src, /obj/machinery/computer/vehicle_interior_console/proc/unlook)
	LAZYREMOVE(viewers, weakref(user))


/obj/machinery/computer/vehicle_interior_console/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, interior_controller.key_type))
		if(!interior_controller.key)
			user.drop_item()
			W.forceMove(src)
			interior_controller.key = W
			interior_controller.driver_seat.verbs += /obj/structure/bed/chair/vehicle_interior_pilot/verb/remove_key
		return
	..()

/obj/machinery/computer/vehicle_interior_console/CtrlClick(var/mob/user)
	if(Adjacent(user))
		if(interior_controller.on)
			interior_controller.driver_seat.stop_engine()
		else
			interior_controller.driver_seat.start_engine()
	else
		return ..()

/obj/machinery/computer/vehicle_interior_console/AltClick(var/mob/user)
	if(Adjacent(user))
		interior_controller.driver_seat.remove_key()
	else
		return ..()

/obj/machinery/computer/vehicle_interior_console/examine(mob/user)
	. = ..()
	if(ishuman(user) && Adjacent(user))
		. += "The power light is [interior_controller.on ? "on" : "off"].\nThere are[interior_controller.key ? "" : " no"] keys in the ignition."
		. += "The charge meter reads [interior_controller.cell? round(interior_controller.cell.percent(), 0.01) : 0]%"

/obj/machinery/computer/vehicle_interior_console/proc/clean_all_viewers()
	if(LAZYLEN(viewers))
		for(var/weakref/W in viewers)
			var/M = W.resolve()
			if(M)
				unlook(M)

/obj/machinery/computer/vehicle_interior_console/ex_act(severity)
	// nothing

////////////////////////////////////////////////////////////////////////////////
// Pilot seat

/obj/structure/bed/chair/vehicle_interior_pilot
	name = "shuttle seat"
	desc = "A comfortable, secure seat. It has a sturdy-looking buckling system for smoother flights."
	base_icon = "shuttle_chair"
	icon_state = "shuttle_chair_preview"
	buckle_movable = TRUE // we do some silly stuff though
	var/buckling_sound = 'sound/effects/metal_close.ogg'
	var/padding = "blue"
	var/obj/vehicle/has_interior/controller/interior_controller = null

/obj/structure/bed/chair/vehicle_interior_pilot/New(var/newloc, var/new_material, var/new_padding_material)
	..(newloc, MAT_STEEL, padding)

/obj/structure/bed/chair/vehicle_interior_pilot/post_buckle_mob()
	playsound(src,buckling_sound,75,1)
	if(has_buckled_mobs())
		base_icon = "shuttle_chair-b"
	else
		base_icon = "shuttle_chair"
	..()

/obj/structure/bed/chair/vehicle_interior_pilot/update_icon()
	..()
	if(!has_buckled_mobs())
		var/image/I = image(icon, "[base_icon]_special")
		I.plane = MOB_PLANE
		I.layer = ABOVE_MOB_LAYER
		if(applies_material_colour)
			I.color = material.icon_colour
		add_overlay(I)

/obj/structure/bed/chair/vehicle_interior_pilot/unbuckle_mob(mob/living/buckled_mob, force = FALSE)
	if(LAZYLEN(interior_controller.driver_console.viewers))
		playsound(src, "keyboard", 40) // out of console
		interior_controller.driver_console.clean_all_viewers()
	else
		. = ..()

/obj/structure/bed/chair/vehicle_interior_pilot/Destroy()
	if(LAZYLEN(interior_controller.driver_console.viewers))
		interior_controller.driver_console.clean_all_viewers()
	return ..()

/obj/structure/bed/chair/vehicle_interior_pilot/ex_act(severity)
	// knock out of camera view
	if(LAZYLEN(interior_controller.driver_console.viewers))
		interior_controller.driver_console.clean_all_viewers()

//-------------------------------------------
// Verb control
//-------------------------------------------
/obj/structure/bed/chair/vehicle_interior_pilot/verb/start_engine()
	set name = "Start engine"
	set category = "Vehicle"
	set src in view(0)

	if(!istype(usr, /mob/living/carbon/human))
		return

	if(interior_controller.on)
		to_chat(usr, "The engine is already running.")
		return

	interior_controller.turn_on()
	if (interior_controller.on)
		to_chat(usr, "You start [interior_controller]'s engine.")
	else
		if(!interior_controller.cell)
			to_chat(usr, "[interior_controller] doesn't appear to have a power cell!")
		else if(interior_controller.cell.charge < interior_controller.charge_use)
			to_chat(usr, "[interior_controller] is out of power.")
		else
			to_chat(usr, "[interior_controller]'s engine won't start.")

/obj/structure/bed/chair/vehicle_interior_pilot/verb/stop_engine()
	set name = "Stop engine"
	set category = "Vehicle"
	set src in view(0)

	if(!istype(usr, /mob/living/carbon/human))
		return

	if(!interior_controller.on)
		to_chat(usr, "The engine is already stopped.")
		return

	interior_controller.turn_off()
	if (!interior_controller.on)
		to_chat(usr, "You stop [src]'s engine.")

/obj/structure/bed/chair/vehicle_interior_pilot/verb/remove_key()
	set name = "Remove key"
	set category = "Vehicle"
	set src in view(0)

	if(!istype(usr, /mob/living/carbon/human))
		return

	if(!interior_controller.key)
		return

	if(interior_controller.on)
		interior_controller.turn_off()

	interior_controller.key.loc = usr.loc
	if(!usr.get_active_hand())
		usr.put_in_hands(interior_controller.key)
	interior_controller.key = null

	verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/remove_key

/obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_on()
	set name = "Headlights on"
	set category = "Vehicle"
	set src in view(0)

	interior_controller.headlights_enabled = TRUE
	playsound(src, "switch", 40)

	verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_off

/obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_off()
	set name = "Headlights off"
	set category = "Vehicle"
	set src in view(0)

	interior_controller.headlights_enabled = FALSE
	playsound(src, "switch", 40)

	verbs -= /obj/structure/bed/chair/vehicle_interior_pilot/verb/headlights_on
