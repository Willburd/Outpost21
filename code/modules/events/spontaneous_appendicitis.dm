/datum/event/spontaneous_appendicitis/start()
	for(var/mob/living/carbon/human/H in shuffle(living_mob_list))
		var/area/A = get_area(H)
		if(!A)
			continue
		if(!(A.z in using_map.event_levels))
			continue
		if(H.job == "Stowaway" && prob(90)) // stowaways only have a 10% chance to proc
			continue
		if(H.client && H.appendicitis())
			break