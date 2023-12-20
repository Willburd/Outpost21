/obj/item/toy/plushie/jil
	name = "Jil plushie"
	desc = "A small plush ball of fluff, this one will only steal your heart!"
	icon = 'icons/obj/toy_op.dmi'
	icon_state = "plushie_jil"
	var/cooldown = 0

/obj/item/toy/plushie/jil/attack_self(mob/user as mob)
	if(!cooldown)
		playsound(user, 'sound/voice/merp.ogg', 10, 0)
		src.visible_message("<span class='danger'>Merp!</span>")
		cooldown = 1
		addtimer(CALLBACK(src, .proc/cooldownreset), 50)
	return ..()

/obj/item/toy/plushie/jil/proc/cooldownreset()
	cooldown = 0

/obj/item/toy/plushie/tinytin
	name = "tiny tin plushie"
	desc = "A tiny fluffy nevrean plush with the label 'Tiny-Tin.' Press his belly to hear a sound!"
	icon = 'icons/obj/toy_op.dmi'
	icon_state = "plushie_tin"
	var/cooldown = 0

/obj/item/toy/plushie/tinytin/attack_self(mob/user as mob)
	if(!cooldown)
		playsound(user, 'sound/voice/peep.ogg', 10, 0)
		src.visible_message("<span class='danger'>Peep peep!</span>")
		cooldown = 1
		addtimer(CALLBACK(src, .proc/cooldownreset), 50)
	return ..()

/obj/item/toy/plushie/tinytin/proc/cooldownreset()
	cooldown = 0


/obj/item/toy/plushie/tinytin/sec
	name = "officer tiny tin plushie"
	desc = "Officer Tiny-Tin, now with rooty-tooty-shooty action! Press his belly to hear a sound!"
	icon = 'icons/obj/toy_op.dmi'
	icon_state = "plushie_tinsec"


/obj/item/toy/plushie/tinytin/sec/attack_self(mob/user as mob)
	if(!cooldown)
		playsound(user, 'sound/misc/tinytin_fuckedup.ogg', 85, 0)
		src.visible_message("<span class='danger'>That means you fucked up!</span>")
		cooldown = 1
		addtimer(CALLBACK(src, .proc/cooldownreset), 50)
	return ..()


/obj/item/toy/plushie/pillow
	name = "plush pillow"
	desc = "A fluffy soft pillow!"
	icon = 'icons/obj/toy_op.dmi'
	icon_state = "plushie_pillow"

/obj/item/toy/plushie/pillow/red
	name = "red plush pillow"
	desc = "A red fluffy soft pillow!"
	icon = 'icons/obj/toy_op.dmi'
	icon_state = "plushie_pillowr"

/obj/item/toy/plushie/pillow/green
	name = "green plush pillow"
	desc = "A green fluffy soft pillow!"
	icon = 'icons/obj/toy_op.dmi'
	icon_state = "plushie_pillowg"

/obj/item/toy/plushie/pillow/blue
	name = "blue plush pillow"
	desc = "A blue fluffy soft pillow!"
	icon = 'icons/obj/toy_op.dmi'
	icon_state = "plushie_pillowb"


//Large plushies.
/obj/structure/plushie/tesh/taaa
	name = "Silly Teshari Plush"
	desc = "A large plush of some huge, colorful teshari."
	icon = 'icons/obj/toy_op.dmi'
	icon_state = "taaa_plush"
	anchored = FALSE
	density = TRUE
	phrase = "WHY!"

/obj/structure/plushie/tesh/gold
	name = "Gold Teshari Plush"
	desc = "A large plush of some a colorful, golden teshari, very huggable!"
	icon = 'icons/obj/toy_op.dmi'
	icon_state = "teshplush_gold"
	anchored = FALSE
	density = TRUE
	phrase = "Chirp!"
