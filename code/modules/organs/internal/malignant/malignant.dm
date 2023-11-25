// malignant organs! Develops randomly from radiation exposure and events!
/obj/item/organ/internal/malignant
	organ_tag = "malignant" // gets a random number after, to allow multiple organs!
	icon = 'icons/obj/surgery_op.dmi'
	var/validBPsites = list(BP_GROIN, BP_TORSO, BP_HEAD, BP_L_ARM, BP_R_ARM, BP_L_HAND, BP_R_HAND, BP_L_FOOT, BP_R_FOOT, BP_L_LEG, BP_R_LEG) // copy of BP_ALL

	var/cooldown = 0
	var/cooldownmin = 0
	var/cooldownmax = 0

/obj/item/organ/internal/malignant/New(var/mob/living/holder, var/internal, var/force_location = null)
	// choose a random site for us to grow in before calling parent
	organ_tag = "[initial(organ_tag)]_[rand(999,9999)]"
	var/i = 0
	if(!force_location)
		while(++i < 10)
			// done here, because New() does all the setup for placing the organ...
			// attempt to select a valid exterior organ that isn't synthetic!
			parent_organ = pick(validBPsites)
			if(isliving(holder))
				var/obj/item/organ/checklimb = holder.organs_by_name[parent_organ]
				if(checklimb)
					// valid limb, check if organic!
					if(checklimb.status == 0 && checklimb.robotic < ORGAN_ROBOT)
						return ..( holder, internal)
	else
		parent_organ = force_location
		return ..( holder, internal)
	// invalid, spawn as dead...
	status = ORGAN_DEAD

/mob/living/carbon/human/proc/malignant_organ_spawn( var/allowtumors = TRUE, var/allowparasites = TRUE)
	if(stat == DEAD)
		return FALSE
	if(isSynthetic())
		return FALSE
	if(!species)
		return FALSE
	if(species.reagent_tag == IS_DIONA || species.reagent_tag == IS_SLIME)
		return

	// get a list of valid malignant organs and spawn one
	var/list/paths = list()
	if(allowtumors)
		paths += subtypesof(/obj/item/organ/internal/malignant/tumor)
	if(allowparasites)
		paths += subtypesof(/obj/item/organ/internal/malignant/parasite)
	// place in body
	var/neworganpath = pick(paths)
	var/obj/item/organ/internal/malignant/neworgan = new neworganpath( src, TRUE)
	if(neworgan.status == 0) // healthy new organ spawned... Otherwise this is a failure...
		return TRUE
	// welp, clean up.
	neworgan.Destroy()
	return FALSE



/obj/item/organ/internal/malignant/tumor
	name = "tumor"
	icon_state = "tumor"
	//dead_icon = "tumor-dead"

	var/stage = 1
	var/stage_progress = 0



/obj/item/organ/internal/malignant/parasite
	name = "parasite"
	icon_state = "parasite"
	dead_icon = "parasite-dead"

	validBPsites = list(BP_GROIN, BP_TORSO, BP_HEAD) // unlike tumors, we like certain other places!
	can_reject = 0

	var/feedchance = 1 	// fixed chance that parasite will feed this loop
	var/growth = 1 		// some parasites grow! the feedmod vars get multiplied by it as it does!
	var/feedmodmin = 1
	var/feedmodmax = 2

/obj/item/organ/internal/malignant/parasite/process()
	. = ..()

	if(cooldown > 0)
		cooldown--
		return

	if(!owner)
		return

	if(prob(feedchance))
		cooldown = rand(cooldownmin,cooldownmax)
		if(feed())
			growth++

/obj/item/organ/internal/malignant/parasite/proc/feed()
	// perform actions based on the parasite
	if(feedmodmax > 0)
		if(owner.nutrition > 0)
			owner.nutrition = max(owner.nutrition - rand( growth * feedmodmin, growth * feedmodmax),0)
		else
			owner.remove_blood(1 + rand( growth * feedmodmin, growth * feedmodmax))
	// by default, don't grow. Other parasites might thought!
	return FALSE



