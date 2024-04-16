/* Library Machines
 *
 * Contains:
 *		Borrowbook datum
 *		Library Public Computer
 *		Library Computer
 *		Library Scanner
 *		Book Binder
 */

/*
 * Borrowbook datum
 */
/datum/borrowbook // Datum used to keep track of who has borrowed what when and for how long.
	var/bookname
	var/mobname
	var/getdate
	var/duedate

/*
 * Library Public Computer
 * Outpost 21 edit - Complete recode of this into a search engine for recipes and reagents
 */
/obj/machinery/librarypubliccomp
	name = "visitor computer"
	icon = 'icons/obj/library.dmi'
	icon_state = "computer"
	anchored = TRUE
	density = TRUE

	desc = "Used for research, I swear!"

	var/doc_title = "Click a search entry!"
	var/doc_body = ""
	var/searchmode = null
	var/appliance = null //sublists for food menu
	var/crash = FALSE

	var/current_ad1 = ""
	var/current_ad2 = ""

/obj/machinery/librarypubliccomp/Initialize()
	. = ..()
	GLOB.game_wiki.init_wiki_data() // self-prevents multiple reinitilizations
	current_ad1 = get_ad()
	current_ad2 = get_ad()

/obj/machinery/librarypubliccomp/attack_hand(mob/user)
	if(..())
		return 1
	if(crash)
		user.visible_message("[user] performs percussive maintenance on \the [src].", "You try to smack some sense into \the [src].")
		if(prob(10))
			crash = FALSE
	if(!crash)
		tgui_interact(user)
		playsound(src, "keyboard", 40) // into console

/obj/machinery/librarypubliccomp/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PublicLibrary", name)
		ui.open()

/obj/machinery/librarypubliccomp/tgui_data(mob/user)
	var/data[0]
	if(GLOB.game_wiki)
		if(!crash)
			// search page
			data["errorText"] = ""
			data["searchmode"] = searchmode
			data["ad_string1"] = current_ad1
			data["ad_string2"] = current_ad2
			// get searches
			data["search"] = list()
			data["appliance"] = appliance
			if(searchmode == "Food Recipes")
				if(appliance)
					data["search"] = GLOB.game_wiki.searchcache_foodrecipe[appliance]
				else
					var/list/options = list()
					for(var/app in list("Simple","Microwave","Fryer","Oven","Grill","Candy Maker","Cereal Maker"))
						if(!isnull(GLOB.game_wiki.searchcache_foodrecipe["[app]"]))
							options.Add("[app]")
					data["search"] = options
			if(searchmode == "Drink Recipes")
				data["search"] = GLOB.game_wiki.searchcache_drinkrecipe
			if(searchmode == "Chemistry")
				data["search"] = GLOB.game_wiki.searchcache_chemreact
			if(searchmode == "Catalogs")
				data["search"] = GLOB.game_wiki.searchcache_catalogs
			if(searchmode == "Materials")
				data["search"] = GLOB.game_wiki.searchcache_material
			if(searchmode == "Particle Physics")
				data["search"] = GLOB.game_wiki.searchcache_smasher
			if(searchmode == "Ores")
				data["search"] = GLOB.game_wiki.searchcache_ore

			// display message
			data["title"] = doc_title
			data["body"] = doc_body
			data["print"] = (doc_body && length(doc_body) > 0)
		else
			// intentional TGUI crash, amazingly awful
			data["searchmode"] = "Error"
			data["search"] = -1
	else
		data["errorText"] = "Database unreachable."
	return data

