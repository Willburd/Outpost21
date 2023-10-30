/datum/absorbed_dna
	var/name
	var/datum/dna/dna
	var/speciesName
	var/list/languages
	var/identifying_gender
	var/list/flavour_texts
	var/list/genMods
	var/ooc_notes
	var/appearance_flags
	var/weight
	var/sizemult

/datum/absorbed_dna/New(var/newName, var/newDNA, var/newSpecies, var/newLanguages, var/newIdentifying_Gender, var/list/newFlavour, var/list/newGenMods, var/newoocnotes, var/newappearance_flags, var/newweight, var/newsizemult)
	..()
	name = newName
	dna = newDNA
	speciesName = newSpecies
	languages = newLanguages
	identifying_gender = newIdentifying_Gender
	flavour_texts = newFlavour ? newFlavour.Copy() : null
	genMods = newGenMods ? newGenMods.Copy() : null
	// vore stuff
	sizemult = newsizemult
	ooc_notes = newoocnotes
	appearance_flags = newappearance_flags
	weight = newweight
