#define TOOL_FIXVEIN "fixvein"
#define TOOL_BONEGEL "bonegel"
#define TOOL_TRANSPLANT "transplant"

/mob/living/carbon/human/monkey/auto_doc
	// Absolutely awful crap for surgery tgui passthroughs... I hate this, but I really wanted to avoid redoing ALL OF SURGERY, sue me.
	// Steps that check for a target limb or organ check the machine, if they see it's an autodoc monkey
	var/obj/machinery/auto_doc/owner_machine

/mob/living/carbon/human/monkey/auto_doc/rad_act(severity)
	return

/mob/living/carbon/human/monkey/auto_doc/handle_disabilities()
	return

/mob/living/carbon/human/monkey/auto_doc/handle_addictions()
	return

/mob/living/carbon/human/monkey/auto_doc/handle_statuses()
	// autodoc says NO
	stunned = 0
	weakened = 0
	paralysis = 0
	stuttering = 0
	silent = 0
	druggy = 0
	slurring = 0
	confused = 0

/obj/machinery/auto_doc
	name = "Auto-Doc"
	desc = "Veymed 'Dr.Zaius Auto-Doc'. A machine preprogrammed with various simple medical operations. Known to Reduce strain on understaffed medical facilities."
	icon = 'icons/obj/survival_pod.dmi' // TEMP
	icon_state = "tubes" // TEMP
	density = FALSE
	anchored = TRUE
	unacidable = TRUE
	use_power = USE_POWER_IDLE
	idle_power_usage = 1
	active_power_usage = 5
	var/mob/living/carbon/human/monkey/auto_doc/doctor
	var/list/operations
	var/list/tools

	var/delay_time = 10 SECONDS
	var/next_time = 0

	var/operation_active = FALSE
	var/operation_type = ""
	var/operation_stage = 1

	var/external_organ_target = BP_GROIN
	var/internal_organ_target = O_APPENDIX

/obj/machinery/auto_doc/New()
	. = ..()
	create_tools()
	create_operations()
	// setup the good doctor
	doctor = new(src)
	doctor.owner_machine = src

/obj/machinery/auto_doc/proc/create_operations()
	operations = list()
	var/list/open_site = list(TOOL_SCALPEL,TOOL_HEMOSTAT,TOOL_RETRACTOR)
	var/list/close_site = list(TOOL_CAUTERY)

	operations["remove_organ"] 				= open_site + list(TOOL_SCALPEL,TOOL_HEMOSTAT) + close_site
	operations["insert_organ"] 				= open_site + list(TOOL_TRANSPLANT,TOOL_FIXVEIN) + close_site
	operations["internal_bleeding"] 		= open_site + list(TOOL_FIXVEIN) + close_site
	operations["repair_bone"] 				= open_site + list(TOOL_BONEGEL,TOOL_BONESET,TOOL_BONEGEL) + close_site

/obj/machinery/auto_doc/proc/create_tools()
	tools = list()
	tools[TOOL_SCALPEL] 	= new /obj/item/weapon/surgical/scalpel(src)
	tools[TOOL_HEMOSTAT] 	= new /obj/item/weapon/surgical/hemostat(src)
	tools[TOOL_RETRACTOR] 	= new /obj/item/weapon/surgical/retractor(src)
	tools[TOOL_DRILL] 		= new /obj/item/weapon/surgical/surgicaldrill(src)
	tools[TOOL_SAW] 		= new /obj/item/weapon/surgical/circular_saw(src)
	tools[TOOL_BONESET] 	= new /obj/item/weapon/surgical/bonesetter(src)
	tools[TOOL_FIXVEIN] 	= new /obj/item/weapon/surgical/FixOVein(src)
	tools[TOOL_BONEGEL] 	= new /obj/item/weapon/surgical/bonegel(src)
	tools[TOOL_CAUTERY] 	= new /obj/item/weapon/surgical/cautery(src)
	tools[TOOL_TRANSPLANT]  = null // special

/obj/machinery/auto_doc/proc/get_step_whitelist()
	// list of steps the autodoc may perform, this stops it getting stuck in places with multiple options for the same tool... Keep it simple.
	// different states of the machine may allow different things someday, like allowing implants if one is loaded into storage?...
	var/list/whitelisted_steps = list()
	whitelisted_steps.Add("Create Incision")
	whitelisted_steps.Add("Clamp Bleeders")
	whitelisted_steps.Add("Retract Skin")
	whitelisted_steps.Add("Cauterize Incision")
	whitelisted_steps.Add("Detatch Organ")
	whitelisted_steps.Add("Remove Organ")
	whitelisted_steps.Add("Replace Organ")
	whitelisted_steps.Add("Attach Organ")
	whitelisted_steps.Add("Fix Vein")
	whitelisted_steps.Add("Glue Bone")
	whitelisted_steps.Add("Set Bone")
	whitelisted_steps.Add("Finish Mending Bone")
	return whitelisted_steps

