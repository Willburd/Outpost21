/*
	This is a self assembled wiki for chemical reagents, food recipies,
	and other information that should be assembled from game files.
	Instead of being shoved in an outdated wiki that no one updates.
*/

GLOBAL_DATUM_INIT(game_wiki, /datum/internal_wiki/main, new)

/datum/internal_wiki/main
	var/list/pages = list()

	var/list/ores = list()
	var/list/materials = list()
	var/list/smashers = list()

	var/list/foodreact = list()
	var/list/drinkreact = list()
	var/list/phororeact = list()
	var/list/chemreact = list()

	var/list/foodrecipe = list()
	var/list/drinkrecipe = list()

	var/list/spoilerore = list()
	var/list/spoilermat = list()
	var/list/spoilersmasher = list()
	var/list/spoilerreact = list()

	var/list/catalogs = list()

	var/list/searchcache_ore = list()
	var/list/searchcache_material = list()
	var/list/searchcache_smasher = list()
	var/list/searchcache_foodrecipe = list()
	var/list/searchcache_drinkrecipe = list()
	var/list/searchcache_chemreact = list()
	var/list/searchcache_catalogs = list()

/datum/internal_wiki/main/proc/init_wiki_data()
	if(pages.len)
		return // already init
	log_world("Init game built wiki")

	// assemble ore wiki
	for(var/N in GLOB.ore_data)
		var/ore/OR = GLOB.ore_data[N]
		var/datum/internal_wiki/page/P = new()
		P.ore_assemble(OR)
		if(!OR.spoiler)
			ores["[OR.display_name]"] = P
			searchcache_ore.Add("[OR.display_name]")
		else
			spoilerore["[OR.display_name]"] = P
		pages.Add(P)

	// assemble material wiki
	for(var/mat in name_to_material)
		var/datum/material/M = name_to_material[mat]
		var/datum/internal_wiki/page/P = new()
		P.material_assemble(M)
		if(!M.spoiler)
			materials["[M.display_name]"] = P
			searchcache_material.Add("[M.display_name]")
		else
			spoilermat["[M.display_name]"] = P
		pages.Add(P)

	// assemble particle smasher wiki
	var/list/smasher_recip = list()
	for(var/D in subtypesof(/datum/particle_smasher_recipe))
		smasher_recip += new D
	for(var/datum/particle_smasher_recipe/R in smasher_recip)
		var/datum/internal_wiki/page/P = new()

		var/obj/item/res = new R.result;
		P.smasher_assemble(R,res.name)
		if(!R.spoiler)
			smashers["[res.name]"] = P
			searchcache_smasher.Add("[res.name]")
		else
			spoilersmasher["[res.name]"] = P
		qdel(res)
		pages.Add(P)

	// assemble chemical reactions wiki
	for(var/reagent in SSchemistry.chemical_reagents)
		if(allow_reagent(reagent))
			var/datum/internal_wiki/page/P = new()
			var/datum/reagent/R = SSchemistry.chemical_reagents[reagent]
			if(!R.spoiler)
				if(R.is_food)
					P.food_assemble(R)
					foodreact["[R.name]"] = P
				if(R.is_drink)
					P.drink_assemble(R)
					drinkreact["[R.name]"] = P
				if(R.is_phoro)
					P.chemical_assemble(R)
					phororeact["[R.name]"] = P
				if(!R.is_food && !R.is_drink && !R.is_phoro)
					P.chemical_assemble(R)
					searchcache_chemreact.Add("[R.name]")
					chemreact["[R.name]"] = P
			else
				P.chemical_assemble(R)
				spoilerreact["[R.name]"] = P
			pages.Add(P)
	init_kitchen_data()

	// assemble low reward catalog entries
	for(var/datum/category_group/G in GLOB.catalogue_data.categories)
		for(var/datum/category_item/catalogue/item in G.items)
			if(istype(item,/datum/category_item/catalogue/anomalous))
				continue // lets always consider these spoilers
			if(istype(item,/datum/category_item/catalogue/fauna/catslug/custom))
				continue // too many silly entries
			if(item.value > CATALOGUER_REWARD_TRIVIAL)
				continue
			var/datum/internal_wiki/page/catalog/P = new()
			P.title = item.name
			P.catalog_record = item
			catalogs["[item.name]"] = P
			searchcache_catalogs.Add("[item.name]")
			pages.Add(P)

	log_world("Wiki page count [pages.len]")

