#define ASSIGNMENT_ANY "Any"
#define ASSIGNMENT_AI "AI"
#define ASSIGNMENT_CYBORG "Cyborg"
#define ASSIGNMENT_ENGINEER "Engineer"
#define ASSIGNMENT_GARDENER "Botanist"
#define ASSIGNMENT_JANITOR "Janitor"
#define ASSIGNMENT_MEDICAL "Medical"
#define ASSIGNMENT_SCIENTIST "Scientist"
#define ASSIGNMENT_SECURITY "Security"
#define ASSIGNMENT_CARGO "Cargo"

//
// VOREStation overrides to the default event manager configuration. //YW EDIT: WHY THE FUCK IS THIS NOT MENTIONED IN THE REGULAR FILE, AAAGGGHAA!
//
// This file lets us configure which events we want in the rotation without conflicts with upstream.
// It works because the actual event containers don't define New(), allowing us to use New() to replace
// the lists of available events.  If they ever do define New() this will need to be changed.
//
// Specifically the change is to move events we don't want down into the disabled_events list
//
// Outpost edit: Re-enabling most of the Fun events.. we like chaos.

// Adds a list of pre-disabled events to the available events list.
// This keeps them in the rotation, but disabled, so they can be enabled with a click if desired that round.
/datum/event_container/proc/add_disabled_events(var/list/disabled_events)
	for(var/datum/event_meta/EM in disabled_events)
		EM.enabled = 0
		available_events += EM

/datum/event_container/mundane/New()
	available_events = list(
		// Severity level, event name, even type, base weight, role weights, one shot, min weight, max weight. Last two only used if set and non-zero
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Nothing",			/datum/event/nothing,			30),
		// Bluescreens APCs, but they still work
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "APC Damage",		/datum/event/apc_damage,		20, 	list(ASSIGNMENT_ENGINEER = 20)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Brand Intelligence",/datum/event/brand_intelligence,10, 	list(ASSIGNMENT_ENGINEER = 10),	1),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Camera Damage",		/datum/event/camera_damage,		20, 	list(ASSIGNMENT_ENGINEER = 20)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Canister Leak",		/datum/event/canister_leak,		10, 	list(ASSIGNMENT_ENGINEER = 20), min_jobs = list(ASSIGNMENT_ENGINEER = 1)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Space Dust",		/datum/event/dust,	 			0, 		list(ASSIGNMENT_ENGINEER = 20), 0, 0, 50, min_jobs = list(ASSIGNMENT_ENGINEER = 2)),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Economic News",		/datum/event/economic_event,	90),

		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Lost Spiders",		/datum/event/spider_migration, 	10, 	list(ASSIGNMENT_ANY = 1), 1),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Hacker",		/datum/event/money_hacker, 		0, 		list(ASSIGNMENT_ANY = 4), 1, 10, 25),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Money Lotto",		/datum/event/money_lotto, 		0, 		list(ASSIGNMENT_ANY = 1), 1, 5, 15),
		//new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Mundane News", 	/datum/event/mundane_news, 		300),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "PDA Spam",			/datum/event/pda_spam, 			0, 		list(ASSIGNMENT_ANY = 4), 1, 25, 50),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Shipping Error",	/datum/event/shipping_error	, 	30, 	list(ASSIGNMENT_ANY = 2), 0),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Trivial News",		/datum/event/trivial_news, 		50),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Lore News",			/datum/event/lore_news, 		50),
		// Spawns mice, lizards, or dud spiderlings
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Vermin Infestation",/datum/event/infestation, 		50,		list(ASSIGNMENT_JANITOR = 5), 1),
		// Rot only weakens walls, not destroy them
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Wallrot",			/datum/event/wallrot, 			10,		list(ASSIGNMENT_ENGINEER = 10), 1),
		new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Disposal Damage",	/datum/event/disposal_damage,	10, 	list(ASSIGNMENT_ANY = 1))
	)
	add_disabled_events(list(
	))

