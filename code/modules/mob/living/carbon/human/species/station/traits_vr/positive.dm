/datum/trait/positive
	category = TRAIT_TYPE_POSITIVE

/datum/trait/positive/speed_fast
	name = "Haste"
	desc = "Allows you to move faster on average than baseline."
	cost = 3 //YW EDIT
	var_changes = list("slowdown" = -0.5)
/datum/dna/gene/trait_linked/speed_fast/New() // Genetically linked trait
	block = TRAITBLOCK_SPEEDFAST
	activation_messages=list("You feel faster.")
	deactivation_messages=list("You feel less quick.")
	primitive_expression_messages=list("dances around.")
	linked_trait_path = /datum/trait/positive/speed_fast
	. = ..()


//YW ADDITION: START
/datum/trait/positive/speed_fast_plus
	name = "Haste, Major "
	desc = "Allows you to move MUCH faster on average than baseline."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 5
	var_changes = list("slowdown" = -1.0)
/datum/dna/gene/trait_linked/speed_fast_plus/New() // Genetically linked trait
	block = TRAITBLOCK_SPEEDFASTEX
	activation_messages=list("You feel a lot faster.")
	deactivation_messages=list("You feel less quick.")
	primitive_expression_messages=list("moves like a blur.")
	linked_trait_path = /datum/trait/positive/speed_fast_plus
	. = ..()
//YW ADDITION: END


/datum/trait/positive/hardy
	name = "Hardy"
	desc = "Allows you to carry heavy equipment with less slowdown."
	cost = 1
	var_changes = list("item_slowdown_mod" = 0.5)
/datum/dna/gene/trait_linked/hardy/New() // Genetically linked trait
	block = TRAITBLOCK_HARDY
	activation_messages=list("You feel hardy.")
	deactivation_messages=list("You feel less hardy.")
	linked_trait_path = /datum/trait/positive/hardy
	. = ..()


/datum/trait/positive/hardy_plus
	name = "Hardy, Major"
	desc = "Allows you to carry heavy equipment with almost no slowdown."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 2
	var_changes = list("item_slowdown_mod" = 0.25)
/datum/dna/gene/trait_linked/hardy_plus/New() // Genetically linked trait
	block = TRAITBLOCK_HARDYEX
	activation_messages=list("You feel a lot more hardy.")
	deactivation_messages=list("You feel less hardy.")
	linked_trait_path = /datum/trait/positive/hardy_plus
	. = ..()


/datum/trait/positive/endurance_high
	name = "High Endurance"
	desc = "Increases your maximum total hitpoints to 125"
	cost = 2 //YW EDIT
	var_changes = list("total_health" = 125)
/datum/dna/gene/trait_linked/endurance_high/New() // Genetically linked trait
	block = TRAITBLOCK_ENDURANCE
	activation_messages=list("You feel sturdier.")
	deactivation_messages=list("You feel less sturdy.")
	primitive_expression_messages=list("wiggles around.")
	linked_trait_path = /datum/trait/positive/endurance_high
	. = ..()

/datum/trait/positive/endurance_high/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(S.total_health)

/datum/trait/positive/endurance_high/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(initial(S.total_health))


//YW ADDITION: START
/datum/trait/positive/endurance_very_high
	name = "Endurance, Very High "
	desc = "Increases your maximum total hitpoints to 150"
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 3
	var_changes = list("total_health" = 150)
/datum/dna/gene/trait_linked/endurance_very_high/New() // Genetically linked trait
	block = TRAITBLOCK_ENDURANCE_MAJOR
	activation_messages=list("You feel a lot more sturdy.")
	deactivation_messages=list("You feel less sturdy.")
	primitive_expression_messages=list("wiggles around a bunch.")
	linked_trait_path = /datum/trait/positive/endurance_very_high
	. = ..()

/datum/trait/positive/endurance_very_high/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(S.total_health)

/datum/trait/positive/endurance_very_high/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(initial(S.total_health))


/datum/trait/positive/endurance_extremely_high
	name = "High Endurance, Extremely"
	desc = "Increases your maximum total hitpoints to 175"
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 4
	var_changes = list("total_health" = 175)
/datum/dna/gene/trait_linked/endurance_extremely_high/New() // Genetically linked trait
	block = TRAITBLOCK_ENDURANCEEX
	activation_messages=list("You feel indestructable.")
	deactivation_messages=list("You don't feel indestructable anymore.")
	primitive_expression_messages=list("wiggles around excitedly.")
	linked_trait_path = /datum/trait/positive/endurance_extremely_high
	. = ..()

