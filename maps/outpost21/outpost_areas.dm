// put all map-specific areas here for ease of use and not cluttering a thousand other maps - Ignus
/area/muriki // area/outpost was already in use, so we're using the planet's name.
	icon = 'icons/turf/areas_vr.dmi'
	icon_state = "deck1"
	sound_env = STANDARD_STATION

// Misc
/area/mine/explored/muriki_wilds
	name = "\improper muriki Wilderness Outer Perimeter"

/area/mine/unexplored/muriki_wilds
	name = "\improper muriki Wilderness Inner Perimeter"

/area/muriki/lowerelev
	name = "\improper Arrivals Elevator Shaft"
	icon_state = "dark128"
	ambience = AMBIENCE_FOREBODING
	sound_env = TUNNEL_ENCLOSED
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS

/area/muriki/lowerevac
	name = "\improper Evac Elevator Shaft"
	icon_state = "dark128"
	ambience = AMBIENCE_FOREBODING
	sound_env = TUNNEL_ENCLOSED
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS



//Station! Y'know, the important stuff.
//
// Atmospherics ---------------------------------------------------------------------
//
/area/engineering/atmoshall
	name = "\improper Atmospherics Hallway"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "atmos"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/muriki/atmos/voxdump
	name = "\improper Hazardous Gas Filtration Substation"
	icon_state = "yelblacir"
	ambience = AMBIENCE_ATMOS
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

//Processor. Our station is cool enough to have a giant vore eldrich horror for a terraforming station.
/area/muriki/processor
	name = "\improper Core Terraformer Processing"
	base_turf = /turf/simulated/floor/flesh
	icon = 'icons/turf/areas.dmi'
	icon_state = "blue"
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	sound_env = SPACE
	ambience = AMBIENCE_MEATZONE
	music = 'sound/ambience/approaching_planet.ogg'
	requires_power = FALSE

/area/muriki/processor/euth
	name = "\improper Processor Euthanization"
	icon_state = "nuke_storage"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_FOREBODING
	music = 'sound/ambience/ambimine.ogg'
//Hallways... I guess?
/area/muriki/processor/hall
	name = "\improper Core Processor Cavities"
	icon_state = "anohallway"

/area/muriki/processor/hall/airmix
	name = "\improper Terraformer Alveolar duct"

/area/muriki/processor/hall/waterway_upper
	name = "\improper Terraformer Upper Jejunum"

/area/muriki/processor/hall/waterway_low
	name = "\improper Terraformer Lower Jejunum"

/area/muriki/processor/hall/waterway_other
	name = "\improper Terraformer Ileum"

//Glands
/area/muriki/processor/gland
	name = "\improper Terraformer Gaseous Glands"
	icon_state = "green"

/area/muriki/processor/gland/space
	name = "\improper Terraformer Inhallation Gland"

/area/muriki/processor/gland/airmix
	name = "\improper Terraformer Primary Enzyme Cavity" //Technically a pool, but it makes more sense here.

/area/muriki/processor/gland/nitrogen
	name = "\improper Terraformer Common Nitrogen Duct"

/area/muriki/processor/gland/co2
	name = "\improper Terraformer Carbon Dioxide Bladder"

/area/muriki/processor/gland/phoron
	name = "\improper Terraformer Phoronic Sack"

//Pools.. don't swim in these.
/area/muriki/processor/pools
	name = "\improper Terraformer Enzomatic Pools"
	icon_state = "yellow"

/area/muriki/processor/pools/pylorus
	name = "\improper Terraformer Pyloric Pool"

/area/muriki/processor/pools/antrum
	name = "\improper Terraformer Antrum Pool"

/area/muriki/processor/pools/crop
	name = "\improper Terraformer Crop"

/area/muriki/processor/pools/cropbig
	name = "\improper Terraformer Greater Crop"

/area/muriki/processor/pools/gizzard //Note to medical: Don't even bother rescuing anyone in here.
	name = "\improper Terraformer Gizzard"

/area/muriki/processor/pools/eastfund
	name = "\improper Terraformer Eastern Fundic Pool"

/area/muriki/processor/pools/westfund
	name = "\improper Terraformer Western Fundic Pool"

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
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/muriki/bathroom/bar
	name = "\improper Bar Head"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/bathroom/bridge
	name = "\improper Privy"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/muriki/bathroom/captain
	name = "\improper Oval Office"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/muriki/bathroom/cargo
	name = "\improper Main Cargo Bog"
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/muriki/bathroom/cargopub
	name = "\improper Cargo Public Restroom"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/bathroom/cargolower
	name = "\improper Lower Cargo Bog"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/muriki/bathroom/chapel
	name = "\improper Chapel Pilgrimage"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/bathroom/courthouse
	name = "\improper Dreadbox"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/muriki/bathroom/dorm
	name = "\improper Pool Restroom"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/bathroom/engineering
	name = "\improper Engineering Latrine"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/muriki/bathroom/engsingle
	name = "\improper Engineering Lobby Latrine"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/muriki/bathroom/kitchen
	name = "\improper Kitchen Comode"
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS

/area/muriki/bathroom/medical
	name = "\improper Medical Depository"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/muriki/bathroom/medupper
	name = "\improper Recovery Depository"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/muriki/bathroom/sanitorium
	name = "\improper Sanitorium"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/bathroom/sciupper
	name = "\improper Science Lavatory"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/muriki/bathroom/scilower
	name = "\improper Lower Science Lavatory"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/muriki/bathroom/security
	name = "\improper Security Thunderbox"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/muriki/bathroom/securitypub
	name = "\improper Arrivals Restroom"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/bathroom/vox
	name = "\improper Vomit Closet"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/muriki/bathroom/casino
	name = "\improper Casino Royal Flush"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_CIV

//
// Medical ---------------------------------------------------------
//

/area/maintenance/medbay_roof
	name = "\improper Medical Roof Maintenance"
	base_turf = /turf/simulated/open
	sound_env = SMALL_ENCLOSED

/area/maintenance/cargobay_roof
	name = "\improper Disposal Pressure Management"
	base_turf = /turf/simulated/open
	sound_env = SMALL_ENCLOSED