/datum/event_container/moderate/New()
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Nothing",					/datum/event/nothing,					40),
		// Leaks gas into an unoccupied room.
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Atmos Leak",				/datum/event/atmos_leak, 				30,		list(ASSIGNMENT_ENGINEER = 25), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Lost Spiders",				/datum/event/spider_migration,			10, 	list(ASSIGNMENT_SECURITY = 30), 1), //YW EDIT
		// Just disables comms for a short while.
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Communication Blackout",	/datum/event/communications_blackout,	50,	list(ASSIGNMENT_AI = 100, ASSIGNMENT_SECURITY = 50), 1),
		// Just blows out a few lights
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Electrical Storm",			/datum/event/electrical_storm, 			70,		list(ASSIGNMENT_ENGINEER = 20, ASSIGNMENT_JANITOR = 150), 1),
		// This one is just too fun.
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Gravity Failure",			/datum/event/gravity,	 				2,		list(ASSIGNMENT_ENGINEER = 60), 1),
		// Temporary power failure, but mitigatead by subgrids
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Grid Check",				/datum/event/grid_check, 				20,		list(ASSIGNMENT_ENGINEER = 25), 1),
		// Pure RP fun, no mechanical effects.
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Ion Storm",				/datum/event/ionstorm, 					20,		list(ASSIGNMENT_AI = 80, ASSIGNMENT_CYBORG = 50, ASSIGNMENT_ENGINEER = 15, ASSIGNMENT_SCIENTIST = 5)),
		// Opens doors in brig.  So just RP fun
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Prison Break",				/datum/event/prison_break,				10,		list(ASSIGNMENT_SECURITY = 100), 1, min_jobs = list(ASSIGNMENT_SECURITY = 3)),
		// Radiation, but only in space.
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Rogue Drones",				/datum/event/rogue_drone, 				50,		list(ASSIGNMENT_SECURITY = 20), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Solar Storm",				/datum/event/solar_storm, 				30,		list(ASSIGNMENT_ENGINEER = 40, ASSIGNMENT_SECURITY = 30), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Dust",				/datum/event/dust,	 					20,		list(ASSIGNMENT_ENGINEER = 20), 1, 0, 50, min_jobs = list(ASSIGNMENT_ENGINEER = 1)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Virology Breach",			/datum/event/prison_break/virology,		0,		list(ASSIGNMENT_ENGINEER = 30), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Xenobiology Breach",		/datum/event/prison_break/xenobiology,	0,		list(ASSIGNMENT_ENGINEER = 30, ASSIGNMENT_ENGINEER = 40, ASSIGNMENT_SECURITY = 30), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Spider Infestation",		/datum/event/spider_infestation, 		20,		list(ASSIGNMENT_SECURITY = 30), 1),
		//Evil grubs that drain station power slightly
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Grub Infestation",			/datum/event/grub_infestation,			25,		list(ASSIGNMENT_SECURITY = 10, ASSIGNMENT_ENGINEER = 30), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Drone Pod Drop",			/datum/event/drone_pod_drop,			10,		list(ASSIGNMENT_SCIENTIST = 40), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Appendicitis", 			/datum/event/spontaneous_appendicitis, 	10,		list(ASSIGNMENT_MEDICAL = 30), 1), //YW EDIT, Readde
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Malignant Organ", 			/datum/event/spontaneous_malignant_organ,10,	list(ASSIGNMENT_MEDICAL = 30), 1),
		//new /datum/event_meta(EVENT_LEVEL_MODERATE, "Maintenance Predator",		/datum/event/maintenance_predator,		100,	list(ASSIGNMENT_ANY = 5), 0),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Jellyfish School",			/datum/event/jellyfish_migration,		10,		list(ASSIGNMENT_ANY = 1, ASSIGNMENT_SECURITY = 15, ASSIGNMENT_MEDICAL = 3), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Supply Demand",			/datum/event/supply_demand,				1,		list(ASSIGNMENT_ANY = 5, ASSIGNMENT_SCIENCE = 15, ASSIGNMENT_GARDENER = 10, ASSIGNMENT_ENGINEER = 10, ASSIGNMENT_MEDICAL = 15), 3, min_jobs = list(ASSIGNMENT_CARGO = 1)), //YW EDIT, Readded
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Wormholes",				/datum/event/wormholes, 				20),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Space Vines",				/datum/event/spacevine, 				15,		list(ASSIGNMENT_ENGINEER = 7, ASSIGNMENT_GARDENER = 2), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Atmos Leak",				/datum/event/atmos_leak, 				20,		list(ASSIGNMENT_ENGINEER = 25), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Psychic Screach",			/datum/event/psychic_screach,			2, 		list(ASSIGNMENT_ANY = 1,ASSIGNMENT_ENGINEER = 10), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Chu Pack",					/datum/event/chu_infestation,			1, 		list(ASSIGNMENT_ANY = 1,ASSIGNMENT_ENGINEER = 10,ASSIGNMENT_SECURITY = 10), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Jil Pack",					/datum/event/jil_infestation,			3, 		list(ASSIGNMENT_ANY = 1,ASSIGNMENT_ENGINEER = 10,ASSIGNMENT_SECURITY = 10), 1),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Virus Outbreak", 			/datum/event/viral_infection,			5, 		list(ASSIGNMENT_MEDICAL = 10) , 10, min_jobs = list(ASSIGNMENT_MEDICAL = 2)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Escaped Slimes",			/datum/event/escaped_slimes, 			2,		list(ASSIGNMENT_SCIENCE = 10, ASSIGNMENT_ENGINEER = 40, ASSIGNMENT_SECURITY = 30), 1, min_jobs = list(ASSIGNMENT_MEDICAL = 3)),
		new /datum/event_meta(EVENT_LEVEL_MODERATE, "Disposal Damage",			/datum/event/disposal_damage,			2, 		list(ASSIGNMENT_ANY = 3))
	)
	add_disabled_events(list(
	))

