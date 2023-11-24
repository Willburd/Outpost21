#define SYNX_NOODLE_LOWER_DAMAGE 1 //Using defines to make damage easier to tweak for hacky burn attack code.
#define SYNX_NOODLE_UPPER_DAMAGE 2
#define SYNX_LOWER_DAMAGE 2
#define SYNX_UPPER_DAMAGE 6

#define SYNX_MOVE_NORMAL 5
#define SYNX_MOVE_NOODLE 3

/mob/living/simple_mob/vore/alienanimals/synx //Player controlled variant
	//on inteligence https://synx.fandom.com/wiki/Behavior/Intelligence //keeping this here for player controlled synxes.
	name = "Synx"
	real_name = "Synx"
	desc = "A cold blooded, genderless, parasitic eel from the more distant and stranger areas of the cosmos. Plain, white, perpetually grinning and possessing a hunger as enthusiastic and endless as humanity's sense of exploration."
	tt_desc = "synxus pergulus"

	// Synx species belongs to ChimeraSynx, Base sprites made by: SpitefulCrow
	icon = 'icons/mob/synx.dmi'//giving synxes their own DMI file!
	icon_state = "synx_living"
	icon_living = "synx_living"
	icon_dead = "synx_dead"
	mob_bump_flag = SIMPLE_ANIMAL //This not existing was breaking vore bump for some reason.
	parasitic = TRUE //Digestion immunity var
	enzyme_affect = FALSE
	var/transformed_state = "synx_transformed"
	var/stomach_distended_state = "synx_pet_rainbow" //Proof of concept for now until actual sprite exists

	can_be_antagged = TRUE

	var/list/speak = list()
	var/speak_chance = 0.5 //May have forgotten to read that.
	// Synx speech code overrides normal speech code but is still a x in 200 chance of triggereing, as all mobs do.
	// VAR$ SETUP
	// annoying for player controlled synxes.
	var/poison_per_bite = 1 //Even with 2 this was OP with a 99% injection chance
	var/poison_chance = 99.666
	var/poison_type = "synxchem"//inaprovalin, but evil
	var/memorysize = 50 //Var for how many messages synxes remember if they know speechcode
	var/list/voices = list()
	var/acid_damage_lower = SYNX_LOWER_DAMAGE - 1 //Variables for a hacky way to change to burn damage when they vomit up their stomachs. Set to 1 less than melee damage because it takes a minimum of 1 brute damage for this to activate.
	var/acid_damage_upper = SYNX_UPPER_DAMAGE - 1
	var/stomach_distended = 0 //Check for whether or not the synx has vomitted up its stomach.

	faction = "Synx"
	ai_holder_type = null // added for player controlled variant only.

	maxHealth = 75 // Lowered from 150. 150 is wayyy too high for a noodly stealth predator. - Lo  //That's fair, they're supposed to be weak - Ig
	health = 75
	movement_cooldown = SYNX_MOVE_NORMAL
	see_in_dark = 6
	grab_resist = 2 //slippery. %  grabwill not work. Should be 10-20%. -Lo
	armor = list(			// will be determined
				"melee" = 0, //Changed from 20.They don't have scales or armor. -LO
				"bullet" = 0,
				"laser" = 0,
				"energy" = 0,
				"bomb" = 0, // Same as above. -LO
				"bio" = 50, // Nerfed from 100. They should have some protection against these things, but 100 is pushing it. -Lo
				"rad" = 100) // Keeping 100 rad armor as mobs cannot easily get radiation storm announcements. If this is reduced it'd be a good idea to make it 100 for the ai types.
	has_hands = 1

	response_help  = "pokes and shifts the fur-like bristles on"
	response_disarm = "gently pushes the synx; Dislodging a clump of bristly, and strangely melting, hair from"
	response_harm   = "hits the synx; Ripping out a chunk of sticky, and strangely melting, hair from"


	melee_damage_lower = SYNX_LOWER_DAMAGE // Massive damage reduction, will be balanced with toxin injection/ //LO-  Made up for in skills. Toxin injection does not technically cause damage with these guys. Stomach acid does when they disegage their stomach from their mouths does, but that could be done differently.
	melee_damage_upper = SYNX_UPPER_DAMAGE
	attacktext = list("clawed") // "You are [attacktext] by the mob!"
	var/distend_attacktext = list("smacked")
	var/noodle_attacktext = list("slammed")
	var/initial_attacktext = list("clawed") //I hate needing to do it this way.
	friendly = list("prods") // " The mob [friendly] the person."
	attack_armor_pen = 0	 // How much armor pen this attack has. //Changed from 40. -Lo
	attack_sharp = 1
	attack_edge = 1
	attack_armor_type = "melee" //Default is melee but I'm stating this explicitly to make it more obvious to anybody reading this

	// Vore stuff//leaving most of this here even though its no going to be an AI controlled variant.
	vore_active = 1
	vore_capacity = 2
	vore_pounce_chance = 50
	vore_bump_chance = 10
	vore_bump_emote = "Slowly wraps its tongue around, and slides its drooling maw over the head of"
	vore_standing_too = 1 //I believe this lets it vore standing people, rather than only resting.
	vore_ignores_undigestable = 0 //Synx don't care if you digest or not, you squirm fine either way.
	vore_default_mode = DM_HOLD
	vore_digest_chance = 45		// Chance to switch to digest mode if resisted
	vore_absorb_chance = 0
	vore_escape_chance = 10
	vore_icons = 0 //no vore icons
	swallowTime = 6 SECONDS //Enter the eel you nerd

	// Shouldn't be affected by lack of atmos, it's a space eel. //nah lets give him some temperature
	minbodytemp = 223		//Below -50 Degrees Celcius
	maxbodytemp = 323		//Above 50 Degrees Celcius
	min_oxy = 0
	max_oxy = 0 //Maybe add a max
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0 //Maybe add a max
	min_n2 = 0
	max_n2 = 0 //Maybe add a max
	// TODO: Set a max temperature of about 20-30 above room temperatures. Synx don't like the heat.

