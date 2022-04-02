// put all map-specific areas here for ease of use and not cluttering a thousand other maps - Ignus
/area/muriki // area/outpost was already in use, so we're using the planet's name.
	icon = 'icons/turf/areas_vr.dmi'
	icon_state = "deck1"
	sound_env = STANDARD_STATION

//Station! Y'know, the important stuff.
//
// Atmospherics ---------------------------------------------------------------------
//
/area/engineering/atmoshall
	name = "\improper Atmospherics Hallway"
	icon_state = "atmos"

/area/muriki/atmos/voxdump
	name = "\improper Hazardous Gas Filtration Substation"
	icon_state = "yelblacir"
	ambience = AMBIENCE_ATMOS

/area/muriki/processor
	name = "\improper Core Processing"
	icon = 'icons/turf/areas.dmi'
	icon_state = "blue"
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	sound_env = SPACE
	ambience = AMBIENCE_FOREBODING

/area/muriki/processor/hall
	name = "\improper Core Processor Cavities"
	icon_state = "anohallway"

/area/muriki/processor/euth
	name = "\improper Processor Euthanization"
	icon_state = "nuke_storage"
	sound_env = SMALL_ENCLOSED
	ambience = list(AMBIENCE_FOREBODING, AMBIENCE_ENGINEERING)

//
//Bathrooms. Each department's has a unique ending name, for humor, and navigation.
//
/area/muriki/bathroom
	name = "\improper Bathroom. Don't use."
	icon_state = "cyablatri"
	sound_env = SMALL_ENCLOSED
	flags = RAD_SHIELDED

/area/muriki/bathroom/atmospherics
	name = "\improper Atmospherics Latrine"

/area/muriki/bathroom/bar
	name = "\improper Bar Head"

/area/muriki/bathroom/bridge
	name = "\improper Privy"

/area/muriki/bathroom/captain
	name = "\improper Oval Office"

/area/muriki/bathroom/cargo
	name = "\improper Main Cargo Bog"

/area/muriki/bathroom/cargopub
	name = "\improper Cargo Public Restroom"

/area/muriki/bathroom/cargolower
	name = "\improper Lower Cargo Bog"

/area/muriki/bathroom/chapel
	name = "\improper Chapel Pilgrimage"

/area/muriki/bathroom/courthouse
	name = "\improper Dreadbox"

/area/muriki/bathroom/dorm
	name = "\improper Pool Restroom"

/area/muriki/bathroom/engineering
	name = "\improper Engineering Latrine"

/area/muriki/bathroom/engsingle
	name = "\improper Engineering Lobby Latrine"

/area/muriki/bathroom/kitchen
	name = "\improper Kitchen Comode"

/area/muriki/bathroom/medical
	name = "\improper Medical Depository"

/area/muriki/bathroom/medupper
	name = "\improper Recovery Depository"

/area/muriki/bathroom/sanitorium
	name = "\improper Sanitorium"

/area/muriki/bathroom/sciupper
	name = "\improper Science Lavatory"

/area/muriki/bathroom/scilower
	name = "\improper Lower Science Lavatory"

/area/muriki/bathroom/security
	name = "\improper Security Thunderbox"

/area/muriki/bathroom/securitypub
	name = "\improper Arrivals Restroom"

/area/muriki/bathroom/vox
	name = "\improper Vomit Closet"

//
// Cargo ---------------------------------------------------------
//
/area/quartermaster/breakroom
	name = "\improper Cargo Break Room"
	icon_state = "orawhicir"
	sound_env = SMALL_SOFTFLOOR

/area/quartermaster/mining/
	name = "\improper Mining Department"

/area/quartermaster/mining/prep
	name = "\improper Mining Equipment Storage"

/area/quartermaster/mining/expl
	name = "\improper Exploration Equipment"

/area/quartermaster/mining/secpi
	name = "\improper Exploration Security"
	icon_state = "security_equip_storage"

/area/quartermaster/mining/processing
	name = "\improper Ore Processing"
	ambience = AMBIENCE_ENGINEERING

/area/quartermaster/mining/firstaid
	name = "\improper Mining First Aid"
	icon_state = "medbay2"

/area/muriki/septic
	name = "\improper Septic Tank"
	icon_state = "green"

/area/muriki/yard
	name = "\improper The Yard"
	icon_state = "yelwhicir"

