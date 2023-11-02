// See also controllers/globals.dm

// Creates a global initializer with a given InitValue expression, do not use outside this file
#define GLOBAL_MANAGED(X, InitValue)\
/datum/controller/global_vars/proc/InitGlobal##X(){\
	##X = ##InitValue;\
	gvars_datum_init_order += #X;\
}
// Creates an empty global initializer, do not use outside this file
#define GLOBAL_UNMANAGED(X) /datum/controller/global_vars/proc/InitGlobal##X() { return; }

// Prevents a given global from being VV'd
#ifndef TESTING
#define GLOBAL_PROTECT(X)\
/datum/controller/global_vars/InitGlobal##X(){\
	..();\
	gvars_datum_protected_varlist += #X;\
}
#else
#define GLOBAL_PROTECT(X)
#endif

// Standard BYOND global, do not use outside this file
#define GLOBAL_REAL_VAR(X) var/global/##X

// Standard typed BYOND global, do not use outside this file
#define GLOBAL_REAL(X, Typepath) var/global##Typepath/##X

// Defines a global var on the controller, do not use outside this file.
#define GLOBAL_RAW(X) /datum/controller/global_vars/var/global##X

// Create an untyped global with an initializer expression
#define GLOBAL_VAR_INIT(X, InitValue) GLOBAL_RAW(/##X); GLOBAL_MANAGED(X, InitValue)

// Create a global const var, do not use
#define GLOBAL_VAR_CONST(X, InitValue) GLOBAL_RAW(/const/##X) = InitValue; GLOBAL_UNMANAGED(X)

// Create a list global with an initializer expression
#define GLOBAL_LIST_INIT(X, InitValue) GLOBAL_RAW(/list/##X); GLOBAL_MANAGED(X, InitValue)

// Create a list global that is initialized as an empty list
#define GLOBAL_LIST_EMPTY(X) GLOBAL_LIST_INIT(X, list())

// Create a typed list global with an initializer expression
#define GLOBAL_LIST_INIT_TYPED(X, Typepath, InitValue) GLOBAL_RAW(/list##Typepath/X); GLOBAL_MANAGED(X, InitValue)

// Create a typed list global that is initialized as an empty list
#define GLOBAL_LIST_EMPTY_TYPED(X, Typepath) GLOBAL_LIST_INIT_TYPED(X, Typepath, list())

// Create a typed global with an initializer expression
#define GLOBAL_DATUM_INIT(X, Typepath, InitValue) GLOBAL_RAW(Typepath/##X); GLOBAL_MANAGED(X, InitValue)

// Create an untyped null global
#define GLOBAL_VAR(X) GLOBAL_RAW(/##X); GLOBAL_UNMANAGED(X)

// Create a null global list
#define GLOBAL_LIST(X) GLOBAL_RAW(/list/##X); GLOBAL_UNMANAGED(X)

// Create a typed null global
#define GLOBAL_DATUM(X, Typepath) GLOBAL_RAW(Typepath/##X); GLOBAL_UNMANAGED(X)


// verb tab IDs
#define VERBTAB_SERVER "Server"
#define VERBTAB_MANAGE "Server Management"
#define VERBTAB_LOGS "Server Logs"
#define VERBTAB_ADMIN "Admin"
#define VERBTAB_DEBUG "Debug"
#define VERBTAB_PREFS "Preferences"
#define VERBTAB_MAPPING "Mapping"
#define VERBTAB_ZAS "ZAS"

// AI verbs
#define VERBTAB_AICOMMS "AI Commands"
#define VERBTAB_AISETTINGS "AI Settings"
#define VERBTAB_SUBSYS "Subsystems"
#define VERBTAB_HARDWARE "Hardware"
#define VERBTAB_SOFTWARE "Software"

#define VERBTAB_BLUEPRINT "Blueprints"

#define VERBTAB_GHOST "Ghost"		// the dead's commands
#define VERBTAB_EQUIP "Equipment"	// Objects that persist on a player for a long time, and shouldn't be cluttered by Objects tab stuff, like hardsuits or vehicles
#define VERBTAB_IC "IC"				// character settings and toggles, or menus/notes
#define VERBTAB_OOC "OOC"			// OOC chats and game specific toggles
#define VERBTAB_POWERS "Powers"		// powers unique to species, traits, or antags
#define VERBTAB_OBJECT "Object"		// objects around a player that can be interacted with

#define VERBTAB_SPECIAL "Special Verbs"	// server pings, chatlogs, reloading buttons, and bugfix verbs,  also admin shenanigans
