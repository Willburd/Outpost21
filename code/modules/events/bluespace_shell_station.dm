/datum/event/bluespace_shelling
	announceWhen   = 1
	var/spawncount = 0
	var/department = -1 // this is a really dumb way to do it, but it works nice, uses HOLOMAP_AREACOLOR_
	var/department_name = "surface facility"
	var/time_start = -1
	var/list/finalareas = list()

	// Exclude these types and sub-types from targeting eligibilty
	var/list/area/excluded = list(
		/area/shuttle,
		/area/crew_quarters,
		/area/holodeck,
		/area/engineering/engine_room
	)

/datum/event/bluespace_shelling/setup()
	time_start = world.time + 30 SECONDS
	spawncount = rand(20,35)

/datum/event/bluespace_shelling/announce()
	command_announcement.Announce("Attention [station_name()]. Bluespace shelling confirmed for [department_name]. Fire for Effect. All crew must retreat to a safe distance, seek shelter, and remain in place until the all clear is given. ETA 30 seconds.", "Bluespace Shelling")
	set_security_level(SEC_LEVEL_DELTA)

/datum/event/bluespace_shelling/start()
	var/list/area/grand_list_of_areas = get_station_areas(excluded)
	for(var/area/A in grand_list_of_areas)
		if(department == -1 || A.holomap_color == department)
			finalareas += A

/datum/event/bluespace_shelling/process()
	if(world.time > time_start && spawncount > 0)
		var/area/bombarea = pick(finalareas)
		var/turf/picked = pick(get_current_area_turfs(bombarea))
		if(picked.density == 0)
			explosion(picked,2,5,11)

		time_start = world.time += rand(1,6) SECONDS
		spawncount--



/datum/event/bluespace_shelling/engineering
	department = HOLOMAP_AREACOLOR_ENGINEERING
	department_name = "engineering facility"

/datum/event/bluespace_shelling/science
	department = HOLOMAP_AREACOLOR_SCIENCE
	department_name = "research and development department"

/datum/event/bluespace_shelling/security
	department = HOLOMAP_AREACOLOR_SECURITY
	department_name = "security facility"

/datum/event/bluespace_shelling/cargo
	department = HOLOMAP_AREACOLOR_CARGO
	department_name = "cargo facility"



// specialized
/datum/event/bluespace_shelling/civilian
	department = HOLOMAP_AREACOLOR_CIV
	department_name = "cargo facility"

/datum/event/bluespace_shelling/civilian/start()
	var/list/area/grand_list_of_areas = get_station_areas(excluded)
	for(var/area/A in grand_list_of_areas)
		if(department == HOLOMAP_AREACOLOR_COMMAND || department == HOLOMAP_AREACOLOR_HYDROPONICS || department == HOLOMAP_AREACOLOR_DORMS)
			finalareas += A
