/obj/item/clothing/suit/omnitag
	name = "universal laser tag armour"
	desc = "For the bold and the brash."
	icon = 'icons/inventory/suit/item_op.dmi'
	default_worn_icon = 'icons/inventory/suit/mob_op.dmi'
	item_icons = list(slot_l_hand_str = 'icons/mob/items/lefthand_suits_op.dmi', slot_r_hand_str = 'icons/mob/items/righthand_suits_op.dmi')
	icon_state = "omnitag"
	item_state_slots = list(slot_r_hand_str = "tdomni", slot_l_hand_str = "tdomni")
	blood_overlay_type = "armor"
	body_parts_covered = UPPER_TORSO
	allowed = list (/obj/item/weapon/gun/energy/lasertag)
	siemens_coefficient = 3.0

/*
/obj/item/clothing/suit/omnitag/switch
	name = "Switch Armor"
	desc = "Replica armor commonly worn by (TODO - add dumb switch joke armor...)"
	icon_state = "omnitag2"
*/
