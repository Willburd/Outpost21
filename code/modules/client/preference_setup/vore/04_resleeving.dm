// Define a place to save in character setup
/datum/preferences
	var/resleeve_lock = 0	// Whether movs should have OOC reslieving protection. Default false.
	var/resleeve_scan = 1	// Whether mob should start with a pre-spawn body scan.  Default true.
	var/hasmind_scan = 1	// Whether mob should start with a pre-spawn mind scan.  Default true.

// Definition of the stuff for Sizing
/datum/category_item/player_setup_item/vore/resleeve
	name = "Resleeving"
	sort_order = 4

/datum/category_item/player_setup_item/vore/resleeve/load_character(var/savefile/S)
	S["resleeve_lock"]		>> pref.resleeve_lock
	S["resleeve_scan"]		>> pref.resleeve_scan
	S["hasmind_scan"]		>> pref.hasmind_scan



/datum/category_item/player_setup_item/vore/resleeve/save_character(var/savefile/S)
	S["resleeve_lock"]		<< pref.resleeve_lock
	S["resleeve_scan"]		<< pref.resleeve_scan
	S["hasmind_scan"]		<< pref.hasmind_scan

/datum/category_item/player_setup_item/vore/resleeve/sanitize_character()
	pref.resleeve_lock		= sanitize_integer(pref.resleeve_lock, 0, 1, initial(pref.resleeve_lock))
	pref.resleeve_scan		= sanitize_integer(pref.resleeve_scan, 0, 1, initial(pref.resleeve_scan))
	pref.hasmind_scan       = sanitize_integer(pref.hasmind_scan, 0, 1, initial(pref.hasmind_scan))

/datum/category_item/player_setup_item/vore/resleeve/copy_to_mob(var/mob/living/carbon/human/character)
	if(character && !istype(character,/mob/living/carbon/human/dummy))
		spawn(50)
			if(QDELETED(character) || QDELETED(pref))
				return // They might have been deleted during the wait
			if(pref.resleeve_scan)
				var/datum/transhuman/body_record/BR = new()
				if(!isnull(character.client))
					character.sync_dna_blocks_from_client_setup(character.client)
				domutcheck( character, null)
				BR.init_from_mob(character, pref.resleeve_scan, pref.resleeve_lock)
				to_chat(character, "<span class='notice'><b>Your body record has been synced with the [using_map.dock_name] database</b></span>")
			if(pref.hasmind_scan && character.mind)
				var/datum/transcore_db/DB = SStranscore.db_by_key()
				DB.m_backup(character.mind, null, TRUE) //mind,nif,one_time = TRUE) outpost 21  edit - nif removal
				to_chat(character, "<span class='notice'><b>Your mind record has been synced with the [using_map.dock_name] database</b></span>")
			if(pref.resleeve_lock)
				character.resleeve_lock = character.ckey
			character.original_player = character.ckey

/datum/category_item/player_setup_item/vore/resleeve/content(var/mob/user)
	. += "<br>"
	. += "<b>Start With Body Scan:</b> <a [pref.resleeve_scan ? "class='linkOn'" : ""] href='?src=\ref[src];toggle_resleeve_scan=1'><b>[pref.resleeve_scan ? "Yes" : "No"]</b></a><br>"
	. += "<b>Start With Mind Scan:</b> <a [pref.hasmind_scan ? "class='linkOn'" : ""] href='?src=\ref[src];toggle_hasmind_scan=1'><b>[pref.hasmind_scan ? "Yes" : "No"]</b></a><br>"
	. += "<b>Prevent Body Impersonation:</b> <a [pref.resleeve_lock ? "class='linkOn'" : ""] href='?src=\ref[src];toggle_resleeve_lock=1'><b>[pref.resleeve_lock ? "Yes" : "No"]</b></a><br>"

/datum/category_item/player_setup_item/vore/resleeve/OnTopic(var/href, var/list/href_list, var/mob/user)
	if(href_list["toggle_resleeve_lock"])
		pref.resleeve_lock = pref.resleeve_lock ? 0 : 1;
		return TOPIC_REFRESH
	else if(href_list["toggle_resleeve_scan"])
		pref.resleeve_scan = pref.resleeve_scan ? 0 : 1;
		return TOPIC_REFRESH
	else if(href_list["toggle_hasmind_scan"])
		pref.hasmind_scan = pref.hasmind_scan ? 0 : 1;
		return TOPIC_REFRESH
	return ..();
