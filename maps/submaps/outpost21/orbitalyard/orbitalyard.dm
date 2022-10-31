// This causes PoI maps to get 'checked' and compiled, when undergoing a unit test.
// This is so CI can validate PoIs, and ensure future changes don't break PoIs, as PoIs are loaded at runtime and the compiler can't catch errors.
// When adding a new PoI, please add it to this list.
#if MAP_TEST
#include "chunk_A.dmm"
#include "chunk_B.dmm"
#include "chunk_C.dmm"
#include "scaff_A.dmm"
#include "scaff_B.dmm"
#include "scaff_C.dmm"
#include "giant_asteroid_A"
#endif

/datum/map_template/outpost21/space/orbitalyard
	name = "Space Content - Spooce"
	desc = "Used to fill extra space to explore in the orbital yard."

/datum/map_template/outpost21/space/orbitalyard_huge
	name = "Space Content - Thats no moon"
	desc = "Used to make the orbital yard a FUN place to explore."


//////////////////////////////////////////////////////////////
// Generic floating junk
/datum/map_template/outpost21/space/orbitalyard/chunk_A
	name = "Asteroid Variant A"
	desc = "Random asteroid."
	mappath = 'maps/submaps/outpost21/orbitalyard/chunk_A.dmm'
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/chunk_B
	name = "Asteroid Variant B"
	desc = "Random asteroid."
	mappath = 'maps/submaps/outpost21/orbitalyard/chunk_B.dmm'
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/chunk_C
	name = "Asteroid Variant C"
	desc = "Random asteroid."
	mappath = 'maps/submaps/outpost21/orbitalyard/chunk_C.dmm'
	allow_duplicates = TRUE
	cost = 5


/datum/map_template/outpost21/space/orbitalyard/scaff_A
	name = "Scaffolding Variant A"
	desc = "Random construction."
	mappath = 'maps/submaps/outpost21/orbitalyard/scaff_A.dmm'
	allow_duplicates = TRUE
	cost = 5

/datum/map_template/outpost21/space/orbitalyard/scaff_B
	name = "Scaffolding Variant B"
	desc = "Random construction."
	mappath = 'maps/submaps/outpost21/orbitalyard/scaff_B.dmm'
	allow_duplicates = TRUE
	cost = 5


/datum/map_template/outpost21/space/orbitalyard/scaff_C
	name = "Scaffolding Variant C"
	desc = "Random construction."
	mappath = 'maps/submaps/outpost21/orbitalyard/scaff_C.dmm'
	allow_duplicates = TRUE
	cost = 5


//////////////////////////////////////////////////////////////
// Huge structures in the yard (usually one at a time...)
/datum/map_template/outpost21/space/orbitalyard_huge/giant_asteroid_A
	name = "Giant Asteroid Variant A"
	desc = "Random Giant asteroid."
	mappath = 'maps/submaps/outpost21/orbitalyard/giant_asteroid_A.dmm'
	allow_duplicates = TRUE
	cost = 40

/*/datum/map_template/outpost21/space/orbitalyard_huge/engine_ruins
	name = "Engine Ruins"
	desc = "Destroyed ruins of a reactor and engines."
	mappath = 'maps/submaps/outpost21/orbitalyard/scaff_C.dmm'
	allow_duplicates = FALSE
	cost = 25
*/


//////////////////////////////////////////////////////////////
// Area definitions
/area/submap/outpost21/asteroid_generic
	name = "\improper Asteroids"
	ambience = AMBIENCE_SPACE
	icon_state = "red2"
	has_gravity = 0
	ambience = list('sound/ambience/ambispace.ogg','sound/music/title2.ogg','sound/music/space.ogg','sound/music/main.ogg','sound/music/traitor.ogg','sound/ambience/space/space_serithi.ogg','sound/music/freefallin.mid')
	base_turf = /turf/space