//
// Civilian ---------------------------------------------------------
//
/area/muriki/arriveelev
	name = "\improper Arrivals Elevators"
	icon_state = "shuttle"
	ambience = AMBIENCE_ARRIVALS

/area/muriki/arriveproc
	name = "\improper Arrivals Processing"
	icon_state = "blublacir"
	ambience = AMBIENCE_ARRIVALS

/area/muriki/arrivejani
	name = "\improper Arrivals Janitorial Closet"
	icon_state = "cyablasqu"
	sound_env = SMALL_ENCLOSED

/area/muriki/janiextra
	name = "\improper Overflow Janitorial Closet"
	icon_state = "cyablasqu"
	sound_env = SMALL_ENCLOSED

/area/muriki/crew/
	name = "\improper Crew Area"
	icon_state = "cyawhicir"
	ambience = AMBIENCE_GENERIC

/area/muriki/crew/arcade
	name = "\improper Arcade"
	icon_state = "cyawhicir"

/area/muriki/crew/barback
	name = "\improper Bartender Backroom"
	icon_state = "cyawhicir"

/area/muriki/crew/arcade/lasertag
	name = "\improper Laser Tag Arena"
	icon_state = "purwhitri"

/area/muriki/crew/arcade/lasertagstore
	name = "\improper Laser Tag Storage"
	icon_state = "purwhicir"

/area/muriki/crew/sauna1
	name = "\improper Sauna Room One"
	icon_state = "bluewnew"
	sound_env = SMALL_SOFTFLOOR

/area/muriki/crew/sauna2
	name = "\improper Sauna Room Two"
	icon_state = "bluewnew"
	sound_env = SMALL_SOFTFLOOR

/area/muriki/crew/poollocker
	name = "\improper Pool Showers"
	icon_state = "locker"
	sound_env = MEDIUM_SOFTFLOOR

/area/muriki/crew/judge
	name = "\improper Judge's Office"
	icon_state = "bluenew"
	sound_env = SMALL_ENCLOSED

/area/muriki/crew/glass
	name = "\improper Dorm Dayroom"
	icon_state = "recreation_area"
	sound_env = SMALL_ENCLOSED

/area/muriki/crew/dormaid
	name = "\improper Dorm First Aid Station"
	icon_state = "medbay2"
	sound_env = SMALL_ENCLOSED

/area/muriki/crew/baraid
	name = "\improper Public First Aid Station"
	icon_state = "medbay2"
	sound_env = SMALL_ENCLOSED

/area/chapel/chapel_music
	name = "\improper Music Room"
	icon_state = "yellow"

//Hallways-------
/area/muriki/crewstairwell
	name = "\improper Civilian Stairwell"
	icon_state = "bluenew"
	music = 'sound/ambience/signal.ogg'
	sound_env = TUNNEL_ENCLOSED

/area/hallway/muriki/dorm
	name = "\improper Dorm Hallway"
	icon_state = "bluewnew"

/area/hallway/muriki/civup
	name = "\improper Civilian Upper Hallway"
	icon_state = "bluenew"

/area/hallway/security/main
	name = "\improper Security Main Hallway"
	icon_state = "blue"

/area/hallway/security/armor
	name = "\improper Security Armory Hallway"
	icon_state = "red2"

/area/hallway/security/upper
	name = "\improper Security Upper Hallway"
	icon_state = "blue"

//Hydro-------
/area/muriki/crew/kitchenfreezer
	name = "\improper Kitchen Freezer"
	icon_state = "bluewnew"

/area/hydroponics/publicgarden
	name = "\improper Public Garden"
	icon_state = "cafe_garden"

/area/hydroponics/apiary
	name = "\improper Hydroponics Aipiary"
	icon_state = "hydro"

/area/hydroponics/hallway
	name = "\improper Hydroponics Hallway"
	icon_state = "center"

/area/hydroponics/gibber //Watch your step~
	name = "\improper Hydroponics Gibber Deposit"
	icon_state = "red2"

//
// Engineering -----------------------------------------------------
//
/area/engineering/trammaint
	name = "\improper Tram Maintenance Room"
	icon_state = "engineering"
	sound_env = LARGE_ENCLOSED

/area/engineering/hardsuitstore
	name = "\improper Engineering Hardsuit Storage"
	icon_state = "eva"

