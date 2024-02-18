/turf/simulated/floor/gas_crack
	icon = 'icons/turf/flooring/asteroid.dmi'
	desc = "Rough sand with a huge crack. It seems to be nothing in particular."
	name = "cracked sand"
	icon_state = "asteroid_cracked"
	initial_flooring = /decl/flooring/rock

/turf/simulated/floor/gas_crack/methane
	desc = "Rough sand with a huge crack. A terrible smell wafts from beneath it."

/turf/simulated/floor/gas_crack/methane/Initialize()
	. = ..()
	if(!air) make_air()
	air.adjust_gas("methane", 2500)

/turf/simulated/floor/gas_crack/nitrogen
	desc = "Rough sand with a huge crack. A strong breeze blows through it."

/turf/simulated/floor/gas_crack/nitrogen/Initialize()
	. = ..()
	if(!air) make_air()
	air.adjust_gas("nitrogen", 2500)

/turf/simulated/floor/gas_crack/carbon
	desc = "Rough sand with a huge crack. A strong breeze blows through it."

/turf/simulated/floor/gas_crack/carbon/Initialize()
	. = ..()
	if(!air) make_air()
	air.adjust_gas("carbon_dioxide", 2500)
