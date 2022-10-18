/* First aid storage
 * Contains:
 *		First Aid Kits
 * 		Pill Bottles
 */

/*
 * First Aid Kits
 */

/obj/item/weapon/storage/firstaid/vox
	name = "vox-safe medical kit"
	desc = "Contains medical treatments that are safe for vox crewmembers."
	icon = 'icons/obj/storage_op.dmi'
	item_icons = list(slot_l_hand_str = 'icons/mob/items/lefthand_storage_op.dmi', slot_r_hand_str = 'icons/mob/items/righthand_storage_op.dmi')
	icon_state = "voxkit"
	item_state_slots = list(slot_r_hand_str = "firstaid-vox", slot_l_hand_str = "firstaid-vox")
	starts_with = list(
		/obj/item/weapon/reagent_containers/syringe/voxkit,
		/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/clotting,
		/obj/item/weapon/reagent_containers/hypospray/autoinjector/biginjector/clotting,
		/obj/item/weapon/storage/pill_bottle/tramadol,
		/obj/item/weapon/storage/pill_bottle/dylovene,
		/obj/item/weapon/storage/pill_bottle/iron,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/stack/medical/advanced/bruise_pack,
		/obj/item/device/healthanalyzer
	)