/obj/item/organ/internal/malignant/engineered
	name = "engineered"
	icon_state = "engineered"
	dead_icon = "engineered-dead"
	can_reject = 0


/****************************************************
				Tumor varients
		these eventually kill you in some strange unique way.
****************************************************/

// cancer! *party blower*! Causes various bad symptoms, and eventually internally bleeds you to death.
/obj/item/organ/internal/malignant/tumor/cancer
	name = "tumor"
	cooldownmin = 15
	cooldownmax = 25

/obj/item/organ/internal/malignant/tumor/cancer/process()
	. = ..()

	if(cooldown > 0)
		cooldown--
		return

	if(!owner)
		return

	if(++stage_progress > 300)
		++stage
		stage_progress = rand(100,200)

	if(stage == 1)
		if(prob(1))
			owner.Weaken(2)
			cooldown = rand(cooldownmin,cooldownmax)
	if(stage > 1)
		if(prob(1))
			owner.Weaken(3)
			owner.adjustToxLoss(3)
			owner.nutrition = max(owner.nutrition - rand(1,5),0)
			cooldown = rand(cooldownmin,cooldownmax)
	if(stage > 2)
		if(prob(1))
			switch(parent_organ)
				if(BP_GROIN)
					owner.vomit()
				if(BP_HEAD)
					if(prob(30))
						owner.vomit()
					else if(prob(30))
						owner.make_dizzy(90)
					else
						owner.Confuse(20)
			owner.nutrition = max(owner.nutrition - rand(1,5),0)
			cooldown = rand(cooldownmin,cooldownmax)
	if(stage > 3)
		if(prob(1))
			var/obj/item/organ/external/bodypart = owner.get_organ(parent_organ)
			var/datum/wound/W = new /datum/wound/internal_bleeding(2)
			bodypart.wounds += W
			owner.Weaken(10)
			owner.adjustToxLoss(20)
			owner.nutrition = max(owner.nutrition - rand(1,5),0)
			cooldown = rand(cooldownmin,cooldownmax)


// WHERE SOIL. Simple toxin damage that makes you throwup and lose nutrition sometimes
/obj/item/organ/internal/malignant/tumor/potato
	name = "mimetic potato"
	icon_state = "potato"
	validBPsites = list(BP_GROIN, BP_TORSO)
	cooldownmin = 15
	cooldownmax = 35

/obj/item/organ/internal/malignant/tumor/potato/process()
	. = ..()

	if(cooldown > 0)
		cooldown--
		return

	if(prob(3))
		owner.adjustToxLoss(2)
		owner.nutrition = max(owner.nutrition - rand(1,5),0)

	if(prob(2))
		owner.vomit()
		cooldown = rand(cooldownmin,cooldownmax)

/obj/item/organ/internal/malignant/tumor/potato/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/material/knife))
		new /obj/item/weapon/reagent_containers/food/snacks/rawsticks(get_turf(src))
		to_chat(user, "<span class='notice'>You cut the mimetic potato.</span>")
		qdel(src)
		return
	. = ..()




// pinata makes you eventually explode into candy
/obj/item/organ/internal/malignant/tumor/pinata
	name = "pinata gland"
	icon_state = "pinata"

/obj/item/organ/internal/malignant/tumor/pinata/process()
	. = ..()

	if(stage_progress == 0)
		stage_progress = rand(10,60)
	stage_progress++

	if(cooldown > 0)
		cooldown--
		return

	if(stage_progress > 350)
		pop()
		return

	if(!owner)
		return

	if(prob(2))
		if(prob(30))
			owner.vomit()
		else if(prob(30))
			owner.make_dizzy(20)
		else
			owner.Confuse(30)

	if(prob(2))
		if(stage_progress > 200)
			to_chat(owner, "<span class='danger'>The pressure inside you hurts.</span>")
			owner.custom_emote(VISIBLE_MESSAGE, "winces painfully.")
		else if(stage_progress > 100)
			to_chat(owner, "<span class='warning'>You feel a pressure inside you.</span>")
			owner.custom_emote(VISIBLE_MESSAGE, "winces painfully.")
		else
			to_chat(owner, "<span class='warning'>You feel bloated.</span>")
			owner.custom_emote(VISIBLE_MESSAGE, "winces slightly.")

