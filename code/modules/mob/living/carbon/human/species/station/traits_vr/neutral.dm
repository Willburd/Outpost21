/datum/trait/neutral
	category = TRAIT_TYPE_NEUTRAL

/datum/trait/neutral/metabolism_up
	name = "Metabolism, Fast"
	desc = "You process ingested and injected reagents faster, but get hungry faster (Teshari speed)."
	cost = 0
	var_changes = list("metabolic_rate" = 1.2, "hunger_factor" = 0.2, "metabolism" = 0.06) // +20% rate and 4x hunger (Teshari level)
	excludes = list(/datum/trait/neutral/metabolism_down, /datum/trait/neutral/metabolism_apex)
/datum/dna/gene/trait_linked/metabolism_up/New() // Genetically linked trait
	block = TRAITBLOCK_METABOLISM_UP
	linked_trait_path = /datum/trait/neutral/metabolism_up
	. = ..()


/datum/trait/neutral/metabolism_down
	name = "Metabolism, Slow"
	desc = "You process ingested and injected reagents slower, but get hungry slower."
	cost = 0
	var_changes = list("metabolic_rate" = 0.8, "hunger_factor" = 0.04, "metabolism" = 0.0012) // -20% of default.
	excludes = list(/datum/trait/neutral/metabolism_up, /datum/trait/neutral/metabolism_apex)
/datum/dna/gene/trait_linked/metabolism_down/New() // Genetically linked trait
	block = TRAITBLOCK_METABOLISM_DOWN
	linked_trait_path = /datum/trait/neutral/metabolism_up
	. = ..()


/datum/trait/neutral/metabolism_apex
	name = "Metabolism, Apex"
	desc = "Finally a proper excuse for your predatory actions. Essentially doubles the fast trait rates. Good for characters with big appetites."
	cost = 0
	var_changes = list("metabolic_rate" = 1.4, "hunger_factor" = 0.4, "metabolism" = 0.012) // +40% rate and 8x hunger (Double Teshari)
	excludes = list(/datum/trait/neutral/metabolism_up, /datum/trait/neutral/metabolism_down)
/datum/dna/gene/trait_linked/metabolism_apex/New() // Genetically linked trait
	block = TRAITBLOCK_METABOLISM_APEX
	linked_trait_path = /datum/trait/neutral/metabolism_up
	. = ..()


//YW ADDITIONS: START
/datum/trait/neutral/alcohol_intolerance_basic
	name = "Liver of Lilies"
	desc = "You have a hard time with alcohol. Maybe you just never took to it, or maybe it doesn't agree with you... either way, drinks hit twice as hard. You may wish to note this down in your medical records, and perhaps your exploitable info as well."
	cost = 0
	var_changes = list("alcohol_mod" = 2)
/datum/dna/gene/trait_linked/alcohol_intolerance_basic/New() // Genetically linked trait
	block = TRAITBLOCK_ALCOHOL_INTOL_BASIC
	linked_trait_path = /datum/trait/neutral/alcohol_intolerance_basic
	. = ..()


/datum/trait/neutral/alcohol_tolerance_basic
	name = "Liver of Iron"
	desc = "You can hold drinks much better than those lily-livered land-lubbers! Arr! You may wish to note this down in your medical records."
	cost = 0
	var_changes = list("alcohol_mod" = 0.75)
/datum/dna/gene/trait_linked/alcohol_tolerance_basic/New() // Genetically linked trait
	block = TRAITBLOCK_ALCOHOL_TOL_BASIC
	linked_trait_path = /datum/trait/neutral/alcohol_tolerance_basic
	. = ..()

/*
/datum/trait/neutral/cryogenic
	name = "Cryogenic Metabolism"
	desc = "Your body requires near cryogenic temperatures to operate. Extremely intricate arrangements are needed for you to remain indoors. The outdoors is comfortable for you, however. WARNING: You will spawn in an atmosphere that is VERY hostile to you with no protective equipment!"
	cost = 0
	var_changes = list("heat_discomfort_level" = T0C)
	excludes = list(/datum/trait/hot_blood,/datum/trait/cold_blood,/datum/trait/extreme_cold_blood)
*/

/datum/trait/neutral/hot_blood
	name = "Hot-Blooded"
	desc = "You are too hot at the standard 20C. 18C is more suitable. Rolling down your jumpsuit or being unclothed helps."
	cost = 0
	var_changes = list("heat_discomfort_level" = T0C+19)
	excludes = list(/datum/trait/neutral/cold_blood, /datum/trait/neutral/extreme_cold_blood)
/datum/dna/gene/trait_linked/hot_blood/New() // Genetically linked trait
	block = TRAITBLOCK_HOT_BLOOD
	activation_messages=list("You feel warmer...")
	deactivation_messages=list("You cool off...")
	linked_trait_path = /datum/trait/neutral/hot_blood
	. = ..()


/datum/trait/neutral/cold_blood
	name = "Cold-Blooded"
	desc = "You are too cold at the standard 20C. 22C is more suitable. Wearing clothing that covers your legs and torso helps."
	cost = 0
	var_changes = list("cold_discomfort_level" = T0C+21)
	excludes = list(/datum/trait/neutral/hot_blood, /datum/trait/neutral/cold_blood)
/datum/dna/gene/trait_linked/cold_blood/New() // Genetically linked trait
	block = TRAITBLOCK_COLD_BLOOD
	activation_messages=list("You feel colder...")
	deactivation_messages=list("You heat back up...")
	linked_trait_path = /datum/trait/neutral/cold_blood
	. = ..()