/datum/trait/positive/endurance_extremely_high/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(S.total_health)

/datum/trait/positive/endurance_extremely_high/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.setMaxHealth(initial(S.total_health))
//YW ADDITION: END


/datum/trait/positive/nonconductive
	name = "Non-Conductive"
	desc = "Decreases your susceptibility to electric shocks by 25%." //YW EDIT
	cost = 2 //This effects tasers! :YW EDIT
	var_changes = list("siemens_coefficient" = 0.75) //YW EDIT
/datum/dna/gene/trait_linked/nonconductive/New() // Genetically linked trait
	block = TRAITBLOCK_NONCONDUCT
	activation_messages=list("You feel a little more rubbery.")
	deactivation_messages=list("You feel less rubbery.")
	primitive_expression_messages=list("looks a little shiny.")
	linked_trait_path = /datum/trait/positive/nonconductive
	. = ..()

/datum/trait/positive/nonconductive_plus
	name = "Non-Conductive, Major"
	desc = "Decreases your susceptibility to electric shocks by 50%." //YW EDIT
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 3 //Let us not forget this effects tasers! :YW EDIT
	var_changes = list("siemens_coefficient" = 0.5) //YW EDIT
/datum/dna/gene/trait_linked/nonconductive_plus/New() // Genetically linked trait
	block = TRAITBLOCK_NONCONDUCT_MAJOR
	activation_messages=list("You feel more rubbery.")
	deactivation_messages=list("You feel less rubbery.")
	primitive_expression_messages=list("looks shiny.")
	linked_trait_path = /datum/trait/positive/nonconductive_plus
	. = ..()

//YW ADDITION: START
/datum/trait/positive/nonconductive_robust
	name = "Non-Conductive, Robustly"
	desc = "Decreases your susceptibility to electric shocks by 75%."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 4 //Let us not forget this effects tasers!
	var_changes = list("siemens_coefficient" = 0.25)
/datum/dna/gene/trait_linked/nonconductive_robust/New() // Genetically linked trait
	block = TRAITBLOCK_NONCONDUCTEX
	activation_messages=list("You feel a lot more rubbery.")
	deactivation_messages=list("You feel less rubbery.")
	primitive_expression_messages=list("looks very shiny.")
	linked_trait_path = /datum/trait/positive/nonconductive_robust
	. = ..()
//YW ADDITION: END

/datum/trait/positive/darksight
	name = "Darksight"
	desc = "Allows you to see a short distance in the dark, but causes sensitivity to sudden flashes of light."
	cost = 1
	var_changes = list("darksight" = 5, "flash_mod" = 1.1)
/datum/dna/gene/trait_linked/darksight/New() // Genetically linked trait
	block = TRAITBLOCK_DARKSIGHT
	activation_messages=list("The darkness fades away.")
	deactivation_messages=list("The darkness returns.")
	primitive_expression_messages=list("squints at the light.")
	linked_trait_path = /datum/trait/positive/darksight
	. = ..()


/datum/trait/positive/darksight_plus
	name = "Darksight, Major"
	desc = "Allows you to see in the dark for the whole screen, but causes sensitivity to sudden flashes of light."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 2
	var_changes = list("darksight" = 8, "flash_mod" = 1.2)
/datum/dna/gene/trait_linked/darksight_plus/New() // Genetically linked trait
	block = TRAITBLOCK_DARKSIGHTEX
	activation_messages=list("The darkness vanishes.")
	deactivation_messages=list("The darkness returns.")
	primitive_expression_messages=list("looks blinded by the light.")
	linked_trait_path = /datum/trait/positive/darksight_plus
	. = ..()


/datum/trait/positive/melee_attack
	name = "Special Attack: Sharp Melee" // Trait Organization for easier browsing. TODO: Proper categorization of 'health/ability/resist/etc'
	desc = "Provides sharp melee attacks that do slightly more damage."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 1
	var_changes = list("unarmed_types" = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp))


/datum/trait/positive/melee_attack_fangs
	name = "Special Attack: Sharp Melee & Numbing Fangs" // Trait Organization for easier browsing. TODO: Proper categorization of 'health/ability/resist/etc'
	desc = "Provides sharp melee attacks that do slightly more damage, along with fangs that makes the person bit unable to feel their body or pain."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 2
	var_changes = list("unarmed_types" = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/claws, /datum/unarmed_attack/bite/sharp, /datum/unarmed_attack/bite/sharp/numbing))