/obj/item/organ/internal/malignant/tumor/pinata/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(can_puncture(W))
		pop()
		return
	. = ..()

/obj/item/organ/internal/malignant/tumor/pinata/proc/pop()
	// place a ton of candy at location, then delete organ!
	var/count = rand(20,30)
	while(count-- > 0)
		var/picker = pick(/obj/item/clothing/mask/chewable/candy/gum,/obj/item/clothing/mask/chewable/candy/lolli,/obj/item/weapon/reagent_containers/food/snacks/candy/gummy,/obj/item/weapon/reagent_containers/food/snacks/candy_corn)
		var/obj/item/newcandy = new picker()
		newcandy.loc = src.loc

	var/turf/T = loc
	if(owner)
		// SURPRISE!
		playsound(owner, 'sound/items/bikehorn.ogg', 50, 1)
		playsound(src, 'sound/effects/snap.ogg', 50, 1)
		owner.gib()
		T = owner.loc
	else
		// only the organ pops!
		playsound(src, 'sound/items/bikehorn.ogg', 50, 1)
		playsound(src, 'sound/effects/snap.ogg', 50, 1)

	// YAYYYYY
	if(!turf_clear(T))
		T = get_turf(src)
	new /obj/effect/decal/cleanable/confetti(T)
	Destroy()


// Teleports you randomly, until it gets you killed
/obj/item/organ/internal/malignant/tumor/bluespace
	name = "bluespace tumor"
	icon_state = "tumor"
	validBPsites = list(BP_GROIN, BP_TORSO)
	cooldownmin = 25
	cooldownmax = 65

/obj/item/organ/internal/malignant/tumor/bluespace/process()
	. = ..()

	if(cooldown > 0)
		cooldown--
		return

	if(!owner)
		return

	if(stage_progress == 0)
		stage_progress = rand(10,60)
	stage_progress++

	if(stage_progress > 300 && stage < 6)
		stage++
		stage_progress = 0

	if(prob(stage * 2))
		var/outer_teleport_radius = stage * 2
		var/inner_teleport_radius = stage / 2

		var/list/turfs = list()
		if(inner_teleport_radius > 0)
			for(var/turf/T in orange(owner,outer_teleport_radius))
				if(get_dist(owner,T) >= inner_teleport_radius)
					turfs |= T

		if(turfs.len)
			// Moves the mob, causes sparks.
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(3, 1, get_turf(owner))
			s.start()
			var/turf/picked = get_turf(pick(turfs))                      // Just in case...
			owner.loc = picked                                          // And teleport them to the chosen location.
		cooldown = rand(cooldownmin,cooldownmax)


// Get you drunk constantly until liver failure
/obj/item/organ/internal/malignant/tumor/beerbelly
	name = "beerbelly"
	icon_state = "tumor"
	validBPsites = list(BP_GROIN)
	cooldownmin = 25
	cooldownmax = 95

/obj/item/organ/internal/malignant/tumor/beerbelly/process()
	. = ..()

	if(!owner)
		return

	if(cooldown > 0)
		cooldown--
		return

	if(stage_progress == 0)
		stage_progress = rand(10,60)
	stage_progress++

	if(stage_progress > 350 && stage < 10)
		stage++
		stage_progress = 0

	if(prob(12))
		owner.bloodstr.add_reagent( "ethanol", stage * 2)
		cooldown = rand(cooldownmin,cooldownmax)


// Get you drunk constantly until liver failure
/obj/item/organ/internal/malignant/tumor/moneyorgan
	name = "crypto-cache"
	icon_state = "tumor"
	cooldownmin = 15
	cooldownmax = 25
	var/thalers = 0