/mob/living/simple_mob/vore/alienanimals/synx/ai //AI controlled variant
	ai_holder_type = /datum/ai_holder/simple_mob/retaliate

/mob/living/simple_mob/vore/alienanimals/synx/init_vore()
	.=..()
	var/obj/belly/B = vore_selected
	if(istype(B)) // massive runtime errors everywhere on startup without this, assigning things to null anyway, so would be pointless executing anyway.
		B.vore_verb = "swallow"
		B.name = "stomach"
		B.desc	= "You're pulled into the snug stomach of the synx. The walls knead weakly around you, coating you in thick, viscous fluids that cling to your body, that soon starts to tingle and burn..."
		B.digest_burn = 1
		B.digest_brute = 0
		B.emote_lists[DM_HOLD] = list(
		"The walls churn around you, soaking you in thick, smelling fluid as you're kneaded and rolled about in the surprisingly roomy, but still snug, space.",
		"The unusually cool stomach rolls around you slowly and lazily, trying to almost knead you to sleep gently as the synx pulses around you.",
		"The thick, viscous fluids cling to your body soaking in deep, giving you a full bath with the kneading of the walls helping to make sure you'll be smelling like synx stomach for days."
		)
		B.emote_lists[DM_DIGEST] = list(
		"The stomach kneads roughly around you, squishing and molding to your shape, with the thick fluids clinging to your body and tingling, making it hard to breathe.",
		"Firm churns of the stomach roll and knead you around, your body tingling as fur sizzles all around you, your body getting nice and tenderized for the stomach.",
		"Your body tingles and the air smells strongly of acid, as the stomach churns around you firmly and slowly, eager to break you down.",
		"You're jostled in the stomach as the synx lets out what can only described as an alien belch, the space around you getting even more snug as the thick acids rise further up your body."
		)
		B.digest_messages_prey = list(
		"Your eyes grow heavy as the air grows thin in the stomach, the burning of the acids slowly putting you into a final slumber, adding you to the synx's hips and tail.",
		"Slowly, the stinging and burning of the acids, and the constant churning is just too much, and with a few final clenches, your body is broken down into fuel for the synx.",
		"The acids and fluids rise up above your head, quickly putting an end to your squirming and conciousness.. the stomach eager to break you down completely.",
		"The synx lets out an audible belch, the last of your air going with it, and with a few audible crunches from the outside, the stomach claims you as food for the parasite."
		)
		B.mode_flags = DM_FLAG_NUMBING	//Prey are more docile when it doesn't hurt.