/datum/trait/positive/fangs
	name = "Special Attack: Numbing Fangs" // Trait Organization for easier browsing. TODO: Proper categorization of 'health/ability/resist/etc'
	desc = "Provides fangs that makes the person bit unable to feel their body or pain."
	cost = 1
	var_changes = list("unarmed_types" = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick, /datum/unarmed_attack/punch, /datum/unarmed_attack/bite/sharp/numbing))


/datum/trait/positive/minor_brute_resist
	name = "Brute Resist, Minor"
	desc = "Adds 10% resistance to brute damage sources." //YW EDIT
	cost = 1 //YW EDIT
	var_changes = list("brute_mod" = 0.9) //YW EDIT
/datum/dna/gene/trait_linked/minor_brute_resist/New() // Genetically linked trait
	block = TRAITBLOCK_BRUTERESIST_MINOR
	activation_messages=list("You feel a little more durable.")
	deactivation_messages=list("You feel less durable.")
	linked_trait_path = /datum/trait/positive/minor_brute_resist
	. = ..()


/datum/trait/positive/brute_resist
	name = "Brute Resist"
	desc = "Adds 20% resistance to brute damage sources." //YW EDIT
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 2 //YW EDIT
	var_changes = list("brute_mod" = 0.8)
/datum/dna/gene/trait_linked/brute_resist/New() // Genetically linked trait
	block = TRAITBLOCK_BRUTERESIST
	activation_messages=list("You feel more durable.")
	deactivation_messages=list("You feel less durable.")
	linked_trait_path = /datum/trait/positive/brute_resist
	. = ..()


//YW ADDITION: START
/datum/trait/positive/brute_resist_plus
	name = "Brute Resist, Major"
	desc = "Adds 40% resistance to brute damage sources."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 3
	var_changes = list("brute_mod" = 0.6) //YW EDIT
/datum/dna/gene/trait_linked/brute_resist_plus/New() // Genetically linked trait
	block = TRAITBLOCK_BRUTERESIST_MAJOR
	activation_messages=list("You feel a lot more durable.")
	deactivation_messages=list("You feel less durable.")
	linked_trait_path = /datum/trait/positive/brute_resist_plus
	. = ..()
// YW ADDITION: END


/datum/trait/positive/minor_burn_resist
	name = "Burn Resist, Minor"
	desc = "Adds 10% resistance to burn damage sources." //YW EDIT
	cost = 1 //YW EDIT
	var_changes = list("burn_mod" = 0.9) //YW EDIT
/datum/dna/gene/trait_linked/minor_burn_resist/New() // Genetically linked trait
	block = TRAITBLOCK_BURNRESIST_MINOR
	activation_messages=list("Your skin feels a little waxy.")
	deactivation_messages=list("You skin feels less waxy.")
	linked_trait_path = /datum/trait/positive/minor_burn_resist
	. = ..()


/datum/trait/positive/burn_resist
	name = "Burn Resist"
	desc = "Adds 20% resistance to burn damage sources." //YW EDIT
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 2 //YW EDIT
	var_changes = list("burn_mod" = 0.8) //YW EDIT
/datum/dna/gene/trait_linked/burn_resist/New() // Genetically linked trait
	block = TRAITBLOCK_BURNRESIST
	activation_messages=list("Your skin feels waxy.")
	deactivation_messages=list("You skin feels less waxy.")
	linked_trait_path = /datum/trait/positive/burn_resist
	. = ..()


//YW ADDITIONS: START
/datum/trait/positive/burn_resist_plus
	name = "Burn Resist, Major"
	desc = "Adds 40% resistance to burn damage sources."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 3
	var_changes = list("burn_mod" = 0.6)
/datum/dna/gene/trait_linked/burn_resist_plus/New() // Genetically linked trait
	block = TRAITBLOCK_BURNRESIST_MAJOR
	activation_messages=list("Your skin feels like wax.")
	deactivation_messages=list("You skin feels less waxy.")
	linked_trait_path = /datum/trait/positive/burn_resist_plus
	. = ..()


