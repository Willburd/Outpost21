////////////////////////////////////////
////////////////PET VERSION/////////////
////////////////////////////////////////
/mob/living/simple_mob/vore/alienanimals/synx/ai/pet
	faction = "Cargonia" //Should not share a faction with those pesky non station synxes.//This is so newspaper has a failchance
	name = "Bob"
	desc = "A very regular pet."
	tt_desc = "synxus pergulus"
	glow_range = 4
	glow_toggle = 1
	player_msg = "You aren't supposed to be in this. Wrong mob."

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/init_vore()
	.=..()
	var/obj/belly/B = vore_selected
	if(istype(B)) // massive runtime errors everywhere on startup without this, assigning things to null anyway, so would be pointless executing anyway.
		B.vore_verb = "swallow"
		B.digest_burn = 1
		B.digest_brute = 0

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/holo/init_vore()
	.=..()
	var/obj/belly/B = vore_selected
	if(istype(B)) // massive runtime errors everywhere on startup without this, assigning things to null anyway, so would be pointless executing anyway.
		B.vore_verb = "swallow"
		B.digest_burn = 5
		B.digest_brute = 5

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet
	speak_chance = 1.0333

//HONKMOTHER Code.
/*/mob/living/simple_mob/vore/alienanimals/synx/proc/honk()
	set name = "HONK"
	set desc = "TAAA RAINBOW"
	set category = VERBTAB_POWERS
	icon_state = "synx_pet_rainbow"
	icon_living = "synx_pet_rainbow"
	playsound(src.loc, 'sound/items/bikehorn.ogg', 50, 1)
*/
/mob/living/simple_mob/vore/alienanimals/synx/proc/bikehorn()
	playsound(src.loc, 'sound/items/bikehorn.ogg', 50, 1)

//HOLOSEEDSPAWNCODE
/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/holo/death()
	..()
	visible_message("<span class='notice'>\The [src] fades away!</span>")
	var/location = get_turf(src)
	new /obj/item/seeds/hardlightseed/typesx(location)
	qdel(src)

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/holo/gib()
	visible_message("<span class='notice'>\The [src] fades away!</span>")
	var/location = get_turf(src)
	new /obj/item/seeds/hardlightseed/typesx(location)
	qdel(src)

////////////////////////////////////////
////////////////SYNX VARIATIONS/////////
////////////////////////////////////////
/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/holo
	poison_chance = 100
	poison_type = "fakesynxchem" //unlike synxchem this one heals!
	name = "Hardlight synx"
	desc = "A cold blooded, genderless, space eel.. or a hologram of one. Guess the current synx are undergoing re-training? Either way this one is probably infinitely more friendly.. and less deadly."
	icon_state = "synx_hardlight_living"
	icon_living = "synx_hardlight_living"
	icon_dead = "synx_hardlight_dead"
	icon_gib = null
	alpha = 127
	speak = list("SX System Online")
	faction = "neutral"//Can be safely bapped with newspaper.
	melee_damage_lower = 0 //Holos do no damage
	melee_damage_upper = 0
	meat_amount = 0
	meat_type = null
	//Vore Section
	vore_default_mode = DM_HEAL
	vore_capacity = 2
	vore_digest_chance = 0    //Holos cannot digest
	vore_pounce_chance = 40 //Shouldn't fight
	vore_bump_chance = 0 //lowered bump chance
	vore_escape_chance = 30 //Much higher escape chance.. it's a hologram.
	swallowTime = 10 SECONDS //Much more time to run