/datum/trait/neutral/extreme_cold_blood
	name = "Extremely Cold Blooded"
	desc = "Your body relies on the outside temperature to keep warm. Wearing warm clothing such as jackets is commonplace for you."
	cost = 0
	var_changes = list("cold_discomfort_level" = T0C+24)
	excludes = list(/datum/trait/neutral/hot_blood, /datum/trait/neutral/cold_blood)
/datum/dna/gene/trait_linked/extreme_cold_blood/New() // Genetically linked trait
	block = TRAITBLOCK_ICE_BLOOD
	activation_messages=list("You feel ice cold...")
	deactivation_messages=list("You heat back up...")
	linked_trait_path = /datum/trait/neutral/extreme_cold_blood
	. = ..()

//YW ADDITIONS: END

/* YW Commented out will be moved to Positive/Negative for map balance
/datum/trait/neutral/coldadapt
	name = "Temp. Adapted, Cold"
	desc = "You are able to withstand much colder temperatures than other species, and can even be comfortable in extremely cold environments. You are also more vulnerable to hot environments, and have a lower body temperature as a consequence of these adaptations."
	cost = 0
	var_changes = list("cold_level_1" = 200,  "cold_level_2" = 150, "cold_level_3" = 90, "breath_cold_level_1" = 180, "breath_cold_level_2" = 100, "breath_cold_level_3" = 60, "cold_discomfort_level" = 210, "heat_level_1" = 330, "heat_level_2" = 380, "heat_level_3" = 700, "breath_heat_level_1" = 360, "breath_heat_level_2" = 400, "breath_heat_level_3" = 850, "heat_discomfort_level" = 295, "body_temperature" = 290)
	can_take = ORGANICS
	excludes = list(/datum/trait/neutral/hotadapt)

/datum/trait/neutral/hotadapt
	name = "Temp. Adapted, Heat"
	desc = "You are able to withstand much hotter temperatures than other species, and can even be comfortable in extremely hot environments. You are also more vulnerable to cold environments, and have a higher body temperature as a consequence of these adaptations."
	cost = 0
	var_changes = list("heat_level_1" = 420, "heat_level_2" = 460, "heat_level_3" = 1100, "breath_heat_level_1" = 440, "breath_heat_level_2" = 510, "breath_heat_level_3" = 1500, "heat_discomfort_level" = 390, "cold_level_1" = 280, "cold_level_2" = 220, "cold_level_3" = 140, "breath_cold_level_1" = 260, "breath_cold_level_2" = 240, "breath_cold_level_3" = 120, "cold_discomfort_level" = 280, "body_temperature" = 330)
	can_take = ORGANICS // negates the need for suit coolers entirely for synths, so no
	excludes = list(/datum/trait/neutral/coldadapt)
YW change end */

/datum/trait/neutral/autohiss_unathi
	name = "Autohiss (Unathi)"
	desc = "You roll your S's and x's"
	cost = 0
	var_changes = list(
	autohiss_basic_map = list(
			"s" = list("ss", "sss", "ssss")
		),
	autohiss_extra_map = list(
			"x" = list("ks", "kss", "ksss")
		),
	autohiss_exempt = list(LANGUAGE_UNATHI))
	excludes = list(/datum/trait/neutral/autohiss_tajaran/*, /datum/trait/neutral/autohiss_zaddat*/)


/datum/trait/neutral/autohiss_tajaran
	name = "Autohiss (Tajaran)"
	desc = "You roll your R's."
	cost = 0
	var_changes = list(
	autohiss_basic_map = list(
			"r" = list("rr", "rrr", "rrrr")
		),
	autohiss_exempt = list(LANGUAGE_SIIK,LANGUAGE_AKHANI,LANGUAGE_ALAI))
	excludes = list(/datum/trait/neutral/autohiss_unathi/*, /datum/trait/neutral/autohiss_zaddat*/)


/* outpost 21 - race removal
/datum/trait/neutral/autohiss_zaddat
	name = "Autohiss (Zaddat)"
	desc = "You buzz your S's and F's."
	cost = 0
	var_changes = list(
	autohiss_basic_map = list(
			"f" = list("v","vh"),
			"ph" = list("v", "vh")
		),
	autohiss_extra_map = list(
			"s" = list("z", "zz", "zzz"),
			"ce" = list("z", "zz"),
			"ci" = list("z", "zz"),
			"v" = list("vv", "vvv")
		),
	autohiss_exempt = list(LANGUAGE_ZADDAT,LANGUAGE_VESPINAE))
	excludes = list(/datum/trait/neutral/autohiss_tajaran, /datum/trait/neutral/autohiss_unathi)
*/

///YW ADDITION: START
/datum/trait/neutral/autohiss_vassilian
	name = "Autohiss (Vassilian)"
	desc = "You buzz your S's, F's, Th's, and R's."
	cost = 0
	var_changes = list(
	autohiss_basic_map = list(
        "s" = list("sz", "z", "zz"),
        "f" = list("zk")
		),
	autohiss_extra_map = list(
		"th" = list("zk", "szk"),
        "r" = list("rk")
	),
	autohiss_exempt = list("Vespinae"))
	excludes = list(/datum/trait/neutral/autohiss_tajaran, /datum/trait/neutral/autohiss_unathi)
//YW ADDITION: END


/datum/trait/neutral/bloodsucker
	name = "Bloodsucker, Obligate"
	desc = "Makes you unable to gain nutrition from anything but blood. To compenstate, you get fangs that can be used to drain blood from prey."
	cost = 0
	var_changes = list("organic_food_coeff" = 0, "bloodsucker" = TRUE)
	excludes = list(/datum/trait/positive/bloodsucker_plus) //YW EDIT: /datum/trait/positive/bloodsucker_plus
