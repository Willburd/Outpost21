/////////////////////////////
// Helpers for DNA2
/////////////////////////////

// Pads 0s to t until length == u
/proc/add_zero2(t, u)
	var/temp1
	while (length(t) < u)
		t = "0[t]"
	temp1 = t
	if (length(t) > u)
		temp1 = copytext(t,2,u+1)
	return temp1

// DNA Gene activation boundaries, see dna2.dm.
// Returns a list object with 4 numbers.
/proc/GetDNABounds(var/block)
	var/list/BOUNDS=dna_activity_bounds[block]
	if(!istype(BOUNDS))
		return DNA_DEFAULT_BOUNDS
	return BOUNDS

// Give Random Bad Mutation to M
/proc/randmutb(var/mob/living/M)
	if(!M || !(M.dna)) return
	M.dna.check_integrity()
	//var/block = pick(GLASSESBLOCK,COUGHBLOCK,FAKEBLOCK,NERVOUSBLOCK,CLUMSYBLOCK,TWITCHBLOCK,HEADACHEBLOCK,BLINDBLOCK,DEAFBLOCK,HALLUCINATIONBLOCK) // Most of these are disabled anyway.
	var/block = pick(	BLINDBLOCK,
						DEAFBLOCK,
						TWITCHBLOCK,
						HEADACHEBLOCK,
						TRAITBLOCK_SLOWDOWN,
						TRAITBLOCK_ENDURLOW,
						TRAITBLOCK_BRUTEWEAK_MINOR,
						TRAITBLOCK_REDUCEDCHEM,
						TRAITBLOCK_PAININTOL,
						TRAITBLOCK_CONDUCTIVE,
						TRAITBLOCK_HAEMOPHILIA,
						TRAITBLOCK_LIGHTWEIGHT,
						TRAITBLOCK_LIGHTSENSITIVE,
						VERTIGOBLOCK,
						TRAITBLOCK_ALLERGY_MEAT,
						TRAITBLOCK_ALLERGY_FISH,
						TRAITBLOCK_ALLERGY_POLLEN,
						TRAITBLOCK_ALLERGY_FRUIT,
						TRAITBLOCK_ALLERGY_VEGI,
						TRAITBLOCK_ALLERGY_NUTS,
						TRAITBLOCK_ALLERGY_SOY,
						TRAITBLOCK_ALLERGY_DAIRY,
						TRAITBLOCK_ALLERGY_FUNGI,
						TRAITBLOCK_ALLERGY_SALT,
						TRAITBLOCK_ALLERGY_COFFEE,
						TRAITBLOCK_SPICE_INTOL_BASIC,
						TRAITBLOCK_COLORBLIND_MONO,
						TRAITBLOCK_COLORBLIND_VULP,
						TRAITBLOCK_COLORBLIND_TAJ,
						TRAITBLOCK_HOT_BLOOD,
						TRAITBLOCK_COLD_BLOOD)
	M.dna.SetSEState(block, 1)

// Give Random Good Mutation to M
/proc/randmutg(var/mob/living/M)
	if(!M || !(M.dna)) return
	M.dna.check_integrity()
	//var/block = pick(HULKBLOCK,XRAYBLOCK,TELEBLOCK,NOBREATHBLOCK,REMOTEVIEWBLOCK,REGENERATEBLOCK,INCREASERUNBLOCK,REMOTETALKBLOCK,MORPHBLOCK,BLENDBLOCK,NOPRINTSBLOCK,SHOCKIMMUNITYBLOCK,SMALLSIZEBLOCK) // Much like above, most of these blocks are disabled in code.
	var/block = pick(	XRAYBLOCK,
						TELEBLOCK,
						LASERBLOCK,
						FARTBLOCK,
						REGENERATEBLOCK,
						TRAITBLOCK_SPEEDFAST,
						TRAITBLOCK_ENDURANCE,
						TRAITBLOCK_DARKSIGHT,
						TRAITBLOCK_BRUTERESIST_MINOR,
						TRAITBLOCK_ALCOHOL_TOLEX,
						TRAITBLOCK_PHOTORESIST,
						TRAITBLOCK_COLDADAPT,
						TRAITBLOCK_HOTADAPT,
						TRAITBLOCK_ALCOHOL_TOL_BASIC,
						TRAITBLOCK_EYEGLOW,
						TRAITBLOCK_TRASHCAN,
						TRAITBLOCK_GEMEATER,
						TRAITBLOCK_ENZYME)
	M.dna.SetSEState(block, 1)

