/obj/vehicle/has_interior/controller
	name = "cargo train tug"
	dir = 4

	move_delay = 1

	health = 100
	maxhealth = 100
	fire_dam_coeff = 0.7
	brute_dam_coeff = 0.5

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
	var/active_engines = 0

//-------------------------------------------
// Standard procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/Initialize()
	. = ..()

/obj/vehicle/has_interior/controller/Move()
	. = ..()

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
	..()

/obj/vehicle/has_interior/controller/update_icon()
	. = ..()

//-------------------------------------------
// Vehicle procs
//-------------------------------------------
/obj/vehicle/has_interior/controller/explode()
	..()


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
	if(!load(C, user))
		to_chat(user, "<font color='red'>You were unable to load [C] on [src].</font>")


/obj/vehicle/has_interior/controller/attack_hand(mob/user as mob)
	if(user.stat || user.restrained() || !Adjacent(user))
		return 0

	if(user != load && (user in src))
		user.forceMove(loc)			//for handling players stuck in src
	else if(load)
		unload(user)			//unload if loaded
	else if(!load && !user.buckled)
		load(user, user)				//else try climbing on board
	else
		return 0

/obj/vehicle/has_interior/controller/load(var/atom/movable/C, var/mob/user)
	if(!istype(C, /mob/living/carbon/human))
		return 0

	return ..()