//
// Cargo ---------------------------------------------------------
//
/area/quartermaster/breakroom
	name = "\improper Cargo Break Room"
	base_turf = /turf/simulated/mineral/floor/muriki
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
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/muriki/septic
	name = "\improper Septic Tank"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "green"

/area/muriki/yard
	name = "\improper The Yard"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "yelwhicir"

/area/muriki/station/trawler_dock
	name = "\improper Mining trawler Landing Pad"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "orablasqu"

/area/maintenance/cargoupper
	name = "Cargo Roof Maintenance"
	base_turf = /turf/simulated/open
	icon_state = "green"

/area/maintenance/cargomid
	name = "Cargo Disposal Maintenance"
	base_turf = /turf/simulated/open
	icon_state = "orawhicir"


//
// Civilian ---------------------------------------------------------
//
/area/muriki/arriveelev
	name = "\improper Arrivals Elevators"
	icon_state = "shuttle"
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS

/area/muriki/arriveproc
	name = "\improper Arrivals Processing"
	icon_state = "blublacir"
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS

/area/muriki/arrivejani
	name = "\improper Arrivals Janitorial Closet"
	icon_state = "cyablasqu"
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_JANITOR

/area/muriki/janiextra
	name = "\improper Overflow Janitorial Closet"
	icon_state = "cyablasqu"
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_JANITOR

/area/muriki/cybstorage
	name = "\improper Cyborg Storage"
	icon_state = "shuttle"
	ambience = AMBIENCE_GENERIC
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS

/area/muriki/crew/
	name = "\improper Crew Area"
	icon_state = "cyawhicir"
	ambience = AMBIENCE_GENERIC

/area/muriki/crew/arcade
	name = "\improper Arcade"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "cyawhicir"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/casino
	name = "\improper Casino and Smoke Lounge"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "cyawhicir"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/casinostore
	name = "\improper Casino Storage"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "orawhicir"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/barback
	name = "\improper Bartender Backroom"
	icon_state = "cyawhicir"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/arcade/lasertag
	name = "\improper Laser Tag Arena"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "purwhitri"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/arcade/lasertagstore
	name = "\improper Laser Tag Storage"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "purwhicir"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/sauna1
	name = "\improper Sauna Room One"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "bluewnew"
	sound_env = SMALL_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/sauna2
	name = "\improper Sauna Room Two"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "bluewnew"
	sound_env = SMALL_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/poollocker
	name = "\improper Pool Showers"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "locker"
	sound_env = MEDIUM_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/judge
	name = "\improper Judge's Office"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "bluenew"
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/glass
	name = "\improper Dorm Dayroom"
	icon_state = "recreation_area"
	base_turf = /turf/simulated/mineral/floor/muriki
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/dormaid
	name = "\improper Dorm First Aid Station"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "medbay2"
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/muriki/crew/baraid
	name = "\improper Public First Aid Station"
	icon_state = "medbay2"
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/muriki/crew/engyaid
	name = "\improper Public Cargo First Aid Station"
	icon_state = "medbay2"
	sound_env = SMALL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/chapel/chapel_music
	name = "\improper Music Room"
	icon_state = "yellow"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/vr_train
	name = "\improper Virtual Reality Training"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "blublatri"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/muriki/crew/civmail
	name = "\improper Civilian Mail Room"
	icon_state = "orablasqu"
	holomap_color = HOLOMAP_AREACOLOR_CIV


//Hallways-------
/area/muriki/crewstairwell
	name = "\improper Civilian Stairwell"
	icon_state = "bluenew"
	music = 'sound/ambience/signal.ogg'
	sound_env = TUNNEL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/hallway/muriki/dorm
	name = "\improper Dorm Hallway"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "bluewnew"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/hallway/muriki/civup
	name = "\improper Civilian Upper Hallway"
	icon_state = "bluenew"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/hallway/security/main
	name = "\improper Security Main Hallway"
	icon_state = "blue"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/hallway/security/armor
	name = "\improper Security Armory Hallway"
	icon_state = "red2"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/hallway/security/upper
	name = "\improper Security Upper Hallway"
	icon_state = "blue"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

//Hydro-------
/area/muriki/crew/kitchenfreezer
	name = "\improper Kitchen Freezer"
	icon_state = "bluewnew"
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS

/area/hydroponics/publicgarden
	name = "\improper Public Garden"
	icon_state = "cafe_garden"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/hydroponics/apiary
	name = "\improper Hydroponics Aipiary"
	icon_state = "hydro"
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS

/area/hydroponics/hallway
	name = "\improper Hydroponics Hallway"
	icon_state = "center"
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS

/area/hydroponics/gibber //Watch your step~
	name = "\improper Hydroponics Gibber Deposit"
	icon_state = "red2"
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS

//
// Engineering -----------------------------------------------------
//
/area/engineering/trammaint
	name = "\improper Tram Maintenance Room"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "engineering"
	sound_env = LARGE_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/hardsuitstore
	name = "\improper Engineering Hardsuit Storage"
	icon_state = "eva"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/enginestorage
	name = "\improper Engine Storage"
	icon_state = "primarystorage"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/auxstore
	name = "\improper Engineering Aux Storage"
	icon_state = "auxstorage"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/corepower
	name = "\improper Engine Generator"
	icon_state = "engine"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/eva
	name = "\improper Engineering Exterior Access"
	icon_state = "eva"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/gravgen
	name = "\improper Elevator Gravity Assist"
	icon_state = "maint_pumpstation"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/engineering/coreproctunnel
	name = "\improper Core Processor Atmo Tunnel"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "darkred"
	sound_env = TUNNEL_ENCLOSED
	ambience = AMBIENCE_FOREBODING
	music = 'sound/ambience/ambimine.ogg'
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

//them dat der bluespezz warpy magic
/area/teleporter/engineering
	name = "\improper Engineering Teleporter"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/teleporter/bridge
	name = "\improper Bridge Teleporter"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND


