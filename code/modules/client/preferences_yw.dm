/datum/preferences
	var/wingdings = 1
	var/colorblind_mono = 0
	var/colorblind_vulp = 0
	var/colorblind_taj = 0
	var/haemophilia = 1

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
	dat += "Colorblind - Monochromacy): <a href='?src=\ref[src];colorblind_mono=1'><b>[pref.colorblind_mono ? "Yes" : "No"]</b></a><br>"
	dat += "Colorblind - Green-Red): <a href='?src=\ref[src];colorblind_vulp=1'><b>[pref.colorblind_vulp ? "Yes" : "No"]</b></a><br>"
	dat += "Colorblind - Blue-Red): <a href='?src=\ref[src];colorblind_taj=1'><b>[pref.colorblind_taj ? "Yes" : "No"]</b></a><br>"
	dat += "<hr>"
	dat += "Genetically Blind: <a href='?src=\ref[src];sdisabilities=[BLIND]'><b>[pref.sdisabilities & BLIND ? "Yes" : "No"]</b></a><br>"
	dat += "Genetically Deaf: <a href='?src=\ref[src];sdisabilities=[DEAF]'><b>[pref.sdisabilities & DEAF ? "Yes" : "No"]</b></a><br>"
	dat += "Epilepsy: <a href='?src=\ref[src];disabilities=[EPILEPSY]'><b>[pref.disabilities & EPILEPSY ? "Yes" : "No"]</b></a><br>"
	dat += "Vertigo: <a href='?src=\ref[src];disabilities=[VERTIGO]'><b>[pref.disabilities & VERTIGO ? "Yes" : "No"]</b></a><br>"
	dat += "Haemophilia: <a href='?src=\ref[src];haemophilia=1'><b>[pref.haemophilia ? "Yes" : "No"]</b></a><br>"
	dat += "Speak Wingdings: <a href='?src=\ref[src];wingdings=1'><b>[pref.wingdings ? "Yes" : "No"]</b></a><br>"
	dat += "<hr><br>"
	dat += "<a href='?src=\ref[src];reset_disabilities=1'>Reset</a><br>"
	// outpost 21 edit end

	dat += "</center></html>"
	var/datum/browser/popup = new(user, "disabil", "<div align='center'>Choose Disabilities</div>", 350, 380, src)
	popup.set_content(dat)
	popup.open()