// Random Appearance Mutation -> Is now just a random mutation
// outpost 21 edit - we don't mess with cosmetics anymore, as it breaks a lot. So we do a random SE mutation instead!
/proc/randmuti(var/mob/living/M)
	if(!M || !(M.dna)) return
	M.dna.check_integrity()
	M.dna.SetSEValue(rand(1,DNA_SE_LENGTH),rand(1,4095)) // M.dna.SetUIValue(rand(1,DNA_UI_LENGTH),rand(1,4095)) < old

// Scramble UI or SE.
/proc/scramble(var/UI, var/mob/M, var/prob)
	if(!M || !(M.dna))	return
	M.dna.check_integrity()
	if(UI)
		for(var/i = 1, i <= DNA_UI_LENGTH-1, i++)
			if(prob(prob))
				M.dna.SetUIValue(i,rand(1,4095),1)
		M.dna.UpdateUI()
		M.UpdateAppearance()
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			H.sync_organ_dna()
	else
		for(var/i = 1, i <= DNA_SE_LENGTH-1, i++)
			if(prob(prob))
				M.dna.SetSEValue(i,rand(1,4095),1)
		M.dna.UpdateSE()
		domutcheck(M, null)
	return

// I haven't yet figured out what the fuck this is supposed to do.
/proc/miniscramble(input,rs,rd)
	/* Willbird - my attempt at something more intersting and less goofy, but longtime players will likely prefer the original code.
	// these are based on the dna_modifier settings raw input
	// rs is 1 to 10
	// rd is 1 to 20
	var/hexval = hex2num(input)
	if(rd < rs)
		// if duration is less than power, orbit near center
		if(hexval > 8)
			hexval -= rand(rs,rs * 3)
		else
			hexval += rand(rs,rs * 3)
	else
		// if duration is greater than power, push away from center
		if(hexval > 8)
			hexval += rand(rs,rs * 2)
		else
			hexval -= rand(rs,rs * 2)

	// try to lock at far ends
	if(hexval < 0)
		hexval = 0
	if(hexval > 15)
		hexval = 15
	if(prob(rd))
		// teehee
		if(hexval == 0)
			hexval += rand(3)
		if(hexval == 15)
			hexval -= rand(3)
	*/
	var/output = null
	if (input == "C" || input == "D" || input == "E" || input == "F")
		output = pick(prob((rs*10));"4",prob((rs*10));"5",prob((rs*10));"6",prob((rs*10));"7",prob((rs*5)+(rd));"0",prob((rs*5)+(rd));"1",prob((rs*10)-(rd));"2",prob((rs*10)-(rd));"3")
	if (input == "8" || input == "9" || input == "A" || input == "B")
		output = pick(prob((rs*10));"4",prob((rs*10));"5",prob((rs*10));"A",prob((rs*10));"B",prob((rs*5)+(rd));"C",prob((rs*5)+(rd));"D",prob((rs*5)+(rd));"2",prob((rs*5)+(rd));"3")
	if (input == "4" || input == "5" || input == "6" || input == "7")
		output = pick(prob((rs*10));"4",prob((rs*10));"5",prob((rs*10));"A",prob((rs*10));"B",prob((rs*5)+(rd));"C",prob((rs*5)+(rd));"D",prob((rs*5)+(rd));"2",prob((rs*5)+(rd));"3")
	if (input == "0" || input == "1" || input == "2" || input == "3")
		output = pick(prob((rs*10));"8",prob((rs*10));"9",prob((rs*10));"A",prob((rs*10));"B",prob((rs*10)-(rd));"C",prob((rs*10)-(rd));"D",prob((rs*5)+(rd));"E",prob((rs*5)+(rd));"F")
	if (!output) output = "5"
	//var/output = num2hex(hexval,0)
	return output

