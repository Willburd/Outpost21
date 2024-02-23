/datum/category_item/catalogue/technology/janicart
	name = "Cargo Train Tug"
	desc = "A standard issue cargo tug, meant for hauling obscene amounts of crates when the mail system won't suffice. Note: only licensed cargo crew are authorized to drive this vehicle."
	value = CATALOGUER_REWARD_TRIVIAL

/obj/vehicle/train/janicart
	name = "janicart"
	icon = 'icons/obj/vehicles_op.dmi'
	icon_state = "pussywagon"
	on = 0
	powered = 1
	locked = 0

	load_item_visible = 1
	load_offset_x = 0
	mob_offset_y = 7
	flags = OPENCONTAINER

	var/scrubbing = FALSE //Floor cleaning enabled
	var/amount_per_transfer_from_this = 5 //shit I dunno, adding this so syringes stop runtime erroring. --NeoFite
	var/obj/item/weapon/storage/bag/trash/mybag	= null
	var/callme = "pimpin' ride"	//how do people refer to it?

	var/obj/item/weapon/key/key
	var/key_type = /obj/item/weapon/key/janicart

	catalogue_data = list(/datum/category_item/catalogue/technology/janicart)

/obj/item/weapon/key/janicart
	name = "key"
	desc = "A keyring with a small steel key, and a pink fob reading \"Pussy Wagon\"."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "keys"
	w_class = ITEMSIZE_TINY

//-------------------------------------------
// Standard procs
//-------------------------------------------
/obj/vehicle/train/janicart/New()
	..()
	// apply speed
	move_delay = config.run_speed
	move_delay *= 1.1
	cell = new /obj/item/weapon/cell/high(src)
	key = new key_type(src)
	turn_off()	//so engine verbs are correctly set
	create_reagents(600)

	verbs -= /obj/vehicle/train/verb/unlatch_v // not needed

	var/image/I = new(icon = 'icons/obj/vehicles_op.dmi', icon_state = "pussywagon_overlay", layer = src.layer + 0.2) //over mobs
	add_overlay(I)

/obj/vehicle/train/janicart/vehicle_move(var/turf/destination)
	if(on && cell.charge < charge_use)
		turn_off()
		update_stats()
		if(load && is_train_head())
			to_chat(load, "The drive motor briefly whines, then drones to a stop.")

	if(is_train_head() && !on)
		return 0

	//space check ~no flying space trains sorry
	if(on && istype(destination, /turf/space))
		return 0

	return ..()

/obj/vehicle/train/janicart/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/mop))
		if(reagents.total_volume > 1)
			reagents.trans_to_obj(W, 2)
			to_chat(user, "<span class='notice'>You wet [W] in the [callme].</span>")
			playsound(src, 'sound/effects/slosh.ogg', 25, 1)
		else
			to_chat(user, "<span class='notice'>This [callme] is out of water!</span>")
	else if(istype(W, /obj/item/weapon/storage/bag/trash))
		to_chat(user, "<span class='notice'>You hook the trashbag onto the [callme].</span>")
		user.drop_item()
		W.loc = src
		mybag = W
	else if(istype(W, key_type))
		if(!key)
			user.drop_item()
			W.forceMove(src)
			key = W
			verbs += /obj/vehicle/train/engine/verb/remove_key
		return
	..()

/obj/vehicle/train/janicart/attack_hand(mob/user)
	if(mybag)
		mybag.loc = get_turf(user)
		user.put_in_hands(mybag)
		mybag = null
	else
		..()

/obj/vehicle/train/janicart/insert_cell(var/obj/item/weapon/cell/C, var/mob/living/carbon/human/H)
	..()
	update_stats()

/obj/vehicle/train/janicart/remove_cell(var/mob/living/carbon/human/H)
	..()
	update_stats()

/obj/vehicle/train/janicart/Bump(atom/Obstacle)
	var/obj/machinery/door/D = Obstacle
	var/mob/living/carbon/human/H = load
	if(istype(D) && istype(H))
		D.Bumped(H)		//a little hacky, but hey, it works, and respects access rights

	..()

//-------------------------------------------
// Train procs
//-------------------------------------------
/obj/vehicle/train/janicart/turn_on()
	if(!key)
		return
	if(!cell)
		return
	else
		..()
		update_stats()

		verbs -= /obj/vehicle/train/engine/verb/stop_engine
		verbs -= /obj/vehicle/train/engine/verb/start_engine

		if(on)
			verbs += /obj/vehicle/train/engine/verb/stop_engine
		else
			verbs += /obj/vehicle/train/engine/verb/start_engine

/obj/vehicle/train/janicart/turn_off()
	..()

	verbs -= /obj/vehicle/train/engine/verb/stop_engine
	verbs -= /obj/vehicle/train/engine/verb/start_engine

	if(!on)
		verbs += /obj/vehicle/train/engine/verb/start_engine
	else
		verbs += /obj/vehicle/train/engine/verb/stop_engine

/obj/vehicle/train/janicart/RunOver(var/mob/living/M)
	..()

	if(is_train_head() && ishuman(load))
		var/mob/living/carbon/human/D = load
		to_chat(D, "<font color='red'><B>You ran over [M]!</B></font>")
		visible_message("<B><font color='red'>\The [callme] ran over [M]!</B></font>")
		add_attack_logs(D,M,"Ran over with [src.name]")
		attack_log += text("\[[time_stamp()]\] <font color='red'>ran over [M.name] ([M.ckey]), driven by [D.name] ([D.ckey])</font>")
	else
		attack_log += text("\[[time_stamp()]\] <font color='red'>ran over [M.name] ([M.ckey])</font>")