/obj/machinery/librarypubliccomp/tgui_act(action, params)
	if(..())
		return TRUE
	add_fingerprint(usr)
	playsound(src, "keyboard", 40) // into console

	current_ad1 = get_ad()
	current_ad2 = get_ad()

	switch(action)
		if("closesearch")
			if(!crash)
				searchmode = null
				doc_title = "Click a search entry!"
				doc_body = ""
			. = TRUE

		if("closeappliance")
			if(!crash)
				doc_title = "Click a search entry!"
				doc_body = ""
				appliance = null
			. = TRUE

		if("foodsearch")
			if(!crash)
				searchmode = "Food Recipes"
			. = TRUE

		if("drinksearch")
			if(!crash)
				searchmode = "Drink Recipes"
			. = TRUE

		if("oresearch")
			if(!crash)
				searchmode = "Ores"
			. = TRUE

		if("matsearch")
			if(!crash)
				searchmode = "Materials"
			. = TRUE

		if("smashsearch")
			if(!crash)
				searchmode = "Particle Physics"
			. = TRUE

		if("chemsearch")
			if(!crash)
				searchmode = "Chemistry"
			. = TRUE

		if("catalogsearch")
			if(!crash)
				searchmode = "Catalogs"
			. = TRUE

		if("crash")
			// intentional TGUI crash, amazingly awful
			if(!crash)
				crash = TRUE
				spawn(rand(1000,4000))
					// crashes till it fixes itself
					crash = FALSE
			. = TRUE

		if("print")
			if(!crash && doc_title && doc_body)
				visible_message("<span class='notice'>[src] rattles and prints out a sheet of paper.</span>")
				// playsound(loc, 'sound/goonstation/machines/printer_dotmatrix.ogg', 50, 1)

				var/obj/item/weapon/paper/P = new /obj/item/weapon/paper(loc)
				P.name = doc_title
				P.info = doc_body
			. = TRUE

		// final search
		if("search")
			if(!crash)
				var/search = params["data"]
				var/datum/internal_wiki/page/P
				var/setpage = TRUE
				if(searchmode == "Food Recipes")
					if(!appliance)
						appliance = params["data"] // have not selected it yet
						setpage = FALSE
					else
						P = GLOB.game_wiki.foodrecipe[search]
				if(searchmode == "Drink Recipes")
					P = GLOB.game_wiki.drinkrecipe[search]
				if(searchmode == "Chemistry")
					P = GLOB.game_wiki.chemreact[search]
				if(searchmode == "Catalogs")
					P = GLOB.game_wiki.catalogs[search]
				if(searchmode == "Materials")
					P = GLOB.game_wiki.materials[search]
				if(searchmode == "Particle Physics")
					P = GLOB.game_wiki.smashers[search]
				if(searchmode == "Ores")
					P = GLOB.game_wiki.ores[search]

				if(setpage)
					if(P)
						doc_title = P.title
						doc_body = P.get_data()
					else
						doc_title = "Error"
						doc_body = "Invalid data."
			. = TRUE

/obj/machinery/librarypubliccomp/proc/get_ad()
	switch(rand(1,20))
		if(1)
			return "Inferior ears? Teshari enhancement surgeries might be for you!"
		if(2)
			return "Phoron huffers anonymous group chat. Join Today!"
		if(3)
			return "Hot and single Vox raiders near your system!"
		if(4)
			return "Need company? Holographic NIF friends! FREE DOWNLOAD!"
		if(5)
			return "LostSpagetti.sol your one stop SYNX DATING website!"
		if(6)
			return "HONK.bonk clown-only social media. Sign up TODAY!"
		if(7)
			return "FREE ORGANS! FREE ORGANS! FREE ORGANS! Terms apply."
		if(8)
			return "Smile.me.com.net.skrell.node.exe.js DOWNLOAD NOW!"
		if(9)
			return "Bankrupt? We can help! Buy uranium coins today!"
		if(10)
			return "CONGRATULATIONS, you're our [rand(1,10000)]TH visitor! DOWNLOAD!"
		if(11)
			return "Your system is out of date, DOWNLOAD DRIVERS!"
		if(12)
			return "Ms.Kitty can't hang in there long, click here to support FELINE INDEPENDENCE!"
		if(13)
			return "Cortical borer therapy! Treats anxiety, stress, and impending sense of univeral collapse!"
		if(14)
			return "Help I licked the supermatter! And other strange stories from Nanotrasen. FREE PDF!"
		if(15)
			return "TIME IS COMING TO AN END, BUY GOLD NOW!"
		if(16)
			return "Your own pet clown? It sounds too REAL to be TRUE! VIEW ARTICLE!"
		if(17)
			return "Are you a BIGSHOT? Investment opportunities inside!"
		if(18)
			return "Spacestation13.exe FREE DOWNLOAD NOW!"
		if(19)
			return "Bored and alone? Date a wizard today! WIZZBIZZ.KAZAM!"
		else
			return "Hot skrell babes in your area!"

// mapper varient for dorms and residences
/obj/machinery/librarypubliccomp/personal
	name = "personal computer"
	desc = "Have you Bingled THAT today?"