/datum/trait/positive/improved_biocompat
	name = "Improved Biocompatibility"
	desc = "Your body is naturally (or artificially) more receptive to healing chemicals without being vulnerable to the 'bad stuff'. You heal more efficiently from most chemicals, with no other drawbacks. Remember to note this down in your medical records!"
	cost = 2
	var_changes = list("chem_strength_heal" = 1.2)
/datum/dna/gene/trait_linked/improved_biocompat/New() // Genetically linked trait
	block = TRAITBLOCK_CHEMADVANCED
	activation_messages=list("You feel your body speed up.")
	deactivation_messages=list("You feel your body slow down.")
	linked_trait_path = /datum/trait/positive/improved_biocompat
	. = ..()


/datum/trait/positive/alcohol_tolerance_advanced
	name = "Liver of Steel"
	desc = "Drinks tremble before your might! You can hold your alcohol twice as well as those blue-bellied barnacle boilers! You may wish to note this down in your medical records."
	cost = 1
	var_changes = list("alcohol_mod" = 0.5)
/datum/dna/gene/trait_linked/alcohol_tolerance_advanced/New() // Genetically linked trait
	block = TRAITBLOCK_ALCOHOL_TOLEX
	activation_messages=list("You feel like your can drink anything.")
	deactivation_messages=list("You feel less confident.")
	linked_trait_path = /datum/trait/positive/alcohol_tolerance_advanced
	. = ..()


/datum/trait/positive/alcohol_immunity
	name = "Liver of Durasteel"
	desc = "You've drunk so much that most booze doesn't even faze you. It takes something like a Pan-Galactic or a pint of Deathbell for you to even get slightly buzzed. You may wish to note this down in your medical records."
	cost = 2
	var_changes = list("alcohol_mod" = 0.25)
/datum/dna/gene/trait_linked/alcohol_immunity/New() // Genetically linked trait
	block = TRAITBLOCK_ALCOHOL_IMMUNE
	activation_messages=list("You feel like there isn't a drink in the universe that you can't take.")
	deactivation_messages=list("You feel less confident.")
	linked_trait_path = /datum/trait/positive/alcohol_immunity
	. = ..()


/datum/trait/positive/pain_tolerance_basic
	name = "Pain Tolerant"
	desc = "You're a little more resistant to pain than most, and experience 10% less pain from from all sources."
	cost = 1
	var_changes = list("pain_mod" = 0.9)
/datum/dna/gene/trait_linked/pain_tolerance_basic/New() // Genetically linked trait
	block = TRAITBLOCK_PAIN_TOLLER_BASIC
	activation_messages=list("You much less sensitive.")
	deactivation_messages=list("You feel more sensitive.")
	linked_trait_path = /datum/trait/positive/pain_tolerance_basic
	. = ..()

/datum/trait/positive/pain_tolerance_advanced
	name = "Pain Tolerance, High "
	desc = "You are noticeably more resistant to pain than most, and experience 20% less pain from all sources."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 2
	var_changes = list("pain_mod" = 0.8)
/datum/dna/gene/trait_linked/pain_tolerance_advanced/New() // Genetically linked trait
	block = TRAITBLOCK_PAIN_TOLLEREX
	activation_messages=list("You can't feel anything.")
	deactivation_messages=list("You feel more sensitive.")
	linked_trait_path = /datum/trait/positive/pain_tolerance_advanced
	. = ..()
//YW ADDITIONS: END

/datum/trait/positive/photoresistant
	name = "Photoresistance" //YW EDIT
	desc = "Decreases stun duration from flashes and other light-based stuns and disabilities by 25%" //YW EDIT
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 1
	var_changes = list("flash_mod" = 0.75) //YW EDIT
/datum/dna/gene/trait_linked/photoresistant/New() // Genetically linked trait
	block = TRAITBLOCK_PHOTORESIST
	activation_messages=list("Was everything always this dim?")
	deactivation_messages=list("The world feels less dim.")
	primitive_expression_messages=list("stares blankly.")
	linked_trait_path = /datum/trait/positive/photoresistant
	. = ..()

//YW ADDITION: START
/datum/trait/positive/photoresistant_plus
	name = "Photoresistance, Major"
	desc = "Decreases stun duration from flashes and other light-based stuns and disabilities by 50%" //YW EDIT
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 2
	var_changes = list("flash_mod" = 0.5) //YW EDIT