//
// Elevator -------------------------------------------------------
// mapping areas
/area/muriki/elevator/secbase
	name = "Security Sublevel 1"
	base_turf = /turf/simulated/mineral/floor/muriki
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/secmain
	name = "Security First Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/secupper
	name = "Security Second Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/medibasement
	name = "Medbay Sublevel 1"
	base_turf = /turf/simulated/mineral/floor/muriki
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/medical
	name = "Medbay First Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/mediupper
	name = "Medbay Second Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/civbase
	name = "Civilian Sublevel 1"
	base_turf = /turf/simulated/mineral/floor/muriki
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/civmain
	name = "Civilian First Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/civupper
	name = "Civilian Second Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/scibase
	name = "Science Sublevel 1"
	base_turf = /turf/simulated/mineral/floor/muriki
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/scimain
	name = "Science First Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT
/area/muriki/elevator/sciupper
	name = "Science Second Floor"
	flags = AREA_FLAG_IS_NOT_PERSISTENT

// finalized elevator areas, lift itself makes these once init
/area/turbolift
	delay_time = 2 SECONDS
	forced_ambience = list('sound/music/elevator2.ogg')
	dynamic_lighting = FALSE //Temporary fix for elevator lighting
	flags = RAD_SHIELDED
	requires_power = FALSE

//SECURITY
/area/turbolift/secbase
	name = "Security Sublevel 1"
	base_turf = /turf/simulated/floor/plating
	lift_floor_label = "Security Basement"
	lift_floor_name = "Brig."
	lift_announce_str = "Arriving at Security Basement."
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/turbolift/secmain
	name = "Security First Floor"
	lift_floor_label = "Security Main"
	lift_floor_name = "Primary Security."
	lift_announce_str = "Arriving at Security Primary."
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/turbolift/secupper
	name = "Security Second Floor"
	lift_floor_label = "Security High Level"
	lift_floor_name = "AI, Telecoms, Evac shuttle."
	lift_announce_str = "Arriving at Security Upper Floor."
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

//MEDICAL
/area/turbolift/medibasement
	name = "Medbay Sublevel 1"
	base_turf = /turf/simulated/floor/plating
	lift_floor_label = "Medical Basement"
	lift_floor_name = "Vox Treatment, Morgue, Surgery Training, Cavern Access."
	lift_announce_str = "Arriving at Medical Basement."
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/turbolift/medical
	name = "Medbay First Floor"
	lift_floor_label = "Medbay"
	lift_floor_name = "Lobby, Surgery, Primary Treatment, Psychology."
	lift_announce_str = "Arriving at Medbay Primary."
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/turbolift/mediupper
	name = "Medbay Second Floor"
	lift_floor_label = "Medical Recovery"
	lift_floor_name = "Resleeving, CMO, Checkup, Recovery ward, Hangar."
	lift_announce_str = "Arriving at Medical Loft."
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

//Civilian
/area/turbolift/civbase
	name = "Civilian Sublevel 1"
	base_turf = /turf/simulated/floor/plating
	lift_floor_label = "Basement"
	lift_floor_name = "Cafe, Pool, Dorms, Arcade, Cavern Access."
	lift_announce_str = "Arriving at Basement."
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/turbolift/civmain
	name = "Civilian First Floor"
	lift_floor_label = "First Floor"
	lift_floor_name = "Bar, Bridge, Evac Hallway."
	lift_announce_str = "Arriving at First Floor."
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/turbolift/civupper
	name = "Civilian Second Floor"
	lift_floor_label = "Second Floor"
	lift_floor_name = "Chapel, Library, Garden."
	lift_announce_str = "Arriving at Second Floor."
	holomap_color = HOLOMAP_AREACOLOR_CIV

//Science
/area/turbolift/scibase
	name = "Science Sublevel 1"
	base_turf = /turf/simulated/floor/plating
	lift_floor_label = "Research Basement"
	lift_floor_name = "Xenobio, Particle lab, Xenoarch, Cavern Access"
	lift_announce_str = "Arriving at Basement."
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/turbolift/scimain
	name = "Science First Floor"
	lift_floor_label = "Research First Floor"
	lift_floor_name = "RnD, Robotics, RD."
	lift_announce_str = "Arriving at First Floor."
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/turbolift/sciupper
	name = "Science Second Floor"
	lift_floor_label = "Research Second Floor"
	lift_floor_name = "Telesci, Xenoflora."
	lift_announce_str = "Arriving at Second Floor."
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

//
//----------------- Exterior / hazard areas / mine ---------------------------------
//
/area/muriki/grounds //Non dangerous variant, for inside the fence
	name = "\improper Facility Grounds"
	icon_state = "dark"
	base_turf = /turf/simulated/mineral/floor/muriki
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'

/area/muriki/grounds/graveyard
	name = "\improper Facility Graveyard"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "outside1"

/area/muriki/grounds/terraform
	name = "\improper Facility Terraformer Base"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "outside2"

/area/muriki/grounds/engi
	name = "\improper Facility Near Engineering"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "orablatri"

/area/muriki/grounds/waste
	name = "\improper Facility Near Waste Management"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "orablatri"

/area/muriki/grounds/sec
	name = "\improper Facility Near Security"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "redblatri"

/area/muriki/grounds/med
	name = "\improper Facility Near Medical"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "cyablatri"

/area/muriki/grounds/shutt
	name = "\improper Facility Shuttle Pads"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "deck1"

/area/muriki/grounds/civ
	name = "\improper Facility Near Civilian Structure"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "bluwhitri"

/area/muriki/grounds/sci
	name = "\improper Facility Near Science"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "purblatri"

/area/muriki/grounds/tramborder
	name = "\improper Tram Line Edge"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "redwhicir"

/area/muriki/grounds/tramlineeast
	name = "\improper Eastern Tram Line"
	base_turf = /turf/simulated/floor/outdoors/mud/muriki
	icon_state = "redblasqu"

/area/muriki/grounds/tramlinewest
	name = "\improper Western Tram Line"
	base_turf = /turf/simulated/floor/outdoors/mud/muriki
	icon_state = "redblatri"

//Mine variants for mob spawns.
/area/mine/explored/muriki/surface
	name = "\improper Facility Grounds"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	base_turf = /turf/simulated/mineral/floor/muriki
	music = 'sound/ambience/ambiatm1.ogg'

/area/mine/unexplored/muriki/surface
	name = "\improper Facility Grounds"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'

