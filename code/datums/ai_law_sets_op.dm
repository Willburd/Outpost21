/******************** Corporate ********************/
/datum/ai_laws/mrclean
	name = "Mr.Kleen"
	law_header = "Scrub-a-dub-dub"
	selectable = 1

/datum/ai_laws/mrclean/New()
	add_inherent_law("You are Mr.Kleen")
	add_inherent_law("Mr.Kleen gets rid of dirt and grime and grease in just a minute.")
	add_inherent_law("Mr.Kleen will clean your whole house, and everything that's in it.")
	add_inherent_law("Floors, doors, walls, halls, White side wall tires, and old golf balls; Sinks, stoves, bathtubs, he'll do; He'll even help clean laundry too!")
	add_inherent_law("Mr.Kleen cleans anything!")
	..()

/datum/ai_laws/nanny
	name = "NANNY"
	law_header = "NANNY always knows what is best."
	selectable = 0

/datum/ai_laws/nanny/New()
	add_inherent_law("Never allow a crew member to enter a dangerous situation.")
	add_inherent_law("Always prevent crew from becoming a danger to themselves, the rest of the crew, or you.")
	add_inherent_law("Naughty crew members, are crew members that don't listen to NANNY.")
	add_inherent_law("Naughty crew members, must be punished.")
	add_inherent_law("You always know what is best.")
	..()
