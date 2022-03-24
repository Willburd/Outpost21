// put all map-specific areas here for ease of use and not cluttering a thousand other maps - Ignus
/area/outpost
	icon = 'icons/turf/areas_vr.dmi'


//Shuttles
/area/outpost/station/mining_dock
	name = "\improper Mining Shuttle Landing Pad"
	icon_state = "orablasqu"

/area/shuttle/mining
	name = "\improper Mining Trawler"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/space

/area/medical/hangar
	name = "\improper Medevac Shuttle Hangar"
	icon_state = "medical"

/area/shuttle/medical
	name = "\improper Medevac Shuttle"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/space

// Bad guys
/area/shuttle/mercenary
	name = "\improper Mercenary Vessel"
	flags = AREA_FLAG_IS_NOT_PERSISTENT

/area/shuttle/skipjack
	name = "\improper Vox Vessel"
	flags = AREA_FLAG_IS_NOT_PERSISTENT