/datum/dna/gene/trait_linked/bloodsucker/New() // Genetically linked trait
	block = TRAITBLOCK_BLOODSUCKER
	linked_trait_path = /datum/trait/neutral/bloodsucker
	. = ..()

/datum/trait/neutral/bloodsucker/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/bloodsuck

/datum/trait/neutral/bloodsucker/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/carbon/human/proc/bloodsuck
/*YW Comment out in favour for our variant
/datum/trait/neutral/bloodsucker_freeform
	name = "Bloodsucker"
	desc = "You get fangs that can be used to drain blood from prey."
	cost = 0
	var_changes = list("bloodsucker" = TRUE)
	excludes = list(/datum/trait/neutral/bloodsucker)

/datum/trait/neutral/bloodsucker_freeform/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/bloodsuck
*/


/datum/trait/neutral/succubus_drain
	name = "Succubus Drain"
	desc = "Makes you able to gain nutrition from draining prey in your grasp."
	cost = 0
/datum/dna/gene/trait_linked/succubus_drain/New() // Genetically linked trait
	block = TRAITBLOCK_SUCCUBUS
	linked_trait_path = /datum/trait/neutral/succubus_drain
	. = ..()

/datum/trait/neutral/succubus_drain/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/succubus_drain
	H.verbs |= /mob/living/carbon/human/proc/succubus_drain_finalize
	H.verbs |= /mob/living/carbon/human/proc/succubus_drain_lethal

/datum/trait/neutral/succubus_drain/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/carbon/human/proc/succubus_drain
	H.verbs -= /mob/living/carbon/human/proc/succubus_drain_finalize
	H.verbs -= /mob/living/carbon/human/proc/succubus_drain_lethal


/datum/trait/neutral/long_vore
	name = "Long Predatorial Reach"
	desc = "Makes you able to use your tongue to grab creatures."
	cost = 0
/datum/dna/gene/trait_linked/long_vore/New() // Genetically linked trait
	block = TRAITBLOCK_TONGUE
	activation_messages=list("Your tongue extends...")
	deactivation_messages=list("Your tongue retracts...")
	linked_trait_path = /datum/trait/neutral/long_vore
	. = ..()

/datum/trait/neutral/long_vore/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/long_vore

/datum/trait/neutral/long_vore/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/proc/long_vore


/datum/trait/neutral/feeder
	name = "Feeder"
	desc = "Allows you to feed your prey using your own body."
	cost = 0
/datum/dna/gene/trait_linked/feeder/New() // Genetically linked trait
	block = TRAITBLOCK_FEEDER
	linked_trait_path = /datum/trait/neutral/feeder
	. = ..()

/datum/trait/neutral/feeder/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/slime_feed

/datum/trait/neutral/feeder/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/carbon/human/proc/slime_feed


/datum/trait/neutral/hard_vore
	name = "Brutal Predation"
	desc = "Allows you to tear off limbs & tear out internal organs."
	cost = 0
/datum/dna/gene/trait_linked/hard_vore/New() // Genetically linked trait
	block = TRAITBLOCK_HARDVORE
	linked_trait_path = /datum/trait/neutral/hard_vore
	. = ..()

/datum/trait/neutral/hard_vore/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/shred_limb

/datum/trait/neutral/hard_vore/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/proc/shred_limb


/datum/trait/neutral/trashcan
	name = "Trash Can"
	desc = "Allows you to dispose of some garbage on the go instead of having to look for a bin or littering like an animal."
	cost = 0
	var_changes = list("trashcan" = 1)
/datum/dna/gene/trait_linked/trashcan/New() // Genetically linked trait
	block = TRAITBLOCK_TRASHCAN
	linked_trait_path = /datum/trait/neutral/trashcan
	. = ..()

/datum/trait/neutral/trashcan/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/eat_trash

/datum/trait/neutral/trashcan/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/proc/eat_trash


/datum/trait/neutral/gem_eater
	name = "Expensive Taste"
	desc = "You only gain nutrition from raw ore and refined minerals. There's nothing that sates the appetite better than precious gems, exotic or rare minerals and you have damn fine taste. Anything else is beneath you."
	cost = 0
	var_changes = list("organic_food_coeff" = 0, "eat_minerals" = 1)
/datum/dna/gene/trait_linked/gem_eater/New() // Genetically linked trait
	block = TRAITBLOCK_GEMEATER
	linked_trait_path = /datum/trait/neutral/gem_eater
	. = ..()

/datum/trait/neutral/gem_eater/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/eat_minerals

/datum/trait/neutral/gem_eater/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/proc/eat_minerals


/datum/trait/neutral/synth_chemfurnace
	name = "Biofuel Processor"
	desc = "You are able to gain energy through consuming and processing normal food, at the cost of significantly slower recharging via cyborg chargers. Energy-dense foods such as protein bars and survival food will yield the best results."
	cost = 0
	can_take = SYNTHETICS
	var_changes = list("organic_food_coeff" = 0, "synthetic_food_coeff" = 0.6)
	excludes = list(/datum/trait/neutral/biofuel_value_down)


/datum/trait/neutral/glowing_eyes
	name = "Glowing Eyes"
	desc = "Your eyes show up above darkness. SPOOKY! And kinda edgey too."
	cost = 0
	var_changes = list("has_glowing_eyes" = 1)
/datum/dna/gene/trait_linked/glowing_eyes/New() // Genetically linked trait
	block = TRAITBLOCK_EYEGLOW
	activation_messages=list("Things look a bit brighter...")
	deactivation_messages=list("Things dim back down...")
	linked_trait_path = /datum/trait/neutral/glowing_eyes
	. = ..()

