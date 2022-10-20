////////////////////////////////////////
//////// Excursion Shuttle /////////////
////////////////////////////////////////
// The 'shuttle' of the excursion shuttle
/datum/shuttle/autodock/overmap/dig
	name = "Mining Trawler"
	warmup_time = 0
	current_location = "outpost_landing_pad"
	docking_controller_tag = "digshuttle_docker"
	shuttle_area = list(/area/shuttle/mining)
	fuel_consumption = 3

/datum/shuttle/autodock/overmap/medical
	name = "Medical Rescue"
	warmup_time = 0
	current_location = "outpost_medical_hangar"
	docking_controller_tag = "secshuttle_docker"
	shuttle_area = list(/area/shuttle/medical)
	fuel_consumption = 1 //much less, due to being teeny

// The 'ship' of the excursion shuttle
/obj/effect/overmap/visitable/ship/landable/mining
	name = "Mining Trawler"
	desc = "A hefty beast for making the station rich. Supposedly in compliance."
	vessel_mass = 10000
	vessel_size = SHIP_SIZE_SMALL
	shuttle = "Mining Shuttle"

/obj/effect/overmap/visitable/ship/landable/medical
	name = "Medical Rescue"
	desc = "A modified search and rescue spacecraft. No man left behind."
	vessel_mass = 2500
	vessel_size = SHIP_SIZE_SMALL
	shuttle = "Medical Rescue"

/obj/machinery/computer/shuttle_control/explore/mining
	name = "short jump console"
	shuttle_tag = "Mining Trawler"
	req_one_access = list(access_pilot)

/obj/machinery/computer/shuttle_control/explore/medical
	name = "short jump console"
	shuttle_tag = "Medical Rescue"
	req_one_access = list(access_medical)


// station tram
/obj/effect/shuttle_landmark/premade/mining/muriki
	name = "ES Outpost 21 (Landing Pad)"
	landmark_tag = "outpost_landing_pad"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/muriki/station/mining_dock

/obj/effect/shuttle_landmark/premade/medical/muriki
	name = "ES Outpost 21 (Medical Dock)"
	landmark_tag = "outpost_medical_hangar"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/medical/hangar

/obj/effect/shuttle_landmark/premade/beltmining/muriki
	name = "ES Outpost 21 (Belter Pad)"
	landmark_tag = "belter_colony"
	base_turf = /turf/simulated/floor/reinforced
	base_area = /area/quartermaster/miningdock
