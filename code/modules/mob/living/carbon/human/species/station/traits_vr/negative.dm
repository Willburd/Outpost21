/datum/trait/negative
	category = TRAIT_TYPE_NEGATIVE

/datum/trait/negative/speed_slow
	name = "Slowdown"
	desc = "Allows you to move slower on average than baseline."
	cost = -3 //YW EDIT
	var_changes = list("slowdown" = 0.5)
/datum/dna/gene/trait_linked/speed_slow/New() // Genetically linked trait
	block = TRAITBLOCK_SLOWDOWN
	activation_messages=list("You feel slower.")
	deactivation_messages=list("You get a bit faster.")
	linked_trait_path = /datum/trait/negative/speed_slow
	. = ..()


/datum/trait/negative/speed_slow_plus
	name = "Slowdown, Major"
	desc = "Allows you to move MUCH slower on average than baseline."
	cost = -5 //YW EDIT
	var_changes = list("slowdown" = 1.0)
/datum/dna/gene/trait_linked/speed_slow_plus/New() // Genetically linked trait
	block = TRAITBLOCK_SLOWDOWNEX
	activation_messages=list("You feel a lot slower.")
	deactivation_messages=list("You get a bit faster.")
	linked_trait_path = /datum/trait/negative/speed_slow_plus
	. = ..()


/datum/trait/negative/weakling
	name = "Weakling"
	desc = "Causes heavy equipment to slow you down more when carried."
	cost = -1
	var_changes = list("item_slowdown_mod" = 1.5)
/datum/dna/gene/trait_linked/weakling/New() // Genetically linked trait
	block = TRAITBLOCK_WEAK
	activation_messages=list("You feel weaker.")
	deactivation_messages=list("You get a bit stronger.")
	linked_trait_path = /datum/trait/negative/weakling
	. = ..()


/datum/trait/negative/weakling_plus
	name = "Weakling, Major"
	desc = "Allows you to carry heavy equipment with much more slowdown."
	cost = -2
	var_changes = list("item_slowdown_mod" = 2.0)
/datum/dna/gene/trait_linked/weakling_plus/New() // Genetically linked trait
	block = TRAITBLOCK_WEAKEX
	activation_messages=list("You feel a lot weaker.")
	deactivation_messages=list("You get a bit stronger.")
	linked_trait_path = /datum/trait/negative/weakling_plus
	. = ..()


/datum/trait/negative/endurance_low
	name = "Low Endurance"
	desc = "Reduces your maximum total hitpoints to 75."
	cost = -2
	var_changes = list("total_health" = 75)
/datum/dna/gene/trait_linked/endurance_low/New() // Genetically linked trait
	block = TRAITBLOCK_ENDURLOW
	activation_messages=list("You feel more frail.")
	deactivation_messages=list("You feel a bit less frail.")
	linked_trait_path = /datum/trait/negative/endurance_low
	. = ..()

/datum/trait/negative/endurance_low/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(S.total_health)

/datum/trait/negative/endurance_low/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(initial(S.total_health))


/datum/trait/negative/endurance_very_low
	name = "Low Endurance, Major"
	desc = "Reduces your maximum total hitpoints to 50."
	cost = -3 //Teshari HP. This makes the person a lot more suseptable to getting stunned, killed, etc.
	var_changes = list("total_health" = 50)
/datum/dna/gene/trait_linked/endurance_very_low/New() // Genetically linked trait
	block = TRAITBLOCK_ENDURLOWEX
	activation_messages=list("You feel a lot more frail.")
	deactivation_messages=list("You feel a bit less frail.")
	linked_trait_path = /datum/trait/negative/endurance_very_low
	. = ..()

/datum/trait/negative/endurance_very_low/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(S.total_health)

/datum/trait/negative/endurance_very_low/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(initial(S.total_health))


//YW ADDITIONS: START
/datum/trait/negative/endurance_glass
	name = "Endurance, Glass"
	desc = "Your body is very fragile. Reduces your maximum hitpoints to 25. Beware sneezes."
	cost = -4
	var_changes = list("total_health" = 25)
/datum/dna/gene/trait_linked/endurance_glass/New() // Genetically linked trait
	block = TRAITBLOCK_ENDURLOWEST
	activation_messages=list("You feel like a breeze could break your bones.")
	deactivation_messages=list("You feel a lot less frail.")
	linked_trait_path = /datum/trait/negative/endurance_glass
	. = ..()

/datum/trait/negative/endurance_glass/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(S.total_health)

/datum/trait/negative/endurance_glass/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(initial(S.total_health))


