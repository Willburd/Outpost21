/obj/effect/map_effect/interval/redspaceexitcontroller
	name = "red space exit spawn controller"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	opacity = 0

	// used to spawn portals at /obj/effect/landmark/redspacestart locations
	always_run = TRUE
	interval_lower_bound = 15 SECONDS
	interval_upper_bound = 30 SECONDS

/obj/effect/map_effect/interval/redspaceexitcontroller/trigger()
	var/list/redexitlist = list()
	for(var/obj/effect/landmark/R in landmarks_list)
		if(R.name == "redentrance")
			redexitlist += R

	if(redexitlist.len > 0)
		create_wormhole( pick(redexitlist).loc, pick(redexitlist).loc, 15 SECONDS, 45 SECONDS, FALSE, TRUE)
	else
		create_wormhole( src.loc, src.loc, 20, 30, FALSE, TRUE)