/* //OC-insert mob removals. Commenting out instead of full removal as there's some good detail here.
/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/asteri/init_vore()
	.=..()
	var/obj/belly/B = vore_selected
	B.desc    = "The synx eagerly swallows you, taking you from its gullet into its long, serpentine stomach. The internals around you greedily press into your from all sides, keeping you coated in a slick coat of numbing fluids..."
	B.digest_burn = 2
	B.digest_brute = 0 //no brute should be done. ramping up burn as a result. this is acid. -Lo
	B.emote_lists[DM_HOLD] = list(
	"Your taut prison presses and pads into your body, the synx squeezing around you almost constrictingly tight while the rolling pulses of muscle around you keep your squirms well-contained.",
	"You can feel parts of you sink and press into the squishy stomach walls as the synx's gut seems to relax, the wet ambience of its stomach muffling the parasite's various heartbeats.",
	"You can hear the synx teasingly mimic the sounds you've made while it's eaten you, the stomach walls practically massaging more of numbing fluid into you as its innards do their best to tire you out.",
	)
	B.emote_lists[DM_DIGEST] = list(
	"The stomach gives a crushing squeeze around your frame, its body restraining your movements and pressing digestive fluids deeper into you with overwhelming pressure from all sides..",
	"The synx's insides greedily press into you all over, kneading around your body and softening you up for the slurry of numbing acid that's pooled around your melting frame.",
	"You can hear a cacophony of wet churns and gurgles from the synx's body as it works on breaking you down, the parasite eagerly awaiting your final moments.",
	"The tight, fleshy tunnel constricts around you, making it even harder to breathe the already thin air as the digestive cocktail around you wears you out.",
	)
	B.digest_messages_prey = list(
	"You finally give in to the constricting pressure, softened up enough for the acids around you to turn your entire being into a gooey slop to be pumped through its body.",
	"Slipping past the point of saving, your body gives out on you as the stomach walls grind your goopy remains into a chunky sludge, leaving behind only a few acid-soaked bones for it to stash in the vents.",
	"The constant fatal massage pulls you under, your conciousness fading away as you're drawn into a numb, permanent sleep. The body you leave behind is put to good use as a few extra pounds on the synx's frame, its now-wider hips making it just a little harder to squeeze through the vents it's so fond of.",
	"The synx's body gleefully takes what's left of your life, Asteri's usually-repressed sadism overwhelmed with a sinister satisfaction in snuffing you out as your liquefied remains gush into a bit more heft on the parasite's emaciated frame.",
	)
*/

/mob/living/simple_mob/vore/alienanimals/synx/New() //this is really cool. Should be able to ventcrawl canonicaly, contort, and make random speech.
	// some things should be here that arent tho.
	..()
	verbs |= /mob/living/proc/ventcrawl
//	verbs |= /mob/living/simple_mob/vore/alienanimals/synx/proc/distend_stomach //to do later: sprites of stomach outside the body. //Commenting out until it's done - Ig
	verbs |= /mob/living/simple_mob/vore/alienanimals/synx/proc/contort
	verbs |= /mob/living/simple_mob/vore/alienanimals/synx/proc/sonar_ping
	verbs |= /mob/living/proc/shred_limb
	verbs |= /mob/living/simple_mob/vore/alienanimals/synx/proc/randomspeech
	real_name = name
	voices += "Garbled voice"
	voices += "Unidentifiable Voice"
	speak += "Who is there?"
	speak += "What is that thing?!"