//YW ADDITIONS: END

/datum/trait/negative/minor_brute_weak
	name = "Brute Weakness, Minor"
	desc = "Increases damage from brute damage sources by 10%" //YW EDIT
	cost = -1
	var_changes = list("brute_mod" = 1.1) //YW EDIT
/datum/dna/gene/trait_linked/minor_brute_weak/New() // Genetically linked trait
	block = TRAITBLOCK_BRUTEWEAK_MINOR
	activation_messages=list("Everything feels a little more dangerous.")
	deactivation_messages=list("You feel less vulnerable.")
	linked_trait_path = /datum/trait/negative/minor_brute_weak
	. = ..()


/datum/trait/negative/brute_weak
	name = "Brute Weakness"
	desc = "Increases damage from brute damage sources by 20%" //YW EDIT
	cost = -2
	var_changes = list("brute_mod" = 1.2) //YW EDIT
/datum/dna/gene/trait_linked/brute_weak/New() // Genetically linked trait
	block = TRAITBLOCK_BRUTEWEAK
	activation_messages=list("Everything feels more dangerous.")
	deactivation_messages=list("You feel less vulnerable.")
	linked_trait_path = /datum/trait/negative/brute_weak
	. = ..()


/datum/trait/negative/brute_weak_plus
	name = "Brute Weakness, Major"
	desc = "Increases damage from brute damage sources by 40%" //YW EDIT
	cost = -3
	var_changes = list("brute_mod" = 1.4) //YW EDIT
/datum/dna/gene/trait_linked/brute_weak_plus/New() // Genetically linked trait
	block = TRAITBLOCK_BRUTEWEAK_MAJOR
	activation_messages=list("Everything feels a lot more dangerous.")
	deactivation_messages=list("You feel less vulnerable.")
	linked_trait_path = /datum/trait/negative/brute_weak_plus
	. = ..()


/datum/trait/negative/minor_burn_weak
	name = "Burn Weakness, Minor"
	desc = "Increases damage from burn damage sources by 10%" //YW EDIT
	cost = -1
	var_changes = list("burn_mod" = 1.1) //YW EDIT
/datum/dna/gene/trait_linked/minor_burn_weak/New() // Genetically linked trait
	block = TRAITBLOCK_BURNWEAK_MINOR
	activation_messages=list("You feel a little more flammable.")
	deactivation_messages=list("You feel less flammable.")
	linked_trait_path = /datum/trait/negative/minor_burn_weak
	. = ..()


/datum/trait/negative/burn_weak
	name = "Burn Weakness"
	desc = "Increases damage from burn damage sources by 20%" //YW EDIT
	cost = -2
	var_changes = list("burn_mod" = 1.2) //YW EDIT
/datum/dna/gene/trait_linked/burn_weak/New() // Genetically linked trait
	block = TRAITBLOCK_BURNWEAK
	activation_messages=list("You feel more flammable.")
	deactivation_messages=list("You feel less flammable.")
	linked_trait_path = /datum/trait/negative/burn_weak
	. = ..()


/datum/trait/negative/burn_weak_plus
	name = "Burn Weakness, Major"
	desc = "Increases damage from burn damage sources by 40%" //YW EDIT
	cost = -3
	var_changes = list("burn_mod" = 1.4) //YW EDIT
/datum/dna/gene/trait_linked/burn_weak_plus/New() // Genetically linked trait
	block = TRAITBLOCK_BURNWEAK_MAJOR
	activation_messages=list("You feel a lot more flammable.")
	deactivation_messages=list("You feel less flammable.")
	linked_trait_path = /datum/trait/negative/burn_weak_plus
	. = ..()


//YW ADDITIONS: START
/datum/trait/negative/reduced_biocompat
	name = "Biocompatibility, Reduced "
	desc = "For whatever reason, you're one of the unlucky few who don't get as much benefit from modern-day chemicals. Remember to note this down in your medical records!"
	cost = -1
	var_changes = list("chem_strength_heal" = 0.8)
/datum/dna/gene/trait_linked/reduced_biocompat/New() // Genetically linked trait
	block = TRAITBLOCK_REDUCEDCHEM
	activation_messages=list("You feel your body slowing down.")
	deactivation_messages=list("You feel your body speeding up.")
	linked_trait_path = /datum/trait/negative/reduced_biocompat
	. = ..()


/datum/trait/negative/sensitive_biochem
	name = "Biochemistry, Sensitive "
	desc = "Your biochemistry is a little delicate, rendering you more susceptible to both deadly toxins and the more subtle ones. You'll probably want to list this in your medical records, and perhaps in your exploitable info as well."
	cost = -1
	var_changes = list("chem_strength_tox" = 1.25)