/obj/machinery/auto_doc/proc/get_victim()
	var/obj/machinery/optable/linked_table
	linked_table = locate() in loc
	if(!linked_table)
		src.visible_message("\The [src] flashes 'No operation table detected'.")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		return null
	return linked_table.victim

/obj/machinery/auto_doc/process()
	if(!(doctor.status_flags & GODMODE))
		handle_doctor() // force reset doctor
	if(operation_active && next_time > 0 && world.time > next_time)
		next_time = 0
		perform_operation()

/obj/machinery/auto_doc/attack_hand(mob/user as mob)
	add_fingerprint(user)
	if(!operation_active)
		start_operation(user)

/obj/machinery/auto_doc/attackby(obj/item/O, mob/user)
	. = ..()
	if(istype(O,/obj/item/organ/internal))
		add_fingerprint(user)
		user.drop_item(src)
		insert_organ(user,O)

/obj/machinery/auto_doc/AltClick(var/mob/user)
	. = ..()
	add_fingerprint(user)
	remove_organ(user)

/obj/machinery/auto_doc/verb/empty_organ()
	set name = "Eject Stored Organ"
	set category = VERBTAB_OBJECT
	set src in oview(1)

	if(usr.stat != 0)
		return

	add_fingerprint(usr)
	remove_organ()
	return

/obj/machinery/auto_doc/Destroy()
	. = ..()
	doctor.drop_item(src)
	doctor.Destroy()
	for(var/obj/item/I in contents)
		if(istype(I,/obj/item/weapon/surgical))
			I.Destroy()
		else
			I.forceMove(loc)

/obj/machinery/auto_doc/proc/start_operation(mob/user as mob)
	// get target surgical zone
	var/mob/living/carbon/human/victim = get_victim()
	if(!victim)
		src.visible_message("\The [src] flashes 'Please position subject for surgery on operating table'.")
		return
	else
		src.visible_message("\The [src] flashes 'Please prepare subject for surgery, reminder to place N2O mask over their face before operation begins'.")
	var/list/targetlist = list()
	var/list/destinationlist = list()
	for(var/organ_name in BP_ALL)
		var/obj/item/organ/O = victim.get_organ(organ_name)
		targetlist.Add(O.name)
		destinationlist[O.name] = O

	var/aim_choice = tgui_input_list(user, "Choose surgical target:", "Surgical Target", targetlist)
	if(!aim_choice || !victim)
		return
	else
		var/obj/item/organ/EO = destinationlist[aim_choice]
		external_organ_target = EO.organ_tag

	// get surgery
	var/list/surgery_type = list("Remove Organ","Insert Organ","Repair Internal Bleeding","Repair Bone")
	var/surgery = tgui_input_list(user, "Choose surgery:", "Surgery Type", surgery_type)
	var/obj/item/organ/external/EO = destinationlist[aim_choice]
	switch(surgery)
		if("Remove Organ")
			operation_type = "remove_organ"
			if(EO.encased)
				src.visible_message("\The [src] flashes 'Target location requires complex bone manipulation, a surgical professional is required for organ removal'.")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
				return
			// if organ removal, select target organ
			var/list/internallist = list()
			var/list/internaldestinationlist = list()
			for(var/obj/item/organ/internal/O in victim.internal_organs)
				if(O.parent_organ == EO.organ_tag)
					internallist.Add(O.name)
					internaldestinationlist[O.name] = O
			if(internallist.len == 0)
				src.visible_message("\The [src] flashes 'Target location has no internal organs'.")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
				return
			var/organremove = tgui_input_list(user, "Choose organ to remove:", "Organ Target", internallist)
			if(!organremove || !victim)
				return
			var/obj/item/organ/target_organ = internaldestinationlist[organremove]
			if(target_organ)
				internal_organ_target = target_organ.organ_tag
				src.visible_message("\The [src] flashes 'Beginning operation: Remove Organ [target_organ.name]'.")
		if("Insert Organ")
			operation_type = "insert_organ"
			if(EO.encased)
				src.visible_message("\The [src] flashes 'Target location requires complex bone manipulation, a surgical professional is required for organ transplant'.")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
				return
			// if organ insertion, NEED an organ to insert!
			if(!tools[TOOL_TRANSPLANT])
				src.visible_message("\The [src] flashes 'Please load organ into storage chamber'.")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
				return
			else
				var/obj/item/organ/I = tools[TOOL_TRANSPLANT]
				if(I.status & ORGAN_DEAD)
					src.visible_message("\The [src] flashes 'Organ has decayed beyond safety treshold'.")
					playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
					return
				src.visible_message("\The [src] flashes 'Beginning operation: Transplant [I.name] into [EO.name]'.")
		if("Repair Internal Bleeding")
			operation_type = "internal_bleeding"
			if(EO.encased)
				src.visible_message("\The [src] flashes 'Target location requires complex bone manipulation, a surgical professional is required to repair internal bleeding'.")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
				return
			src.visible_message("\The [src] flashes 'Beginning operation: Repair Internal Bleeding in [EO.name]'.")
		if("Repair Bone")
			operation_type = "repair_bone"
			src.visible_message("\The [src] flashes 'Beginning operation: Repair Bones in [EO.name], bicardine injection advised. A damaged limb will result in surgical complications'.")
		else
			return
	// BEGIN
	playsound(src,  'sound/machines/boobeebeep.ogg', 100, 0)
	operation_active = TRUE
	next_time = world.time + delay_time
	operation_stage = 1