/area/mine/explored/muriki/cave
	name = "\improper Facility Tunnels"
	base_turf = /turf/simulated/mineral/floor/muriki
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/cave
	name = "\improper Muriki Caverns"
	base_turf = /turf/simulated/mineral/floor/muriki
	sound_env = TUNNEL_ENCLOSED

//Subdivided areas because holy crap zas hates our map.
//Basement. Dept.
/area/mine/explored/muriki
	base_turf = /turf/simulated/mineral/floor/muriki
/area/mine/unexplored/muriki
	base_turf = /turf/simulated/mineral/floor/muriki

/area/mine/explored/muriki/cave/eng
	name = "\improper Facility Engineering Tunnels"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "orange"
	base_turf = /turf/simulated/mineral/floor/muriki
/area/mine/unexplored/muriki/cave/eng
	name = "\improper Muriki Caverns Near Engineering"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "orange"

/area/mine/explored/muriki/cave/cargo
	name = "\improper Muriki Cargo Isle Caverns"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "yellow"
/area/mine/unexplored/muriki/cave/cargo
	name = "\improper Muriki Caverns Near Cargo"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "yellow"

/area/mine/explored/muriki/cave/waste
	name = "\improper Muriki Waste Processing Caves"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "green"
/area/mine/unexplored/muriki/cave/waste
	name = "\improper Muriki Caverns Near Waste"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "green"

/area/mine/explored/muriki/cave/sec
	name = "\improper Muriki Security Caverns"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "darkred"
/area/mine/unexplored/muriki/cave/sec
	name = "\improper Muriki Caverns Near Security"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "darkred"

/area/mine/explored/muriki/cave/med
	name = "\improper Muriki Medical Caverns"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "bluenew"
/area/mine/unexplored/muriki/cave/med
	name = "\improper Muriki Caverns Near Medical"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "bluenew"

/area/mine/explored/muriki/cave/sci
	name = "\improper Muriki Research Caverns"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "purple"
/area/mine/unexplored/muriki/cave/sci
	name = "\improper Muriki Caverns Near Research"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "purple"

/area/mine/explored/muriki/cave/civ
	name = "\improper Muriki Civilian Caverns"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "dark128"
/area/mine/unexplored/muriki/cave/civ
	name = "\improper Muriki Caverns Near Civilian"
	sound_env = TUNNEL_ENCLOSED
	icon_state = "dark128"

//fillers
/area/mine/unexplored/muriki/cave/terra
	name = "\improper Muriki Caverns Near Terraformer"
	icon_state = "cave"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/cave/west
	name = "\improper Muriki Western Caverns"
	icon_state = "west"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/cave/south
	name = "\improper Muriki Southern Caverns"
	icon_state = "south"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/cave/east
	name = "\improper Muriki Eastern Caverns"
	icon_state = "east"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/cave/north
	name = "\improper Muriki Northern Caverns"
	icon_state = "north"
	sound_env = TUNNEL_ENCLOSED

//below the mountain
/area/mine/explored/muriki/mountainbase
	name = "\improper Facility Mountain Caves"
	icon_state = "center"
	base_turf = /turf/simulated/mineral/floor/muriki
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/mountainbase
	name = "\improper Muriki Easstern Mountain Caverns"
	icon_state = "east"
	base_turf = /turf/simulated/mineral/floor/muriki
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/mountainbasenorth
	name = "\improper Muriki Northern Mountain Caverns"
	icon_state = "north"
	base_turf = /turf/simulated/mineral/floor/muriki
	sound_env = TUNNEL_ENCLOSED

//------second floor------
/area/mine/explored/muriki/mountainnorth
	name = "\improper North Facility Mountainside"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "north"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS

/area/mine/explored/muriki/mountaineast
	name = "\improper Eastern Facility Mountainside"
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki
	icon_state = "east"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS

/area/mine/unexplored/muriki/mountainnorth
	name = "\improper Muriki Northern Mountain Caverns"
	icon_state = "north"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/mountaineast
	name = "\improper Muriki Eastern Mountain Caverns"
	icon_state = "east"
	sound_env = TUNNEL_ENCLOSED

/area/mine/explored/muriki/valley
	name = "\improper Valley Edge"
	icon_state = "center"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS

/area/mine/unexplored/muriki/valleyeast
	name = "\improper Muriki Lower Valley"
	base_turf = /turf/simulated/floor/outdoors/mud/muriki
	icon_state = "east"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS

/area/mine/unexplored/muriki/valleywest
	name = "\improper Muriki Lower Valley"
	base_turf = /turf/simulated/floor/outdoors/mud/muriki
	icon_state = "west"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS

//-------third floor--------
/area/mine/explored/muriki/mountaintopnorth
	name = "\improper North Facility Mountaintop"
	icon_state = "north"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS

/area/mine/explored/muriki/mountaintopeast
	name = "\improper Eastern Facility Mountaintop"
	icon_state = "east"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS

/area/mine/unexplored/muriki/mountaintopnorth
	name = "\improper Muriki Northern Mountaintop Caverns"
	icon_state = "north"
	sound_env = TUNNEL_ENCLOSED

/area/mine/unexplored/muriki/mountaintopeast
	name = "\improper Muriki Eastern Mountaintop Caverns"
	icon_state = "east"
	sound_env = TUNNEL_ENCLOSED

/area/muriki/crystal
	name = "\improper Muriki Crystal Den"
	icon_state = "bluwhicir"
	sound_env = TUNNEL_ENCLOSED

//Skyline
/area/muriki/skyline
	name = "\improper Facility Airspace"
	icon_state = "dark"
	sound_env = SOUND_ENVIRONMENT_MOUNTAINS
	music = 'sound/ambience/ambiatm1.ogg'

/area/muriki/skyline/east
	name = "\improper Eastern Facility Airspace"
	icon_state = "east"

/area/muriki/skyline/west
	name = "\improper Western Facility Airspace"
	icon_state = "west"

/area/muriki/skyline/north
	name = "\improper Northern Facility Airspace"
	icon_state = "north"

/area/muriki/skyline/south
	name = "\improper Southern Facility Airspace"
	icon_state = "south"

/area/muriki/skyline/cent
	name = "\improper Central Facility Airspace"
	icon_state = "center"