//////////////////////////////////////////////////////////////////////////////////////
///////////////////////////// SPECIAL ITEMS/REAGENTS !!!! ////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
/obj/item/seeds/hardlightseed/typesx
	seed_type = "hardlightseedsx"

/datum/reagent/inaprovaline/synxchem
	name = "Alien nerveinhibitor"
	description = "A toxin that slowly metabolizes damaging the person, but makes them unable to feel pain."
	id = "synxchem"
	metabolism = REM * 0.1 //Slow metabolization to try and mimic permanent nerve damage without actually being too cruel to people
	color = "#FFFFFF"
	overdose = REAGENTS_OVERDOSE * 4 //But takes a lot to OD

/datum/reagent/inaprovaline/synxchem/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien != IS_DIONA)
		if(prob(8))
			M.custom_pain("You [pick("feel numb!","feel dizzy and heavy.","feel strange!")]",60)
		if(prob(2))
			M.custom_pain("You [pick("suddenly lose control over your body!", "can't move!", "are frozen in place.", "can't struggle!")]",60)
			M.AdjustParalysis(1)
	// 	M.add_chemical_effect(CE_STABLE, 15)
		M.add_chemical_effect(CE_PAINKILLER, 60)
		// M.adjustToxLoss(0.4) //Dealing twice of it as tox, even if you have no brute, its not true conversion. Synxchem without stomach shoved out of its mouth isn't going to do tox. -Lo
	//	M.adjustHalLoss(1) //we do not need halloss as well as paralyze. lo-

/datum/reagent/inaprovaline/synxchem/holo
	name = "SX type simulation nanomachines" //Educational!
	description = "Type SX nanomachines to simulate what it feels like to come in contact with a synx, minus the damage"
	id = "fakesynxchem"
	metabolism = REM * 1 //ten times faster for convenience of testers.
	color = "#00FFFF"
	overdose = REAGENTS_OVERDOSE * 20 //it's all fake. But having nanomachines move through you is not good at a certain amount.

/datum/reagent/inaprovaline/synxchem/holo/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien != IS_DIONA)
		if(prob(5))
			M.custom_pain("You feel no pain!",60)
		if(prob(2))
			M.custom_pain("You suddenly lose control over your body!",60)
			M.AdjustParalysis(1)
		M.add_chemical_effect(CE_STABLE, 15)
		M.add_chemical_effect(CE_PAINKILLER, 50)
		M.adjustBruteLoss(-0.2)//Made to simulate combat, also useful as very odd healer.
		M.adjustToxLoss(-0.2) //HELP ITS MAULING ME!
		M.adjustFireLoss(-0.2) //huh this mauling aint so bad
		//M.adjustHalLoss(10) //OH MY GOD END MY PAIN NOW WHO MADE THIS SIMULATION //Removing because this is spammy and stunlocks for absurd durations

/datum/reagent/inaprovaline/synxchem/clown
	name = "HONK"
	description = "HONK"
	id = "clownsynxchem"
	metabolism = REM * 0.5
	color = "#FFFFFF"
	overdose = REAGENTS_OVERDOSE * 200

/datum/reagent/inaprovaline/synxchem/clown/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.adjustToxLoss(0.01)
	playsound(M.loc, 'sound/items/bikehorn.ogg', 50, 1)
	M.adjustBruteLoss(-2)//healing brute
	if(prob(1))
		M.custom_pain("I have no horn but I must honk!",60)
	if(prob(2))
		var/location = get_turf(M)
		new /obj/item/weapon/bikehorn(location)
		M.custom_pain("You suddenly cough up a bikehorn!",60)

/datum/reagent/inaprovaline/synxchem/overdose(var/mob/living/carbon/M, var/alien, var/removed)
	..()
	if(alien != IS_DIONA)
		M.make_dizzy(10)
		if(prob(5))
			M.AdjustStunned(1)
		if(prob(2))
			M.AdjustParalysis(1)