// HELLO I MAKE BELL CURVES AROUND YOUR DESIRED TARGET
// So a shitty way of replacing gaussian noise.
// input: YOUR TARGET
// rs: RAD STRENGTH
// rd: DURATION
/proc/miniscrambletarget(input,rs,rd)
	var/output = null
	switch(input)
		if("0")
			output = pick(prob((rs*10)+(rd));"0",prob((rs*10)+(rd));"1",prob((rs*10));"2",prob((rs*10)-(rd));"3")
		if("1")
			output = pick(prob((rs*10)+(rd));"0",prob((rs*10)+(rd));"1",prob((rs*10)+(rd));"2",prob((rs*10));"3",prob((rs*10)-(rd));"4")
		if("2")
			output = pick(prob((rs*10));"0",prob((rs*10)+(rd));"1",prob((rs*10)+(rd));"2",prob((rs*10)+(rd));"3",prob((rs*10));"4",prob((rs*10)-(rd));"5")
		if("3")
			output = pick(prob((rs*10)-(rd));"0",prob((rs*10));"1",prob((rs*10)+(rd));"2",prob((rs*10)+(rd));"3",prob((rs*10)+(rd));"4",prob((rs*10));"5",prob((rs*10)-(rd));"6")
		if("4")
			output = pick(prob((rs*10)-(rd));"1",prob((rs*10));"2",prob((rs*10)+(rd));"3",prob((rs*10)+(rd));"4",prob((rs*10)+(rd));"5",prob((rs*10));"6",prob((rs*10)-(rd));"7")
		if("5")
			output = pick(prob((rs*10)-(rd));"2",prob((rs*10));"3",prob((rs*10)+(rd));"4",prob((rs*10)+(rd));"5",prob((rs*10)+(rd));"6",prob((rs*10));"7",prob((rs*10)-(rd));"8")
		if("6")
			output = pick(prob((rs*10)-(rd));"3",prob((rs*10));"4",prob((rs*10)+(rd));"5",prob((rs*10)+(rd));"6",prob((rs*10)+(rd));"7",prob((rs*10));"8",prob((rs*10)-(rd));"9")
		if("7")
			output = pick(prob((rs*10)-(rd));"4",prob((rs*10));"5",prob((rs*10)+(rd));"6",prob((rs*10)+(rd));"7",prob((rs*10)+(rd));"8",prob((rs*10));"9",prob((rs*10)-(rd));"A")
		if("8")
			output = pick(prob((rs*10)-(rd));"5",prob((rs*10));"6",prob((rs*10)+(rd));"7",prob((rs*10)+(rd));"8",prob((rs*10)+(rd));"9",prob((rs*10));"A",prob((rs*10)-(rd));"B")
		if("9")
			output = pick(prob((rs*10)-(rd));"6",prob((rs*10));"7",prob((rs*10)+(rd));"8",prob((rs*10)+(rd));"9",prob((rs*10)+(rd));"A",prob((rs*10));"B",prob((rs*10)-(rd));"C")
		if("10")//A
			output = pick(prob((rs*10)-(rd));"7",prob((rs*10));"8",prob((rs*10)+(rd));"9",prob((rs*10)+(rd));"A",prob((rs*10)+(rd));"B",prob((rs*10));"C",prob((rs*10)-(rd));"D")
		if("11")//B
			output = pick(prob((rs*10)-(rd));"8",prob((rs*10));"9",prob((rs*10)+(rd));"A",prob((rs*10)+(rd));"B",prob((rs*10)+(rd));"C",prob((rs*10));"D",prob((rs*10)-(rd));"E")
		if("12")//C
			output = pick(prob((rs*10)-(rd));"9",prob((rs*10));"A",prob((rs*10)+(rd));"B",prob((rs*10)+(rd));"C",prob((rs*10)+(rd));"D",prob((rs*10));"E",prob((rs*10)-(rd));"F")
		if("13")//D
			output = pick(prob((rs*10)-(rd));"A",prob((rs*10));"B",prob((rs*10)+(rd));"C",prob((rs*10)+(rd));"D",prob((rs*10)+(rd));"E",prob((rs*10));"F")
		if("14")//E
			output = pick(prob((rs*10)-(rd));"B",prob((rs*10));"C",prob((rs*10)+(rd));"D",prob((rs*10)+(rd));"E",prob((rs*10)+(rd));"F")
		if("15")//F
			output = pick(prob((rs*10)-(rd));"C",prob((rs*10));"D",prob((rs*10)+(rd));"E",prob((rs*10)+(rd));"F")

	if(!input || !output) //How did this happen?
		output = "8"

	return output

// /proc/updateappearance has changed behavior, so it's been removed
// Use mob.UpdateAppearance() instead.