//-------------------------------------------
// Interaction procs
//-------------------------------------------
/obj/vehicle/train/janicart/relaymove(mob/user, direction)
	if(user != load)
		return 0
	if(user.stat != CONSCIOUS)
		return

	if(is_train_head())
		if(direction == reverse_direction(dir) && tow)
			return 0
		if(vehicle_move(get_step(src, direction),direction))
			return 1
		return 0
	else
		return ..()

/obj/vehicle/train/janicart/examine(mob/user)
	. = ..()
	if(Adjacent(user))
		. += "The power light is [on ? "on" : "off"].\nThere are[key ? "" : " no"] keys in the ignition."
		. += "The charge meter reads [cell? round(cell.percent(), 0.01) : 0]%"
		. += "This [callme] contains [reagents.total_volume] unit\s of water!"
		if(mybag)
			. += "\A [mybag] is hanging on the [callme]."

/obj/vehicle/train/janicart/CtrlClick(var/mob/user)
	if(Adjacent(user))
		if(on)
			stop_engine()
		else
			start_engine()
	else
		return ..()

/obj/vehicle/train/janicart/AltClick(var/mob/user)
	if(Adjacent(user))
		remove_key()
	else
		return ..()

/obj/vehicle/train/janicart/verb/start_engine()
	set name = "Start engine"
	set category = VERBTAB_EQUIP
	set src in view(0)

	if(!ishuman(usr))
		return

	if(on)
		to_chat(usr, "The engine is already running.")
		return

	turn_on()
	if (on)
		to_chat(usr, "You start \the [callme]'s engine.")
	else
		if(!cell)
			to_chat(usr, "\The [callme] doesn't appear to have a power cell!")
		else if(cell.charge < charge_use)
			to_chat(usr, "\The [callme] is out of power.")
		else
			to_chat(usr, "\The [callme]'s engine won't start.")

/obj/vehicle/train/janicart/verb/stop_engine()
	set name = "Stop engine"
	set category = VERBTAB_EQUIP
	set src in view(0)

	if(!ishuman(usr))
		return

	if(!on)
		to_chat(usr, "The engine is already stopped.")
		return

	turn_off()
	if (!on)
		to_chat(usr, "You stop \the [callme]'s engine.")

/obj/vehicle/train/janicart/verb/remove_key()
	set name = "Remove key"
	set category = VERBTAB_EQUIP
	set src in view(0)

	if(!ishuman(usr))
		return

	if(!key || (load && load != usr))
		return

	if(on)
		turn_off()

	key.loc = usr.loc
	if(!usr.get_active_hand())
		usr.put_in_hands(key)
	key = null

	verbs -= /obj/vehicle/train/engine/verb/remove_key

/obj/vehicle/train/janicart/verb/toggle_brush()
	set name = "Toggle brushes"
	set category = VERBTAB_EQUIP
	set src in view(0)

	if(!ishuman(usr))
		return

	scrubbing = !scrubbing
	if (scrubbing)
		to_chat(usr, "You turn \the [callme]'s brushes on.")
	else
		to_chat(usr, "You turn \the [callme]'s brushes off.")

/obj/vehicle/train/janicart/latch(obj/vehicle/train/T, mob/user)
	// nothing latchs to this!
	return 0

// VOREStation Edit Start - Overlay stuff for the chair-like effect
/obj/vehicle/train/janicart/update_icon()
	..()
	cut_overlays()
	if(!open)
		var/image/O = image(icon = 'icons/obj/vehicles_op.dmi', icon_state = "pussywagon_overlay", dir = src.dir)
		O.layer = FLY_LAYER
		O.plane = MOB_PLANE
		add_overlay(O)

/obj/vehicle/train/janicart/set_dir()
	..()
	update_icon()
// VOREStation Edit End - Overlay stuff for the chair-like effect

/obj/vehicle/train/janicart/Moved(atom/old_loc, direction, forced = FALSE)
	. = ..()
	if(scrubbing)
		if(reagents.has_reagent("water", 1) || reagents.has_reagent("cleaner", 1))
			var/turf/tile = loc
			tile.clean_blood()
			if(istype(tile, /turf/simulated))
				var/turf/simulated/T = tile
				T.dirt = 0
			for(var/A in tile)
				if(istype(A,/obj/effect/rune) || istype(A,/obj/effect/decal/cleanable) || istype(A,/obj/effect/overlay))
					qdel(A)
				else if(ishuman(A))
					var/mob/living/carbon/human/cleaned_human = A
					if(cleaned_human.lying)
						if(cleaned_human.head)
							cleaned_human.head.clean_blood()
							cleaned_human.update_inv_head(0)
						if(cleaned_human.wear_suit)
							cleaned_human.wear_suit.clean_blood()
							cleaned_human.update_inv_wear_suit(0)
						else if(cleaned_human.w_uniform)
							cleaned_human.w_uniform.clean_blood()
							cleaned_human.update_inv_w_uniform(0)
						if(cleaned_human.shoes)
							cleaned_human.shoes.clean_blood()
							cleaned_human.update_inv_shoes(0)
						cleaned_human.clean_blood(1)
						to_chat(cleaned_human, "<span class='warning'>\The [callme] cleans your face!</span>")
			reagents.trans_to_turf(tile, 1, 10)	//10 is the multiplier for the reaction effect. probably needed to wet the floor properly.
		else
			scrubbing = FALSE
			if(ishuman(load))
				var/mob/living/carbon/human/D = load
				to_chat(D, "\The [callme]'s brushes turn off, as it runs out of cleaner.")
