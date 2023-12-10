/////////////////////
// DISABILITY GENES
//
// These activate either a mutation, disability, or sdisability.
//
// Gene is always activated.
/////////////////////

/datum/dna/gene/disability
	name="DISABILITY"

	// Mutation to give (or 0)
	var/mutation=0

	// Disability to give (or 0)
	var/disability=0

	// SDisability to give (or 0)
	var/sdisability=0

/datum/dna/gene/disability/can_activate(var/mob/M,var/flags)
	return 1 // Always set!

/datum/dna/gene/disability/activate(var/mob/M, var/connected, var/flags)
	if(mutation && !(mutation in M.mutations))
		M.mutations.Add(mutation)
	if(disability)
		M.disabilities|=disability
	if(sdisability)
		M.sdisabilities|=sdisability
	if(activation_messages.len)
		if(!(flags & GENE_INITIAL_ACTIVATION))
			var/msg = pick(activation_messages)
			to_chat(M, "<span class='warning'>[msg]</span>")
	else
		testing("[name] has no activation message.")

/datum/dna/gene/disability/deactivate(var/mob/M, var/connected, var/flags)
	if(mutation && (mutation in M.mutations))
		M.mutations.Remove(mutation)
	if(disability)
		M.disabilities &= (~disability)
	if(sdisability)
		M.sdisabilities &= (~sdisability)
	if(deactivation_messages.len)
		if(!(flags & GENE_INITIAL_ACTIVATION))
			var/msg = pick(deactivation_messages)
			to_chat(M, "<span class='warning'>[msg]</span>")
	else
		testing("[name] has no deactivation message.")

/* outpost 21 edit - disabling due to lots of genes
// Note: Doesn't seem to do squat, at the moment.
/datum/dna/gene/disability/hallucinate
	name="Hallucinate"
	activation_messages="Your mind says 'Hello'."
	mutation=mHallucination

/datum/dna/gene/disability/hallucinate/New()
	block=HALLUCINATIONBLOCK
*/

/datum/dna/gene/disability/epilepsy
	name="Epilepsy"
	activation_messages=list("You get a headache.")
	deactivation_messages=list("Your headache stops.")
	disability=EPILEPSY

/datum/dna/gene/disability/epilepsy/New()
	block=HEADACHEBLOCK

/datum/dna/gene/disability/cough
	name="Coughing"
	activation_messages=list("You start coughing.")
	deactivation_messages=list("You stop couching.")
	disability=COUGHING

/datum/dna/gene/disability/cough/New()
	block=COUGHBLOCK

/* outpost 21 edit - disabling due to lots of genes
/datum/dna/gene/disability/clumsy
	name="Clumsiness"
	activation_messages="You feel lightheaded."
	mutation=CLUMSY

/datum/dna/gene/disability/clumsy/New()
	block=CLUMSYBLOCK
*/

/datum/dna/gene/disability/tourettes
	name="Tourettes"
	activation_messages=list("You twitch.")
	deactivation_messages=list("You feel less unstable.")
	disability=TOURETTES

/datum/dna/gene/disability/tourettes/New()
	block=TWITCHBLOCK

/datum/dna/gene/disability/nervousness
	name="Nervousness"
	activation_messages=list("You feel nervous.")
	deactivation_messages=list("You feel more calm.")
	disability=NERVOUS

/datum/dna/gene/disability/nervousness/New()
	block=NERVOUSBLOCK

/datum/dna/gene/disability/vertigo
	name="Vertigo"
	activation_messages=list("You feel like the world could start spinning.")
	deactivation_messages=list("The world feels more stable.")
	disability=VERTIGO

/datum/dna/gene/disability/vertigo/New()
	block=VERTIGOBLOCK

/datum/dna/gene/disability/blindness
	name="Blindness"
	activation_messages=list("You can't seem to see anything.")
	deactivation_messages=list("Your vision returns.")
	sdisability=BLIND

/datum/dna/gene/disability/blindness/New()
	block=BLINDBLOCK

/datum/dna/gene/disability/deaf
	name="Deafness"
	activation_messages=list("It's kinda quiet.")
	deactivation_messages=list("You can hear again.")
	sdisability=DEAF

/datum/dna/gene/disability/deaf/New()
	block=DEAFBLOCK

/datum/dna/gene/disability/deaf/activate(var/mob/M, var/connected, var/flags)
	..(M,connected,flags)
	M.ear_deaf = 1

/datum/dna/gene/disability/nearsighted
	name="Nearsightedness"
	activation_messages=list("Your eyes feel weird...")
	deactivation_messages=list("Everything comes back into focus.")
	disability=NEARSIGHTED

/datum/dna/gene/disability/nearsighted/New()
	block=GLASSESBLOCK
