
//////////////////////////////////
//			Entertainer
//////////////////////////////////

/datum/job/entertainer
	title = "Entertainer"
	flag = ENTERTAINER
	departments = list(DEPARTMENT_CIVILIAN)
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Head of Personnel"
	selection_color = "#515151"
	access = list(access_entertainment)
	minimal_access = list(access_entertainment)
	pto_type = PTO_CIVILIAN

	outfit_type = /decl/hierarchy/outfit/job/assistant/entertainer
	job_description = "An entertainer does just that, entertains! Put on plays, play music, sing songs, tell stories, or read your favorite fanfic."
	alt_titles = list("Radio Host" = /datum/alt_title/radiohost)

// Entertainer Alt Titles
/datum/alt_title/radiohost
	title = "Radio Host"
	title_blurb = "Play music, sing songs, tell stories, or read your favorite fanfic. You are the radiowave gremlin of the station, make sure everyone else knows that!"