/datum/internal_wiki/main/proc/init_kitchen_data()
	// this is basically a clone of code\modules\food\recipe_dump.dm
	// drinks
	var/list/drink_recipes = list()
	for(var/decl/chemical_reaction/instant/drinks/CR in SSchemistry.chemical_reactions)
		var/datum/reagent/Rd = SSchemistry.chemical_reagents[CR.result]
		if(!isnull(Rd))
			drink_recipes[CR.type] = list("Result" = "[CR.name]",
									"Desc" = "[Rd.description]",
									"Flavor" = "[Rd.taste_description]",
									"ResAmt" = CR.result_amount,
									"Reagents" = CR.required_reagents ? CR.required_reagents.Copy() : list(),
									"Catalysts" = CR.catalysts ? CR.catalysts.Copy() : list(),
									"Spoiler" = CR.spoiler)
	// Build the kitchen recipe lists
	var/list/food_recipes = subtypesof(/datum/recipe)
	for(var/Rp in food_recipes)
		//Lists don't work with datum-stealing no-instance initial() so we have to.
		var/datum/recipe/R = new Rp()
		var/obj/res = new R.result()
		food_recipes[Rp] = list(
						"Result" = "[res.name]",
						"Desc" = "[res.desc]",
						"Flavor" = "",
						"ResAmt" = "1",
						"Reagents" = R.reagents ? R.reagents.Copy() : list(),
						"Catalysts" = list(),
						"Fruit" = R.fruit ? R.fruit.Copy() : list(),
						"Ingredients" = R.items ? R.items.Copy() : list(),
						"Coating" = R.coating,
						"Appliance" = R.appliance,
						"Allergens" = 0,
						"Spoiler" = R.spoiler
						)
		qdel(res)
		qdel(R)
	// basically condiments, tofu, cheese, soysauce, etc
	for(var/decl/chemical_reaction/instant/food/CR in SSchemistry.chemical_reactions)
		food_recipes[CR.type] = list("Result" = CR.name,
								"ResAmt" = CR.result_amount,
								"Reagents" = CR.required_reagents ? CR.required_reagents.Copy() : list(),
								"Catalysts" = CR.catalysts ? CR.catalysts.Copy() : list(),
								"Fruit" = list(),
								"Ingredients" = list(),
								"Allergens" = 0)
	//Items needs further processing into human-readability.
	for(var/Rp in food_recipes)
		var/working_ing_list = list()
		food_recipes[Rp]["has_coatable_items"] = FALSE
		for(var/I in food_recipes[Rp]["Ingredients"])
			if(I == /obj/item/weapon/holder/mouse) // amazing snowflake runtime fix, initilizing a holder makes it flip out because it's not in a mob.
				if("mouse" in working_ing_list)
					var/sofar = working_ing_list["mouse"]
					working_ing_list["mouse"] = sofar+1
				else
					working_ing_list["mouse"] = 1
			else if(I == /obj/item/weapon/holder/diona) // YOU TOO
				if("diona" in working_ing_list)
					var/sofar = working_ing_list["diona"]
					working_ing_list["diona"] = sofar+1
				else
					working_ing_list["diona"] = 1
			else if(I == /obj/item/weapon/holder) // And you especially, needed for "splat" microwave recipe
				if("micro" in working_ing_list)
					var/sofar = working_ing_list["micro"]
					working_ing_list["micro"] = sofar+1
				else
					working_ing_list["micro"] = 1
			else
				var/atom/ing = new I()
				if(istype(ing, /obj/item/weapon/reagent_containers/food/snacks)) // only subtypes of this have a coating variable and are checked for it (fruit are a subtype of this, so there's a check for them too later)
					food_recipes[Rp]["has_coatable_items"] = TRUE

				//So now we add something like "Bread" = 3
				if(ing.name in working_ing_list)
					var/sofar = working_ing_list[ing.name]
					working_ing_list[ing.name] = sofar+1
				else
					working_ing_list[ing.name] = 1

		if(LAZYLEN(food_recipes[Rp]["Fruit"]))
			food_recipes[Rp]["has_coatable_items"] = TRUE
		food_recipes[Rp]["Ingredients"] = working_ing_list

	//Reagents can be resolved to nicer names as well
	for(var/Rp in food_recipes)
		for(var/rid in food_recipes[Rp]["Reagents"])
			var/datum/reagent/Rd = SSchemistry.chemical_reagents[rid]
			if(!Rd) // Leaving this here in the event that if rd is ever invalid or there's a recipe issue, it'll be skipped and recipe dumps can still be ran.
				log_runtime(EXCEPTION("Food \"[Rp]\" had an invalid RID: \"[rid]\"! Check your reagents list for a missing or mistyped reagent!"))
				continue // This allows the dump to still continue, and it will skip the invalid recipes.
			var/R_name = Rd.name
			var/amt = food_recipes[Rp]["Reagents"][rid]
			food_recipes[Rp]["Reagents"] -= rid
			food_recipes[Rp]["Reagents"][R_name] = amt
			food_recipes[Rp]["Allergens"] |= Rd.allergen_type
		for(var/rid in food_recipes[Rp]["Catalysts"])
			var/datum/reagent/Rd = SSchemistry.chemical_reagents[rid]
			if(!Rd) // Leaving this here in the event that if rd is ever invalid or there's a recipe issue, it'll be skipped and recipe dumps can still be ran.
				log_runtime(EXCEPTION("Food \"[Rp]\" had an invalid RID: \"[rid]\"! Check your reagents list for a missing or mistyped reagent!"))
				continue // This allows the dump to still continue, and it will skip the invalid recipes.
			var/R_name = Rd.name
			var/amt = food_recipes[Rp]["Catalysts"][rid]
			food_recipes[Rp]["Catalysts"] -= rid
			food_recipes[Rp]["Catalysts"][R_name] = amt
	for(var/Rp in drink_recipes)
		for(var/rid in drink_recipes[Rp]["Reagents"])
			var/datum/reagent/Rd = SSchemistry.chemical_reagents[rid]
			if(!Rd) // Leaving this here in the event that if rd is ever invalid or there's a recipe issue, it'll be skipped and recipe dumps can still be ran.
				log_runtime(EXCEPTION("Food \"[Rp]\" had an invalid RID: \"[rid]\"! Check your reagents list for a missing or mistyped reagent!"))
				continue // This allows the dump to still continue, and it will skip the invalid recipes.
			var/R_name = Rd.name
			var/amt = drink_recipes[Rp]["Reagents"][rid]
			drink_recipes[Rp]["Reagents"] -= rid
			drink_recipes[Rp]["Reagents"][R_name] = amt
			drink_recipes[Rp]["Allergens"] |= Rd.allergen_type
		for(var/rid in drink_recipes[Rp]["Catalysts"])
			var/datum/reagent/Rd = SSchemistry.chemical_reagents[rid]
			if(!Rd) // Leaving this here in the event that if rd is ever invalid or there's a recipe issue, it'll be skipped and recipe dumps can still be ran.
				log_runtime(EXCEPTION("Food \"[Rp]\" had an invalid RID: \"[rid]\"! Check your reagents list for a missing or mistyped reagent!"))
				continue // This allows the dump to still continue, and it will skip the invalid recipes.
			var/R_name = Rd.name
			var/amt = drink_recipes[Rp]["Catalysts"][rid]
			drink_recipes[Rp]["Catalysts"] -= rid
			drink_recipes[Rp]["Catalysts"][R_name] = amt

	//We can also change the appliance to its proper name.
	for(var/Rp in food_recipes)
		switch(food_recipes[Rp]["Appliance"])
			if(1)
				food_recipes[Rp]["Appliance"] = "Microwave"
			if(2)
				food_recipes[Rp]["Appliance"] = "Fryer"
			if(4)
				food_recipes[Rp]["Appliance"] = "Oven"
			if(8)
				food_recipes[Rp]["Appliance"] = "Grill"
			if(16)
				food_recipes[Rp]["Appliance"] = "Candy Maker"
			if(32)
				food_recipes[Rp]["Appliance"] = "Cereal Maker"

	//////////////////////// SORTING
	var/list/foods_to_paths = list()
	var/list/drinks_to_paths = list()
	for(var/Rp in food_recipes) // "Appliance" will sort the list by APPLIANCES first. Items without an appliance will append to the top of the list. The old method was "Result", which sorts the list by the name of the result.
		foods_to_paths["[food_recipes[Rp]["Appliance"]] [Rp]"] = Rp //Append recipe datum path to keep uniqueness
	for(var/Rp in drink_recipes)
		drinks_to_paths["[drink_recipes[Rp]["Result"]] [Rp]"] = Rp
	foods_to_paths = sortAssoc(foods_to_paths)
	drinks_to_paths = sortAssoc(drinks_to_paths)

	var/list/foods_newly_sorted = list()
	var/list/drinks_newly_sorted = list()
	for(var/Rr in foods_to_paths)
		var/Rp = foods_to_paths[Rr]
		foods_newly_sorted[Rp] = food_recipes[Rp]
	for(var/Rr in drinks_to_paths)
		var/Rp = drinks_to_paths[Rr]
		drinks_newly_sorted[Rp] = drink_recipes[Rp]
	food_recipes = foods_newly_sorted
	drink_recipes = drinks_newly_sorted

	// assemble output page
	for(var/Rp in food_recipes)
		if(food_recipes[Rp] && !food_recipes[Rp]["Spoiler"] && !isnull(food_recipes[Rp]["Result"]))
			var/datum/internal_wiki/page/P = new()
			P.recipe_assemble(food_recipes[Rp])
			foodrecipe["[P.title]"] = P
			// organize into sublists
			var/app = food_recipes[Rp]["Appliance"]
			if(!app || app == "")
				app = "Simple"
			if(!searchcache_foodrecipe[app])
				searchcache_foodrecipe[app] = list()
			searchcache_foodrecipe[app].Add("[P.title]")
			pages.Add(P)
	for(var/Rp in drink_recipes)
		if(drink_recipes[Rp] && !drink_recipes[Rp]["Spoiler"] && !isnull(drink_recipes[Rp]["Result"]))
			var/datum/internal_wiki/page/P = new()
			P.recipe_assemble(drink_recipes[Rp])
			drinkrecipe["[P.title]"] = P
			searchcache_drinkrecipe.Add("[P.title]")
			pages.Add(P)