/area/engineering/enginestorage
	name = "\improper Engine Storage"
	icon_state = "primarystorage"

/area/engineering/auxstore
	name = "\improper Engineering Aux Storage"
	icon_state = "auxstorage"

/area/engineering/corepower
	name = "\improper Engine Generator"
	icon_state = "engine"

/area/engineering/eva
	name = "\improper Engineering Exterior Access"
	icon_state = "eva"

/area/engineering/gravgen
	name = "\improper Elevator Gravity Assist"
	icon_state = "maint_pumpstation"

/area/engineering/coreproctunnel
	name = "\improper Core Processor Atmo Tunnel"
	icon_state = "darkred"
	sound_env = TUNNEL_ENCLOSED
	ambience = AMBIENCE_FOREBODING

//them dat der bluespezz warpy magic
/area/teleporter/engineering
	name = "\improper Engineering Teleporter"

/area/teleporter/bridge
	name = "\improper Bridge Teleporter"


//
// Elevator -------------------------------------------------------
//
/area/turbolift
	delay_time = 2 SECONDS
	forced_ambience = list('sound/music/elevator.ogg')
	dynamic_lighting = FALSE //Temporary fix for elevator lighting
	flags = RAD_SHIELDED
	requires_power = FALSE

/area/turbolift/start
	name = "\improper Turbolift Start"

/area/turbolift/basement
	name = "\improper basement"
	base_turf = /turf/simulated/open

/area/turbolift/mainfloor
	name = "\improper main level"
	base_turf = /turf/simulated/open

/area/turbolift/upperfloor
	name = "\improper upper level"
	base_turf = /turf/simulated/open


//SECURITY
/area/turbolift/secbase
	name = "Security Sublevel 1"
	lift_floor_label = "Security Basement"
	lift_floor_name = "Brig."
	lift_announce_str = "Arriving at Security Basement."

/area/turbolift/secmain
	name = "Security First Floor"
	lift_floor_label = "Security Main"
	lift_floor_name = "Primary Security."
	lift_announce_str = "Arriving at Security Primary."

/area/turbolift/secupper
	name = "Security Second Floor"
	lift_floor_label = "Security High Level"
	lift_floor_name = "AI, Telecoms, Solar Backup, Evac shuttle."
	lift_announce_str = "Arriving at Security Upper Floor."

//MEDICAL
/area/turbolift/medibasement
	name = "Medbay Sublevel 1"
	lift_floor_label = "Medical Basement"
	lift_floor_name = "Vox Treatment, Morgue, Surgery Training, Cavern Access."
	lift_announce_str = "Arriving at Medical Basement."

/area/turbolift/medical
	name = "Medbay First Floor"
	lift_floor_label = "Medbay"
	lift_floor_name = "Lobby, Surgery, Primary Treatment, Psychology."
	lift_announce_str = "Arriving at Medbay Primary."

/area/turbolift/mediupper
	name = "Medbay Second Floor"
	lift_floor_label = "Medical Recovery"
	lift_floor_name = "Resleeving, CMO, Checkup, Recovery ward, Hangar."
	lift_announce_str = "Arriving at Medical Loft."

//Civilian
/area/turbolift/civbase
	name = "Civilian Sublevel 1"
	lift_floor_label = "Basement"
	lift_floor_name = "Cafe, Pool, Dorms, Lasertag."
	lift_announce_str = "Arriving at Basement."

/area/turbolift/civmain
	name = "Civilian First Floor"
	lift_floor_label = "First Floor"
	lift_floor_name = "Bar, Bridge, Evac Hallway."
	lift_announce_str = "Arriving at First Floor."

/area/turbolift/civupper
	name = "Civilian Second Floor"
	lift_floor_label = "Second Floor"
	lift_floor_name = "Chapel, Library, Garden."
	lift_announce_str = "Arriving at Second Floor."

//Science
/area/turbolift/scibase
	name = "Science Sublevel 1"
	lift_floor_label = "Research Basement"
	lift_floor_name = "Xnobio, Particle lab, Xenoarch"
	lift_announce_str = "Arriving at Basement."

/area/turbolift/scimain
	name = "Science First Floor"
	lift_floor_label = "Research First Floor"
	lift_floor_name = "RnD, Robotics, RD."
	lift_announce_str = "Arriving at First Floor."