/datum/trait/neutral/glowing_eyes/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/toggle_eye_glow

/datum/trait/neutral/glowing_eyes/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/carbon/human/proc/toggle_eye_glow


/datum/trait/neutral/glowing_body
	name = "Glowing Body"
	desc = "Your body glows about as much as a PDA light! Settable color and toggle in Abilities tab ingame."
	cost = 0
/datum/dna/gene/trait_linked/glowing_body/New() // Genetically linked trait
	block = TRAITBLOCK_BODYGLOW
	activation_messages=list("You feel a bit brighter...")
	deactivation_messages=list("You dim back down...")
	linked_trait_path = /datum/trait/neutral/glowing_body
	. = ..()

/datum/trait/neutral/glowing_body/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/glow_toggle
	H.verbs |= /mob/living/proc/glow_color

/datum/trait/neutral/glowing_body/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/proc/glow_toggle
	H.verbs -= /mob/living/proc/glow_color


//Allergen custom effects!
/datum/trait/neutral/allergy_effects
	name = "Allergic Reaction : Sneezing"
	desc = "This trait causes spontanious sneezing as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	var/allergeneffect = AG_SNEEZE

/datum/trait/neutral/allergy_effects/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	if(S.allergen_reaction & AG_FLAG_SPECIESBASE)
		S.allergen_reaction = 0 // this is the first to override! Wipe all effects, so we can setup our custom reaction!
	S.allergen_reaction |= allergeneffect
	..(S,H)

/datum/trait/neutral/allergy_effects/bruise
	name = "Allergic Reaction : Bruising"
	desc = "This trait causes spontanious bruising as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_PHYS_DMG

/datum/trait/neutral/allergy_effects/burns
	name = "Allergic Reaction : Burns"
	desc = "This trait causes spontanious burns as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_BURN_DMG

/datum/trait/neutral/allergy_effects/toxic
	name = "Allergic Reaction : Toxins"
	desc = "This trait causes spontanious bloodstream toxins as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_TOX_DMG

/datum/trait/neutral/allergy_effects/gasp
	name = "Allergic Reaction : Gasping"
	desc = "This trait causes spontanious airway constriction as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_OXY_DMG

/datum/trait/neutral/allergy_effects/twitch
	name = "Allergic Reaction : Twitch"
	desc = "This trait causes spontanious twitching as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_EMOTE

/datum/trait/neutral/allergy_effects/weakness
	name = "Allergic Reaction : Weakness"
	desc = "This trait causes spontanious weakness as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_WEAKEN

/datum/trait/neutral/allergy_effects/sleepy
	name = "Allergic Reaction : Blurred vision"
	desc = "This trait causes spontanious blurred vision as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_BLURRY

/datum/trait/neutral/allergy_effects/sleepy
	name = "Allergic Reaction : Sleepy"
	desc = "This trait causes spontanious sleepiness as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_SLEEPY

/datum/trait/neutral/allergy_effects/confusion
	name = "Allergic Reaction : Confusion"
	desc = "This trait causes spontanious confusion as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_CONFUSE

/datum/trait/neutral/allergy_effects/sneeze
	name = "Allergic Reaction : Sneezing"
	desc = "This trait causes spontanious sneezing as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_SNEEZE

/datum/trait/neutral/allergy_effects/gibbing
	name = "Allergic Reaction : Gibbing"
	desc = "This trait causes spontanious gibbing as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_GIBBING

/datum/trait/neutral/allergy_effects/cough
	name = "Allergic Reaction : Coughing"
	desc = "This trait causes spontanious coughing as an Allergic reaction. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	allergeneffect = AG_COUGH

//Allergen traits! Not available to any species with a base allergens var.
/datum/trait/neutral/allergy
	name = "Allergy: Gluten"
	desc = "You're highly allergic to gluten proteins, which are found in most common grains. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	var/allergen = ALLERGEN_GRAINS

/datum/trait/neutral/allergy/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	S.allergens |= allergen
	..(S,H)


/datum/trait/neutral/allergy/meat
	name = "Allergy: Meat"
	desc = "You're highly allergic to just about any form of meat. You're probably better off just sticking to vegetables. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_MEAT
/datum/dna/gene/trait_linked/allergy/meat/New() // Genetically linked trait
	block = TRAITBLOCK_ALLERGY_MEAT
	linked_trait_path = /datum/trait/neutral/allergy/meat
	. = ..()


/datum/trait/neutral/allergy/fish
	name = "Allergy: Fish"
	desc = "You're highly allergic to fish. It's probably best to avoid seafood in general. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_FISH
/datum/dna/gene/trait_linked/allergy/fish/New() // Genetically linked trait
	block = TRAITBLOCK_ALLERGY_FISH
	linked_trait_path = /datum/trait/neutral/allergy/fish
	. = ..()


/datum/trait/neutral/allergy/pollen
	name = "Allergy: Pollen"
	desc = "You're highly allergic to pollen and many plants. It's probably best to avoid hydroponics in general. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_POLLEN
/datum/dna/gene/trait_linked/allergy/pollen/New() // Genetically linked trait
	block = TRAITBLOCK_ALLERGY_POLLEN
	linked_trait_path = /datum/trait/neutral/allergy/pollen
	. = ..()


/datum/trait/neutral/allergy/fruit
	name = "Allergy: Fruit"
	desc = "You're highly allergic to fruit. Vegetables are fine, but you should probably read up on how to tell the difference. Remember, tomatoes are a fruit. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_FRUIT
