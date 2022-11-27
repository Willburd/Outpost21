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

	weapons_equiped = list(/obj/item/vehicle_interior_weapon/mainturret)
	// list of weapons, with a sublist containing directions, with a subsub list of x and ys
	weapons_draw_offset = list(list("1" = list(-64,-64),"2" = list(-64,-64),"4" = list(-64,-64),"8" = list(-64,-64)) )


/obj/item/weapon/key/heavyarmor_tank
	name = "key"
	desc = "A keyring with a small steel key, and a yellow fob reading \"Choo Choo!\"."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "train_keys"
	w_class = ITEMSIZE_TINY

/obj/item/vehicle_interior_weapon/lmg
	name = "\improper Ultra AC 2"
	desc = "A superior version of the standard Solgov Autocannon MK2 design."

	icon = 'icons/obj/pointdefense.dmi'
	icon_state = "pointdefense2"

	projectile = /obj/item/projectile/bullet/pistol/medium
	fire_sound = 'sound/weapons/Gunshot_machinegun.ogg'
	projectiles = 30 //10 bursts, matching the Scattershot's 10. Also, conveniently, doesn't eat your powercell when reloading like 300 bullets does.
	projectiles_per_shot = 3
	deviation = 0.3
	fire_cooldown = 2


/obj/item/vehicle_interior_weapon/mainturret
	name = "\improper TD Type-L Accelerator"
	desc = "Tandem Logistics Linear-Type Heavy-Ordinance Magnetic Accelerator."

	icon = 'icons/obj/vehicles_160x160.dmi'
	icon_state = "tank_turret"

	// graphics offset of lorge boi
	old_x = -64
	old_y = -64
	pixel_x = -64
	pixel_y = -64

	projectile = /obj/item/projectile/bullet/kyshell
	fire_sound = 'sound/weapons/railgun.ogg'
	projectiles = 1
	projectiles_per_shot = 1
	deviation = 0.1
	fire_cooldown = 6


// basically just meaner /obj/item/projectile/bullet/srmrocket
/obj/item/projectile/bullet/kyshell
	name ="TD Type-L \"Reclaimer\" Shell"
	desc = "Boom"
	icon = 'icons/obj/grenade_op.dmi'
	icon_state = "shell"
	damage = 35 // Bonk
	sharp = FALSE
	does_spin = FALSE
	hud_state = "rocket_he"
	hud_state_empty = "rocket_empty"

/obj/item/projectile/bullet/kyshell/on_hit(atom/target, blocked=0)
	if(!isliving(target)) //if the target isn't alive, so is a wall or something
		explosion(target, 1, 2, 2, 4)
	else
		explosion(target, 0, 0, 2, 4)
	return 1

/obj/item/projectile/bullet/kyshell/throw_impact(atom/target, var/speed)
	if(!isliving(target)) //if the target isn't alive, so is a wall or something
		explosion(target, 1, 2, 2, 4)
	else
		explosion(target, 0, 0, 2, 4)
	qdel(src)

/obj/item/ammo_casing/kyshell
	name = "TD Type-L \"Reclaimer\" Shell"
	desc = "High explosive shell."
	icon_state = "rocketshell"
	projectile_type = /obj/item/projectile/bullet/kyshell
	caliber = "rocket"
	matter = list(MAT_STEEL = 10000)
