// Note for newly added fluff items: Ckeys should not contain any spaces, underscores or capitalizations,
// or else the item will not be usable.
// Example: Someone whose username is "Master Pred_Man" should be written as "masterpredman" instead
// Note: Do not use characters such as # in the display_name. It will cause the item to be unable to be selected.

/datum/gear/fluff
	path = /obj/item
	sort_category = "Fluff Items"
	display_name = "If this item can be chosen or seen, ping a coder immediately!"
	ckeywhitelist = list("This entry should never be choosable with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard
	character_name = list("This entry should never be choosable with this variable set.")
	cost = 0

/*
/datum/gear/fluff/testhorn
	path = /obj/item/weapon/bikehorn
	display_name = "Airhorn - Example Item" //Don't use the same as another item
	description = "An example item that you probably shouldn't see!"
	ckeywhitelist = list("broman2000")
	allowed_roles = list("Engineer")   //Don't include this if the item is not role restricted
	character_name = list("shitfacemcgee")  //Character name. this variable is required, or the item doesn't show in loadout. Change to "character_name = null" if not character restricted.
*/

/datum/gear/fluff/collar //Use this as a base path for collars if you'd like to set tags in loadout. Make sure you don't use apostrophes in the display name or this breaks!
	slot = slot_tie

/datum/gear/fluff/collar/New()
	..()
	gear_tweaks += gear_tweak_collar_tag

//  0-9 CKEYS

//  A CKEYS

//  B CKEYS

//buckwildwolf (cormac)
/datum/gear/fluff/surveypatch_buck
	path = /obj/item/clothing/accessory/solgov/ec_patch
	ckeywhitelist = list("buckwildwolf")
	character_name = null

//  C CKEYS

//  D CKEYS

//darklord92
/datum/gear/fluff/surveypatch_dark
	path = /obj/item/clothing/accessory/solgov/ec_patch
	ckeywhitelist = list("darklord92")
	character_name = null

/datum/gear/fluff/medalval_dark
	path = /obj/item/clothing/accessory/medal/solgov/silver/sol
	ckeywhitelist = list("darklord92")
	character_name = list("Tesum Shari")

//drakefrostpaw
/datum/gear/fluff/surveypatch_drake
	path = /obj/item/clothing/accessory/solgov/ec_patch
	ckeywhitelist = list("drakefrostpaw")
	character_name = null

/datum/gear/fluff/ironstar_drake
	path = /obj/item/clothing/accessory/medal/solgov/iron/star
	ckeywhitelist = list("drakefrostpaw")
	character_name = list("Drake Frostpaw")

//  E CKEYS

//  F CKEYS

//  G CKEYS

//  H CKEYS

//  I CKEYS

//  J CKEYS
//jademanique (etheo)
/datum/gear/fluff/surveypatch_eth
	path = /obj/item/clothing/accessory/solgov/ec_patch
	ckeywhitelist = list("jademanique")
	character_name = null

//  K CKEYS

//  L CKEYS

//  M CKEYS

//  N CKEYS
//Nadyr
/datum/gear/fluff/surveypatch_nad
	path = /obj/item/clothing/accessory/solgov/ec_patch
	ckeywhitelist = list("nadyr")
	character_name = null

/datum/gear/fluff/ironstar_nad
	path = /obj/item/clothing/accessory/medal/solgov/iron/star
	ckeywhitelist = list("nadyr")
	character_name = list("Taaa")

//  O CKEYS
//Ozydev
/datum/gear/fluff/ironstar_ozy
	path = /obj/item/clothing/accessory/medal/solgov/iron/star
	ckeywhitelist = list("Ozydev")
	character_name = list("Ecise Nei")

//  P CKEYS

//  Q CKEYS

//  R CKEYS

//remthebold
/datum/gear/fluff/surveypatch_rem
	path = /obj/item/clothing/accessory/solgov/ec_patch
	ckeywhitelist = list("remthebold")
	character_name = null

/datum/gear/fluff/flightpin_rem
	path = /obj/item/clothing/accessory/solgov/specialty/pilot
	ckeywhitelist = list("remthebold")
	character_name = list("Trashfire")

/datum/gear/fluff/medalval_rem
	path = /obj/item/clothing/accessory/medal/solgov/silver/sol
	ckeywhitelist = list("remthebold")
	character_name = list("Trashfire")

/datum/gear/fluff/ironstar_rempap
	path = /obj/item/clothing/accessory/medal/solgov/iron/star
	ckeywhitelist = list("remthebold")
	character_name = list("Papin Vandalia")

/datum/gear/fluff/rankpin_rem
	path = /obj/item/clothing/accessory/solgov/specialty/officer
	ckeywhitelist = list("remthebold")
	character_name = list("Trashfire")

//  S CKEYS

//Seagha (iggy)
/datum/gear/fluff/surveypatch_seag
	path = /obj/item/clothing/accessory/solgov/ec_patch
	ckeywhitelist = list("seagha")
	character_name = null

/datum/gear/fluff/flightpin_seag
	path = /obj/item/clothing/accessory/solgov/specialty/pilot
	ckeywhitelist = list("seagha")
	character_name = list("Schale Vam")

/datum/gear/fluff/whiteheart_seag
	path = /obj/item/clothing/accessory/medal/solgov/heart
	ckeywhitelist = list("seagha")
	character_name = list("Schale Vam")

/datum/gear/fluff/rankpin_seag
	path = /obj/item/clothing/accessory/solgov/specialty/officer
	ckeywhitelist = list("seagha")
	character_name = list("Schale Vam")

//Synxplushy
/datum/gear/fluff/surveypatch_synx
	path = /obj/item/clothing/accessory/solgov/ec_patch
	ckeywhitelist = list("synxplushy")
	character_name = null

/datum/gear/fluff/ironstar_synx
	path = /obj/item/clothing/accessory/medal/solgov/iron/star
	ckeywhitelist = list("synxplushy")
	character_name = list("Me Eep")

//  T CKEYS

//  U CKEYS

//  V CKEYS

//  W CKEYS
//wdf71 (darmah)
/datum/gear/fluff/surveypatch_darm
	path = /obj/item/clothing/accessory/solgov/ec_patch
	ckeywhitelist = list("wdf71")
	character_name = null

/datum/gear/fluff/ironstar_darm
	path = /obj/item/clothing/accessory/medal/solgov/iron/star
	ckeywhitelist = list("wdf71")
	character_name = list("Mitz")

//  X CKEYS

//  Y CKEYS

//  Z CKEYS
