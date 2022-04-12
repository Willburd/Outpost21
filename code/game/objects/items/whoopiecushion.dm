/obj/item/latexballon/whoopee
	name = "whoopee cushion"
	icon = 'icons/obj/items_op.dmi'
	desc = "A joke as old as time."
	icon_state = "whoopee"
	item_icons = list(
			slot_l_hand_str = 'icons/mob/items/lefthand_gloves_op.dmi',
			slot_r_hand_str = 'icons/mob/items/righthand_gloves_op.dmi',
			)
	item_state = "whoopee"
	layer = HIDING_LAYER

/obj/item/latexballon/whoopee/blow(obj/item/weapon/tank/tank)
	if (icon_state == "whoopee_bursted")
		return
	src.air_contents = tank.remove_air_volume(3)
	icon_state = "whoopee_blow"
	item_state = "whoopee"

/obj/item/latexballon/whoopee/burst()
	if (!air_contents)
		return
	playsound(src, 'sound/effects/poot.ogg', 100, 1)
	icon_state = "whoopee_bursted"
	item_state = "whoopee"
	loc.assume_air(air_contents)
	air_contents = null

/obj/item/latexballon/whoopee/Crossed(atom/movable/AM as mob|obj)
	// poot
	if (!air_contents)
		return
	if(istype(loc,/turf/))
		playsound(src, 'sound/effects/poot.ogg', 100, 1)
		icon_state = "whoopee"
		item_state = "whoopee"
		loc.assume_air(air_contents)
		air_contents = null