/*
 * Library Computer
 */
// TODO: Make this an actual /obj/machinery/computer that can be crafted from circuit boards and such
// It is August 22nd, 2012... This TODO has already been here for months.. I wonder how long it'll last before someone does something about it. // Nov 2019. Nope.
/obj/machinery/librarycomp
	name = "Check-In/Out Computer"
	desc = "Print books from the archives! (You aren't quite sure how they're printed by it, though.)"
	icon = 'icons/obj/library.dmi'
	icon_state = "computer"
	anchored = TRUE
	density = TRUE
	var/arcanecheckout = 0
	var/screenstate = 0 // 0 - Main Menu, 1 - Inventory, 2 - Checked Out, 3 - Check Out a Book
	var/sortby = "author"
	var/buffer_book
	var/buffer_mob
	var/upload_category = "Fiction"
	var/list/checkouts = list()
	var/list/inventory = list()
	var/checkoutperiod = 5 // In minutes
	var/obj/machinery/libraryscanner/scanner // Book scanner that will be used when uploading books to the Archive

	var/bibledelay = 0 // LOL NO SPAM (1 minute delay) -- Doohl

	var/static/list/all_books

	var/static/list/base_genre_books

/obj/machinery/librarycomp/Initialize()
	. = ..()

	if(!base_genre_books || !base_genre_books.len)
		base_genre_books = list(
			/obj/item/weapon/book/custom_library/fiction,
			/obj/item/weapon/book/custom_library/nonfiction,
			/obj/item/weapon/book/custom_library/reference,
			/obj/item/weapon/book/custom_library/religious,
			/obj/item/weapon/book/bundle/custom_library/fiction,
			/obj/item/weapon/book/bundle/custom_library/nonfiction,
			/obj/item/weapon/book/bundle/custom_library/reference,
			/obj/item/weapon/book/bundle/custom_library/religious
			)

	if(!all_books || !all_books.len)
		all_books = list()

		for(var/path in subtypesof(/obj/item/weapon/book/codex/lore))
			var/obj/item/weapon/book/C = new path(null)
			all_books[C.name] = C

		for(var/path in subtypesof(/obj/item/weapon/book/custom_library) - base_genre_books)
			var/obj/item/weapon/book/B = new path(null)
			all_books[B.title] = B

		for(var/path in subtypesof(/obj/item/weapon/book/bundle/custom_library) - base_genre_books)
			var/obj/item/weapon/book/M = new path(null)
			all_books[M.title] = M