/datum/dna/gene/trait_linked/sensitive_biochem/New() // Genetically linked trait
	block = TRAITBLOCK_RAISEDCHEM
	activation_messages=list("You feel a little uneasy.")
	deactivation_messages=list("You feel less uneasy.")
	linked_trait_path = /datum/trait/negative/sensitive_biochem
	. = ..()


/datum/trait/negative/alcohol_intolerance_advanced
	name = "Liver of Air"
	desc = "The only way you can hold a drink is if it's in your own two hands, and even then you'd best not inhale too deeply near it. Drinks hit thrice as hard. You may wish to note this down in your medical records, and perhaps your exploitable info as well."
	cost = -1
	var_changes = list("alcohol_mod" = 3)
/datum/dna/gene/trait_linked/alcohol_intolerance_advanced/New() // Genetically linked trait
	block = TRAITBLOCK_AIRLIVER
	activation_messages=list("You feel like a glass of water could make you tipsy.")
	deactivation_messages=list("You feel like less of a lightweight.")
	linked_trait_path = /datum/trait/negative/alcohol_intolerance_advanced
	. = ..()


/datum/trait/negative/pain_intolerance_basic
	name = "Pain Intolerant"
	desc = "You are frail and sensitive to pain. You experience 25% more pain from all sources."
	cost = -1
	var_changes = list("pain_mod" = 1.25)
/datum/dna/gene/trait_linked/pain_intolerance_basic/New() // Genetically linked trait
	block = TRAITBLOCK_PAININTOL
	activation_messages=list("Everything feels more sensitive.")
	deactivation_messages=list("You feel less sensitive.")
	linked_trait_path = /datum/trait/negative/pain_intolerance_basic
	. = ..()

/datum/trait/negative/pain_intolerance_advanced
	name = "Pain Intolerance, High "
	desc = "You are highly sensitive to all sources of pain, and experience 50% more pain."
	cost = -2
	var_changes = list("pain_mod" = 1.5) //this makes you extremely vulnerable to most sources of pain, a stunbaton bop or shotgun beanbag will do around 90 agony, almost enough to drop you in one hit
/datum/dna/gene/trait_linked/pain_intolerance_advanced/New() // Genetically linked trait
	block = TRAITBLOCK_PAININTOLEX
	activation_messages=list("Everything feels a lot more sensitive.")
	deactivation_messages=list("You feel less sensitive.")
	linked_trait_path = /datum/trait/negative/pain_intolerance_advanced
	. = ..()
//YW ADDITIONS: END

/datum/trait/negative/conductive
	name = "Conductive"
	desc = "Increases your susceptibility to electric shocks by 25%" //YW EDIT
	cost = -2 //YW EDIT
	var_changes = list("siemens_coefficient" = 1.25) //This makes you a lot weaker to tasers. :YW EDIT
/datum/dna/gene/trait_linked/conductive/New() // Genetically linked trait
	block = TRAITBLOCK_CONDUCTIVE
	activation_messages=list("You can feel a tingle in the air.")
	deactivation_messages=list("You a little more resistant.")
	linked_trait_path = /datum/trait/negative/conductive
	. = ..()

/datum/trait/negative/conductive_plus
	name = "Conductive, Major"
	desc = "Increases your susceptibility to electric shocks by 50%" //YW EDIT
	cost = -3 //YW EDIT
	var_changes = list("siemens_coefficient" = 1.5) //This makes you significantly weaker to tasers. //YW EDIT
	varchange_type = TRAIT_VARCHANGE_LESS_BETTER
/datum/dna/gene/trait_linked/conductive_plus/New() // Genetically linked trait
	block = TRAITBLOCK_CONDUCTIVE_MAJOR
	activation_messages=list("You can feel the static in the air.")
	deactivation_messages=list("You a little more resistant.")
	linked_trait_path = /datum/trait/negative/conductive_plus
	. = ..()

//YW ADDITIONS: START
/datum/trait/negative/conductive_extreme
	name = "Conductive, Extremely"
	desc = "Increases your susceptibility to electric shocks by 100%"
	cost = -4
	var_changes = list("siemens_coefficient" = 2.0) //This makes you extremely weak to tasers.
/datum/dna/gene/trait_linked/conductive_extreme/New() // Genetically linked trait
	block = TRAITBLOCK_CONDUCTIVE_EXTREME
	activation_messages=list("You can feel the current in the wires nearby.")
	deactivation_messages=list("You a little more resistant.")
	linked_trait_path = /datum/trait/negative/conductive_extreme
	. = ..()