/datum/reagent/inaprovaline/synxchem/holo/overdose(var/mob/living/carbon/M, var/alien, var/removed)
	return

/datum/reagent/inaprovaline/synxchem/clown/overdose(var/mob/living/carbon/M, var/alien, var/removed)
	return


//////////////////////////////////////////////////////////////////////////////////////
///////////////////////////// PASSIVE POWERS!!!! /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// nevermind. I added any roleplay flavor weird fur mechanics to happen when you touch or attack the synx.

/mob/living/simple_mob/vore/alienanimals/synx/apply_melee_effects(var/atom/A) //Re-adding this for AI synx
	if(stomach_distended) //Hacky burn damage code
		if(isliving(A)) //Only affect living mobs, should include silicons. This could be expanded to deal special effects to acid-vulnerable objects.
			var/mob/living/L = A
			var/armor_modifier = abs((L.getarmor(null, "bio") / 100) - 1) //Factor in victim bio armor
			var/amount = rand(acid_damage_lower, acid_damage_upper) //Select a damage value
			var/damage_done = amount * armor_modifier
			if(damage_done > 0) //sanity check, no healing the victim if somehow this is a negative value.
				L.adjustFireLoss(damage_done)
				return
			else
				to_chat(src,"<span class='notice'>Your stomach bounces off of the victim's armor!</span>")
				return
		return // If stomach is distended, return here to perform no forcefeeding or poison injecton.

	if(!(status_flags & HIDING))
		// only apply synx stabs when not hiding
		if(isliving(A))
			var/mob/living/L = A
			if(L.reagents)
				var/target_zone = pick(BP_TORSO,BP_TORSO,BP_TORSO,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_HEAD)
				if(L.can_inject(src, null, target_zone))
					if(prob(poison_chance))
						to_chat(L, "<span class='warning'>You feel a strange substance on you.</span>")
						L.reagents.add_reagent(poison_type, poison_per_bite)

/mob/living/simple_mob/vore/alienanimals/synx/hear_say(var/list/message_pieces, var/verb = "says", var/italics = 0, var/mob/speaker = null, var/sound/speech_sound, var/sound_vol)
	. = ..()

	var/list/combined = combine_message(message_pieces, verb, speaker)
	var/message = combined["raw"]
	if(!message || !speaker)
		return
	if(message == "")
		return
	if (speaker == src)
		return

	speaker = speaker.GetVoice()
	speak += message
	voices += speaker
	if(voices.len>=memorysize)
		voices -= (pick(voices)) // making the list more dynamic
	if(speak.len>=memorysize)
		speak -= (pick(speak)) // making the list more dynamic
	if(resting)
		resting = !resting
	if(message=="Honk!")
		bikehorn()

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/clown/Life()
	..()
	if(vore_fullness)
		size_multiplier = 1+(0.5*vore_fullness)
		update_icons()
	if(!vore_fullness && size_multiplier != 1)
		size_multiplier = 1
		update_icons()
/mob/living/simple_mob/vore/alienanimals/synx/Life()
	..()
	if(isnull(key) && voices && prob(speak_chance)) // only AI randomly speaks
		randomspeech()

/mob/living/simple_mob/vore/alienanimals/synx/perform_the_nom(mob/living/user, mob/living/prey, mob/living/pred, obj/belly/belly, delay) // Synx can only eat people if their organs are on the inside.
	if(stomach_distended)
		to_chat(src,"<span class='notice'>You can't eat with your stomach outside of you!</span>")
		return
	else
		..()

//////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// POWERS!!!! /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