/datum/internal_wiki/main/proc/allow_reagent(var/reagent)
	// This is used to filter out some of the base reagent types, such as "drink", without putting spoiler tags on base types...
	if(reagent == "reagent")
		return FALSE
	if(reagent == "drugs")
		return FALSE
	if(reagent == "drink")
		return FALSE
	return TRUE

/datum/internal_wiki/page
	var/title = ""
	var/body = ""

/datum/internal_wiki/page/proc/get_data()
	// this is so we can override these for catalog records viewing
	return body

/datum/internal_wiki/page/proc/ore_assemble(var/ore/O)
	title = O.display_name
	body = ""
	if(O.smelts_to)
		var/datum/material/S = get_material_by_name(O.smelts_to)
		body += "<b>Smelt: [S.name]</b><br>"
	if(O.compresses_to)
		var/datum/material/C = get_material_by_name(O.compresses_to)
		body += "<b>Compress: [C.name]</b><br>"
	body += "<b>Grind: [SSchemistry.chemical_reagents[O.reagent].name]</b><br>"
	if(O.alloy)
		body += "<br>"
		body += "<b>Alloy Component of: </b><br>"
		// Assemble what alloys this ore can make
		for(var/datum/alloy/A in GLOB.alloy_data)
			for(var/req in A.requires)
				if(O.name == req )
					var/datum/material/M = get_material_by_name(A.metaltag)
					body += "<b>-[M.display_name]</b><br>"
					break
	else
		body += "<br>"
		body += "<b>No known Alloys</b><br>"