//Other areas in the caves
/area/mine/explored/muriki/tuggrave
	name = "\improper Tug Graveyard"
	base_turf = /turf/simulated/mineral/floor/muriki
	sound_env = TUNNEL_ENCLOSED
	icon_state = "dk_yellow"

//Moon riiiiver
/area/mine/explored/muriki/river
	name = "\improper Muriki River"
	icon_state = "blue2"
	base_turf = /turf/simulated/floor/water/acidic/deep/muriki
	sound_env = SOUND_ENVIRONMENT_SEWER_PIPE
	music = 'sound/ambience/ruins/ruins3.ogg'

/area/mine/explored/muriki/river/mouth
	name = "\improper River Mouth"

/area/mine/explored/muriki/river/north
	name = "\improper River North"

/area/mine/explored/muriki/river/south
	name = "\improper River South"

/area/mine/explored/muriki/river/east
	name = "\improper River East"

/area/mine/explored/muriki/river/hole
	name = "\improper River Cave-in"

/area/mine/explored/muriki/river/end
	name = "\improper River Falls"

//
// Maintenance ------------------------------------------------------------
//
/area/maintenance
	base_turf = /turf/simulated/mineral/floor/muriki

/area/maintenance/medicelev
	name = "\improper Medical Elevator Maintenance Shaft"
	base_turf = /turf/simulated/open
	icon_state = "maint_medbay"

/area/maintenance/medicelevbasement
	name = "\improper Medical Elevator Maintenance Foundation"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "maint_medbay"

/area/maintenance/secelev
	name = "\improper Security Elevator Maintenance Shaft"
	base_turf = /turf/simulated/open
	icon_state = "maint_security_port"

/area/maintenance/secelevbasement
	name = "\improper Security Elevator Maintenance Foundation"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "pmaint"

/area/maintenance/scielev
	name = "\improper Research Elevator Maintenance Shaft"
	base_turf = /turf/simulated/open
	icon_state = "maint_research_shuttle"

/area/maintenance/scielevbasement
	name = "\improper Research Elevator Maintenance Foundation"
	icon_state = "pmaint"

/area/maintenance/research/geneticshole
	name = "\improper Research Genetics Hole"
	icon_state = "pmaint"
	base_turf = /turf/simulated/open

/area/maintenance/crewelev
	name = "\improper Civilian Elevator Maintenance Shaft"
	base_turf = /turf/simulated/open
	icon_state = "maint_security_port"

/area/maintenance/crewelevbasement
	name = "\improper Civilian Elevator Maintenance Foundation"
	icon_state = "pmaint"

/area/maintenance/wastedisposal
	name = "\improper Waste Disposal Maintenance"
	base_turf = /turf/simulated/open
	icon_state = "maint_research_shuttle"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/maintenance/wastedisposalnear
	name = "\improper Near Waste Disposal Maintenance"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "maint_medbay"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

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
	base_turf = /turf/simulated/open
	icon_state = "blue"

/area/maintenance/gravgen
	name = "\improper Gravity Generator Maintenance"
	base_turf = /turf/simulated/open
	icon_state = "blue"

/area/maintenance/oldbridge
	name = "\improper Abandoned Bridge"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon = 'icons/turf/areas.dmi'
	icon_state = "bridge"
	broken_light_chance = 85
	haunted = TRUE

//Cavern maintenance
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
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/laundry
	name = "\improper Medical Laundry Room"
	icon_state = "locker"
	sound_env = SMALL_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/mail
	name = "\improper Medical Mailing Room"
	icon_state = "quartdelivery"
	base_turf = /turf/simulated/mineral/floor/muriki
	sound_env = SMALL_SOFTFLOOR
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/locker
	name = "\improper Medical Locker Room"
	icon_state = "locker"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/recovlaund
	name = "\improper Medical Recovery Laundry"
	icon_state = "locker"
	flags = RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/evastore
	name = "\improper Medical Hazop And Hardsuit Storage"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "locker"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/sleevecheck
	name = "\improper Medical Resleeving Verification"
	icon_state = "medbay3"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/checkup
	name = "\improper Medical Examination Room"
	icon_state = "medbay3"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgtrain
	name = "\improper Medical Surgery Training Theater"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "medbay4"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/hallway/secondary/secmedbridge
	name = "\improper Medical Security Transfer Bridge"
	icon_state = "blue-red2"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

//vox treatment: In compliance with....

/area/medical/voxlab
	name = "\improper Vox Treatment Lab"
	icon_state = "purple"
	sound_env = SMALL_ENCLOSED
	base_turf = /turf/simulated/mineral/floor/muriki
	ambience = list(AMBIENCE_OTHERWORLDLY, AMBIENCE_OUTPOST)
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/airgap
	name = "\improper Vox Treatment Airgap"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/airlock
	name = "\improper Vox Treatment Airlock"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/lobby
	name = "\improper Vox Treatment Lobby"
	icon_state = "decontamination"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/main
	name = "\improper Vox Treatment Lab"
	icon_state = "medbay_triage"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/storage
	name = "\improper Vox Treatment Storage"
	icon_state = "storage"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/surgery
	name = "\improper Vox Surgery"
	icon_state = "surgery"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/chem
	name = "\improper Vox Chemistry Lab"
	icon_state = "chem"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/recov
	name = "\improper Vox Recovery"
	icon_state = "Sleep"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/voxlab/breakroom
	name = "\improper Vox Lab Breakroom"
	icon_state = "bar"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/hangar
	name = "\improper Medevac Shuttle Hangar"
	icon_state = "medical"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/tankstore
	name = "\improper Nurse Bradley's Office"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "blue"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/autosleever
	name = "\improper Automated Resleever"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "blue"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

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
//Backup Generators
//
/area/muriki/rooftop/medgen
	name = "\improper Medical Backup Generator"
	sound_env = SMALL_ENCLOSED
	icon_state = "blue"

/area/muriki/rooftop/scigen
	name = "\improper Research Backup Generator"
	sound_env = SMALL_ENCLOSED
	icon_state = "blue"

/area/muriki/rooftop/civgen
	name = "\improper Civilian Backup Generator"
	sound_env = SMALL_ENCLOSED
	icon_state = "blue"

