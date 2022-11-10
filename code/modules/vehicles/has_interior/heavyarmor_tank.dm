/obj/vehicle/has_interior/controller/heavyarmor_tank
	name = "K72-4"
	desc = "Kylos model 72 varient 4, heavy asset reclaimation vehicle. For when lesser force has failed."
	move_delay = 4

	key_type = /obj/item/weapon/key/heavyarmor_tank

	health = 2500
	maxhealth = 2500
	fire_dam_coeff = 0.5
	brute_dam_coeff = 0.4
	breakwalls = TRUE

	weapons_equiped = list(/obj/item/vehicle_interior_weapon/lmg)


/obj/item/weapon/key/heavyarmor_tank
	name = "key"
	desc = "A keyring with a small steel key, and a yellow fob reading \"Choo Choo!\"."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "train_keys"
	w_class = ITEMSIZE_TINY

/obj/item/vehicle_interior_weapon/lmg
	name = "\improper Ultra AC 2"
	desc = "A superior version of the standard Solgov Autocannon MK2 design."
	icon_state = "mecha_uac2"
	projectile = /obj/item/projectile/bullet/pistol/medium
	fire_sound = 'sound/weapons/Gunshot_machinegun.ogg'
	projectiles = 30 //10 bursts, matching the Scattershot's 10. Also, conveniently, doesn't eat your powercell when reloading like 300 bullets does.
	projectiles_per_shot = 3
	deviation = 0.3
	fire_cooldown = 2