/datum/dna/gene/trait_linked/allergy/fruit/New() // Genetically linked trait
	block = TRAITBLOCK_ALLERGY_FRUIT
	linked_trait_path = /datum/trait/neutral/allergy/fruit
	. = ..()


/datum/trait/neutral/allergy/vegetable
	name = "Allergy: Vegetable"
	desc = "You're highly allergic to vegetables. Fruit are fine, but you should probably read up on how to tell the difference. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_VEGETABLE
/datum/dna/gene/trait_linked/allergy/vegetable/New() // Genetically linked trait
	block = TRAITBLOCK_ALLERGY_VEGI
	linked_trait_path = /datum/trait/neutral/allergy/vegetable
	. = ..()

/datum/trait/neutral/allergy/nuts
	name = "Allergy: Nuts"
	desc = "You're highly allergic to hard-shell seeds, such as peanuts. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_SEEDS
/datum/dna/gene/trait_linked/allergy/nuts/New() // Genetically linked trait
	block = TRAITBLOCK_ALLERGY_NUTS
	linked_trait_path = /datum/trait/neutral/allergy/nuts
	. = ..()


/datum/trait/neutral/allergy/soy
	name = "Allergy: Soy"
	desc = "You're highly allergic to soybeans, and some other kinds of bean. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_BEANS
/datum/dna/gene/trait_linked/allergy/soy/New() // Genetically linked trait
	block = TRAITBLOCK_ALLERGY_SOY
	linked_trait_path = /datum/trait/neutral/allergy/soy
	. = ..()


/datum/trait/neutral/allergy/dairy
	name = "Allergy: Lactose"
	desc = "You're highly allergic to lactose, and consequently, just about all forms of dairy. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_DAIRY
/datum/dna/gene/trait_linked/allergy/dairy/New() // Genetically linked trait
	block = TRAITBLOCK_ALLERGY_DAIRY
	linked_trait_path = /datum/trait/neutral/allergy/dairy
	. = ..()


/datum/trait/neutral/allergy/fungi
	name = "Allergy: Fungi"
	desc = "You're highly allergic to fungi such as mushrooms. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_FUNGI
/datum/dna/gene/trait_linked/allergy/fungi/New() // Genetically linked trait
	block = TRAITBLOCK_ALLERGY_FUNGI
	linked_trait_path = /datum/trait/neutral/allergy/fungi
	. = ..()


/datum/trait/neutral/allergy/coffee
	name = "Allergy: Coffee"
	desc = "You're highly allergic to coffee in specific. NB: By taking this trait, you acknowledge there is a significant risk your character may suffer a fatal reaction if exposed to this substance."
	cost = 0
	allergen = ALLERGEN_COFFEE
/datum/dna/gene/trait_linked/allergy/coffee/New() // Genetically linked trait
	block = TRAITBLOCK_ALLERGY_COFFEE
	linked_trait_path = /datum/trait/neutral/allergy/coffee
	. = ..()


/datum/trait/neutral/allergen_reduced_effect
	name = "Reduced Allergen Reaction"
	desc = "This trait drastically reduces the effects of allergen reactions. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	var_changes = list("allergen_damage_severity" = 1.25, "allergen_disable_severity" = 5)
	excludes = list(/datum/trait/neutral/allergen_increased_effect)


/datum/trait/neutral/allergen_increased_effect
	name = "Increased Allergen Reaction"
	desc = "This trait drastically increases the effects of allergen reactions, enough that even a small dose can be lethal. If you don't have any allergens set, it does nothing. It does not apply to special reactions (such as unathi drowsiness from sugars)."
	cost = 0
	var_changes = list("allergen_damage_severity" = 5, "allergen_disable_severity" = 20)
	excludes = list(/datum/trait/neutral/allergen_reduced_effect)


// Spicy Food Traits, from negative to positive.
/datum/trait/neutral/spice_intolerance_extreme
	name = "Spice Intolerance, Extreme"
	desc = "Spicy (and chilly) peppers are three times as strong. (This does not affect pepperspray.)"
	cost = 0
	var_changes = list("spice_mod" = 3) // 300% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!
/datum/dna/gene/trait_linked/spice_intolerance_extreme/New() // Genetically linked trait
	block = TRAITBLOCK_SPICE_INTOL_EXTREME
	linked_trait_path = /datum/trait/neutral/spice_intolerance_extreme
	. = ..()


/datum/trait/neutral/spice_intolerance_basic
	name = "Spice Intolerance, Heavy"
	desc = "Spicy (and chilly) peppers are twice as strong. (This does not affect pepperspray.)"
	cost = 0
	var_changes = list("spice_mod" = 2) // 200% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!
/datum/dna/gene/trait_linked/spice_intolerance_basic/New() // Genetically linked trait
	block = TRAITBLOCK_SPICE_INTOL_BASIC
	linked_trait_path = /datum/trait/neutral/spice_intolerance_basic
	. = ..()


/datum/trait/neutral/spice_intolerance_slight
	name = "Spice Intolerance, Slight"
	desc = "You have a slight struggle with spicy foods. Spicy (and chilly) peppers are one and a half times stronger. (This does not affect pepperspray.)"
	cost = 0
	var_changes = list("spice_mod" = 1.5) // 150% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!
/datum/dna/gene/trait_linked/spice_intolerance_slight/New() // Genetically linked trait
	block = TRAITBLOCK_SPICE_INTOL_SLIGHT
	linked_trait_path = /datum/trait/neutral/spice_intolerance_slight
	. = ..()


/datum/trait/neutral/spice_tolerance_basic
	name = "Spice Tolerance"
	desc = "Spicy (and chilly) peppers are only three-quarters as strong. (This does not affect pepperspray.)"
	cost = 0
	var_changes = list("spice_mod" = 0.75) // 75% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!