/datum/internal_wiki/page/proc/material_assemble(var/datum/material/M)
	title = M.display_name
	body  = "<b>Integrity: [M.integrity]</b><br>"
	body += "<b>Hardness: [M.hardness]</b><br>"
	body += "<b>Weight: [M.weight]</b><br>"
	body += "<br>"
	body += "<b>Transparent: [M.opacity >= 0.5 ? "No" : "Yes"]</b><br>"
	body += "<b>Conductive: [M.conductive ? "Yes" : "No"]</b><br>"
	body += "<b>Stability: [M.protectiveness]</b><br>"
	body += "<b>Blast Res.: [M.explosion_resistance]</b><br>"
	body += "<b>Radioactivity: [M.radioactivity]</b><br>"
	body += "<b>Reflectivity: [M.reflectivity * 100]%</b><br>"
	body += "<br>"
	if(M.melting_point != null)
		body += "<b>Melting Point: [M.melting_point]k</b><br>"
	else
		body += "<b>Melting Point: --- </b><br>"
	if(M.ignition_point != null)
		body += "<b>Ignition Point: [M.ignition_point]k</b><br>"
	else
		body += "<b>Ignition Point: --- </b><br>"
	M.get_recipes() // generate if not already
	if(M.recipes != null && M.recipes.len > 0)
		body += "<br>"
		body += "<b>Recipies: </b><br>"
		for(var/datum/stack_recipe/R in M.recipes)
			body += "<b>-[R.title]</b><br>"