/mob/living/simple_mob/vore/alienanimals/synx/proc/contort()
	set name = "Contort"
	set desc = "Switch between amorphous and humanoid forms. Allows you to hide beneath tables or certain items while amorphous."
	set category = VERBTAB_POWERS

	if(stat == DEAD || paralysis || weakened || stunned || restrained())
		return
	if(stomach_distended)
		to_chat(src,"<span class='warning'>You can't disguise with your stomach outside of your body!</span>")
		return

	if(status_flags & HIDING)
		// prepare to enter ambush attack mode
		if(do_after(src, 3 SECONDS))
			icon_living = transformed_state //Switch state to transformed state
			status_flags &= ~HIDING
			pass_flags &= ~PASSTABLE
			reset_plane_and_layer()
			to_chat(src,"<span class='warning'>You changed back into your disguise.</span>")
			movement_cooldown = SYNX_MOVE_NORMAL
			// perform melee attacks with claws now. These also do injections!
			attacktext = initial_attacktext
			melee_damage_lower = SYNX_LOWER_DAMAGE
			melee_damage_upper = SYNX_UPPER_DAMAGE
			update_icons()
	else
		// noodle escape time
		icon_living = initial(icon_living) //Switch state to what it was originally defined.
		status_flags |= HIDING
		layer = HIDING_LAYER //Just above cables with their 2.44
		pass_flags |= PASSTABLE // actually let you hide as a worm should
		plane = OBJ_PLANE
		to_chat(src,"<span class='warning'>Now they see your true form.</span>")
		movement_cooldown = SYNX_MOVE_NOODLE
		// weak noodle bonks while contorted
		attacktext = noodle_attacktext
		melee_damage_lower = SYNX_NOODLE_LOWER_DAMAGE
		melee_damage_upper = SYNX_NOODLE_UPPER_DAMAGE
		update_icons()


/mob/living/simple_mob/vore/alienanimals/synx/proc/randomspeech()
	set name = "speak"
	set desc = "Take a sentence you've heard and speak it."
	set category = VERBTAB_IC
	if(stomach_distended)
		usr << "<span class='notice'>You can't speak with your stomach outside of you!</span>"
	else if(speak && voices)
		handle_mimic()
	else
		usr << "<span class='warning'>YOU NEED TO HEAR THINGS FIRST, try using Ventcrawl to eevesdrop on nerds.</span>"

/mob/living/simple_mob/vore/alienanimals/synx/proc/handle_mimic()
	name = pick(voices)
	spawn(2)
		src.say("![html_decode(pick(speak))]") // noise language
	spawn(5)
		name = real_name

//lo- procs adjusted to mobs.

/mob/living/simple_mob/vore/alienanimals/synx
	var/next_sonar_ping = 0

/mob/living/simple_mob/vore/alienanimals/synx/proc/sonar_ping()
	set name = "Listen In"
	set desc = "Allows you to listen in to movement and noises around you."
	set category = VERBTAB_IC

	if(incapacitated())
		to_chat(src, "<span class='warning'>You need to recover before you can use this ability.</span>")
		return
	if(world.time < next_sonar_ping)
		to_chat(src, "<span class='warning'>You need another moment to focus.</span>")
		return
	if(is_deaf() || is_below_sound_pressure(get_turf(src)))
		to_chat(src, "<span class='warning'>You are for all intents and purposes currently deaf!</span>")
		return
	next_sonar_ping += 10 SECONDS
	var/heard_something = FALSE
	to_chat(src, "<span class='notice'>You take a moment to listen in to your environment...</span>")
	for(var/mob/living/L in range(client.view, src))
		var/turf/T = get_turf(L)
		if(!T || L == src || L.stat == DEAD || is_below_sound_pressure(T))
			continue
		heard_something = TRUE
		var/feedback = list()
		feedback += "<span class='notice'>There are noises of movement "
		var/direction = get_dir(src, L)
		if(direction)
			feedback += "towards the [dir2text(direction)], "
			switch(get_dist(src, L) / client.view)
				if(0 to 0.2)
					feedback += "very close by."
				if(0.2 to 0.4)
					feedback += "close by."
				if(0.4 to 0.6)
					feedback += "some distance away."
				if(0.6 to 0.8)
					feedback += "further away."
				else
					feedback += "far away."
		else // No need to check distance if they're standing right on-top of us
			feedback += "right on top of you."
		feedback += "</span>"
		to_chat(src,jointext(feedback,null))
	if(!heard_something)
		to_chat(src, "<span class='notice'>You hear no movement but your own.</span>")