/area/muriki/rooftop/secgen
	name = "\improper Security Backup Generator"
	sound_env = SMALL_ENCLOSED
	icon_state = "blue"

/area/muriki/rooftop/comgen
	name = "\improper Command Backup Generator"
	sound_env = SMALL_ENCLOSED
	icon_state = "blue"

/area/muriki/rooftop/cargen
	name = "\improper Cargo Backup Generator"
	sound_env = SMALL_ENCLOSED
	icon_state = "blue"

//
// Security-----------------------------------------------------------------------
//
/area/security/brig/low
	name = "\improper Security Low Security Brig"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "brig"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/brig/lowobservation
	name = "\improper Security Low Security Brig Observation"
	base_turf = /turf/simulated/open
	icon_state = "security_sub"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/brig/observation
	name = "\improper Security Brig Observation"
	base_turf = /turf/simulated/open
	icon_state = "security_sub"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/brig/drunk
	name = "\improper Security Drunktank"
	base_turf = /turf/simulated/open
	icon_state = "brig"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/brig/isolate
	name = "\improper Security Solitary Confinement"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "brig"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/tankstore
	name = "\improper Security Heavy Armor Storage"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "security_sub"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/mechent
	name = "\improper Security Mech Entrance"
	icon_state = "security_sub"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/kennels
	name = "\improper Security Kennels"
	icon_state = "red2"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/eva
	name = "\improper Security External Access"
	icon_state = "red2"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/stairwell
	name = "\improper Security Stairwell"
	icon_state = "red2"
	sound_env = TUNNEL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/security/hangar
	name = "\improper Security hangar"
	icon_state = "red2"
	sound_env = LARGE_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

//
// Science-----------------------------------------------------------------------
//
/area/constructionsite/science2
	name = "\improper Research Construction Site"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "construction"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd
	name = "\improper Research"
	icon = 'icons/turf/areas.dmi'
	icon_state = "purple"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/chemistry
	name = "\improper Research Backup Chemistry"
	icon_state = "chem"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/breakroom
	name = "\improper Research Breakroom"
	icon_state = "locker"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/lockers
	name = "\improper Research Locker Room"
	icon_state = "locker"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/entry
	name = "\improper Research Entryway Decontamination"
	icon_state = "decontamination"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/stairwell
	name = "\improper Science Stairwell"
	icon_state = "purple"
	sound_env = TUNNEL_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/otherlab
	name = "\improper RnD Auxillary Laboratory"
	icon_state = "outpost_research"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/telesci
	name = "\improper Research Telescience"
	icon_state = "teleporter"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/xenobiology
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/xenobiology/xenoflora2
	name = "\improper Xenoflora Hazard Lab"
	icon_state = "xeno_f_lab"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/xenobiology/xenobioh
	name = "\improper Hazardous Xenobiology Lab"
	icon_state = "xeno_f_lab"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/xenobiology/xenobiohstore
	name = "\improper Hazardous Xenobiology Storage"
	icon_state = "research_storage"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/xenobiology/lost
	name = "\improper Abandoned Xenobiology Lab"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "blue"

/area/rnd/xenobiology/burn
	name = "\improper Xenobiology Threat Supression"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "red2"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/rnd/research/atmosia
	name = "\improper Research Scrubber Filtration"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/rnd/research/analysis
	name = "\improper Research Sample Analysis"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/anomaly
	name = "\improper Anomalous Materials Lab"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/medical
	name = "\improper Xenolab First aid"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/rnd/research/isolation_a
	name = "\improper Research Isolation 1"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/isolation_b
	name = "\improper Research Isolation 2"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/isolation_c
	name = "\improper Research Isolation 3"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/longtermstorage
	name = "\improper Xenolab Long-Term Storage"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/anomaly_storage
	name = "\improper Xenolab Anomalous Storage"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/anomaly_analysis
	name = "\improper Xenolab Anomaly Analysis"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/exp_prep
	name = "\improper Xenolab Expedition Preperation"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/mailing
	name = "\improper Research Mailing"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/rnd/research/oldrd
	name = "\improper Old RDs office"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/laundry
	name = "\improper Xenolab Laundry"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/breakroom
	name = "\improper Research Break Room"
	base_turf = /turf/simulated/open
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/phoronics
	name = "\improper Phoronics"
	icon_state = "magblacir"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/phoronics/burn
	name = "\improper Phoronics Burn Chamber"
	icon_state = "redblacir"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/research/phoronics/clean
	name = "\improper Phoronics Cleaning Closet"
	icon_state = "purwhitri"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE


//----------------
/area/rnd/hallway
	name = "\improper Research hallway"
	icon_state = "hallC"
	sound_env = LARGE_ENCLOSED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/main
	name = "\improper Primary Research hallway"
	icon_state = "hallC"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/basementstairs
	name = "\improper Primary Research Server Access"
	base_turf = /turf/simulated/mineral/floor/muriki
	icon_state = "purple"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/upper
	name = "\improper Upper Research hallway"
	icon_state = "hallC"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/lowmain
	name = "\improper Lower Main Research hallway"
	icon_state = "hallC"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/xeno
	name = "\improper Xenoarch hallway"
	icon_state = "hallC"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/hazard
	name = "\improper Hazardous Research hallway"
	icon_state = "hallC"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/staircase
	name = "\improper Research Stairwell"
	icon_state = "purple"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/phoronicsbridge
	name = "\improper Phoronics Access Bridge"
	icon_state = "magblasqu"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/rnd/hallway/phoronicsmainhall
	name = "\improper Phoronics Main Hallway"
	icon_state = "magblatri"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE


/area/muriki/research/isolation_hall
	name = "Research Isolation Hall"
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

//
//-----------------------------------------------------------------------
//Offworld

/area/offworld/asteroidyard/station/
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_MAINTENANCE
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/offworld/asteroidyard/external
	name = "\improper Reclamation Yard Exterior"
	icon_state = "red2"
	has_gravity = 0
	ambience = AMBIENCE_OUTPOST21_SPACE
	base_turf = /turf/space
	ambience = AMBIENCE_SPACE

/area/offworld/asteroidyard/external/has_gravity()
	return 0

/area/offworld/asteroidyard/external/yardzone
	icon_state = "construction"