/area/turbolift/sciupper
	name = "Science Second Floor"
	lift_floor_label = "Research Second Floor"
	lift_floor_name = "Telesci, Xenoflora."
	lift_announce_str = "Arriving at Second Floor."

//
// Exterior / hazard areas / mine ---------------------------------
//
/area/muriki/grounds //Non dangerous variant, for inside the fence
	name = "\improper Facility Grounds"
	icon_state = "dark"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'

/area/muriki/grounds/tramline
	name = "\improper Exterior Tram Line"
	icon_state = "redblatri"

/area/mine/explored/muriki/surface
	name = "\improper Facility Grounds"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'

/area/mine/unexplored/muriki/surface
	name = "\improper Muiriki Surface"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'

/area/mine/explored/muriki/cave
	name = "\improper Facility Tunnels"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/cave
	name = "\improper Muriki Caverns"
	sound_env = TUNNEL_ENCLOSED

//
// Maintenance ------------------------------------------------------------
//
/area/maintenance/medicelev
	name = "\improper Medical Elevator Maintenance Shaft"
	icon_state = "maint_medbay"

/area/maintenance/secelev
	name = "\improper Security Elevator Maintenance Shaft"
	icon_state = "maint_security_port"

/area/maintenance/scielev
	name = "\improper Research Elevator Maintenance Shaft"
	icon_state = "maint_research_shuttle"

/area/maintenance/crewelev
	name = "\improper Civilian Elevator Maintenance Shaft"
	icon_state = "pmaint"

/area/maintenance/lowerelev
	name = "\improper Arrivals Elevator Shaft"
	icon_state = "dark128"

/area/maintenance/lowerevac
	name = "\improper Evac Elevator Shaft"
	icon_state = "dark128"

/area/maintenance/wastedisposal
	name = "\improper Waste Disposal Maintenance"
	icon_state = "maint_medbay"

/area/maintenance/wastenear
	name = "\improper Near Waste Maintenance"
	icon_state = "blue"

/area/maintenance/sec
	name = "\improper Near Security Maintenance"
	icon_state = "blue"

/area/maintenance/med
	name = "\improper Near Medical Maintenance"
	icon_state = "bluenew"

/area/maintenance/sci
	name = "\improper Near Science Maintenance"
	icon_state = "purple"

/area/maintenance/civ
	name = "\improper Near Civilian Maintenance"
	icon_state = "maintcentral"

/area/maintenance/eng
	name = "\improper Near Engineering Maintenance"
	icon_state = "maint_engineering"

/area/maintenance/bridge
	name = "\improper Bridge Maintenance"
	icon_state = "bluenew"

/area/maintenance/kennel
	name = "\improper Kennels Maintenance"
	icon_state = "blue"

/area/maintenance/gravgen
	name = "\improper Gravity Generator Maintenance"
	icon_state = "blue"

//caves
/area/maintenance/cave
	name = "\improper Facility Lower Maintenance"
	icon_state = "dark128"

/area/maintenance/spine
	name = "\improper Maintenance Spine"
	icon = 'icons/turf/areas_vr.dmi'
	icon_state = "orawhisqu"

/area/maintenance/tug
	name = "\improper Maintenance Tug Tunnel"
	icon = 'icons/turf/areas_vr.dmi'
	icon_state = "deckmaint1"

//
// Medical ------------------------------------------------------------
//
/area/medical/stairwell
	name = "\improper Medical Stairwell"
	icon_state = "bluenew"
	music = 'sound/ambience/signal.ogg'
	sound_env = TUNNEL_ENCLOSED

/area/medical/laundry
	name = "\improper Medical Laundry Room"
	icon_state = "locker"
	sound_env = SMALL_SOFTFLOOR

/area/medical/mail
	name = "\improper Medical Mailing Room"
	icon_state = "quartdelivery"
	sound_env = SMALL_SOFTFLOOR

/area/medical/locker
	name = "\improper Medical Locker Room"
	icon_state = "locker"

/area/medical/recovlaund
	name = "\improper Medical Recovery Laundry"
	icon_state = "locker"
	flags = RAD_SHIELDED

/area/medical/evastore
	name = "\improper Medical Hazop And Hardsuit Storage"
	icon_state = "locker"

/area/medical/sleevecheck
	name = "\improper Medical Resleeving Verification"
	icon_state = "medbay3"

