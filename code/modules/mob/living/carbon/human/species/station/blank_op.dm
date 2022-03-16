// outpost 21 custom race removal - needed to retain cosmetic stability and xenochimera, check blank_vr.dm for the original purpose of this. Mostly custom_race stuff.
/datum/species/New()
	if(!base_species)
		base_species = name
	..()