/*
/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/greed
	name = "Greed"
	desc = "A cold blooded, genderless, parasitic eel from the more distant and stranger areas of the cosmos. black, perpetually grinning and possessing a hunger as enthusiastic and endless as humanity's sense of exploration.. This one has the name Greed burnt into its back, the burnt in name seems to be luminescent making it harder for it to blend into the dark."
	//icon= //icon= would just set what DMI we are using, we already have our special one set.
	icon_state = "synx_greed_living"
	icon_living = "synx_greed_living"
	icon_dead = "synx_greed_dead"
	speak = list("Who is there?")//preset unique words Greed remembers, to be defined more
	player_msg = "You Hunger."
	health = 100//Slightly lower health due to being damaged permanently.
	speak_chance = 2.5
	//Vore Section
	vore_capacity = 4 //What a fat noodle.
	vore_digest_chance = 1	//Multivore but lower digest chance
	vore_pounce_chance = 90 //Fighting is effort, engulf them whole.
	vore_bump_chance = 2 //lowered bump chance
	vore_escape_chance = 5 //Multivore allows for people to shove eachother out so lower normal escape chance.
*/ //OP edit - Removing because this is a custom character of someone.

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/synth //TODO: This one needs to be made into an ERT borg module. - Ig
	icon_state = "synx_C_living"
	icon_living = "synx_C_living"
	icon_dead = "synx_C_dead"
	//hostile = 1
	name = "SYN-X"
	desc = "A robotic recreation of a an Alien parasite. The metal plates seem quite thick."
	humanoid_hands = 1
	health = 150 //Metally //Op edit - dropped from 200 to 150, with the armor plating that's insane.
	player_msg = "All systems nominal."
	/////////////////////ARMOR
	armor = list(
			"melee" = 50,
			"bullet" = 50,
			"laser" = -50,
			"energy" = -50,
			"bomb" = 50,
			"bio" = 100,
			"rad" = 100)
	////////////////////////////MED INJECTOR
	poison_type = "oxycodone" //OD effects, eye_blurry | Confuse + for slimes | stuttering
	poison_chance = 77 //high but not guranteed.
	poison_per_bite = 9 //OD for oxyc is 20
	//////////////////////////////////////////////FACTION
	faction = "SYN"

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/synth/New()
	..()
	name = "SYN-KinC-([rand(100,999)])"

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/synth/goodboy
	//hostile = 0
	faction = "neutral"

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/diablo
	name = "Diablo"
	desc = "A cold blooded, genderless, parasitic eel from the more distant and stranger areas of the cosmos. grey, perpetually grinning and possessing a hunger as enthusiastic and endless as humanity's sense of exploration. It has a tracking collar that doesn't seem to work."
	icon_state = "synx_diablo_living"
	icon_living = "synx_diablo_living"
	icon_dead = "synx_diablo_dead"
	speak = list( )
	//Vore Section
	vore_capacity = 2

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/grins
	name = "Grins"
	desc = "A cold blooded, genderless, parasitic eel from the more distant and stranger areas of the cosmos. Perpetually grinning and possessing a hunger as enthusiastic and endless as humanity's sense of exploration.. This one has a small shock collar on it that reads 'Grins'."
	icon_state = "synx_grins_living"
	icon_living = "synx_grins_living"
	icon_dead = "synx_grins_dead"
	player_msg = "The collar shorts out.. you're free now."
	speak = list("*weh","Who're you?","Hello~", "Fuck", "You're cute, Trashfire", "How did they die this time?", "I'm so bored", "!moans", "Who's a good space parasite?", "*merp", "Let me brush your teeth!", "NO! Spit that out!", "Spit me out!", "Good morning") //some pre-sampled lines so it doesn't freak out. //Added some more from our local RD, and some references.
	//Vore Section
	vore_capacity = 2
	vore_digest_chance = 70 //He's greedy
	vore_pounce_chance = 80
	vore_bump_chance = 10 //Don't go running through them all the time
	vore_escape_chance = 10


/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/clown
	//hostile = 1
	poison_chance = 100
	poison_type = "clownsynxchem" //unlike synxchem this one HONKS
	name = "Inflatable Clown Synx"
	desc = "Honk!, made this here with all the fun on in the booth. At the gate outside, when they pull up, they get me loose. Yeah, Jump Out Clowns, that's Clown gang, hoppin' out tiny cars. This shit way too funny, when we pull up give them the honk hard!"
	icon_state = "synx_pet_rainbow"
	icon_living = "synx_pet_rainbow"
	//icon_dead = "synx_hardlight_dead"
	icon_gib = null
	faction = "clown"
	melee_damage_lower = 1
	melee_damage_upper = 1
	//environment_smash = 0
	//destroy_surroundings = 0
	//Vore Section
	vore_default_mode = DM_HEAL
	vore_capacity = 10
	vore_digest_chance = 0
	vore_pounce_chance = 1 //MAKE THEM HONK
	vore_bump_chance = 0 //lowered bump chance
	vore_escape_chance = 100