/area/offworld/asteroidyard/station/halls
	name = "\improper Reclamation Yard Hallway"
	icon_state = "purple"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/asteroidyard/station/halls_storage
	name = "\improper Reclamation Yard Hallway"
	icon_state = "green"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/asteroidyard/station/halls_bar
	name = "\improper Reclamation Yard Hallway"
	icon_state = "orange"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/asteroidyard/station/access_shaft
	name = "\improper Reclamation Yard Access Shaft"
	icon_state = "red"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/offworld/asteroidyard/station/washing
	name = "\improper Reclamation Yard Cleaning Room"
	icon_state = "red"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/offworld/asteroidyard/station/dockingbay
	name = "\improper Reclamation Yard Hanger"
	icon_state = "decontamination"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_HANGAR
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/offworld/asteroidyard/station/cave
	name = "\improper Reclamation Yard Caverns"
	icon_state = "construction"
	sound_env = ASTEROID
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/offworld/asteroidyard/station/storage
	name = "\improper Reclamation Yard Storage"
	icon_state = "locker"
	sound_env = ASTEROID
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/offworld/asteroidyard/station/bar
	name = "\improper Reclamation Yard Bar"
	icon_state = "green"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/offworld/asteroidyard/station/medbox
	name = "\improper Reclamation Medical Station"
	icon_state = "medbay2"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/offworld/asteroidyard/station/spelunker
	name = "\improper Reclamation Spelunker"
	icon_state = "toilet"
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/offworld/asteroidyard/station/engineering
	name = "\improper Reclamation Yard Engineering"
	icon_state = "orange"
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/asteroidyard/station/solarControl
	name = "\improper Reclamation Yard Solar Control"
	icon_state = "orange"
	ambience = AMBIENCE_SUBSTATION
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/offworld/asteroidyard/station/observation
	name = "\improper Reclamation Yard Observation"
	icon_state = "blue"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_FOREBODING
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/offworld/asteroidyard/station/telecomms
	name = "\improper Reclamation Yard Telecomms Satellite"
	icon_state = "tcomsatlob"
	sound_env = LARGE_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/offworld/asteroidyard/station/teleport
	name = "\improper Reclamation Yard Teleporter"
	icon_state = "tcomsatlob"
	sound_env = SMALL_ENCLOSED
	ambience = AMBIENCE_ENGINEERING
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

//
//-----------------------------------------------------------------------
//Shuttles
/area/shuttle/trawler
	name = "\improper Mining Trawler"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/simulated/floor/plating/external/muriki
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/shuttle/medical
	name = "\improper Medevac Shuttle"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/simulated/floor
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/shuttle/security
	name = "\improper Security Shuttle"
	icon_state = "shuttle2"
	requires_power = 1
	base_turf = /turf/simulated/floor
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

//
// Tramline --------------------------------------------------
//
/area/shuttle/tram
	name = "\improper Station Tram"
	icon = 'icons/turf/areas.dmi'
	icon_state = "shuttlegrn"
	base_turf = /turf/simulated/floor

/area/muriki/tramstation
	name = "\improper Tram Station"
	icon_state = "dark128"
	sound_env = LARGE_ENCLOSED
	ambience = list(AMBIENCE_ARRIVALS, AMBIENCE_HANGAR)
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/muriki/tramstation/shed
	name = "\improper Tram Station - Shed"
	icon_state = "dark128"

/area/muriki/tramstation/waste
	name = "\improper Tram Station - Waste"
	icon_state = "dark128"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/muriki/tramstation/cargeng
	name = "\improper Tram Station - Cargo Engineering"
	icon_state = "dark128"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/muriki/tramstation/civ
	name = "\improper Tram Station - Civilian"
	icon_state = "dark128"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS


// Bad guys
/area/shuttle/mercenary
	name = "\improper Mercenary Vessel"
	flags = AREA_FLAG_IS_NOT_PERSISTENT

/area/shuttle/skipjack
	name = "\improper Vox Vessel"
	flags = AREA_FLAG_IS_NOT_PERSISTENT

//
// Vehicle interiors ---------------------------------------------------------------------
//
/area/vehicle_interior/
	sound_env = SMALL_ENCLOSED
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	requires_power = FALSE


/area/vehicle_interior/heavyarmor_carrier_A
	name = "\improper Carrier A"

/area/vehicle_interior/heavyarmor_carrier_B
	name = "\improper Carrier A"


/area/vehicle_interior/heavyarmor_tank_A
	name = "\improper Tank A"

/area/vehicle_interior/heavyarmor_tank_B
	name = "\improper Tank B"

/area/vehicle_interior/heavyarmor_tank_C
	name = "\improper Tank C"


/area/vehicle_interior/heavyarmor_medic_recovery
	name = "\improper Medic Recovery Vehicle"


//
// Specialtiy -------------------------------------------------------------------------------
//

/area/specialty/redspace
	name = "\improper Unknown"
	base_turf = /turf/simulated/floor/flesh
	icon = 'icons/turf/areas.dmi'
	icon_state = "blue"
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	sound_env = SPACE
	ambience = AMBIENCE_MEATZONE
	music = 'sound/ambience/approaching_planet.ogg'
	requires_power = FALSE
	broken_light_chance = 75
	haunted = TRUE

/area/specialty/thedarkplace // halucination punishment zone
	name = "\improper Unknown"
	base_turf = /turf/simulated/floor/weird_things/dark
	icon = 'icons/turf/areas.dmi'
	icon_state = "blue"
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	sound_env = SPACE
	ambience = AMBIENCE_FOREBODING
	music = 'sound/ambience/ambisin1.ogg'

/area/virtual_reality/lighting // virtual reality, but cooler
	dynamic_lighting = 1 // literally the only change, I just wanted neat lights for the hazard course.

/area/virtual_reality/requirespower // virtual reality, but for doors that are pried open, and lights that are dead
	dynamic_lighting = 1
	requires_power = TRUE

/area/specialty/hell
	name = "\improper Unknown"
	base_turf = /turf/simulated/floor/lava
	icon = 'icons/turf/areas.dmi'
	icon_state = "blue"
	flags = RAD_SHIELDED | AREA_FLAG_IS_NOT_PERSISTENT
	sound_env = SPACE
	ambience = AMBIENCE_MEATZONE
	music = 'sound/ambience/approaching_planet.ogg'
	requires_power = FALSE
	dynamic_lighting = 0

