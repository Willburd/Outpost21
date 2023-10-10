/obj/effect/map_effect/interval/redspaceexitcontroller
	name = "red space exit spawn controller"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	opacity = 0

	// used to spawn portals at /obj/effect/landmark/redspacestart locations
	always_run = TRUE
	interval_lower_bound = 35 SECONDS
	interval_upper_bound = 95 SECONDS

/obj/effect/map_effect/interval/atmogland/trigger()
	var/list/redexitlist = list()
	for(var/obj/effect/landmark/R in landmarks_list)
		if(R.name == "redentrance")
			redexitlist += R

	if(redexitlist.len > 0)
		create_wormhole( pick(redexitlist).loc, src.loc, 80, 130, FALSE, TRUE)
	else
		create_wormhole( src.loc, src.loc, 80, 130, FALSE, TRUE)
