// Bitflags for mutations.
#define STRUCDNASIZE 27
#define   UNIDNASIZE 13

// Generic mutations:
#define TK              1
#define COLD_RESISTANCE 2
#define XRAY            3
#define HULK            4
#define CLUMSY          5
#define FAT             6
#define HUSK            7
#define NOCLONE         8
#define LASER           9  // Harm intent - click anywhere to shoot lasers from eyes.
#define HEAL            10 // Healing people with hands.

#define SKELETON      29
#define PLANT         30

// Other Mutations:
#define mNobreath      100 // No need to breathe.
#define mRemote        101 // Remote viewing.
#define mRegen         102 // Health regeneration.
#define mRun           103 // No slowdown.
#define mRemotetalk    104 // Remote talking.
#define mMorph         105 // Hanging appearance.
#define mBlend         106 // Nothing. (seriously nothing)
#define mHallucination 107 // Hallucinations.
#define mFingerprints  108 // No fingerprints.
#define mShock         109 // Insulated hands.
#define mSmallsize     110 // Table climbing.

// disabilities
#define NEARSIGHTED 0x1
#define EPILEPSY    0x2
#define COUGHING    0x4
#define TOURETTES   0x8
#define NERVOUS     0x10
#define VERTIGO     0x20

// sdisabilities
#define BLIND 0x1
#define MUTE  0x2
#define DEAF  0x4

// addictions
#define ADDICT_NICOTINE 	0x1
#define ADDICT_PAINKILLER 	0x2
#define ADDICT_BLISS		0x4
#define ADDICT_OXY			0x8
#define ADDICT_HYPER		0x10

// The way blocks are handled badly needs a rewrite, this is horrible.
// Too much of a project to handle at the moment, TODO for later.
var/BLINDBLOCK    = 0
var/DEAFBLOCK     = 0
//var/HULKBLOCK     = 0
var/TELEBLOCK     = 0
var/FIREBLOCK     = 0
var/XRAYBLOCK     = 0
//var/CLUMSYBLOCK   = 0
//var/FAKEBLOCK     = 0
var/COUGHBLOCK    = 0
var/GLASSESBLOCK  = 0
var/EPILEPSYBLOCK = 0
var/TWITCHBLOCK   = 0
var/NERVOUSBLOCK  = 0
var/VERTIGOBLOCK  = 0
// var/MONKEYBLOCK   = STRUCDNASIZE // outpost 21 edit, this is too broken to keep with the current overlays code.

var/HEADACHEBLOCK      = 0
var/NOBREATHBLOCK      = 0
var/REMOTEVIEWBLOCK    = 0
var/REGENERATEBLOCK    = 0
//var/INCREASERUNBLOCK   = 0
var/REMOTETALKBLOCK    = 0
//var/MORPHBLOCK         = 0
//var/BLENDBLOCK         = 0
//var/HALLUCINATIONBLOCK = 0
var/NOPRINTSBLOCK      = 0
//var/SHOCKIMMUNITYBLOCK = 0
//var/SMALLSIZEBLOCK     = 0
var/GIBBINGBLOCK    = 0
var/LASERBLOCK    = 0
var/FARTBLOCK    = 0

