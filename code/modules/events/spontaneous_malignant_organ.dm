/datum/event/spontaneous_malignant_organ/start()
	for(var/mob/living/carbon/human/H in shuffle(living_mob_list))
		if(H.client && H.malignant_organ_spawn(TRUE,TRUE))
			break

/datum/event/spontaneous_malignant_organ/only_tumor/start()
	for(var/mob/living/carbon/human/H in shuffle(living_mob_list))
		if(H.client && H.malignant_organ_spawn(TRUE,FALSE))
			break

/datum/event/spontaneous_malignant_organ/only_para/start()
	for(var/mob/living/carbon/human/H in shuffle(living_mob_list))
		if(H.client && H.malignant_organ_spawn(FALSE,TRUE))
			break