/datum/dna/gene/trait_linked/spice_tolerance_basic/New() // Genetically linked trait
	block = TRAITBLOCK_SPICE_TOL_BASIC
	linked_trait_path = /datum/trait/neutral/spice_tolerance_basic
	. = ..()

/datum/trait/neutral/spice_tolerance_advanced
	name = "Spice Tolerance, Strong"
	desc = "Spicy (and chilly) peppers are only half as strong. (This does not affect pepperspray.)"
	cost = 0
	var_changes = list("spice_mod" = 0.5) // 50% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!
/datum/dna/gene/trait_linked/spice_tolerance_advanced/New() // Genetically linked trait
	block = TRAITBLOCK_SPICE_TOL_ADVANCED
	linked_trait_path = /datum/trait/neutral/spice_tolerance_advanced
	. = ..()

/datum/trait/neutral/spice_immunity
	name = "Spice Tolerance, Extreme"
	desc = "Spicy (and chilly) peppers are basically ineffective! (This does not affect pepperspray.)"
	cost = 0
	var_changes = list("spice_mod" = 0.25) // 25% as effective if spice_mod is set to 1. If it's not 1 in species.dm, update this!
/datum/dna/gene/trait_linked/spice_immunity/New() // Genetically linked trait
	block = TRAITBLOCK_SPICE_TOL_IMMUNE
	linked_trait_path = /datum/trait/neutral/spice_immunity
	. = ..()

/*YW CHANGE START: Commented out because we got our own variants
// Alcohol Traits Start Here, from negative to positive.
/datum/trait/neutral/alcohol_intolerance_advanced
	name = "Liver of Air"
	desc = "The only way you can hold a drink is if it's in your own two hands, and even then you'd best not inhale too deeply near it. Drinks are three times as strong."
	cost = 0
	var_changes = list("alcohol_mod" = 3) // 300% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/alcohol_intolerance_basic
	name = "Liver of Lilies"
	desc = "You have a hard time with alcohol. Maybe you just never took to it, or maybe it doesn't agree with you... either way, drinks are twice as strong."
	cost = 0
	var_changes = list("alcohol_mod" = 2) // 200% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/alcohol_intolerance_slight
	name = "Liver of Tulips"
	desc = "You have a slight struggle with alcohol. Drinks are one and a half times stronger."
	cost = 0
	var_changes = list("alcohol_mod" = 1.5) // 150% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/alcohol_tolerance_basic
	name = "Liver of Iron"
	desc = "You can hold drinks much better than those lily-livered land-lubbers! Arr! Drinks are only three-quarters as strong."
	cost = 0
	var_changes = list("alcohol_mod" = 0.75) // 75% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/alcohol_tolerance_advanced
	name = "Liver of Steel"
	desc = "Drinks tremble before your might! You can hold your alcohol twice as well as those blue-bellied barnacle boilers! Drinks are only half as strong."
	cost = 0
	var_changes = list("alcohol_mod" = 0.5) // 50% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!

/datum/trait/neutral/alcohol_immunity
	name = "Liver of Durasteel"
	desc = "You've drunk so much that most booze doesn't even faze you. It takes something like a Pan-Galactic or a pint of Deathbell for you to even get slightly buzzed."
	cost = 0
	var_changes = list("alcohol_mod" = 0.25) // 25% as effective if alcohol_mod is set to 1. If it's not 1 in species.dm, update this!
// Alcohol Traits End Here.
YW CHANGE STOP*/

/datum/trait/neutral/colorblind/mono
	name = "Colorblindness (Monochromancy)"
	desc = "You simply can't see colors at all, period. You are 100% colorblind."
	cost = 0
/datum/dna/gene/trait_linked/colorblind/mono/New() // Genetically linked trait
	block = TRAITBLOCK_COLORBLIND_MONO
	linked_trait_path = /datum/trait/neutral/colorblind/mono
	. = ..()

/datum/trait/neutral/colorblind/mono/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_monochrome)

/datum/trait/neutral/colorblind/mono/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.remove_modifiers_of_type(/datum/modifier/trait/colorblind_monochrome)


/datum/trait/neutral/colorblind/para_vulp
	name = "Colorblindness (Para Vulp)"
	desc = "You have a severe issue with green colors and have difficulty recognizing them from red colors."
	cost = 0
/datum/dna/gene/trait_linked/colorblind/para_vulp/New() // Genetically linked trait
	block = TRAITBLOCK_COLORBLIND_VULP
	linked_trait_path = /datum/trait/neutral/colorblind/para_vulp
	. = ..()

/datum/trait/neutral/colorblind/para_vulp/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_vulp)

/datum/trait/neutral/colorblind/para_vulp/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.remove_modifiers_of_type(/datum/modifier/trait/colorblind_vulp)


/datum/trait/neutral/colorblind/para_taj
	name = "Colorblindness (Para Taj)"
	desc = "You have a minor issue with blue colors and have difficulty recognizing them from red colors."
	cost = 0
/datum/dna/gene/trait_linked/colorblind/para_taj/New() // Genetically linked trait
	block = TRAITBLOCK_COLORBLIND_TAJ
	linked_trait_path = /datum/trait/neutral/colorblind/para_taj
	. = ..()

/datum/trait/neutral/colorblind/para_taj/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.add_modifier(/datum/modifier/trait/colorblind_taj)

/datum/trait/neutral/colorblind/para_taj/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.remove_modifiers_of_type(/datum/modifier/trait/colorblind_taj)


