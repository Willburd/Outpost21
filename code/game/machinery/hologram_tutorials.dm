/obj/machinery/hologram/holo_tutorial
	name = "\improper Tutorial holopad"
	desc = "It's a floor-mounted device for projecting holographic images. It activates when you get close to it."
	icon_state = "holopad0"
	show_messages = 1
	circuit = /obj/item/weapon/circuitboard/holopad
	plane = TURF_PLANE
	layer = ABOVE_TURF_LAYER
	idle_power_usage = 0
	use_power = USE_POWER_IDLE

	var/obj/effect/overlay/aiholo/holo
	var/loop_requests = 0
	var/holo_range = 5

	var/speechwait = 0
	var/speechphase = 0
	var/list/dialog = list("TEST1","TEST2")
	var/list/seen_names = list()
	var/speech_delay_seconds = 5

	var/holo_name = "Tutorial"
	var/holo_icon = 'icons/mob/AI.dmi'
	var/holo_state = "holo1"

/obj/machinery/hologram/holo_tutorial/attackby(obj/item/I as obj, user as mob)
	attack_hand(user)
	return

/obj/machinery/hologram/holo_tutorial/attack_hand(var/mob/living/carbon/human/user) //Carn: Hologram requests.
	if(!istype(user))
		return
	loop_requests = 1
	speechphase = 1
	speechwait = world.time + 1 SECOND
	if(!holo)
		create_holo()

/obj/machinery/hologram/holo_tutorial/attack_ai(mob/living/silicon/ai/user)
	return

/obj/machinery/hologram/holo_tutorial/process()
	if(world.time < speechwait)
		return

	if(speechphase > 0)
		if(!holo)
			create_holo()
			speechwait = world.time + 1 SECOND // startup
			return

		if(speechphase <= dialog.len)
			holo.visible_message("<b>\The [holo]</b> says, [dialog[speechphase]]")
			speechphase += 1
		else
			speechphase = 0
			clear_holo()

		speechwait = world.time + (speech_delay_seconds SECONDS)
		return

	// next iteration
	if(loop_requests > 0)
		speechphase = 1
		loop_requests -= 1
	else
		// trigger on nearby humans
		var/list/humans = human_mobs(holo_range)
		if(!humans.len)
			return

		// repeat if anyone in proximity has not heard it
		for(var/mob/living/carbon/human/H in humans)
			var/seenName = FALSE
			for(var/name in seen_names)
				if(H.name == name)
					seenName = TRUE
					break
			if(!seenName)
				seen_names.Add(H.name)
				loop_requests += 1
				speechwait = 0
				break

/obj/machinery/hologram/holo_tutorial/proc/create_holo(turf/T = loc)
	holo = new(T)//Spawn a blank effect at the location. //VOREStation Edit to specific type for adding vars
	holo.icon = getHologramIcon(icon(holo_icon,"[holo_state]"))
	holo.layer = FLY_LAYER//Above all the other objects/mobs. Or the vast majority of them.
	holo.anchored = TRUE//So space wind cannot drag it.
	holo.name = "[holo_name] (Hologram)"//If someone decides to right click.
	holo.set_light(2)	//hologram lighting
	set_light(2)			//pad lighting
	icon_state = "holopad1"
	flick("holopadload", src) //VOREStation Add
	holo.visible_message("A holographic image of [holo] flicks to life right before your eyes!")
	return 1

/obj/machinery/hologram/holo_tutorial/proc/clear_holo()
	set_light(0)			//pad lighting (hologram lighting will be handled automatically since its owner was deleted)
	icon_state = "holopad0"
	holo.Destroy()
	holo = null
	return 1



// Because I don't want to do these mapside, and they're generic enough anyway.
/obj/machinery/hologram/holo_tutorial/intro_1
	dialog = list(	"Hello, and welcome to the standardized employee orientation course. This virtual training course will ensure that you understand the basics of how to operate most, if not all, company equipment!",
					"Proceed through the door on your right, when you are ready to begin. All messages can be repeated, if you click on the holopad beneath me."
					)

/obj/machinery/hologram/holo_tutorial/intro_2
	dialog = list(	"Basic interaction, and you.",
					"In most cases, Left clicking on an object will perform its basic interaction. Such as opening a UI, or turning a switch on or off.",
					"Shift clicking will automatically examine an object or location! Examining will display important information about the object or location.",
					"Right clicking any object or location visible on your screen, will list all currently possible interactions with that object."
					)

/obj/machinery/hologram/holo_tutorial/intro_3
	dialog = list(	"Sometimes, objects will be hidden, or obscured by multiple other objects.",
					"Alt clicking, will show all objects currently in the location clicked, this list will appear at the top right of your window.",
					"Some objects also have interactions caused by alt clicking them. However, you will always be shown the list of objects in a location, as explained before.",
					"Please, pull the lever beneath the plastic flaps to continue."
					)

/obj/machinery/hologram/holo_tutorial/intro_4
	dialog = list(	"Some objects will have unique interactions, if you drag yourself, or another object onto it.",
					"For example, while standing next to railings like these, you can click and drag yourself onto them. This will allow you to climb over the railing."
					)

/obj/machinery/hologram/holo_tutorial/intro_5
	dialog = list(	"Object interaction, and your hands!",
					"At the bottom center of your screen is your hands, and what they are holding.",
					"When you click something, the object in your currently active hand will interact with what you click.",
					"If there is nothing in your hand, you will instead perform a basic interaction, as explained to you earlier!",
					"You can drop objects in your current active hand, by clicking the drop icon at the bottom right of your screen. You can also press Q.",
					"To swap your current active hand, click the background of the hand slot. You can also press X.",
					"Many objects will only respond to empty hands, or have unique interactions with specific objects."
					)

/obj/machinery/hologram/holo_tutorial/intro_6
	dialog = list(	"Clicking the throw icon, in the bottom right of your screen will make your next click throw the object in your active hand. You can also press R.",
					"If you are prepared to throw, and do not have anything in your hand. You will catch anything being thrown at you!"
					)