/datum/dna/gene/trait_linked/photoresistant_plus/New() // Genetically linked trait
	block = TRAITBLOCK_PHOTORESISTEX
	activation_messages=list("Was everything always this dark?")
	deactivation_messages=list("The world feels less dark.")
	primitive_expression_messages=list("stares blankly.")
	linked_trait_path = /datum/trait/positive/photoresistant_plus
	. = ..()
//YW ADDITION: END

/datum/trait/positive/winged_flight
	name = "Winged Flight"
	desc = "Allows you to fly by using your wings. Don't forget to bring them!"
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 1 //YW EDIT
/datum/dna/gene/trait_linked/winged_flight/New() // Genetically linked trait
	block = TRAITBLOCK_WINGFLIGHT
	activation_messages=list("You feel like you could take flight")
	deactivation_messages=list("The sky is out of your reach.")
	primitive_expression_messages=list("jumps around happily.")
	linked_trait_path = /datum/trait/positive/winged_flight
	. = ..()

/datum/trait/positive/winged_flight/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/flying_toggle
	H.verbs |= /mob/living/proc/flying_vore_toggle
	H.verbs |= /mob/living/proc/start_wings_hovering

/datum/trait/positive/winged_flight/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/proc/flying_toggle
	H.verbs -= /mob/living/proc/flying_vore_toggle
	H.verbs -= /mob/living/proc/start_wings_hovering


/datum/trait/positive/soft_landing
	name = "Soft Landing"
	desc = "You can fall from certain heights without suffering any injuries, be it via wings, lightness of frame or general dexterity."
	cost = 1
	var_changes = list("soft_landing" = TRUE)
/datum/dna/gene/trait_linked/soft_landing/New() // Genetically linked trait
	block = TRAITBLOCK_SOFTLAND
	activation_messages=list("You feel more nimble.")
	deactivation_messages=list("You feel less nimble.")
	primitive_expression_messages=list("hops in the air.")
	linked_trait_path = /datum/trait/positive/soft_landing
	. = ..()


/datum/trait/positive/hardfeet
	name = "Hard Feet"
	desc = "Makes your nice clawed, scaled, hooved, armored, or otherwise just awfully calloused feet immune to glass shards."
	cost = 1
	var_changes = list("flags" = NO_MINOR_CUT) //Checked the flag is only used by shard stepping.


/datum/trait/positive/antiseptic_saliva
	name = "Antiseptic Saliva"
	desc = "Your saliva has especially strong antiseptic properties that can be used to heal small wounds."
	cost = 1
/datum/dna/gene/trait_linked/antiseptic_saliva/New() // Genetically linked trait
	block = TRAITBLOCK_ANTISEPTIC
	activation_messages=list("Your mouth tastes different.")
	deactivation_messages=list("Your mouth returns to normal.")
	primitive_expression_messages=list("drools.")
	linked_trait_path = /datum/trait/positive/antiseptic_saliva
	. = ..()

/datum/trait/positive/antiseptic_saliva/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..()
	H.verbs |= /mob/living/carbon/human/proc/lick_wounds

/datum/trait/positive/antiseptic_saliva/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..()
	H.verbs -= /mob/living/carbon/human/proc/lick_wounds


/datum/trait/positive/traceur
	name = "Traceur"
	desc = "You're capable of parkour and can *flip over low objects (most of the time)."
	cost = 2
	var_changes = list("agility" = 90)
	varchange_type = TRAIT_VARCHANGE_MORE_BETTER
/datum/dna/gene/trait_linked/traceur/New() // Genetically linked trait
	block = TRAITBLOCK_SPRINGSTEP
	activation_messages=list("You feel more acrobatic.")
	deactivation_messages=list("You feel less acrobatic.")
	primitive_expression_messages=list("does a flip.")
	linked_trait_path = /datum/trait/positive/traceur
	. = ..()


//YW ADDITIONS: START
/datum/trait/positive/bloodsucker_plus
	name = "Evolved Bloodsucker"
	desc = "Makes you able to gain nutrition by draining blood as well as eating food. To compensate, you get fangs that can be used to drain blood from prey."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 1
	var_changes = list("organic_food_coeff" = 0.5, "bloodsucker" = TRUE)
	excludes = list(/datum/trait/neutral/bloodsucker)