/area/medical/checkup
	name = "\improper Medical Examination Room"
	icon_state = "medbay3"

/area/medical/surgtrain
	name = "\improper Medical Surgery Training Theater"
	icon_state = "medbay4"

/area/hallway/secondary/secmedbridge
	name = "\improper Medical Security Transfer Bridge"
	icon_state = "blue-red2"

//vox treatment: In compliance with....

/area/medical/voxlab
	name = "\improper Vox Treatment Lab"
	icon_state = "purple"
	sound_env = SMALL_ENCLOSED
	ambience = list(AMBIENCE_OTHERWORLDLY, AMBIENCE_OUTPOST)

/area/medical/voxlab/airgap
	name = "\improper Vox Treatment Airgap"

/area/medical/voxlab/airlock
	name = "\improper Vox Treatment Airlock"

/area/medical/voxlab/lobby
	name = "\improper Vox Treatment Lobby"
	icon_state = "decontamination"

/area/medical/voxlab/main
	name = "\improper Vox Treatment Lab"
	icon_state = "medbay_triage"

/area/medical/voxlab/storage
	name = "\improper Vox Treatment Storage"
	icon_state = "storage"

/area/medical/voxlab/surgery
	name = "\improper Vox Surgery"
	icon_state = "surgery"

/area/medical/voxlab/chem
	name = "\improper Vox Chemistry Lab"
	icon_state = "chem"

/area/medical/voxlab/recov
	name = "\improper Vox Recovery"
	icon_state = "Sleep"

/area/medical/voxlab/breakroom
	name = "\improper Vox Lab Breakroom"
	icon_state = "bar"

//
// Rooftops-----------------------------------------------------------------------
//
/area/muriki/rooftop
	name = "\improper Rooftop"
	icon = 'icons/turf/areas.dmi'
	icon_state = "away"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'

/area/muriki/rooftop/engineering
	name = "\improper Engineering Roof"
	icon_state = "away4"

/area/muriki/rooftop/cargo
	name = "\improper Cargo Roof"
	icon_state = "away"

/area/muriki/rooftop/disposal
	name = "\improper Waste Management Roof"
	icon_state = "away"

/area/muriki/rooftop/medical
	name = "\improper Medical Roof"
	icon_state = "away1"

/area/muriki/rooftop/security
	name = "\improper Security Roof"
	icon_state = "away3"

/area/muriki/rooftop/science
	name = "\improper Science Roof"
	icon_state = "away2"

/area/muriki/rooftop/civilian
	name = "\improper Civilian Roof"
	icon_state = "away"

//
// Security-----------------------------------------------------------------------
//
/area/security/brig/low
	name = "\improper Security Low Security Brig"
	icon_state = "brig"

/area/security/brig/drunk
	name = "\improper Security Drunktank"
	icon_state = "brig"

/area/security/tankstore
	name = "\improper Security Heavy Armor Storage"
	icon_state = "security_sub"

/area/security/mechent
	name = "\improper Security Mech Entrance"
	icon_state = "security_sub"

/area/security/kennels
	name = "\improper Security Kennels"
	icon_state = "red2"

/area/security/eva
	name = "\improper Security External Access"
	icon_state = "red2"

/area/security/stairwell
	name = "\improper Security Stairwell"
	icon_state = "red2"
	sound_env = TUNNEL_ENCLOSED

/area/security/hangar
	name = "\improper Security hangar"
	icon_state = "red2"
	sound_env = LARGE_ENCLOSED

//
// Science-----------------------------------------------------------------------
//
/area/constructionsite/science2
	name = "\improper Research Construction Site"
	icon_state = "construction"

/area/rnd
	name = "\improper Research"
	icon = 'icons/turf/areas.dmi'
	icon_state = "purple"

/area/rnd/chemistry
	name = "\improper Research Backup Chemistry"
	icon_state = "chem"

/area/rnd/breakroom
	name = "\improper Research Breakroom"
	icon_state = "locker"

/area/rnd/lockers
	name = "\improper Research Locker Room"
	icon_state = "locker"

/area/rnd/entry
	name = "\improper Research Entryway Decontamination"
	icon_state = "decontamination"

/area/rnd/stairwell
	name = "\improper Science Stairwell"
	icon_state = "purple"
	sound_env = TUNNEL_ENCLOSED