/obj/item/organ/internal/malignant/tumor/moneyorgan/process()
	. = ..()

	if(!owner)
		return

	if(cooldown > 0)
		cooldown--
		return

	stage_progress++
	if(stage_progress > 150 && stage < 100)
		stage++
		stage_progress = 0

	if(prob(6))
		thalers += stage

	if(prob(2))
		if(thalers < 100)

		else if(thalers < 500)
			to_chat(owner, "<span class='warning'>You feel bloated.</span>")
			owner.custom_emote(VISIBLE_MESSAGE, "winces slightly.")
		else if(thalers < 1000)
			to_chat(owner, "<span class='warning'>You feel a pressure inside you.</span>")
			owner.custom_emote(VISIBLE_MESSAGE, "winces painfully.")
			if(prob(30))
				owner.vomit()
			else if(prob(30))
				owner.make_dizzy(10)
			else
				owner.Confuse(15)
		else if(thalers < 5000)
			to_chat(owner, "<span class='danger'>The pressure inside you hurts.</span>")
			owner.custom_emote(VISIBLE_MESSAGE, "winces painfully.")
			owner.Weaken(3)
			if(prob(30))
				owner.Stun(10)
				owner.Paralyse(4)
			if(prob(30))
				owner.vomit()
			else if(prob(30))
				owner.make_dizzy(20)
			else
				owner.Confuse(30)
		else
			pop()
		cooldown = rand(cooldownmin,cooldownmax)

/obj/item/organ/internal/malignant/tumor/moneyorgan/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(can_puncture(W))
		pop()
		return
	. = ..()

/obj/item/organ/internal/malignant/tumor/moneyorgan/proc/pop()
	if(owner)
		owner.gib()

	playsound(src, 'sound/effects/snap.ogg', 50, 1)

	// place a ton of money at location, then delete organ!
	while(thalers > 1000)
		thalers -= 1000
		spawn_money(1000, src.loc)
	while(thalers > 500)
		thalers -= 500
		spawn_money(500, src.loc)
	while(thalers > 50)
		thalers -= 50
		spawn_money(50, src.loc)
	while(thalers > 5)
		thalers -= 5
		spawn_money(5, src.loc)
	while(thalers > 1)
		thalers -= 1
		spawn_money(1, src.loc)
	Destroy()


/****************************************************
				Parasite varients
		these produce something into your bloodstream.
		consuming nutrition, blood instead if starving
****************************************************/

// Makes all pain go away, gets greedy for food!
/obj/item/organ/internal/malignant/parasite/painleech
	name = "suffering-sucker"
	feedchance = 4
	feedmodmin = 6
	feedmodmax = 11
	cooldownmin = 20
	cooldownmax = 50

/obj/item/organ/internal/malignant/parasite/painleech/feed()
	..()
	owner.add_chemical_effect(CE_PAINKILLER, 10 + (growth * 20))
	return prob(10) && growth < 10


// honks and tells you jokes in your head
/obj/item/organ/internal/malignant/parasite/honker
	name = "honkworm"
	//icon_state = "honker"
	feedchance = 4
	feedmodmin = 2
	feedmodmax = 3
	cooldownmin = 30
	cooldownmax = 60

/obj/item/organ/internal/malignant/parasite/honker/feed()
	..()
	if(prob(80))
		var/sound = pick( list('sound/misc/sadtrombone.ogg','sound/items/bikehorn.ogg'))
		playsound(owner, sound, 50, 1)
	else
		var/jokelist = list("honk", \
							"hehe", \
							"beep", \
							"boing", \
							"wowzers")
		owner.say(pick(jokelist))
	return prob(5) && growth < 3


// Makes you high periodically
/obj/item/organ/internal/malignant/parasite/gethigh
	name = "woggler"
	feedchance = 4
	feedmodmin = 6
	feedmodmax = 11
	cooldownmin = 10
	cooldownmax = 40

/obj/item/organ/internal/malignant/parasite/gethigh/feed()
	..()
	owner.druggy = max(owner.druggy, 10 + (growth * 20))
	return prob(6) && growth < 5


/****************************************************
				Engineered varients
	specialized organs, made to be surgically grafted into people.
	Will find lots of use with abductors in the future!
	These are not randomly given!
****************************************************/