/datum/dna/gene/trait_linked/bloodsucker_plus/New() // Genetically linked trait
	block = TRAITBLOCK_BLOODSUCKEREX
	activation_messages=list("You feel really thirsty for metal?")
	deactivation_messages=list("Your thirst for blood ends.")
	primitive_expression_messages=list("looks thirsty.")
	linked_trait_path = /datum/trait/positive/bloodsucker_plus
	. = ..()

/datum/trait/positive/bloodsucker_plus/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/bloodsuck

/datum/trait/positive/bloodsucker_plus/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/carbon/human/proc/bloodsuck


/datum/trait/positive/sonar
	name="Perceptive Hearing"
	desc = "You can hear slight vibrations in the air very easily, if you focus."
	cost = 1
/datum/dna/gene/trait_linked/sonar/New() // Genetically linked trait
	block = TRAITBLOCK_SONAR
	activation_messages=list("You hear EVERYTHING.")
	deactivation_messages=list("Your hearing returns to normal.")
	primitive_expression_messages=list("looks around surprised.")
	linked_trait_path = /datum/trait/positive/sonar
	. = ..()

/datum/trait/positive/sonar/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/sonar_ping

/datum/trait/positive/sonar/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/carbon/human/proc/sonar_ping


/datum/trait/positive/coldadapt
	name = "Cold-Adapted"
	desc = "You are able to withstand much colder temperatures than other species, and can even be comfortable in extremely cold environments. You are also more vulnerable to hot environments as a consequence of these adaptations."
	cost = 2
	var_changes = list("cold_level_1" = 200,  "cold_level_2" = 150, "cold_level_3" = 90, "breath_cold_level_1" = 180, "breath_cold_level_2" = 100, "breath_cold_level_3" = 60, "cold_discomfort_level" = 210, "heat_level_1" = 305, "heat_level_2" = 360, "heat_level_3" = 700, "breath_heat_level_1" = 345, "breath_heat_level_2" = 380, "breath_heat_level_3" = 780, "heat_discomfort_level" = 295)
	excludes = list(/datum/trait/positive/hotadapt)
	can_take = ORGANICS
/datum/dna/gene/trait_linked/coldadapt/New() // Genetically linked trait
	block = TRAITBLOCK_COLDADAPT
	activation_messages=list("The world feels warmer.")
	deactivation_messages=list("Everything feels less warm.")
	primitive_expression_messages=list("fluffs up.")
	linked_trait_path = /datum/trait/positive/coldadapt
	. = ..()


/datum/trait/positive/hotadapt
	name = "Heat-Adapted"
	desc = "You are able to withstand much hotter temperatures than other species, and can even be comfortable in extremely hot environments. You are also more vulnerable to cold environments as a consequence of these adaptations."
	cost = 2
	var_changes = list("heat_level_1" = 420, "heat_level_2" = 460, "heat_level_3" = 1100, "breath_heat_level_1" = 440, "breath_heat_level_2" = 510, "breath_heat_level_3" = 1500, "heat_discomfort_level" = 390, "cold_level_1" = 280, "cold_level_2" = 220, "cold_level_3" = 140, "breath_cold_level_1" = 260, "breath_cold_level_2" = 240, "breath_cold_level_3" = 120, "cold_discomfort_level" = 280)
	excludes = list(/datum/trait/positive/coldadapt)
	can_take = ORGANICS
/datum/dna/gene/trait_linked/hotadapt/New() // Genetically linked trait
	block = TRAITBLOCK_HOTADAPT
	activation_messages=list("The world feels colder.")
	deactivation_messages=list("Everything feels less cold.")
	primitive_expression_messages=list("a bit cold.")
	linked_trait_path = /datum/trait/positive/hotadapt
	. = ..()
//YW ADDITIONS: END


/datum/trait/positive/snowwalker
	name = "Snow Walker"
	desc = "You are able to move unhindered on snow."
	cost = 2 //YW EDIT
	var_changes = list("snow_movement" = -2)


/datum/trait/positive/weaver
	name = "Weaver"
	desc = "You can produce silk and create various articles of clothing and objects."
	cost = 2
	var_changes = list("is_weaver" = 1)
/datum/dna/gene/trait_linked/weaver/New() // Genetically linked trait
	block = TRAITBLOCK_WEAVER
	activation_messages=list("You start to leak silk.")
	deactivation_messages=list("You forget how to shot web.")
	primitive_expression_messages=list("leaks silk.")
	linked_trait_path = /datum/trait/positive/weaver
	. = ..()