/datum/internal_wiki/page/proc/smasher_assemble(var/datum/particle_smasher_recipe/M, var/resultname)

	var/obj/item/stack/material/req_mat = null
	if(M.required_material)
		req_mat = new M.required_material
	title = resultname
	body  = "";
	if(req_mat != null)
		body += "<b>Target Sheet: [req_mat.name]</b><br>"
	if(M.items != null && M.items.len > 0)
		if( M.items.len == 1)
			var/Ir = M.items[1]
			var/obj/item/scanitm = new Ir()
			body += "<b>Target Item: [scanitm.name]</b><br>"
			qdel(scanitm)
		else
			body += "<b>Target Item: </b><br>"
			for(var/Ir in M.items)
				var/obj/item/scanitm = new Ir()
				body += "<b>-[scanitm.name]</b><br>"
				qdel(scanitm)
	body += "<b>Threshold Energy: [M.required_energy_min] - [M.required_energy_max]</b><br>"
	body += "<b>Threshold Temp: [M.required_atmos_temp_min]k - [M.required_atmos_temp_max]k</b><br>"
	if(M.reagents != null && M.reagents.len > 0)
		body += "<br>"
		body += "<b>Inducers: </b><br>"
		for(var/R in M.reagents)
			var/amnt = M.reagents[R]
			var/datum/reagent/Rd = SSchemistry.chemical_reagents[R]
			body += "<b>-[Rd.name] [amnt]u</b><br>"
	body += "<br>"
	body += "<b>Results: [resultname]</b><br>"
	body += "<b>Probability: [M.probability]%</b><br>"
	qdel(req_mat)