// Modern traits for modern agonizing problems, see code\game\dna\genes\traits.dm for explaination
// Negative
var/TRAITBLOCK_SLOWDOWN    			= 0
var/TRAITBLOCK_SLOWDOWNEX    		= 0
var/TRAITBLOCK_WEAK    				= 0
var/TRAITBLOCK_WEAKEX    			= 0
var/TRAITBLOCK_ENDURLOW    			= 0
var/TRAITBLOCK_ENDURLOWEX    		= 0
var/TRAITBLOCK_ENDURLOWEST    		= 0
var/TRAITBLOCK_BRUTEWEAK_MINOR   	= 0
var/TRAITBLOCK_BRUTEWEAK   			= 0
var/TRAITBLOCK_BRUTEWEAK_MAJOR   	= 0
var/TRAITBLOCK_BURNWEAK_MINOR   	= 0
var/TRAITBLOCK_BURNWEAK   			= 0
var/TRAITBLOCK_BURNWEAK_MAJOR   	= 0
var/TRAITBLOCK_REDUCEDCHEM 			= 0
var/TRAITBLOCK_RAISEDCHEM 			= 0
var/TRAITBLOCK_AIRLIVER 			= 0
var/TRAITBLOCK_PAININTOL 			= 0
var/TRAITBLOCK_PAININTOLEX 			= 0
var/TRAITBLOCK_CONDUCTIVE 			= 0
var/TRAITBLOCK_CONDUCTIVE_MAJOR 	= 0
var/TRAITBLOCK_CONDUCTIVE_EXTREME 	= 0
var/TRAITBLOCK_HAEMOPHILIA 			= 0
var/TRAITBLOCK_HOLLOW 				= 0
var/TRAITBLOCK_LIGHTWEIGHT			= 0
var/TRAITBLOCK_HYPERSENSITIVE		= 0
var/TRAITBLOCK_BREATH_PHORON		= 0
var/TRAITBLOCK_BREATH_NITROGEN		= 0
var/TRAITBLOCK_BREATH_CARBON		= 0
var/TRAITBLOCK_DARKBLIND			= 0
var/TRAITBLOCK_LIGHTSENSITIVE		= 0
var/TRAITBLOCK_LIGHTSENSITIVEEX		= 0
var/TRAITBLOCK_WINGDINGS			= 0
var/TRAITBLOCK_DETERIORATE			= 0
// Neutral
var/TRAITBLOCK_METABOLISM_UP     	= 0
var/TRAITBLOCK_METABOLISM_DOWN     	= 0
var/TRAITBLOCK_METABOLISM_APEX     	= 0
var/TRAITBLOCK_ALCOHOL_INTOL_BASIC	= 0
var/TRAITBLOCK_ALCOHOL_TOL_BASIC	= 0
var/TRAITBLOCK_HOT_BLOOD			= 0
var/TRAITBLOCK_COLD_BLOOD			= 0
var/TRAITBLOCK_ICE_BLOOD			= 0
var/TRAITBLOCK_BLOODSUCKER			= 0
var/TRAITBLOCK_SUCCUBUS				= 0
var/TRAITBLOCK_TONGUE				= 0
var/TRAITBLOCK_FEEDER				= 0
var/TRAITBLOCK_TRASHCAN				= 0
var/TRAITBLOCK_GEMEATER				= 0
var/TRAITBLOCK_EYEGLOW				= 0
var/TRAITBLOCK_BODYGLOW				= 0
var/TRAITBLOCK_ALLERGY_MEAT			= 0
var/TRAITBLOCK_ALLERGY_FISH			= 0
var/TRAITBLOCK_ALLERGY_POLLEN		= 0
var/TRAITBLOCK_ALLERGY_FRUIT		= 0
var/TRAITBLOCK_ALLERGY_VEGI			= 0
var/TRAITBLOCK_ALLERGY_NUTS			= 0
var/TRAITBLOCK_ALLERGY_SOY			= 0
var/TRAITBLOCK_ALLERGY_DAIRY		= 0
var/TRAITBLOCK_ALLERGY_FUNGI		= 0
var/TRAITBLOCK_ALLERGY_COFFEE		= 0
var/TRAITBLOCK_SPICE_INTOL_EXTREME	= 0
var/TRAITBLOCK_SPICE_INTOL_BASIC	= 0
var/TRAITBLOCK_SPICE_INTOL_SLIGHT	= 0
var/TRAITBLOCK_SPICE_TOL_BASIC		= 0
var/TRAITBLOCK_SPICE_TOL_ADVANCED	= 0
var/TRAITBLOCK_SPICE_TOL_IMMUNE		= 0
var/TRAITBLOCK_COLORBLIND_MONO		= 0
var/TRAITBLOCK_COLORBLIND_VULP		= 0
var/TRAITBLOCK_COLORBLIND_TAJ		= 0
var/TRAITBLOCK_BODY_TALLER			= 0
var/TRAITBLOCK_BODY_TALL			= 0
var/TRAITBLOCK_BODY_SHORT			= 0
var/TRAITBLOCK_BODY_SHORTER			= 0
var/TRAITBLOCK_BODY_OBESE			= 0
var/TRAITBLOCK_BODY_FAT				= 0
var/TRAITBLOCK_BODY_THIN			= 0
var/TRAITBLOCK_BODY_THINNER			= 0
var/TRAITBLOCK_VORE_DOMPRED			= 0
var/TRAITBLOCK_VORE_DOMPREY			= 0
var/TRAITBLOCK_VORE_SUBTOPREY		= 0
var/TRAITBLOCK_MICRO_SIZEDOWN		= 0
var/TRAITBLOCK_MICRO_SIZEUP			= 0
var/TRAITBLOCK_INSATIABLE			= 0
var/TRAITBLOCK_INSATIABLEEX			= 0
var/TRAITBLOCK_DRIPPY				= 0
// Positive
var/TRAITBLOCK_SPEEDFAST			= 0
var/TRAITBLOCK_SPEEDFASTEX			= 0
var/TRAITBLOCK_HARDY				= 0
var/TRAITBLOCK_HARDYEX				= 0
var/TRAITBLOCK_ENDURANCE			= 0
var/TRAITBLOCK_ENDURANCE_MAJOR		= 0
var/TRAITBLOCK_ENDURANCEEX			= 0
var/TRAITBLOCK_NONCONDUCT			= 0
var/TRAITBLOCK_NONCONDUCT_MAJOR		= 0
var/TRAITBLOCK_NONCONDUCTEX			= 0
var/TRAITBLOCK_DARKSIGHT			= 0
var/TRAITBLOCK_DARKSIGHTEX			= 0
var/TRAITBLOCK_BRUTERESIST_MINOR	= 0
var/TRAITBLOCK_BRUTERESIST			= 0
var/TRAITBLOCK_BRUTERESIST_MAJOR	= 0
var/TRAITBLOCK_BURNRESIST_MINOR		= 0
var/TRAITBLOCK_BURNRESIST			= 0
var/TRAITBLOCK_BURNRESIST_MAJOR		= 0
var/TRAITBLOCK_CHEMADVANCED			= 0
var/TRAITBLOCK_ALCOHOL_TOLEX		= 0
var/TRAITBLOCK_ALCOHOL_IMMUNE		= 0
var/TRAITBLOCK_PAIN_TOLLER_BASIC	= 0
var/TRAITBLOCK_PAIN_TOLLEREX		= 0
var/TRAITBLOCK_PHOTORESIST			= 0
var/TRAITBLOCK_PHOTORESISTEX		= 0
var/TRAITBLOCK_WINGFLIGHT			= 0
var/TRAITBLOCK_SOFTLAND				= 0
var/TRAITBLOCK_ANTISEPTIC			= 0
var/TRAITBLOCK_SPRINGSTEP			= 0
var/TRAITBLOCK_BLOODSUCKEREX		= 0
var/TRAITBLOCK_SONAR				= 0
var/TRAITBLOCK_COLDADAPT			= 0
var/TRAITBLOCK_HOTADAPT				= 0
var/TRAITBLOCK_WEAVER				= 0
var/TRAITBLOCK_AQUATIC				= 0
var/TRAITBLOCK_COCOON				= 0
var/TRAITBLOCK_PAINTOLLERANT		= 0
var/TRAITBLOCK_PHORONEXPOSED		= 0
var/TRAITBLOCK_ENZYME				= 0
// XENOCHIMERA
var/TRAITBLOCK_WEAVERXENO			= 0
var/TRAITBLOCK_HYPERSENSITIVE_XENO	= 0
var/TRAITBLOCK_WINGFLIGHT_XENO		= 0
var/TRAITBLOCK_COCOON_XENO			= 0