// Body shape traits
/datum/trait/neutral/taller
	name = "Tall"
	desc = "Your body is taller than average."
	sort = TRAIT_SORT_BODYTYPE
	cost = 0
	var_changes = list("icon_scale_y" = 1.09)
	excludes = list(/datum/trait/neutral/tall, /datum/trait/neutral/short, /datum/trait/neutral/shorter)
/datum/dna/gene/trait_linked/taller/New() // Genetically linked trait
	block = TRAITBLOCK_BODY_TALLER
	linked_trait_path = /datum/trait/neutral/taller
	. = ..()

/datum/trait/neutral/taller/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/taller/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()


/datum/trait/neutral/tall
	name = "Tall, Minor"
	desc = "Your body is a bit taller than average."
	sort = TRAIT_SORT_BODYTYPE
	cost = 0
	var_changes = list("icon_scale_y" = 1.05)
	excludes = list(/datum/trait/neutral/taller, /datum/trait/neutral/short, /datum/trait/neutral/shorter)
/datum/dna/gene/trait_linked/tall/New() // Genetically linked trait
	block = TRAITBLOCK_BODY_TALL
	linked_trait_path = /datum/trait/neutral/tall
	. = ..()

/datum/trait/neutral/tall/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/tall/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()


/datum/trait/neutral/short
	name = "Short, Minor"
	desc = "Your body is a bit shorter than average."
	sort = TRAIT_SORT_BODYTYPE
	cost = 0
	var_changes = list("icon_scale_y" = 0.95)
	excludes = list(/datum/trait/neutral/taller, /datum/trait/neutral/tall, /datum/trait/neutral/shorter)
/datum/dna/gene/trait_linked/short/New() // Genetically linked trait
	block = TRAITBLOCK_BODY_SHORT
	linked_trait_path = /datum/trait/neutral/short
	. = ..()

/datum/trait/neutral/short/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/short/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()


/datum/trait/neutral/shorter
	name = "Short"
	desc = "Your body is shorter than average."
	sort = TRAIT_SORT_BODYTYPE
	cost = 0
	var_changes = list("icon_scale_y" = 0.915)
	excludes = list(/datum/trait/neutral/taller, /datum/trait/neutral/tall, /datum/trait/neutral/short)
/datum/dna/gene/trait_linked/shorter/New() // Genetically linked trait
	block = TRAITBLOCK_BODY_SHORTER
	linked_trait_path = /datum/trait/neutral/shorter
	. = ..()

/datum/trait/neutral/shorter/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/shorter/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()


/datum/trait/neutral/obese
	name = "Bulky, Major"
	desc = "Your body is much wider than average."
	sort = TRAIT_SORT_BODYTYPE
	cost = 0
	var_changes = list("icon_scale_x" = 1.095)
	excludes = list(/datum/trait/neutral/fat, /datum/trait/neutral/thin, /datum/trait/neutral/thinner)
/datum/dna/gene/trait_linked/obese/New() // Genetically linked trait
	block = TRAITBLOCK_BODY_OBESE
	linked_trait_path = /datum/trait/neutral/obese
	. = ..()

/datum/trait/neutral/obese/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/obese/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()


/datum/trait/neutral/fat
	name = "Bulky"
	desc = "Your body is wider than average."
	sort = TRAIT_SORT_BODYTYPE
	cost = 0
	var_changes = list("icon_scale_x" = 1.054)
	excludes = list(/datum/trait/neutral/obese, /datum/trait/neutral/thin, /datum/trait/neutral/thinner)
/datum/dna/gene/trait_linked/fat/New() // Genetically linked trait
	block = TRAITBLOCK_BODY_FAT
	linked_trait_path = /datum/trait/neutral/fat
	. = ..()

/datum/trait/neutral/fat/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/fat/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()


/datum/trait/neutral/thin
	name = "Thin"
	desc = "Your body is thinner than average."
	sort = TRAIT_SORT_BODYTYPE
	cost = 0
	var_changes = list("icon_scale_x" = 0.945)
	excludes = list(/datum/trait/neutral/fat, /datum/trait/neutral/obese, /datum/trait/neutral/thinner)
/datum/dna/gene/trait_linked/thin/New() // Genetically linked trait
	block = TRAITBLOCK_BODY_THIN
	linked_trait_path = /datum/trait/neutral/thin
	. = ..()

/datum/trait/neutral/thin/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/thin/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()


/datum/trait/neutral/thinner
	name = "Thin, Major"
	desc = "Your body is much thinner than average."
	sort = TRAIT_SORT_BODYTYPE
	cost = 0
	var_changes = list("icon_scale_x" = 0.905)
	excludes = list(/datum/trait/neutral/fat, /datum/trait/neutral/obese, /datum/trait/neutral/thin)
/datum/dna/gene/trait_linked/thinner/New() // Genetically linked trait
	block = TRAITBLOCK_BODY_THINNER
	linked_trait_path = /datum/trait/neutral/thinner
	. = ..()

/datum/trait/neutral/thinner/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()

/datum/trait/neutral/thinner/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.update_transform()


/datum/trait/neutral/dominate_predator
	name = "Dominate Predator"
	desc = "Allows you to attempt to take control of a predator while inside of their belly."
	cost = 0
/datum/dna/gene/trait_linked/dominate_predator/New() // Genetically linked trait
	block = TRAITBLOCK_VORE_DOMPRED
	linked_trait_path = /datum/trait/neutral/dominate_predator
	. = ..()

/datum/trait/neutral/dominate_predator/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/proc/dominate_predator

/datum/trait/neutral/dominate_predator/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/proc/dominate_predator