// Simpler. Don't specify UI in order for the mob to use its own.
/mob/proc/UpdateAppearance(var/list/UI=null)
	if(ishuman(src))
		if(UI!=null)
			src.dna.UI=UI
			src.dna.UpdateUI()
		dna.check_integrity()
		var/mob/living/carbon/human/H = src
		H.r_hair   = dna.GetUIValueRange(DNA_UI_HAIR_R,    255)
		H.g_hair   = dna.GetUIValueRange(DNA_UI_HAIR_G,    255)
		H.b_hair   = dna.GetUIValueRange(DNA_UI_HAIR_B,    255)

		H.r_grad   = dna.GetUIValueRange(DNA_UI_HAIRGRAD_R,255)
		H.g_grad   = dna.GetUIValueRange(DNA_UI_HAIRGRAD_G,255)
		H.b_grad   = dna.GetUIValueRange(DNA_UI_HAIRGRAD_B,255)

		H.r_facial = dna.GetUIValueRange(DNA_UI_BEARD_R,   255)
		H.g_facial = dna.GetUIValueRange(DNA_UI_BEARD_G,   255)
		H.b_facial = dna.GetUIValueRange(DNA_UI_BEARD_B,   255)

		H.r_skin   = dna.GetUIValueRange(DNA_UI_SKIN_R,    255)
		H.g_skin   = dna.GetUIValueRange(DNA_UI_SKIN_G,    255)
		H.b_skin   = dna.GetUIValueRange(DNA_UI_SKIN_B,    255)

		H.r_eyes   = dna.GetUIValueRange(DNA_UI_EYES_R,    255)
		H.g_eyes   = dna.GetUIValueRange(DNA_UI_EYES_G,    255)
		H.b_eyes   = dna.GetUIValueRange(DNA_UI_EYES_B,    255)
		H.update_eyes()

		H.s_tone   = 35 - dna.GetUIValueRange(DNA_UI_SKIN_TONE, 220) // Value can be negative.

		if(H.gender != NEUTER)
			if (dna.GetUIState(DNA_UI_GENDER))
				H.gender = FEMALE
			else
				H.gender = MALE

		//Body markings
		for(var/tag in dna.body_markings)
			var/obj/item/organ/external/E = H.organs_by_name[tag]
			if(E)
				var/list/marklist = dna.body_markings[tag]
				E.markings = marklist.Copy()

		//Hair
		var/hair = dna.GetUIValueRange(DNA_UI_HAIR_STYLE,hair_styles_list.len)
		if((0 < hair) && (hair <= hair_styles_list.len))
			H.h_style = hair_styles_list[hair]

		//Hair gradiant
		var/hairgrad = dna.GetUIValueRange(DNA_UI_HAIRGRAD_STYLE,GLOB.hair_gradients.len)
		if((0 < hairgrad) && (hairgrad <= GLOB.hair_gradients.len))
			H.grad_style = GLOB.hair_gradients[hairgrad]

		//Facial Hair
		var/beard = dna.GetUIValueRange(DNA_UI_BEARD_STYLE,facial_hair_styles_list.len)
		if((0 < beard) && (beard <= facial_hair_styles_list.len))
			H.f_style = facial_hair_styles_list[beard]

		// VORE StationEdit Start

		// Ears
		var/ears = dna.GetUIValueRange(DNA_UI_EAR_STYLE, ear_styles_list.len + 1) - 1
		if(ears < 1)
			H.ear_style = null
		else if((0 < ears) && (ears <= ear_styles_list.len))
			H.ear_style = ear_styles_list[ear_styles_list[ears]]

		// Ear Color
		H.r_ears  = dna.GetUIValueRange(DNA_UI_EARS_R,    255)
		H.g_ears  = dna.GetUIValueRange(DNA_UI_EARS_G,    255)
		H.b_ears  = dna.GetUIValueRange(DNA_UI_EARS_B, 	  255)
		H.r_ears2 = dna.GetUIValueRange(DNA_UI_EARS2_R,   255)
		H.g_ears2 = dna.GetUIValueRange(DNA_UI_EARS2_G,   255)
		H.b_ears2 = dna.GetUIValueRange(DNA_UI_EARS2_B,	  255)
		H.r_ears3 = dna.GetUIValueRange(DNA_UI_EARS3_R,   255)
		H.g_ears3 = dna.GetUIValueRange(DNA_UI_EARS3_G,   255)
		H.b_ears3 = dna.GetUIValueRange(DNA_UI_EARS3_B,	  255)


		//Tail
		var/tail = dna.GetUIValueRange(DNA_UI_TAIL_STYLE, tail_styles_list.len + 1) - 1
		if(tail < 1)
			H.tail_style = null
		else if((0 < tail) && (tail <= tail_styles_list.len))
			H.tail_style = tail_styles_list[tail_styles_list[tail]]

		//Wing
		var/wing = dna.GetUIValueRange(DNA_UI_WING_STYLE, wing_styles_list.len + 1) - 1
		if(wing < 1)
			H.wing_style = null
		else if((0 < wing) && (wing <= wing_styles_list.len))
			H.wing_style = wing_styles_list[wing_styles_list[wing]]

		//Wing Color
		H.r_wing   = dna.GetUIValueRange(DNA_UI_WING_R,    255)
		H.g_wing   = dna.GetUIValueRange(DNA_UI_WING_G,    255)
		H.b_wing   = dna.GetUIValueRange(DNA_UI_WING_B,    255)
		H.r_wing2  = dna.GetUIValueRange(DNA_UI_WING2_R,    255)
		H.g_wing2  = dna.GetUIValueRange(DNA_UI_WING2_G,    255)
		H.b_wing2  = dna.GetUIValueRange(DNA_UI_WING2_B,    255)
		H.r_wing3  = dna.GetUIValueRange(DNA_UI_WING3_R,    255)
		H.g_wing3  = dna.GetUIValueRange(DNA_UI_WING3_G,    255)
		H.b_wing3  = dna.GetUIValueRange(DNA_UI_WING3_B,    255)

		// Playerscale
		var/size = dna.GetUIValueRange(DNA_UI_PLAYERSCALE, RESIZE_MAXIMUM * 100)
		H.resize( size / 100, TRUE, ignore_prefs = TRUE)

		// Tail/Taur Color
		H.r_tail   = dna.GetUIValueRange(DNA_UI_TAIL_R,    255)
		H.g_tail   = dna.GetUIValueRange(DNA_UI_TAIL_G,    255)
		H.b_tail   = dna.GetUIValueRange(DNA_UI_TAIL_B,    255)
		H.r_tail2  = dna.GetUIValueRange(DNA_UI_TAIL2_R,   255)
		H.g_tail2  = dna.GetUIValueRange(DNA_UI_TAIL2_G,   255)
		H.b_tail2  = dna.GetUIValueRange(DNA_UI_TAIL2_B,   255)
		H.r_tail3  = dna.GetUIValueRange(DNA_UI_TAIL3_R,   255)
		H.g_tail3  = dna.GetUIValueRange(DNA_UI_TAIL3_G,   255)
		H.b_tail3  = dna.GetUIValueRange(DNA_UI_TAIL3_B,   255)

		return 1
	else
		return 0