//YW ADDITIONS: END


/datum/trait/negative/haemophilia
	name = "Haemophilia - Organics only"
	desc = "When you bleed, you bleed a LOT."
	cost = -3 //YW EDIT
	var_changes = list("bloodloss_rate" = 2)
	can_take = ORGANICS
	varchange_type = TRAIT_VARCHANGE_LESS_BETTER
/datum/dna/gene/trait_linked/haemophilia/New() // Genetically linked trait
	block = TRAITBLOCK_HAEMOPHILIA
	linked_trait_path = /datum/trait/negative/haemophilia
	. = ..()


/datum/trait/negative/hollow
	name = "Hollow Bones/Aluminum Alloy"
	desc = "Your bones and robot limbs are much easier to break."
	cost = -3 // increased due to medical intervention needed. :YW EDIT
/datum/dna/gene/trait_linked/hollow/New() // Genetically linked trait
	block = TRAITBLOCK_HOLLOW
	activation_messages=list("You feel like you're made of glass.")
	deactivation_messages=list("You feel less fragile.")
	linked_trait_path = /datum/trait/negative/hollow
	. = ..()

/datum/trait/negative/hollow/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	for(var/obj/item/organ/external/O in H.organs)
		O.min_broken_damage *= 0.5
		O.min_bruised_damage *= 0.5

/datum/trait/negative/hollow/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	for(var/obj/item/organ/external/O in H.organs)
		O.min_broken_damage = initial(O.min_broken_damage)
		O.min_bruised_damage = initial(O.min_bruised_damage)


/datum/trait/negative/lightweight
	name = "Lightweight"
	desc = "Your light weight and poor balance make you very susceptible to unhelpful bumping. Think of it like a bowling ball versus a pin."
	cost = -2
	var_changes = list("lightweight" = 1)
/datum/dna/gene/trait_linked/lightweight/New() // Genetically linked trait
	block = TRAITBLOCK_LIGHTWEIGHT
	activation_messages=list("The world feels like it's trying to push you over.")
	deactivation_messages=list("Everything feels less overwhelming.")
	linked_trait_path = /datum/trait/negative/lightweight
	. = ..()


/datum/trait/negative/neural_hypersensitivity
	name = "Neural Hypersensitivity"
	desc = "Your nerves are particularly sensitive to physical changes, leading to experiencing twice the intensity of pain and pleasure alike. Makes all pain effects twice as strong, and occur at half as much damage."
	cost = -1
	var_changes = list("trauma_mod" = 2)
/datum/dna/gene/trait_linked/neural_hypersensitivity/New() // Genetically linked trait
	block = TRAITBLOCK_HYPERSENSITIVE
	activation_messages=list("Everything feels more intense.")
	deactivation_messages=list("Everything feels less intense.")
	linked_trait_path = /datum/trait/negative/neural_hypersensitivity
	. = ..()


/datum/trait/negative/breathes
	cost = -2
	can_take = ORGANICS


/datum/trait/negative/breathes/phoron
	name = "Phoron Breather"
	desc = "You breathe phoron instead of oxygen (which is poisonous to you), much like a Vox."
	var_changes = list("breath_type" = "phoron", "poison_type" = "oxygen", "ideal_air_type" = /datum/gas_mixture/belly_air/vox)
/datum/dna/gene/trait_linked/breathes/phoron/New() // Genetically linked trait
	block = TRAITBLOCK_BREATH_PHORON
	activation_messages=list("The air hurts to breath, your body craves phoron!")
	deactivation_messages=list("It no longer hurts to breath.")
	linked_trait_path = /datum/trait/negative/breathes/phoron
	. = ..()


/datum/trait/negative/breathes/nitrogen
	name = "Nitrogen Breather"
	desc = "You breathe nitrogen instead of oxygen (which is poisonous to you). Incidentally, phoron isn't poisonous to breathe to you."
	var_changes = list("breath_type" = "nitrogen", "poison_type" = "oxygen", "ideal_air_type" = /datum/gas_mixture/belly_air/nitrogen_breather)
/datum/dna/gene/trait_linked/breathes/nitrogen/New() // Genetically linked trait
	block = TRAITBLOCK_BREATH_NITROGEN
	activation_messages=list("The air hurts to breath, your body craves nitrogen!")
	deactivation_messages=list("It no longer hurts to breath.")
	linked_trait_path = /datum/trait/negative/breathes/nitrogen
	. = ..()


