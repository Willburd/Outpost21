/decl/emote/visible/ragescree
	key = "ragescree"
	emote_message_1p = "You begin screaming!"
	emote_message_3p = "begins screaming!"
	emote_sound = 'sound/voice/ragescree.ogg'
	emote_delay = 4.5 SECONDS

/decl/emote/visible/ragescree/do_extra(mob/user)
	. = ..()
	// VOREStation Add - Fancy flips
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.Stun(5)
		H.make_jittery(115)
