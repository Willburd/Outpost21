/datum/preferences
	var/blind = 0
	var/mute = 0
	var/deaf = 0

//proc for setting disabilities
/datum/category_item/player_setup_item/general/body/proc/Disabilities_YW(mob/user)
	var/dat = "<body>"
	dat += "<html><center>"

	// outpost 21 edit begin - restored genetic disabilities, and made others accessible... the reset button made them show up anyway...
	dat += "Needs Glasses: <a href='?src=\ref[src];disabilities=[NEARSIGHTED]'><b>[pref.disabilities & NEARSIGHTED ? "Yes" : "No"]</b></a><br>"
	dat += "Chronic Cough: <a href='?src=\ref[src];disabilities=[COUGHING]'><b>[pref.disabilities & COUGHING ? "Yes" : "No"]</b></a><br>"
	dat += "Tourettes: <a href='?src=\ref[src];disabilities=[TOURETTES]'><b>[pref.disabilities & TOURETTES ? "Yes" : "No"]</b></a><br>"
	dat += "Anxiety: <a href='?src=\ref[src];disabilities=[NERVOUS]'><b>[pref.disabilities & NERVOUS ? "Yes" : "No"]</b></a><br>"
	dat += "<hr>"
	dat += "Genetically Blind: <a href='?src=\ref[src];sdisabilities=[BLIND]'><b>[pref.sdisabilities & BLIND ? "Yes" : "No"]</b></a><br>"
	dat += "Genetically Deaf: <a href='?src=\ref[src];sdisabilities=[DEAF]'><b>[pref.sdisabilities & DEAF ? "Yes" : "No"]</b></a><br>"
	dat += "Epilepsy: <a href='?src=\ref[src];disabilities=[EPILEPSY]'><b>[pref.disabilities & EPILEPSY ? "Yes" : "No"]</b></a><br>"
	dat += "Vertigo: <a href='?src=\ref[src];disabilities=[VERTIGO]'><b>[pref.disabilities & VERTIGO ? "Yes" : "No"]</b></a><br>"
	dat += "<hr>"
	dat += "Nicotine addiction: <a href='?src=\ref[src];addictions=[ADDICT_NICOTINE]'><b>[pref.addictions & ADDICT_NICOTINE ? "Yes" : "No"]</b></a><br>"
	dat += "Painkiller addiction: <a href='?src=\ref[src];addictions=[ADDICT_PAINKILLER]'><b>[pref.addictions & ADDICT_PAINKILLER ? "Yes" : "No"]</b></a><br>"
	dat += "Bliss addiction: <a href='?src=\ref[src];addictions=[ADDICT_BLISS]'><b>[pref.addictions & ADDICT_BLISS ? "Yes" : "No"]</b></a><br>"
	dat += "Oxycodone addiction: <a href='?src=\ref[src];addictions=[ADDICT_OXY]'><b>[pref.addictions & ADDICT_OXY ? "Yes" : "No"]</b></a><br>"
	dat += "Hyperzine addiction: <a href='?src=\ref[src];addictions=[ADDICT_HYPER]'><b>[pref.addictions & ADDICT_HYPER ? "Yes" : "No"]</b></a><br>"
	dat += "<hr><br>"
	dat += "<a href='?src=\ref[src];reset_disabilities=1'>Reset</a><br>"
	// outpost 21 edit end

	dat += "</center></html>"
	var/datum/browser/popup = new(user, "disabil", "<div align='center'>Choose Disabilities</div>", 350, 380, src)
	popup.set_content(dat)
	popup.open()
