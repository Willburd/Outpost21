/decl/flooring/outpost_roof/hull
	name = "hull"
	descriptor = "sloped roof plating"
	icon = 'icons/turf/flooring/eris/hull.dmi'
	icon_base = "hullcenter"
	flags = TURF_HAS_EDGES | TURF_HAS_CORNERS | TURF_REMOVE_WRENCH | TURF_CAN_BURN | TURF_CAN_BREAK
	has_base_range = 35
	is_plating = FALSE
	build_type = /obj/item/stack/material/plasteel

/turf/simulated/floor/outpost_roof
	name = "roofing"
	icon = 'icons/turf/flooring/eris/hull.dmi'
	icon_state = "hullcenter0"
	initial_flooring = /decl/flooring/outpost_roof/hull
	outdoors = TRUE

/turf/simulated/floor/solarpanel
	name = "solarpanel"
	icon = 'icons/turf/flooring/plating_vr.dmi'
	icon_state = "solarpanel"
	initial_flooring = /decl/flooring/outpost_roof/hull
	outdoors = TRUE