/area/rnd/otherlab
	name = "\improper RnD Auxillary Laboratory"
	icon_state = "outpost_research"

/area/rnd/telesci
	name = "\improper Research Telescience"
	icon_state = "teleporter"

/area/rnd/xenobiology/xenoflora2
	name = "\improper Xenoflora Hazard Lab"
	icon_state = "xeno_f_lab"

/area/rnd/xenobiology/xenobioh
	name = "\improper Hazardous Xenobiology Lab"
	icon_state = "xeno_f_lab"

/area/rnd/xenobiology/xenobiohstore
	name = "\improper Hazardous Xenobiology Storage"
	icon_state = "research_storage"

/area/rnd/xenobiology/lost
	name = "\improper Abandoned Xenobiology Lab"
	icon_state = "blue"

/area/rnd/xenobiology/burn
	name = "\improper Xenobiology Threat Supression"
	icon_state = "red2"

/area/rnd/research/atmosia
	name = "\improper Research Scrubber Filtration"

/area/rnd/research/analysis
	name = "\improper Research Sample Analysis"

/area/rnd/research/anomaly
	name = "\improper Anomalous Materials Lab"

/area/rnd/research/medical
	name = "\improper Xenolab First aid"

/area/rnd/research/isolation_a
	name = "\improper Research Isolation 1"

/area/rnd/research/isolation_b
	name = "\improper Research Isolation 2"

/area/rnd/research/isolation_c
	name = "\improper Research Isolation 3"

/area/rnd/research/longtermstorage
	name = "\improper Xenolab Long-Term Storage"

/area/rnd/research/anomaly_storage
	name = "\improper Xenolab Anomalous Storage"

/area/rnd/research/anomaly_analysis
	name = "\improper Xenolab Anomaly Analysis"

/area/rnd/research/exp_prep
	name = "\improper Xenolabt Expedition Preperation"

/area/rnd/research/mailing
	name = "\improper Research Mailing"

/area/rnd/research/laundry
	name = "\improper Xenolab Laundry"

/area/rnd/research/breakroom
	name = "\improper Research Break Room"

//----------------
/area/rnd/hallway
	name = "\improper Research hallway"
	icon_state = "hallC"
	sound_env = LARGE_ENCLOSED

/area/rnd/hallway/main
	name = "\improper Primary Research hallway"
	icon_state = "hallC"

/area/rnd/hallway/upper
	name = "\improper Upper Research hallway"
	icon_state = "hallC"

/area/rnd/hallway/lowmain
	name = "\improper Lower Main Research hallway"
	icon_state = "hallC"

/area/rnd/hallway/xeno
	name = "\improper Xenoarch hallway"
	icon_state = "hallC"

/area/rnd/hallway/hazard
	name = "\improper Hazardous Research hallway"
	icon_state = "hallC"

/area/rnd/hallway/staircase
	name = "\improper Research Stairwell"
	icon_state = "purple"

/area/muriki/research/isolation_hall
	name = "Research Isolation Hall"

//
//-----------------------------------------------------------------------
//Shuttles
/area/muriki/station/mining_dock
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

/area/shuttle/security
	name = "\improper Security Escape Shuttle"
	icon_state = "shuttle2"
	requires_power = 1

//
// Tramline --------------------------------------------------
//

/area/shuttle/tram
	name = "\improper Station Tram"
	icon = 'icons/turf/areas.dmi'
	icon_state = "shuttlegrn"

/area/muriki/tramstation
	name = "\improper Tram Station"
	icon_state = "dark128"
	sound_env = LARGE_ENCLOSED
	ambience = list(AMBIENCE_ARRIVALS, AMBIENCE_HANGAR)

/area/muriki/tramstation/waste
	name = "\improper Tram Station - Waste"
	icon_state = "dark128"

/area/muriki/tramstation/cargeng
	name = "\improper Tram Station - Cargo Engineering"
	icon_state = "dark128"

/area/muriki/tramstation/civ
	name = "\improper Tram Station - Civilian"
	icon_state = "dark128"


// Bad guys
/area/shuttle/mercenary
	name = "\improper Mercenary Vessel"
	flags = AREA_FLAG_IS_NOT_PERSISTENT

/area/shuttle/skipjack
	name = "\improper Vox Vessel"
	flags = AREA_FLAG_IS_NOT_PERSISTENT