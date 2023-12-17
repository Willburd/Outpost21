///////////////////////////////////
// POWERS
///////////////////////////////////

/datum/dna/gene/basic/nobreath
	name="No Breathing"
	activation_messages=list("You feel no need to breathe.")
	deactivation_messages=list("You need to breathe!")
	primitive_expression_messages=list("isn't breathing.")
	mutation=mNobreath

/datum/dna/gene/basic/nobreath/New()
	block=NOBREATHBLOCK

/datum/dna/gene/basic/remoteview
	name="Remote Viewing"
	activation_messages=list("Your mind expands.")
	deactivation_messages=list("Your mind contracts.")
	primitive_expression_messages=list("makes noises to itself.")
	mutation=mRemote

/datum/dna/gene/basic/remoteview/New()
	block=REMOTEVIEWBLOCK

/datum/dna/gene/basic/remoteview/activate(var/mob/M, var/connected, var/flags)
	..(M,connected,flags)
	M.verbs += /mob/living/carbon/human/proc/remoteobserve

/datum/dna/gene/basic/regenerate
	name="Regenerate"
	activation_messages=list("You feel better.")
	deactivation_messages=list("You feel normal.")
	primitive_expression_messages=list("'s skin shift's strangely.")
	mutation=mRegen

/datum/dna/gene/basic/regenerate/New()
	block=REGENERATEBLOCK

/* outpost 21 edit - disabled
/datum/dna/gene/basic/increaserun
	name="Super Speed"
	activation_messages=list("Your leg muscles pulsate.")
	mutation=mRun

/datum/dna/gene/basic/increaserun/New()
	block=INCREASERUNBLOCK
*/

/datum/dna/gene/basic/remotetalk
	name="Telepathy"
	activation_messages=list("You expand your mind outwards to others like you.")
	deactivation_messages=list("You feel your mind disconnect from the others.")
	primitive_expression_messages=list("makes noises to itself.")
	mutation=mRemotetalk

/datum/dna/gene/basic/remotetalk/New()
	block=REMOTETALKBLOCK

/datum/dna/gene/basic/remotetalk/activate(var/mob/M, var/connected, var/flags)
	..(M,connected,flags)
	M.verbs += /mob/living/carbon/human/proc/remotesay

/* outpost 21 edit - disabled
/datum/dna/gene/basic/morph
	name="Morph"
	activation_messages=list("Your skin feels strange.")
	mutation=mMorph

/datum/dna/gene/basic/morph/New()
	block=MORPHBLOCK

/datum/dna/gene/basic/morph/activate(var/mob/M)
	..(M)
	M.verbs += /mob/living/carbon/human/proc/morph
*/

/datum/dna/gene/basic/cold_resist
	name="Cold Resistance"
	activation_messages=list("Your body is filled with warmth.")
	deactivation_messages=list("Your body feels colder.")
	primitive_expression_messages=list("shivers.")
	mutation=COLD_RESISTANCE

/datum/dna/gene/basic/cold_resist/New()
	block=FIREBLOCK

/datum/dna/gene/basic/cold_resist/can_activate(var/mob/M,var/flags)
	if(flags & MUTCHK_FORCED)
		return 1
	var/_prob=30
	if(probinj(_prob,(flags&MUTCHK_FORCED)))
		return 1

/datum/dna/gene/basic/cold_resist/OnDrawUnderlays(var/mob/M,var/g,var/fat)
	return "fire[fat]_s"

/datum/dna/gene/basic/noprints
	name="No Prints"
	activation_messages=list("Your fingers feel numb.")
	deactivation_messages=list("Your fingers return to normal.")
	primitive_expression_messages=list("flexes its digits.")
	mutation=mFingerprints

/datum/dna/gene/basic/noprints/New()
	block=NOPRINTSBLOCK

/* outpost 21 edit -disabled
/datum/dna/gene/basic/noshock
	name="Shock Immunity"
	activation_messages=list("Your skin feels strange.")
	mutation=mShock

/datum/dna/gene/basic/noshock/New()
	block=SHOCKIMMUNITYBLOCK

/datum/dna/gene/basic/midget
	name="Midget"
	activation_messages=list("Your skin feels rubbery.")
	mutation=mSmallsize

/datum/dna/gene/basic/midget/New()
	block=SMALLSIZEBLOCK

/datum/dna/gene/basic/midget/can_activate(var/mob/M,var/flags)
	// Can't be big and small.
	if(HULK in M.mutations)
		return 0
	return ..(M,flags)

/datum/dna/gene/basic/midget/activate(var/mob/M, var/connected, var/flags)
	..(M,connected,flags)
	M.pass_flags |= 1

/datum/dna/gene/basic/midget/deactivate(var/mob/M, var/connected, var/flags)
	..(M,connected,flags)
	M.pass_flags &= ~1 //This may cause issues down the track, but offhand I can't think of any other way for humans to get passtable short of varediting so it should be fine. ~Z

/datum/dna/gene/basic/hulk
	name="Hulk"
	activation_messages=list("Your muscles hurt.")
	mutation=HULK

/datum/dna/gene/basic/hulk/New()
	block=HULKBLOCK

/datum/dna/gene/basic/hulk/can_activate(var/mob/M,var/flags)
	// Can't be big and small.
	if(mSmallsize in M.mutations)
		return 0
	return ..(M,flags)

/datum/dna/gene/basic/hulk/OnDrawUnderlays(var/mob/M,var/g,var/fat)
	if(fat)
		return "hulk_[fat]_s"
	else
		return "hulk_[g]_s"

/datum/dna/gene/basic/hulk/OnMobLife(var/mob/living/carbon/human/M)
	if(!istype(M)) return
	if(M.health <= 25)
		M.mutations.Remove(HULK)
		M.update_mutations()		//update our mutation overlays
		to_chat(M, "<span class='warning'>You suddenly feel very weak.</span>")
		M.Weaken(3)
		M.emote("collapse")
*/

/datum/dna/gene/basic/xray
	name="X-Ray Vision"
	activation_messages=list("The walls suddenly disappear.")
	deactivation_messages=list("The walls fade back into view.")
	primitive_expression_messages=list("stares at something it cannot see.")
	mutation=XRAY

/datum/dna/gene/basic/xray/New()
	block=XRAYBLOCK

/datum/dna/gene/basic/tk
	name="Telekenesis"
	activation_messages=list("You feel smarter.")
	deactivation_messages=list("Your telekinetic grasp fails.")
	primitive_expression_messages=list("grabs at something it cannot reach.")
	mutation=TK
	activation_prob=15

/datum/dna/gene/basic/tk/New()
	block=TELEBLOCK
/datum/dna/gene/basic/tk/OnDrawUnderlays(var/mob/M,var/g,var/fat)
	return "telekinesishead[fat]_s"