/datum/trait/positive/weaver/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..()
	H.verbs |= /mob/living/carbon/human/proc/check_silk_amount
	H.verbs |= /mob/living/carbon/human/proc/toggle_silk_production
	H.verbs |= /mob/living/carbon/human/proc/weave_structure
	H.verbs |= /mob/living/carbon/human/proc/weave_item
	H.verbs |= /mob/living/carbon/human/proc/set_silk_color

/datum/trait/positive/weaver/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..()
	H.verbs -= /mob/living/carbon/human/proc/check_silk_amount
	H.verbs -= /mob/living/carbon/human/proc/toggle_silk_production
	H.verbs -= /mob/living/carbon/human/proc/weave_structure
	H.verbs -= /mob/living/carbon/human/proc/weave_item
	H.verbs -= /mob/living/carbon/human/proc/set_silk_color


/datum/trait/positive/aquatic
	name = "Aquatic"
	desc = "You can breathe under water and can traverse water more efficiently. Additionally, you can eat others in the water."
	cost = 1
	var_changes = list("water_breather" = 1, "water_movement" = -4) //Negate shallow water. Half the speed in deep water.
/datum/dna/gene/trait_linked/aquatic/New() // Genetically linked trait
	block = TRAITBLOCK_AQUATIC
	activation_messages=list("You feel like you belong under the sea.")
	deactivation_messages=list("You no longer want to live in the sea.")
	primitive_expression_messages=list("blubs.")
	linked_trait_path = /datum/trait/positive/aquatic
	. = ..()

/datum/trait/positive/aquatic/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/water_stealth
	H.verbs |= /mob/living/carbon/human/proc/underwater_devour

/datum/trait/positive/aquatic/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/carbon/human/proc/water_stealth
	H.verbs -= /mob/living/carbon/human/proc/underwater_devour


/datum/trait/positive/cocoon_tf
	name = "Cocoon Spinner"
	desc = "Allows you to build a cocoon around yourself, using it to transform your body if you desire."
	allowed_species = list(SPECIES_XENOCHIMERA) // outpost 21 edit - most extreme traits are xenochimera locked
	cost = 1
/datum/dna/gene/trait_linked/cocoon_tf/New() // Genetically linked trait
	block = TRAITBLOCK_COCOON
	linked_trait_path = /datum/trait/positive/cocoon_tf
	. = ..()

/datum/trait/positive/cocoon_tf/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/enter_cocoon

/datum/trait/positive/cocoon_tf/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/carbon/human/proc/enter_cocoon


/datum/trait/positive/linguist
	name = "Linguist"
	desc = "Allows you to have more languages."
	cost = 1
	var_changes = list("num_alternate_languages" = 6)
	var_changes_pref = list("extra_languages" = 3)
	varchange_type = TRAIT_VARCHANGE_MORE_BETTER


/datum/trait/positive/good_shooter
	name = "Eagle Eye"
	desc = "You are better at aiming than most."
	cost = 2
	var_changes = list("gun_accuracy_mod" = 25)
	varchange_type = TRAIT_VARCHANGE_MORE_BETTER


/datum/trait/positive/pain_tolerance
	name = "Grit"
	desc = "You can keep going a little longer, a little harder when you get hurt, Injuries only inflict 85% as much pain, and slowdown from pain is 85% as effective."
	cost = 2
	var_changes = list("trauma_mod" = 0.85)
	excludes = list(/datum/trait/negative/neural_hypersensitivity)
	can_take = ORGANICS
/datum/dna/gene/trait_linked/pain_tolerance/New() // Genetically linked trait
	block = TRAITBLOCK_PAINTOLLERANT
	activation_messages=list("You feel like the world can't hurt you.")
	deactivation_messages=list("You feel more vulnerable.")
	linked_trait_path = /datum/trait/positive/pain_tolerance
	. = ..()


/datum/trait/positive/phoron_resist
	name = "Phoron Resistant"
	desc = "Allows contact exposure to phoron without ill effects. Your results may vary."
	cost = 2
	var_changes = list("phoron_contact_mod" = 0)
/datum/dna/gene/trait_linked/phoron_resist/New() // Genetically linked trait
	block = TRAITBLOCK_PHORONEXPOSED
	activation_messages=list("You feel like your skin is made of wax.")
	deactivation_messages=list("You feel less waxy.")
	linked_trait_path = /datum/trait/positive/phoron_resist
	. = ..()
