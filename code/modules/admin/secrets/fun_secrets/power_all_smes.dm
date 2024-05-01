/datum/admin_secret_item/fun_secret/power_all_smes
	name = "Power All SMES"

/datum/admin_secret_item/fun_secret/power_all_smes/execute(var/mob/user)
	. = ..()
	if(.)
		power_restore_quick()

/datum/admin_secret_item/fun_secret/drain_all_smes
	name = "Drain All SMES"

/datum/admin_secret_item/fun_secret/drain_all_smes/execute(var/mob/user)
	. = ..()
	if(.)
		power_kill_quick()