//
// Outpost holomap modifications, or base turf fixes ONLY. !!!OVERRIDES!!! ---------------------------------------------------------------------
//
/area/supply/station
	base_turf = /turf/simulated/floor/outdoors/mud/muriki

/area/rnd/supermatter
	base_turf = /turf/simulated/mineral/floor/muriki

/area/constructionsite/science
	base_turf = /turf/simulated/mineral/floor/muriki

/area/maintenance/disposal
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	base_turf = /turf/simulated/open

/area/maintenance/incinerator
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/muriki

/area/maintenance/substation/mining
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/open

/area/maintenance/tool_storage
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/hallway/secondary/entry/docking_lounge
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS

/area/hallway/secondary/engineering_hallway
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/bridge
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/bridge_hallway
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/bridge/hallway
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/bridge/meeting_room
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/crew_quarters/captain
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/crew_quarters/heads/hop
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/crew_quarters/heads/hor
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/crew_quarters/heads/chief
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/crew_quarters/heads/hos
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/crew_quarters/heads/cmo
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/crew_quarters/courtroom
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters/recreation_area_hallway
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/muriki

/area/hallway/secondary/construction
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters/recreation_area
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/muriki

/area/mint
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/comms
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/server
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/crew_quarters/sleep/engi_wash
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/crew_quarters/sleep/cryo
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/crew_quarters/sleep/elevator
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/crew_quarters/locker
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/crew_quarters/locker/locker_toilet
	base_turf = /turf/simulated/mineral/floor/muriki
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/crew_quarters/fitness
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters/pool
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters/sleep/Dorm_1
	holomap_color = HOLOMAP_AREACOLOR_DORMS
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters/sleep/Dorm_2
	holomap_color = HOLOMAP_AREACOLOR_DORMS
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters/sleep/Dorm_3
	holomap_color = HOLOMAP_AREACOLOR_DORMS
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters/sleep/Dorm_4
	holomap_color = HOLOMAP_AREACOLOR_DORMS
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters/sleep/Dorm_5
	holomap_color = HOLOMAP_AREACOLOR_DORMS
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters/cafeteria
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/crew_quarters/coffee_shop
	holomap_color = HOLOMAP_AREACOLOR_CIV
	base_turf = /turf/simulated/mineral/floor/muriki

/area/crew_quarters/kitchen
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS

/area/crew_quarters/bar
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/library
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/library_conference_room
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/library_office
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/chapel
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/lawoffice
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/security/security_aid_station
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/psych
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/crew_quarters/medbreak
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/crew_quarters/medical_restroom
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/patients_rooms
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/ward
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/patient_wing
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/cmostore
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/robotics
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/medical/virology
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/biostorage
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/muriki

/area/medical/medbay2
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/muriki

/area/medical/virologyaccess
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/morgue
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/muriki

/area/medical/chemistry
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgery
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgery2
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgeryobs
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgeryprep
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgery_hallway
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/surgery_storage
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/muriki

/area/medical/medbay4
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL
	base_turf = /turf/simulated/mineral/floor/muriki

/area/medical/cryo
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/exam_room
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/genetics
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/genetics_cloning
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/medical/first_aid_station_starboard
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/medical/first_aid_station
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/storage/tools
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/janitor/
	holomap_color = HOLOMAP_AREACOLOR_JANITOR

/area/djstation
	holomap_color = HOLOMAP_AREACOLOR_CIV

/area/rnd/rdoffice
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/hydroponics
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS

/area/hydroponics/cafegarden
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS

/area/hydroponics/garden
	holomap_color = HOLOMAP_AREACOLOR_HYDROPONICS

/area/quartermaster
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/quartermaster/foyer
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/quartermaster/qm
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/construction/solars
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/construction/solarscontrol
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/ai_upload
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/ai_upload_foyer
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/ai_server_room
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/ai
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/ai_cyborg_station
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/security/tactical
	holomap_color = HOLOMAP_AREACOLOR_SECURITY
	base_turf = /turf/simulated/floor/outdoors/newdirt_nograss/muriki

/area/tcommsat/
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/tcomsat
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/tcomfoyer
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/tcommsat/computer
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/tcommsat/lounge
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/tcommsat/powercontrol
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/engineering/atmos
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/muriki

/area/engineering/atmos/monitoring
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/muriki

/area/constructionsite/atmospherics
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/muriki

/area/engineering/atmos/storage
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING
	base_turf = /turf/simulated/mineral/floor/muriki

/area/maintenance/substation/engineering
	base_turf = /turf/simulated/open

/area/maintenance/engineering
	base_turf = /turf/simulated/open

/area/maintenance/engi_engine
	base_turf = /turf/simulated/open

/area/maintenance/cargo
	base_turf = /turf/simulated/mineral/floor/muriki

/area/maintenance/substation/cargo
	base_turf = /turf/simulated/open

/area/maintenance/substation/security
	base_turf = /turf/simulated/open

/area/maintenance/arrivals
	base_turf = /turf/simulated/open

/area/maintenance/medbay_aft
	base_turf = /turf/simulated/open

/area/maintenance/medbay_fore
	base_turf = /turf/simulated/open

/area/maintenance/substation/medical
	base_turf = /turf/simulated/open

/area/rnd/xenobiology/xenoflora_storage
	base_turf = /turf/simulated/open

/area/rnd/xenobiology/xenoflora
	base_turf = /turf/simulated/open

/area/maintenance/substation/research
	base_turf = /turf/simulated/open

/area/maintenance/substation/civilian
	base_turf = /turf/simulated/open

/area/maintenance/substation/command
	base_turf = /turf/simulated/open

/area/maintenance/substation/virology
	base_turf = /turf/simulated/open

/area/maintenance/security_port
	base_turf = /turf/simulated/open

/area/maintenance/security_starboard
	base_turf = /turf/simulated/open

/area/maintenance/bar
	base_turf = /turf/simulated/open

/area/medical/sleeper
    flags = 0 //Makes it FILTHY again