/obj/machinery/librarycomp/attack_hand(var/mob/user as mob)
	usr.set_machine(src)
	var/dat = "<HEAD><TITLE>Book Inventory Management</TITLE></HEAD><BODY>\n" // <META HTTP-EQUIV='Refresh' CONTENT='10'>
	switch(screenstate)
		if(0)
			// Main Menu //VOREStation Edit start
			dat += {"<A href='?src=\ref[src];switchscreen=1'>1. View General Inventory</A><BR>
			<A href='?src=\ref[src];switchscreen=2'>2. View Checked Out Inventory</A><BR>
			<A href='?src=\ref[src];switchscreen=3'>3. Check out a Book</A><BR>
			<A href='?src=\ref[src];switchscreen=4'>4. Connect to Internal Archive</A><BR>
			<A href='?src=\ref[src];switchscreen=5'>5. Upload New Title to Archive</A><BR>
			<A href='?src=\ref[src];switchscreen=6'>6. Print a Bible</A><BR>
			<A href='?src=\ref[src];switchscreen=8'>8. Access External Archive</A><BR>"} //VOREStation Edit end
			if(src.emagged)
				dat += "<A href='?src=\ref[src];switchscreen=7'>7. Access the Forbidden Lore Vault</A><BR>"
			if(src.arcanecheckout)
				new /obj/item/weapon/book/tome(src.loc)
				var/datum/gender/T = gender_datums[user.get_visible_gender()]
				to_chat(user, "<span class='warning'>Your sanity barely endures the seconds spent in the vault's browsing window. The only thing to remind you of this when you stop browsing is a dusty old tome sitting on the desk. You don't really remember printing it.</span>")
				user.visible_message("<b>\The [user]</b> stares at the blank screen for a few moments, [T.his] expression frozen in fear. When [T.he] finally awakens from it, [T.he] looks a lot older.", 2)
				src.arcanecheckout = 0
		if(1)
			// Inventory
			dat += "<H3>Inventory</H3><BR>"
			for(var/obj/item/weapon/book/b in inventory)
				dat += "[b.name] <A href='?src=\ref[src];delbook=\ref[b]'>(Delete)</A><BR>"
			dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if(2)
			// Checked Out
			dat += "<h3>Checked Out Books</h3><BR>"
			for(var/datum/borrowbook/b in checkouts)
				var/timetaken = world.time - b.getdate
				//timetaken *= 10
				timetaken /= 600
				timetaken = round(timetaken)
				var/timedue = b.duedate - world.time
				//timedue *= 10
				timedue /= 600
				if(timedue <= 0)
					timedue = "<font color=red><b>(OVERDUE)</b> [timedue]</font>"
				else
					timedue = round(timedue)
				dat += {"\"[b.bookname]\", Checked out to: [b.mobname]<BR>--- Taken: [timetaken] minutes ago, Due: in [timedue] minutes<BR>
				<A href='?src=\ref[src];checkin=\ref[b]'>(Check In)</A><BR><BR>"}
			dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if(3)
			// Check Out a Book
			dat += {"<h3>Check Out a Book</h3><BR>
			Book: [src.buffer_book]
			<A href='?src=\ref[src];editbook=1'>\[Edit\]</A><BR>
			Recipient: [src.buffer_mob]
			<A href='?src=\ref[src];editmob=1'>\[Edit\]</A><BR>
			Checkout Date : [world.time/600]<BR>
			Due Date: [(world.time + checkoutperiod)/600]<BR>
			(Checkout Period: [checkoutperiod] minutes) (<A href='?src=\ref[src];increasetime=1'>+</A>/<A href='?src=\ref[src];decreasetime=1'>-</A>)
			<A href='?src=\ref[src];checkout=1'>(Commit Entry)</A><BR>
			<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"}
		if(4)
			dat += "<h3>Internal Archive</h3>"
			if(!all_books || !all_books.len)
				dat +=	"<font color=red><b>ERROR</b> Something has gone seriously wrong. Contact System Administrator for more information.</font>"
			else
				dat += {"<table>
				<tr><td><A href='?src=\ref[src];sort=author>AUTHOR</A></td><td><A href='?src=\ref[src];sort=title>TITLE</A></td><td><A href='?src=\ref[src];sort=category>CATEGORY</A></td><td></td></tr>"}

				for(var/name in all_books)
					var/obj/item/weapon/book/masterbook = all_books[name]
					var/id = masterbook.type
					var/author = masterbook.author
					var/title = masterbook.name
					var/category = masterbook.libcategory
					dat += "<tr><td>[author]</td><td>[title]</td><td>[category]</td><td><A href='?src=\ref[src];hardprint=[id]'>\[Order\]</A></td></tr>"
				dat += "</table>"
			dat += "<BR><A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if(5)
			//dat += "<H3>ERROR</H3>" //VOREStation Removal
			//dat+= "<FONT color=red>Library Database is in Secure Management Mode.</FONT><BR>\ //VOREStation Removal
			//Contact a System Administrator for more information.<BR>" //VOREStation Removal
			//VOREstation Edit Start
			dat += "<H3>Upload a New Title</H3>"
			if(!scanner)
				for(var/obj/machinery/libraryscanner/S in range(9))
					scanner = S
					break
			if(!scanner)
				dat += "<FONT color=red>No scanner found within wireless network range.</FONT><BR>"
			else if(!scanner.cache)
				dat += "<FONT color=red>No data found in scanner memory.</FONT><BR>"
			else
				dat += {"<TT>Data marked for upload...</TT><BR>
				<TT>Title: </TT>[scanner.cache.name]<BR>"}
				if(!scanner.cache.author)
					scanner.cache.author = "Anonymous"
				dat += {"<TT>Author: </TT><A href='?src=\ref[src];setauthor=1'>[scanner.cache.author]</A><BR>
				<TT>Category: </TT><A href='?src=\ref[src];setcategory=1'>[upload_category]</A><BR>
				<A href='?src=\ref[src];upload=1'>\[Upload\]</A><BR>"}
			//VOREStation Edit End
			dat += "<A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"
		if(7)
			dat += {"<h3>Accessing Forbidden Lore Vault v 1.3</h3>
			Are you absolutely sure you want to proceed? EldritchTomes Inc. takes no responsibilities for loss of sanity resulting from this action.<p>
			<A href='?src=\ref[src];arccheckout=1'>Yes.</A><BR>
			<A href='?src=\ref[src];switchscreen=0'>No.</A><BR>"}
		if(8)
			dat += "<h3>External Archive</h3>" //VOREStation Edit
			establish_old_db_connection()

			//dat += "<h3><font color=red>Warning: System Administrator has slated this archive for removal. Personal uploads should be taken to the NT board of internal literature.</font></h3>" //VOREStation Removal

			if(!dbcon_old.IsConnected())
				dat += "<font color=red><b>ERROR</b>: Unable to contact External Archive. Please contact your system administrator for assistance.</font>"
			else
				dat += {"<A href='?src=\ref[src];orderbyid=1'>(Order book by SS<sup>13</sup>BN)</A><BR><BR>
				<table>
				<tr><td><A href='?src=\ref[src];sort=author>AUTHOR</A></td><td><A href='?src=\ref[src];sort=title>TITLE</A></td><td><A href='?src=\ref[src];sort=category>CATEGORY</A></td><td></td></tr>"}
				var/DBQuery/query = dbcon_old.NewQuery("SELECT id, author, title, category FROM library ORDER BY [sortby]")
				query.Execute()

				var/show_admin_options = check_rights(R_ADMIN, show_msg = FALSE)

				while(query.NextRow())
					var/id = query.item[1]
					var/author = query.item[2]
					var/title = query.item[3]
					var/category = query.item[4]
					dat += "<tr><td>[author]</td><td>[title]</td><td>[category]</td><td><A href='?src=\ref[src];targetid=[id]'>\[Order\]</A>"
					if(show_admin_options) // This isn't the only check, since you can just href-spoof press this button. Just to tidy things up.
						dat += "<A href='?src=\ref[src];delid=[id]'>\[Del\]</A>"
					dat += "</td></tr>"
				dat += "</table>"
			dat += "<BR><A href='?src=\ref[src];switchscreen=0'>(Return to main menu)</A><BR>"

	//dat += "<A HREF='?src=\ref[user];mach_close=library'>Close</A><br><br>"
	user << browse(dat, "window=library")
	onclose(user, "library")

/obj/machinery/librarycomp/emag_act(var/remaining_charges, var/mob/user)
	if (src.density && !src.emagged)
		src.emagged = 1
		return 1

/obj/machinery/librarycomp/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/barcodescanner))
		var/obj/item/weapon/barcodescanner/scanner = W
		scanner.computer = src
		to_chat(user, "[scanner]'s associated machine has been set to [src].")
		for (var/mob/V in hearers(src))
			V.show_message("[src] lets out a low, short blip.", 2)
	else
		..()

/obj/machinery/librarycomp/Topic(href, href_list)
	if(..())
		usr << browse(null, "window=library")
		onclose(usr, "library")
		return

	if(href_list["switchscreen"])
		switch(href_list["switchscreen"])
			if("0")
				screenstate = 0
			if("1")
				screenstate = 1
			if("2")
				screenstate = 2
			if("3")
				screenstate = 3
			if("4")
				screenstate = 4
			if("5")
				screenstate = 5
			if("6")
				if(!bibledelay)
					new /obj/item/weapon/storage/bible(src.loc)
					bibledelay = 1
					spawn(60)
						bibledelay = 0

				else
					for (var/mob/V in hearers(src))
						V.show_message("<b>[src]</b>'s monitor flashes, \"Bible printer currently unavailable, please wait a moment.\"")

			if("7")
				screenstate = 7
			if("8")
				screenstate = 8
	if(href_list["arccheckout"])
		if(src.emagged)
			src.arcanecheckout = 1
		src.screenstate = 0
	if(href_list["increasetime"])
		checkoutperiod += 1
	if(href_list["decreasetime"])
		checkoutperiod -= 1
		if(checkoutperiod < 1)
			checkoutperiod = 1
	if(href_list["editbook"])
		buffer_book = sanitizeSafe(tgui_input_text(usr, "Enter the book's title:"))
	if(href_list["editmob"])
		buffer_mob = sanitize(tgui_input_text(usr, "Enter the recipient's name:", null, null, MAX_NAME_LEN), MAX_NAME_LEN)
	if(href_list["checkout"])
		var/datum/borrowbook/b = new /datum/borrowbook
		b.bookname = sanitizeSafe(buffer_book)
		b.mobname = sanitize(buffer_mob)
		b.getdate = world.time
		b.duedate = world.time + (checkoutperiod * 600)
		checkouts.Add(b)
	if(href_list["checkin"])
		var/datum/borrowbook/b = locate(href_list["checkin"])
		checkouts.Remove(b)
	if(href_list["delbook"])
		var/obj/item/weapon/book/b = locate(href_list["delbook"])
		inventory.Remove(b)
	if(href_list["setauthor"])
		var/newauthor = sanitize(tgui_input_text(usr, "Enter the author's name: "))
		if(newauthor)
			scanner.cache.author = newauthor
	if(href_list["setcategory"])
		var/newcategory = tgui_input_list(usr, "Choose a category: ", "Category", list("Fiction", "Non-Fiction", "Adult", "Reference", "Religion"))
		if(newcategory)
			upload_category = newcategory

	//VOREStation Edit Start
	if(href_list["upload"])
		if(scanner)
			if(scanner.cache)
				var/choice = tgui_alert(usr, "Are you certain you wish to upload this title to the Archive?", "Confirmation", list("Confirm", "Abort"))
				if(choice == "Confirm")
					if(scanner.cache.unique)
						tgui_alert_async(usr, "This book has been rejected from the database. Aborting!")
					else
						establish_old_db_connection()
						if(!dbcon_old.IsConnected())
							tgui_alert_async(usr, "Connection to Archive has been severed. Aborting.")
						else
							/*
							var/sqltitle = dbcon.Quote(scanner.cache.name)
							var/sqlauthor = dbcon.Quote(scanner.cache.author)
							var/sqlcontent = dbcon.Quote(scanner.cache.dat)
							var/sqlcategory = dbcon.Quote(upload_category)
							*/
							var/sqltitle = sanitizeSQL(scanner.cache.name)
							var/sqlauthor = sanitizeSQL(scanner.cache.author)
							var/sqlcontent = sanitizeSQL(scanner.cache.dat)
							var/sqlcategory = sanitizeSQL(upload_category)
							var/DBQuery/query = dbcon_old.NewQuery("INSERT INTO library (author, title, content, category) VALUES ('[sqlauthor]', '[sqltitle]', '[sqlcontent]', '[sqlcategory]')")
							if(!query.Execute())
								to_chat(usr,query.ErrorMsg())
							else
								log_game("[usr.name]/[usr.key] has uploaded the book titled [scanner.cache.name], [length(scanner.cache.dat)] signs")
								tgui_alert_async(usr, "Upload Complete.")
	//VOREStation Edit End

	if(href_list["targetid"])
		var/sqlid = sanitizeSQL(href_list["targetid"])
		establish_old_db_connection()
		if(!dbcon_old.IsConnected())
			tgui_alert_async(usr, "Connection to Archive has been severed. Aborting.")
		if(bibledelay)
			for (var/mob/V in hearers(src))
				V.show_message("<b>[src]</b>'s monitor flashes, \"Printer unavailable. Please allow a short time before attempting to print.\"")
		else
			bibledelay = 1
			spawn(6)
				bibledelay = 0
			var/DBQuery/query = dbcon_old.NewQuery("SELECT * FROM library WHERE id=[sqlid]")
			query.Execute()

			while(query.NextRow())
				var/author = query.item[2]
				var/title = query.item[3]
				var/content = query.item[4]
				var/obj/item/weapon/book/B = new(src.loc)
				B.name = "Book: [title]"
				B.title = title
				B.author = author
				B.dat = content
				B.icon_state = "book[rand(1,16)]"
				B.item_state = B.icon_state
				src.visible_message("[src]'s printer hums as it produces a completely bound book. How did it do that?")
				break

	if(href_list["delid"])
		if(!check_rights(R_ADMIN))
			return
		var/sqlid = sanitizeSQL(href_list["delid"])
		establish_old_db_connection()
		if(!dbcon_old.IsConnected())
			tgui_alert_async(usr, "Connection to Archive has been severed. Aborting.")
		else
			var/DBQuery/query = dbcon_old.NewQuery("DELETE FROM library WHERE id=[sqlid]")
			query.Execute()

	if(href_list["orderbyid"])
		var/orderid = tgui_input_number(usr, "Enter your order:")
		if(orderid)
			if(isnum(orderid))
				var/nhref = "src=\ref[src];targetid=[orderid]"
				spawn() src.Topic(nhref, params2list(nhref), src)
	if(href_list["sort"] in list("author", "title", "category"))
		sortby = href_list["sort"]
	if(href_list["hardprint"])
		var/newpath = href_list["hardprint"]
		var/obj/item/weapon/book/NewBook = new newpath(get_turf(src))
		NewBook.name = "Book: [NewBook.name]"
	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return

/*
 * Library Scanner
 */
/obj/machinery/libraryscanner
	name = "scanner"
	desc = "A scanner for scanning in books and papers."
	icon = 'icons/obj/library.dmi'
	icon_state = "bigscanner"
	anchored = TRUE
	density = TRUE
	var/obj/item/weapon/book/cache		// Last scanned book

/obj/machinery/libraryscanner/attackby(var/obj/O as obj, var/mob/user as mob)
	if(istype(O, /obj/item/weapon/book))
		user.drop_item()
		O.loc = src

/obj/machinery/libraryscanner/attack_hand(var/mob/user as mob)
	usr.set_machine(src)
	var/dat = "<HEAD><TITLE>Scanner Control Interface</TITLE></HEAD><BODY>\n" // <META HTTP-EQUIV='Refresh' CONTENT='10'>
	if(cache)
		dat += "<FONT color=#005500>Data stored in memory.</FONT><BR>"
	else
		dat += "No data stored in memory.<BR>"
	dat += "<A href='?src=\ref[src];scan=1'>\[Scan\]</A>"
	if(cache)
		dat += "       <A href='?src=\ref[src];clear=1'>\[Clear Memory\]</A><BR><BR><A href='?src=\ref[src];eject=1'>\[Remove Book\]</A>"
	else
		dat += "<BR>"
	user << browse(dat, "window=scanner")
	onclose(user, "scanner")

/obj/machinery/libraryscanner/Topic(href, href_list)
	if(..())
		usr << browse(null, "window=scanner")
		onclose(usr, "scanner")
		return

	if(href_list["scan"])
		for(var/obj/item/weapon/book/B in contents)
			cache = B
			break
	if(href_list["clear"])
		cache = null
	if(href_list["eject"])
		for(var/obj/item/weapon/book/B in contents)
			B.loc = src.loc
	src.add_fingerprint(usr)
	src.updateUsrDialog()
	return


/*
 * Book binder
 */
/obj/machinery/bookbinder
	name = "Book Binder"
	desc = "Bundles up a stack of inserted paper into a convenient book format."
	icon = 'icons/obj/library.dmi'
	icon_state = "binder"
	anchored = TRUE
	density = TRUE

/obj/machinery/bookbinder/attackby(var/obj/O as obj, var/mob/user as mob)
	if(istype(O, /obj/item/weapon/paper) || istype(O, /obj/item/weapon/paper_bundle))
		if(istype(O, /obj/item/weapon/paper))
			user.drop_item()
			O.loc = src
			user.visible_message("[user] loads some paper into [src].", "You load some paper into [src].")
			src.visible_message("[src] begins to hum as it warms up its printing drums.")
			sleep(rand(200,400))
			src.visible_message("[src] whirs as it prints and binds a new book.")
			var/obj/item/weapon/book/b = new(src.loc)
			b.dat = O:info
			b.name = "Print Job #" + "[rand(100, 999)]"
			b.icon_state = "book[rand(1,7)]"
			qdel(O)
		else
			user.drop_item()
			O.loc = src
			user.visible_message("[user] loads some paper into [src].", "You load some paper into [src].")
			src.visible_message("[src] begins to hum as it warms up its printing drums.")
			sleep(rand(300,500))
			src.visible_message("[src] whirs as it prints and binds a new book.")
			var/obj/item/weapon/book/bundle/b = new(src.loc)
			b.pages = O:pages
			for(var/obj/item/weapon/paper/P in O.contents)
				P.forceMove(b)
			for(var/obj/item/weapon/photo/P in O.contents)
				P.forceMove(b)
			b.name = "Print Job #" + "[rand(100, 999)]"
			b.icon_state = "book[rand(1,7)]"
			qdel(O)
	else
		..()
