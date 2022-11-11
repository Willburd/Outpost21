/obj/vehicle/has_interior/controller/heavyarmor_carrier
	name = "armored personal carrier"
	move_delay = 2

	key_type = /obj/item/weapon/key/heavyarmor_carrier

	health = 800
	maxhealth = 800
	fire_dam_coeff = 0.5
	brute_dam_coeff = 0.4
	breakwalls = FALSE

	weapons_equiped = list(/obj/item/vehicle_interior_weapon/scattershot)
	weapons_draw_offset = list(list("1" = list(20,20),"2" = list(-20,10),"4" = list(12,20),"8" = list(-12,34)) )


/obj/item/weapon/key/heavyarmor_carrier
	name = "key"
	desc = "A keyring with a small steel key, and a yellow fob reading \"Choo Choo!\"."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "train_keys"
	w_class = ITEMSIZE_TINY

/obj/item/vehicle_interior_weapon/scattershot
	name = "\improper LBX AC 10 \"Scattershot\""
	desc = "A massive shotgun designed to fill a large area with pellets."

	icon = 'icons/obj/pointdefense.dmi'
	icon_state = "pointdefense2"

	projectile = /obj/item/projectile/bullet/pellet/shotgun/flak
	fire_sound = 'sound/weapons/Gunshot_shotgun.ogg'
	fire_volume = 80
	projectiles = 40
	projectiles_per_shot = 4
	deviation = 0.7