/datum/trait/negative/breathes/carbon
	name = "Carbon Dioxide Breather"
	desc = "You breathe carbon dioxide instead of oxygen (which is poisonous to you). Incidentally, phoron isn't poisonous to breathe to you."
	var_changes = list("breath_type" = "carbon_dioxide", "exhale_type" = null, "poison_type" = "oxygen", "ideal_air_type" = /datum/gas_mixture/belly_air/carbon_breather)
/datum/dna/gene/trait_linked/breathes/carbon/New() // Genetically linked trait
	block = TRAITBLOCK_BREATH_CARBON
	activation_messages=list("The air hurts to breath, your body craves carbon dioxide!")
	deactivation_messages=list("It no longer hurts to breath.")
	linked_trait_path = /datum/trait/negative/breathes/carbon
	. = ..()


/datum/trait/negative/monolingual
	name = "Monolingual"
	desc = "You are not good at learning languages."
	cost = -1
	var_changes = list("num_alternate_languages" = 0)
	var_changes_pref = list("extra_languages" = -3)
	varchange_type = TRAIT_VARCHANGE_MORE_BETTER


/datum/trait/negative/dark_blind
	name = "Nyctalopia"
	desc = "You cannot see in dark at all."
	cost = -1
	var_changes = list("darksight" = 0)
	varchange_type = TRAIT_VARCHANGE_MORE_BETTER
/datum/dna/gene/trait_linked/dark_blind/New() // Genetically linked trait
	block = TRAITBLOCK_DARKBLIND
	activation_messages=list("The darkness is blinding.")
	deactivation_messages=list("You can see in the dark again.")
	linked_trait_path = /datum/trait/negative/dark_blind
	. = ..()


/datum/trait/negative/bad_shooter
	name = "Bad Shot"
	desc = "You are terrible at aiming."
	cost = -1
	var_changes = list("gun_accuracy_mod" = -35)
	varchange_type = TRAIT_VARCHANGE_MORE_BETTER


//YW ADDITIONS: START
/datum/trait/negative/light_sensitivity
	name = "Photosensitivity"
	desc = "You have trouble dealing with sudden flashes of light, taking some time for you to recover. The effects of flashes from cameras and security equipment leaves you stunned for some time."
	cost = -1
	var_changes = list("flash_mod" = 1.5)
/datum/dna/gene/trait_linked/light_sensitivity/New() // Genetically linked trait
	block = TRAITBLOCK_LIGHTSENSITIVE
	activation_messages=list("The world feels more bright.")
	deactivation_messages=list("The world feels less bright.")
	linked_trait_path = /datum/trait/negative/light_sensitivity
	. = ..()


/datum/trait/negative/light_sensitivity_plus
	name = "Photosensitivity Extreme"
	desc = "You have trouble dealing with sudden flashes of light, taking quite a long time for you to be able to recover. The effects of flashes from cameras and security equipment leave you stunned for some time."
	cost = -2
	var_changes = list("flash_mod" = 2.0)
/datum/dna/gene/trait_linked/light_sensitivity_plus/New() // Genetically linked trait
	block = TRAITBLOCK_LIGHTSENSITIVEEX
	activation_messages=list("The world feels way too bright.")
	deactivation_messages=list("The world feels less bright.")
	linked_trait_path = /datum/trait/negative/light_sensitivity_plus
	. = ..()
//YW ADDITIONS: END


// outpost 21 additions begin
/datum/trait/negative/wingdings
	name = "Speak Only Wingdings"
	desc = "!?#X!"
	cost = -2
	var_changes = list("wingdings" = 1)
/datum/dna/gene/trait_linked/wingdings/New() // Genetically linked trait
	block = TRAITBLOCK_WINGDINGS
	activation_messages=list("You feel like your !?#X! is #X!???")
	deactivation_messages=list("You feel a lot less dingy wingy.")
	linked_trait_path = /datum/trait/negative/wingdings
	. = ..()


/datum/trait/negative/deteriorate
	name = "Genetic Degradation"
	desc = "You've lost the genetic lottery. Infact you've gone completely bankrupt, and now the universe is trying to foreclose on you. Your body is slowly deteriorating."
	cost = -3
/datum/dna/gene/trait_linked/deteriorate/New() // Genetically linked trait
	block = TRAITBLOCK_DETERIORATE
	activation_messages=list("You feel like you aren't long for this world.")
	deactivation_messages=list("Your body stops rejecting existance.")
	linked_trait_path = /datum/trait/negative/deteriorate
	. = ..()
// outpost 21 additions end