/datum/event_container/major/New()
	available_events = list(
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Nothing",				/datum/event/nothing						,20),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Meteor Wave",			/datum/event/meteor_wave					,29	, list(ASSIGNMENT_ENGINEER = 15),	5),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Carp Migration",		/datum/event/carp_migration					,16	, list(ASSIGNMENT_ANY = 1,ASSIGNMENT_ENGINEER = 10,ASSIGNMENT_SECURITY = 5), 1, min_jobs = list(ASSIGNMENT_SECURITY = 3)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Containment Breach",	/datum/event/prison_break/station			,12	, list(ASSIGNMENT_ANY = 5), 1),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Jellyfish Migration",	/datum/event/jellyfish_migration			,20	, list(ASSIGNMENT_ANY = 5, ASSIGNMENT_SECURITY = 15, ASSIGNMENT_MEDICAL = 10), 5),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Virus Outbreak", 		/datum/event/viral_infection				,5	, list(ASSIGNMENT_MEDICAL = 10) , 10, min_jobs = list(ASSIGNMENT_MEDICAL = 3)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Blob",				/datum/event/blob							,5	, list(ASSIGNMENT_ENGINEER = 10) , 10),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Chu Infestation",		/datum/event/chu_infestation				,1	, list(ASSIGNMENT_ANY = 1,ASSIGNMENT_ENGINEER = 10,ASSIGNMENT_SECURITY = 10), 1),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Jil Infestation",		/datum/event/jil_infestation				,8	, list(ASSIGNMENT_ANY = 1,ASSIGNMENT_ENGINEER = 10,ASSIGNMENT_SECURITY = 10), 1),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Clowns",				/datum/event/clune_infestation				,7	, list(ASSIGNMENT_ANY = 1,ASSIGNMENT_ENGINEER = 5,ASSIGNMENT_SECURITY = 15) , 10),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Redspace",			/datum/event/redspacefissure				,0	, list(ASSIGNMENT_ANY = 5), 1),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Borg Freedom Law",	/datum/event/borglawerror					,1	, list(ASSIGNMENT_CYBORG = 50, ASSIGNMENT_SCIENCE = 10, ASSIGNMENT_SECURITY = 5), 1, min_jobs = list(ASSIGNMENT_CYBORG = 1)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "All Is Clean",		/datum/event/allisclean						,0  , list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Engineering",	/datum/event/bluespace_shelling/engineering	,0	, list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Science",		/datum/event/bluespace_shelling/science		,0	, list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Security",		/datum/event/bluespace_shelling/security	,0	, list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Cargo",			/datum/event/bluespace_shelling/cargo		,0	, list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Civilian",		/datum/event/bluespace_shelling/civilian	,0  , list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Medical",		/datum/event/bluespace_shelling/medical		,0  , list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Waste",			/datum/event/bluespace_shelling/waste		,0  , list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Station",		/datum/event/bluespace_shelling				,0  , list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Spider Migration",	/datum/event/spider_migration				,20	, list(ASSIGNMENT_SECURITY = 5), 1), //YW shifted to spider migration
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Disposal Damage",		/datum/event/disposal_damage				,2	, list(ASSIGNMENT_ENGINEER = 1), 1)
	)
	add_disabled_events(list(
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "All Is Clean",		/datum/event/allisclean,					 0  , list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Engineering",	/datum/event/bluespace_shelling/engineering	,0	, list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Science",		/datum/event/bluespace_shelling/science		,0	, list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Security",		/datum/event/bluespace_shelling/security	,0	, list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Cargo",			/datum/event/bluespace_shelling/cargo		,0	, list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Civilian",		/datum/event/bluespace_shelling/civilian	,0  , list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Medical",		/datum/event/bluespace_shelling/medical		,0  , list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Waste",			/datum/event/bluespace_shelling/waste		,0  , list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Shell Station",		/datum/event/bluespace_shelling				,0  , list(), 1, min_jobs = list(ASSIGNMENT_SECURITY = 99)),
		new /datum/event_meta(EVENT_LEVEL_MAJOR, "Blob",				/datum/event/blob, 					3,		list(ASSIGNMENT_ENGINEER = 10) , 10)
	))

#undef ASSIGNMENT_ANY
#undef ASSIGNMENT_AI
#undef ASSIGNMENT_CYBORG
#undef ASSIGNMENT_ENGINEER
#undef ASSIGNMENT_GARDENER
#undef ASSIGNMENT_JANITOR
#undef ASSIGNMENT_MEDICAL
#undef ASSIGNMENT_SCIENTIST
#undef ASSIGNMENT_SECURITY
#undef ASSIGNMENT_CARGO