/datum/internal_wiki/page/proc/chemical_assemble(var/datum/reagent/R)
	title = R.name
	body  = "<b>Description: </b>[R.description]<br>"
	if(R.overdose > 0)
		body += "<b>Overdose: </b>[R.overdose]U<br>"
	body += "<b>Flavor: </b>[R.taste_description]<br>"
	body += "<br>"
	body += allergen_assemble(R.allergen_type)
	body += "<br>"
	if(SSchemistry.chemical_reactions_by_product[R.id] != null && SSchemistry.chemical_reactions_by_product[R.id].len > 0)
		var/segment = 1

		var/list/display_reactions = list()
		for(var/decl/chemical_reaction/CR in SSchemistry.chemical_reactions_by_product[R.id])
			if(!CR.spoiler)
				display_reactions.Add(CR)
		for(var/decl/chemical_reaction/CR in display_reactions)
			if(display_reactions.len == 1)
				body += "<b>Potential Chemical breakdown: </b><br>"
			else
				body += "<b>Potential Chemical breakdown [segment]: </b><br>"
			segment += 1

			for(var/RQ in CR.required_reagents)
				body += " <b>-Component: </b>[SSchemistry.chemical_reagents[RQ].name]<br>"
			for(var/IH in CR.inhibitors)
				body += " <b>-Inhibitor: </b>[SSchemistry.chemical_reagents[IH].name]<br>"
			for(var/CL in CR.catalysts)
				body += " <b>-Catalyst: </b>[SSchemistry.chemical_reagents[CL].name]<br>"
	else
		body += "<b>Potential Chemical breakdown: </b>UNKNOWN OR BASE-REAGENT<br>"

/datum/internal_wiki/page/proc/food_assemble(var/datum/reagent/R)
	title = R.name
	body  = "<b>Description: </b>[R.description]<br>"
	body += "<br>"
	body += allergen_assemble(R.allergen_type)
	body += "<br>"
	if(SSchemistry.chemical_reactions_by_product[R.id] != null && SSchemistry.chemical_reactions_by_product[R.id].len > 0)
		var/segment = 1
		var/list/display_reactions = list()
		for(var/decl/chemical_reaction/CR in SSchemistry.chemical_reactions_by_product[R.id])
			if(!CR.spoiler)
				display_reactions.Add(CR)
		for(var/decl/chemical_reaction/CR in display_reactions)
			if(display_reactions.len == 1)
				body += "<b>Recipe: </b><br>"
			else
				body += "<b>Recipe </b>[segment]: <br>"
			segment += 1

			for(var/RQ in CR.required_reagents)
				body += " <b>-Component: </b>[SSchemistry.chemical_reagents[RQ].name]<br>"
			for(var/IH in CR.inhibitors)
				body += " <b>-Inhibitor: </b>[SSchemistry.chemical_reagents[IH].name]<br>"
			for(var/CL in CR.catalysts)
				body += " <b>-Catalyst: </b>[SSchemistry.chemical_reagents[CL].name]<br>"
	else
		body += "<b>Recipe: </b>UNKNOWN<br>"

/datum/internal_wiki/page/proc/drink_assemble(var/datum/reagent/R)
	title = R.name
	body  = "<b>Description: </b>[R.description]<br>"
	body += "<b>Flavor: </b>[R.taste_description]<br>"
	body += "<br>"
	body += allergen_assemble(R.allergen_type)
	body += "<br>"
	if(SSchemistry.chemical_reactions_by_product[R.id] != null && SSchemistry.chemical_reactions_by_product[R.id].len > 0)
		var/segment = 1
		var/list/display_reactions = list()
		for(var/decl/chemical_reaction/CR in SSchemistry.chemical_reactions_by_product[R.id])
			if(!CR.spoiler)
				display_reactions.Add(CR)
		for(var/decl/chemical_reaction/CR in display_reactions)
			if(display_reactions.len == 1)
				body += "Mix: <br>"
			else
				body += "Mix [segment]: <br>"
			segment += 1

			for(var/RQ in CR.required_reagents)
				body += " <b>-Component: </b>[SSchemistry.chemical_reagents[RQ].name]<br>"
			for(var/IH in CR.inhibitors)
				body += " <b>-Inhibitor: </b>[SSchemistry.chemical_reagents[IH].name]<br>"
			for(var/CL in CR.catalysts)
				body += " <b>-Catalyst: </b>[SSchemistry.chemical_reagents[CL].name]<br>"
	else
		body += "<b>Mix: </b>UNKNOWN<br>"

