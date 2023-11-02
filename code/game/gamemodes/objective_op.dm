/datum/objective/consume
	var/digested = 0
	target_amount = 1
	explanation_text = "Not yet init. Use child versions for proper explaination texts!"

/datum/objective/consume/check_completion()
	var/total_amount = digested // start with digested count

	if(!isnull(owner) && !isnull(owner.current) && owner.current.stat < DEAD && !isnull(owner.current.vore_organs))
		for(var/B in owner.current.vore_organs)
			for(var/mob/living/L in B)
				if(ishuman(L))
					// counts for crew eaten!
					total_amount += 1

	return total_amount >= target_amount




/datum/objective/consume/hunter/New(var/mincount,var/maxcount)
	target_amount = rand(mincount,maxcount)
	. = ..("At least [target_amount] crew members, must be digested, absorbed, or contained inside you. A good hunter encourages their prey to keep their numbers plentiful.")


/datum/objective/consume/deephunger/New(var/mincount,var/maxcount)
	target_amount = rand(mincount,maxcount)
	. = ..("At least [target_amount] crew members, who are not possessed, must be digested, absorbed, or contained inside you. If you run out of prey, find out how to make more.")