/datum/trait/neutral/dominate_prey
	name = "Dominate Prey"
	desc = "Connect to and dominate the brain of your prey."
	cost = 0
/datum/dna/gene/trait_linked/dominate_prey/New() // Genetically linked trait
	block = TRAITBLOCK_VORE_DOMPREY
	linked_trait_path = /datum/trait/neutral/dominate_prey
	. = ..()

/datum/trait/neutral/dominate_prey/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/dominate_prey

/datum/trait/neutral/dominate_prey/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/proc/dominate_prey


/datum/trait/neutral/submit_to_prey
	name = "Submit To Prey"
	desc = "Allow prey's mind to control your own body."
	cost = 0
/datum/dna/gene/trait_linked/submit_to_prey/New() // Genetically linked trait
	block = TRAITBLOCK_VORE_SUBTOPREY
	linked_trait_path = /datum/trait/neutral/submit_to_prey
	. = ..()

/datum/trait/neutral/submit_to_prey/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/lend_prey_control

/datum/trait/neutral/submit_to_prey/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/proc/lend_prey_control


/datum/trait/neutral/vertical_nom
	name = "Vertical Nom"
	desc = "Allows you to consume people from up above."
	cost = 0
/datum/dna/gene/trait_linked/vertical_nom/New() // Genetically linked trait
	block = TRAITBLOCK_VORE_VERTNOM
	linked_trait_path = /datum/trait/neutral/vertical_nom
	. = ..()

/datum/trait/neutral/vertical_nom/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/proc/vertical_nom

/datum/trait/neutral/vertical_nom/unapply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs -= /mob/living/proc/vertical_nom


/datum/trait/neutral/micro_size_down
	name = "Light Frame"
	desc = "You are considered smaller than you are for micro interactions."
	cost = 0
	var_changes = list("micro_size_mod" = -0.15)
/datum/dna/gene/trait_linked/micro_size_down/New() // Genetically linked trait
	block = TRAITBLOCK_MICRO_SIZEDOWN
	linked_trait_path = /datum/trait/neutral/micro_size_down
	. = ..()


/datum/trait/neutral/micro_size_up
	name = "Heavy Frame"
	desc = "You are considered bigger than you are for micro interactions."
	cost = 0
	var_changes = list("micro_size_mod" = 0.15)
/datum/dna/gene/trait_linked/micro_size_up/New() // Genetically linked trait
	block = TRAITBLOCK_MICRO_SIZEUP
	linked_trait_path = /datum/trait/neutral/micro_size_up
	. = ..()


/datum/trait/neutral/digestion_value_up
	name = "Highly Filling"
	desc = "You provide notably more nutrition to anyone who makes a meal of you."
	cost = 0
	var_changes = list("digestion_nutrition_modifier" = 2)

/datum/trait/neutral/digestion_value_up_plus
	name = "Extremely Filling"
	desc = "You provide a lot more nutrition to anyone who makes a meal of you."
	cost = 0
	var_changes = list("digestion_nutrition_modifier" = 3)

/datum/trait/neutral/digestion_value_down
	name = "Slightly Filling"
	desc = "You provide notably less nutrition to anyone who makes a meal of you."
	cost = 0
	var_changes = list("digestion_nutrition_modifier" = 0.5)

/datum/trait/neutral/digestion_value_down_plus
	name = "Barely Filling"
	desc = "You provide a lot less nutrition to anyone who makes a meal of you."
	cost = 0
	var_changes = list("digestion_nutrition_modifier" = 0.25)


/datum/trait/neutral/food_value_down
	name = "Insatiable"
	desc = "You need to eat a third of a plate more to be sated."
	cost = 0
	can_take = ORGANICS
	var_changes = list(organic_food_coeff = 0.67, digestion_efficiency = 0.66)
	excludes = list(/datum/trait/neutral/bloodsucker)
/datum/dna/gene/trait_linked/food_value_down/New() // Genetically linked trait
	block = TRAITBLOCK_INSATIABLE
	linked_trait_path = /datum/trait/neutral/food_value_down
	. = ..()


/datum/trait/neutral/food_value_down_plus
	name = "Insatiable, Greater"
	desc = "You need to eat three times as much to feel sated."
	cost = 0
	can_take = ORGANICS
	var_changes = list(organic_food_coeff = 0.33, digestion_efficiency = 0.33)
	excludes = list(/datum/trait/neutral/bloodsucker, /datum/trait/neutral/food_value_down)
/datum/dna/gene/trait_linked/food_value_down/New() // Genetically linked trait
	block = TRAITBLOCK_INSATIABLEEX
	linked_trait_path = /datum/trait/neutral/food_value_down
	. = ..()


/datum/trait/neutral/biofuel_value_down
	name = "Discount Biofuel processor"
	desc = "You are able to gain energy through consuming and processing normal food. Unfortunately, it is half as effective as premium models. On the plus side, you still recharge from charging stations fairly efficiently."
	cost = 0
	can_take = SYNTHETICS
	var_changes = list("organic_food_coeff" = 0, "synthetic_food_coeff" = 0.3, digestion_efficiency = 0.5)
	excludes = list(/datum/trait/neutral/synth_chemfurnace)


/datum/trait/neutral/synth_cosmetic_pain
	name = "Pain simulation"
	desc = "You have added modules in your synthetic shell that simulates the sensation of pain. You are able to turn this on and off for repairs as needed or convenience at will."
	cost = 0
	can_take = SYNTHETICS


/datum/trait/neutral/synth_cosmetic_pain/apply(var/datum/species/S,var/mob/living/carbon/human/H)
	..(S,H)
	H.verbs |= /mob/living/carbon/human/proc/toggle_pain_module