/datum/internal_wiki/page/proc/allergen_assemble(var/allergens)
	var/body = ""
	if(allergens > 0)
		body += "<b>Allergens: </b><br>"
		if(allergens & ALLERGEN_MEAT)
			body += "-Meat protein<br>"
		if(allergens & ALLERGEN_FISH)
			body += "-Fish protein<br>"
		if(allergens & ALLERGEN_FRUIT)
			body += "-Fruit<br>"
		if(allergens & ALLERGEN_VEGETABLE)
			body += "-Vegetable<br>"
		if(allergens & ALLERGEN_GRAINS)
			body += "-Grain<br>"
		if(allergens & ALLERGEN_BEANS)
			body += "-Bean<br>"
		if(allergens & ALLERGEN_SEEDS)
			body += "-Nut<br>"
		if(allergens & ALLERGEN_DAIRY)
			body += "-Dairy<br>"
		if(allergens & ALLERGEN_FUNGI)
			body += "-Fungi<br>"
		if(allergens & ALLERGEN_COFFEE)
			body += "-Caffeine<br>"
		if(allergens & ALLERGEN_SUGARS)
			body += "-Sugar<br>"
		if(allergens & ALLERGEN_EGGS)
			body += "-Egg<br>"
		if(allergens & ALLERGEN_STIMULANT)
			body += "-Stimulant<br>"
		if(allergens & ALLERGEN_POLLEN)
			body += "-Pollen<br>"
		body += "<br>"
	return body

/datum/internal_wiki/page/proc/recipe_assemble(var/list/recipe)
	title = recipe["Result"]
	body  = ""
	if(recipe["Desc"])
		body  += "<b>Description: </b>[recipe["Desc"]]<br>"
	if(length(recipe["Flavor"]) > 0)
		body += "<b>Flavor: </b>[recipe["Flavor"]]<br>"
	body += allergen_assemble(recipe["Allergens"])
	body += "<br>"
	if(recipe["Appliance"])
		body += "<b>Appliance: </b>[recipe["Appliance"]]<br><br>"

	var/count //For those commas. Not sure of a great other way to do it.
	//For each large ingredient
	var/pretty_ing = ""
	count = 0
	for(var/ing in recipe["Ingredients"])
		pretty_ing += "[count == 0 ? "" : ", "][recipe["Ingredients"][ing]]x [ing]"
		count++
	if(pretty_ing != "")
		body +=  "<b>Ingredients: </b>[pretty_ing]<br>"

	//Coating
	if(!recipe["has_coatable_items"])
		body += "<b>Coating: </b>N/A, no coatable items<br>"
	else if(recipe["Coating"] == -1)
		body += "<b>Coating: </b>Optionally, any coating<br>"
	else if(isnull(recipe["Coating"]))
		body += "<b>Coating: </b> Must be uncoated<br>"
	else
		var/coatingtype = recipe["Coating"]
		var/datum/reagent/coating = new coatingtype()
		body += "<b>Coating: </b> [coating.name]<br>"

	//For each fruit... why are they named this when it can be vegis too?
	var/pretty_fru = ""
	count = 0
	for(var/fru in recipe["Fruit"])
		pretty_fru += "[count == 0 ? "" : ", "][recipe["Fruit"][fru]]x [fru]"
		count++
	if(pretty_fru != "")
		body += "<b>Components: </b> [pretty_fru]<br>"

	//For each reagent
	var/pretty_rea = ""
	count = 0
	for(var/rea in recipe["Reagents"])
		pretty_rea += "[count == 0 ? "" : ", "][recipe["Reagents"][rea]]u [rea]"
		count++
	if(pretty_rea != "")
		body += "<b>Mix in: </b> [pretty_rea]<br>"

	//For each catalyst
	var/pretty_cat = ""
	count = 0
	for(var/cat in recipe["Catalysts"])
		pretty_cat += "[count == 0 ? "" : ", "][recipe["Catalysts"][cat]]u [cat]"
		count++
	if(pretty_cat != "")
		body += "<b>Catalysts: </b> [pretty_cat]<br>"



/datum/internal_wiki/page/catalog
	var/datum/category_item/catalogue/catalog_record

/datum/internal_wiki/page/catalog/get_data()
	return catalog_record.desc