/mob/proc/ApplySpeciesAndTraits(var/geneflags = 0)
	// this is often called near UpdateAppearance()
	// Updates species and trait controlled data, lots of genes use this for initalizing!
	if(ishuman(src))
		var/mob/living/carbon/human/H = src

		// Technically custom_species is not part of the UI, but this place avoids merge problems.
		H.custom_species = dna.custom_species
		H.custom_say = dna.custom_say
		H.custom_ask = dna.custom_ask
		H.custom_whisper = dna.custom_whisper
		H.custom_exclaim = dna.custom_exclaim
		H.species.blood_color = dna.blood_color
		var/datum/species/S = H.species
		S.produceCopy(dna.species_traits, H, dna.base_species, FALSE, geneflags)
		H.force_update_organs() //VOREStation Add - Gotta do this too
		H.force_update_limbs()
		//H.update_body(0) //VOREStation Edit - Done in force_update_limbs already
		H.update_eyes()
		H.update_hair()

//VOREStation Add
/mob/living/carbon/human/proc/force_update_organs()
	for(var/obj/item/organ/O as anything in organs + internal_organs)
		O.species = species
	species.post_spawn_special(src)
//VOREStation Add End

// Used below, simple injection modifier.
/proc/probinj(var/pr, var/inj)
	return prob(pr+inj*pr)