/mob/living/simple_mob/vore/alienanimals/synx/proc/distend_stomach()
	set name = "Distend Stomach"
	set desc = "Allows you to throw up your stomach, giving your attacks burn damage at the cost of your stomach contents going everywhere. Yuck."
	set category = VERBTAB_POWERS

	if(!stomach_distended) //true if stomach distended is null, 0, or ""
		stomach_distended = !stomach_distended //switch statement
		to_chat (src, "<span class='notice'>You disgorge your stomach, spilling its contents!</span>")
		melee_damage_lower = 1 //Hopefully this will make all brute damage not apply while stomach is distended. I don't see a better way to do this.
		melee_damage_upper = 1
		icon_living = stomach_distended_state
		attack_armor_type = "bio" //apply_melee_effects should handle all burn damage code so this might not be necessary.
		attacktext = distend_attacktext

		for(var/belly in src.vore_organs) //Spit out all contents because our insides are now outsides
			var/obj/belly/B = belly
			for(var/atom/movable/A in B)
				playsound(src, 'sound/effects/splat.ogg', 50, 1)
				B.release_specific_contents(A)
		update_icons()
		return

	if(stomach_distended) //If our stomach has been vomitted
		stomach_distended = !stomach_distended
		to_chat (src, "<span class='notice'>You swallow your insides!</span>")
		melee_damage_lower = SYNX_LOWER_DAMAGE //This is why I'm using a define
		melee_damage_upper = SYNX_UPPER_DAMAGE
		icon_living = initial(icon_living)
		attack_armor_type = "melee"
		attacktext = initial_attacktext
		update_icons()
		return

////////////////////////////////////////
////////////////SYNX DEBUG//////////////
////////////////////////////////////////
/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/debug
	name = "Syntox"
	desc = "ERROR Connection to translation server could not be established!"

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/debug/proc/rename()
	set name = "rename"
	set desc = "Renames the synx"
	set category = VERBTAB_DEBUG
	name = input(usr, "What would you like to change name to?", "Renaming", null)

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/debug/proc/redesc()
	set name = "redesc"
	set desc = "Redescribes the synx"
	set category = VERBTAB_DEBUG
	desc = input(usr, "What would you like to change desc to?", "Redescribing", null)

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/debug/proc/resprite()
	set name = "resprite"
	set desc = "Resprite the synx"
	set category = VERBTAB_DEBUG
	icon_state = input(usr, "What would you like to change icon_state to?", "Respriting", null)

/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/debug/New()
	verbs |= /mob/living/simple_mob/vore/alienanimals/synx/ai/pet/debug/proc/rename
	verbs |= /mob/living/simple_mob/vore/alienanimals/synx/ai/pet/debug/proc/resprite
	verbs |= /mob/living/simple_mob/vore/alienanimals/synx/ai/pet/debug/proc/redesc

////////////////////////////////////////
////////////////SYNX SPAWNER////////////
////////////////////////////////////////
/obj/random/mob/synx
	name = "This is synxes"

/obj/random/mob/synx/item_to_spawn()
	return pick(prob(80);/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/grins,
		prob(33);/mob/living/simple_mob/vore/alienanimals/synx/ai/pet/holo,
		prob(50);/mob/living/simple_mob/vore/alienanimals/synx/ai,) //normal eel boyo.

#undef SYNX_LOWER_DAMAGE
#undef SYNX_UPPER_DAMAGE
#undef SYNX_NOODLE_LOWER_DAMAGE
#undef SYNX_NOODLE_UPPER_DAMAGE
#undef SYNX_MOVE_NORMAL
#undef SYNX_MOVE_NOODLE