/obj/machinery/auto_doc/proc/perform_operation()
	var/mob/living/carbon/human/victim = get_victim()
	// Someone stole our occupant!
	if(!victim)
		src.visible_message("\The [src] flashes 'Surgery interupted'.")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		end_operation(FALSE)
		return

	// check everything is ready...
	var/list/op_list = operations[operation_type]
	if(!op_list)
		src.visible_message("\The [src] flashes 'Invalid operation'.")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		end_operation(FALSE)
		return
	var/toolid = op_list[operation_stage]
	var/obj/item/tool = tools[toolid]
	if(!tool)
		src.visible_message("\The [src] flashes 'Machinery inoperable, tool damaged or missing'.")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		end_operation(FALSE)
	// RELEASE LAST OBJECT
	doctor.drop_item(src)

	// EQUIP DR.NANERS PHD
	handle_doctor()
	doctor.put_in_active_hand(tool)

	// PERFORM THE MAGIC
	tool.do_surgery( victim, doctor, external_organ_target)

	// next step... and are we at the last operation? If so end it!
	operation_stage += 1
	if(operation_stage > op_list.len)
		end_operation(TRUE)
		src.visible_message("\The [src] flashes 'Operation Complete'.")
		playsound(src,  'sound/machines/boobeebeep.ogg', 100, 0)

	// NEXT
	next_time = world.time + delay_time

/obj/machinery/auto_doc/proc/end_operation(var/success)
	operation_type = ""
	operation_active = FALSE
	next_time = 0
	operation_stage = 1

/obj/machinery/auto_doc/proc/insert_organ(mob/user as mob, var/obj/item/organ/O)
	if(operation_active)
		to_chat(user, "<span class='notice'>You cannot insert the [O.name] while the [src] is operating.</span>")
		return
	if(!O)
		return
	if(tools[TOOL_TRANSPLANT])
		return // ALREADY FULL
	tools[TOOL_TRANSPLANT] = O
	to_chat(user, "<span class='notice'>You place \The [O.name] into the [src]'s organ storage unit.</span>")
	playsound(src, 'sound/items/drop/flesh.ogg', 100, 0)

/obj/machinery/auto_doc/proc/remove_organ(mob/user as mob)
	if(operation_active)
		to_chat(user, "<span class='notice'>You cannot open the organ storage while the [src] is operating.</span>")
		return
	if(!tools[TOOL_TRANSPLANT])
		return null
	var/obj/item/I = tools[TOOL_TRANSPLANT]
	I.forceMove(src.loc) // plonk
	tools[TOOL_TRANSPLANT] = null
	to_chat(user, "<span class='notice'>You remove \The [I.name] from the [src]'s organ storage unit.</span>")
	playsound(src, 'sound/items/drop/flesh.ogg', 100, 0)

/obj/machinery/auto_doc/proc/finish_transplant()
	tools[TOOL_TRANSPLANT] = null

/obj/machinery/auto_doc/proc/handle_doctor()
	if(!doctor)
		return
	doctor.owner_machine = src
	doctor.name =  "\improper [name]"
	doctor.real_name = "\improper [name]"
	doctor.a_intent = I_HELP
	doctor.germ_level = 0 // forced clean
	doctor.species.has_fine_manipulation = TRUE // advanced monkey
	doctor.status_flags = GODMODE // no other flags

#undef TOOL_FIXVEIN
#undef TOOL_BONEGEL
#undef TOOL_TRANSPLANT
