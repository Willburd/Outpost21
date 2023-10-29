/client/proc/debug_rogueminer()
	set category = VERBTAB_DEBUG
	set name = "Debug RogueMiner"
	set desc = "Debug the RogueMiner controller."

	if(!holder)	return
	debug_variables(rm_controller)
	feedback_add_details("admin_verb","DRM")
