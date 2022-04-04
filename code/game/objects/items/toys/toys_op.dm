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