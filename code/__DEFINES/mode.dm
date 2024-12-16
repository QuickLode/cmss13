//=================================================
//Self-destruct, nuke, evacuation, and round start miasma.

/// At what time does miasma start if /datum/gamemode_modifier/lz_roundstart_miasma is enabled?
#define DISTRESS_LZ_HAZARD_START (1 MINUTES)
#define EVACUATION_TIME_LOCK 1 HOURS
#define DISTRESS_TIME_LOCK 6 MINUTES
#define SHUTTLE_TIME_LOCK 15 MINUTES
#define SHUTTLE_LOCK_COOLDOWN 10 MINUTES
#define MONORAIL_LOCK_COOLDOWN 3 MINUTES
#define SHUTTLE_LOCK_TIME_LOCK 1 MINUTES
#define EVACUATION_AUTOMATIC_DEPARTURE (10 MINUTES) //All pods automatically depart in 10 minutes, unless they are full or unable to launch for some reason.
#define EVACUATION_ESTIMATE_DEPARTURE ((evac_time + EVACUATION_AUTOMATIC_DEPARTURE - world.time) * 0.1)

#define EVACUATION_STATUS_STANDING_BY 0
#define EVACUATION_STATUS_INITIATING 1
#define EVACUATION_STATUS_IN_PROGRESS 2
#define EVACUATION_STATUS_COMPLETE 3

#define NUCLEAR_TIME_LOCK 90 MINUTES
#define NUKE_EXPLOSION_INACTIVE 0
#define NUKE_EXPLOSION_ACTIVE 1
#define NUKE_EXPLOSION_IN_PROGRESS 2
#define NUKE_EXPLOSION_FINISHED 4
#define NUKE_EXPLOSION_GROUND_FINISHED 8

#define FLAGS_EVACUATION_DENY 1
#define FLAGS_SELF_DESTRUCT_DENY 2

#define LIFEBOAT_LOCKED -1
#define LIFEBOAT_INACTIVE 0
#define LIFEBOAT_ACTIVE 1

#define XENO_ROUNDSTART_PROGRESS_AMOUNT 2
#define XENO_ROUNDSTART_PROGRESS_TIME_1 0
#define XENO_ROUNDSTART_PROGRESS_TIME_2 15 MINUTES

#define ROUND_TIME (world.time - SSticker.round_start_time)

//=================================================


#define IS_MODE_COMPILED(MODE) (ispath(text2path("/datum/game_mode/"+(MODE))))

#define MODE_HAS_FLAG(flag) (SSticker.mode.flags_round_type & flag)
#define MODE_HAS_MODIFIER(modifier_type) (SSticker.mode?.get_gamemode_modifier(modifier_type))
#define MODE_SET_MODIFIER(modifier_type, enabled) (SSticker.mode?.set_gamemode_modifier(modifier_type, enabled))

// Gamemode Flags
#define MODE_INFESTATION (1<<0)
#define MODE_PREDATOR (1<<1)
#define MODE_NO_LATEJOIN (1<<2)
#define MODE_HAS_FINISHED (1<<3)
#define MODE_FOG_ACTIVATED (1<<4)
#define MODE_INFECTION (1<<5)
#define MODE_HUMAN_ANTAGS (1<<6)
#define MODE_NO_SPAWN (1<<7) // Disables marines from spawning in normally
#define MODE_XVX (1<<8) // Affects several castes for XvX, as well as other things (e.g. spawnpool)
#define MODE_NEW_SPAWN (1<<9) // Enables the new spawning, only works for Distress currently
#define MODE_DS_LANDED (1<<10)
#define MODE_BASIC_RT (1<<11)
#define MODE_RANDOM_HIVE (1<<12)// Makes Join-as-Xeno choose a hive to join as burrowed larva at random rather than at user's input..
#define MODE_THUNDERSTORM (1<<13)// Enables thunderstorm effects on maps that are compatible with it. (Lit exterior tiles, rain effects)
#define MODE_FACTION_CLASH (1<<14)// Disables scopes, sniper sentries, OBs, shooting corpses, dragging enemy corpses, stripping enemy corpses, increase armor bullet/bomb/internal damage protection

#define ROUNDSTATUS_FOG_DOWN 1
#define ROUNDSTATUS_PODDOORS_OPEN 2

#define LATEJOIN_MARINES_PER_LATEJOIN_LARVA_EARLY 4
#define LATEJOIN_MARINES_PER_LATEJOIN_LARVA 2.5

//=================================================
#define SHOW_ITEM_ANIMATIONS_NONE 0 //Do not show any item pickup animations
#define SHOW_ITEM_ANIMATIONS_HALF 1 //Toggles tg-style item animations on and off, default on.
#define SHOW_ITEM_ANIMATIONS_ALL 2 //Toggles being able to see animations that occur on the same tile.
//=================================================

//=================================================
#define PAIN_OVERLAY_BLURRY 0 //Blurs your screen a varying amount depending on eye_blur.
#define PAIN_OVERLAY_IMPAIR 1 //Impairs your screen like a welding helmet does depending on eye_blur.
#define PAIN_OVERLAY_LEGACY 2 //Creates a legacy blurring effect over your screen if you have any eye_blur at all. Not recommended.
//=================================================

//=================================================
#define FLASH_OVERLAY_WHITE 0 //Flashes your screen white.
#define FLASH_OVERLAY_DARK 1 //Flashes your screen a dark grey.
//=================================================

//=================================================
#define CRIT_OVERLAY_WHITE 0 //Overlays your screen white.
#define CRIT_OVERLAY_DARK 1 //Overlays your screen a dark grey.
//=================================================

/// Number of weighted marine players for 1 gear_scale. gear_scale is clamped to 1 minimum
#define MARINE_GEAR_SCALING_NORMAL 50

#define RESOURCE_NODE_SCALE 95 //How many players minimum per extra set of resource nodes
#define RESOURCE_NODE_QUANTITY_PER_POP 11 //How many resources total per pop
#define RESOURCE_NODE_QUANTITY_MINIMUM 1120 //How many resources at the minimum

//=================================================

#define ROLE_ADMIN_NOTIFY 1
#define ROLE_ADD_TO_SQUAD 2
#define ROLE_ADD_TO_DEFAULT 4
#define ROLE_WHITELISTED 16
#define ROLE_NO_ACCOUNT 32
#define ROLE_CUSTOM_SPAWN 64
#define ROLE_HIDDEN 128
//=================================================

//Role defines, specifically lists of roles for job bans, crew manifests and the like.
GLOBAL_LIST_INIT(ROLES_COMMAND, list(JOB_CO, JOB_XO, JOB_SO, JOB_AUXILIARY_OFFICER, JOB_INTEL, JOB_CAS_PILOT, JOB_DROPSHIP_PILOT, JOB_TANK_CREW, JOB_DROPSHIP_CREW_CHIEF, JOB_POLICE, JOB_CORPORATE_LIAISON, JOB_COMBAT_REPORTER, JOB_CHIEF_REQUISITION, JOB_CHIEF_ENGINEER, JOB_CMO, JOB_CHIEF_POLICE, JOB_SEA, JOB_SYNTH, JOB_WARDEN))

//Marine roles
#define ROLES_OFFICERS list(JOB_CO, JOB_XO, JOB_SO, JOB_AUXILIARY_OFFICER, JOB_INTEL, JOB_CAS_PILOT, JOB_DROPSHIP_PILOT, JOB_TANK_CREW, JOB_DROPSHIP_CREW_CHIEF, JOB_SEA, JOB_CORPORATE_LIAISON, JOB_COMBAT_REPORTER, JOB_SYNTH, JOB_SHIP_SYNTH, JOB_CHIEF_POLICE, JOB_WARDEN, JOB_POLICE)
GLOBAL_LIST_INIT(ROLES_CIC, list(JOB_CO, JOB_XO, JOB_SO, JOB_WO_CO, JOB_WO_XO))
GLOBAL_LIST_INIT(ROLES_CIC_ANTAG, list(JOB_UPP_SRLT_OFFICER, JOB_UPP_KPT_OFFICER, JOB_UPP_CO_OFFICER, JOB_UPP_COMMISSAR))
GLOBAL_LIST_INIT(ROLES_AUXIL_SUPPORT, list(JOB_AUXILIARY_OFFICER, JOB_INTEL, JOB_CAS_PILOT, JOB_DROPSHIP_PILOT, JOB_DROPSHIP_CREW_CHIEF, JOB_TANK_CREW, JOB_WO_CHIEF_POLICE, JOB_WO_SO, JOB_WO_CREWMAN, JOB_WO_POLICE, JOB_WO_PILOT))
GLOBAL_LIST_INIT(ROLES_AUXIL_SUPPORT_ANTAG, list(JOB_UPP_CREWMAN, JOB_UPP_PILOT))
GLOBAL_LIST_INIT(ROLES_MISC, list(JOB_SYNTH, JOB_SHIP_SYNTH, JOB_WORKING_JOE, JOB_SEA, JOB_CORPORATE_LIAISON, JOB_COMBAT_REPORTER, JOB_MESS_SERGEANT, JOB_WO_CORPORATE_LIAISON, JOB_WO_SYNTH))
GLOBAL_LIST_INIT(ROLES_MISC_ANTAG, list(JOB_UPP_COMBAT_SYNTH, JOB_UPP_SUPPORT_SYNTH, JOB_UPP_JOE))
GLOBAL_LIST_INIT(ROLES_POLICE, list(JOB_CHIEF_POLICE, JOB_WARDEN, JOB_POLICE))
GLOBAL_LIST_INIT(ROLES_POLICE_ANTAG, list(JOB_UPP_POLICE))
GLOBAL_LIST_INIT(ROLES_ENGINEERING, list(JOB_CHIEF_ENGINEER, JOB_ORDNANCE_TECH, JOB_MAINT_TECH, JOB_WO_CHIEF_ENGINEER, JOB_WO_ORDNANCE_TECH))
GLOBAL_LIST_INIT(ROLES_ENGINEERING_ANTAG, list())
GLOBAL_LIST_INIT(ROLES_REQUISITION, list(JOB_CHIEF_REQUISITION, JOB_CARGO_TECH, JOB_WO_CHIEF_REQUISITION, JOB_WO_REQUISITION))
GLOBAL_LIST_INIT(ROLES_REQUISITION_ANTAG, list(JOB_UPP_SUPPLY))
GLOBAL_LIST_INIT(ROLES_MEDICAL, list(JOB_CMO, JOB_RESEARCHER, JOB_DOCTOR, JOB_NURSE, JOB_WO_CMO, JOB_WO_RESEARCHER, JOB_WO_DOCTOR))
GLOBAL_LIST_INIT(ROLES_MEDICAL_ANTAG, list(JOB_UPP_LT_DOKTOR))
GLOBAL_LIST_INIT(ROLES_MARINES,  list(JOB_SQUAD_LEADER, JOB_SQUAD_TEAM_LEADER, JOB_SQUAD_SPECIALIST, JOB_SQUAD_SMARTGUN, JOB_SQUAD_MEDIC, JOB_SQUAD_ENGI, JOB_SQUAD_MARINE))
GLOBAL_LIST_INIT(ROLES_MARINES_ANTAG, list(JOB_UPP, JOB_UPP_ENGI, JOB_UPP_MEDIC, JOB_UPP_SPECIALIST, JOB_UPP_LEADER))
GLOBAL_LIST_INIT(ROLES_SQUAD_ALL, list(SQUAD_MARINE_1, SQUAD_MARINE_2, SQUAD_MARINE_3, SQUAD_MARINE_4, SQUAD_MARINE_5, SQUAD_MARINE_CRYO, SQUAD_MARINE_INTEL))
GLOBAL_LIST_INIT(ROLES_WO, list(JOB_WO_CO, JOB_WO_XO, JOB_WO_CORPORATE_LIAISON, JOB_WO_SYNTH, JOB_WO_CHIEF_POLICE, JOB_WO_SO, JOB_WO_CREWMAN, JOB_WO_POLICE, JOB_WO_PILOT, JOB_WO_CHIEF_ENGINEER, JOB_WO_ORDNANCE_TECH, JOB_WO_CHIEF_REQUISITION, JOB_WO_REQUISITION, JOB_WO_CMO, JOB_WO_DOCTOR, JOB_WO_RESEARCHER, JOB_WO_SQUAD_MARINE, JOB_WO_SQUAD_MEDIC, JOB_WO_SQUAD_ENGINEER, JOB_WO_SQUAD_SMARTGUNNER, JOB_WO_SQUAD_SPECIALIST, JOB_WO_SQUAD_LEADER))



//Groundside roles
GLOBAL_LIST_INIT(ROLES_XENO, list(JOB_XENOMORPH_QUEEN, JOB_XENOMORPH))
GLOBAL_LIST_INIT(ROLES_WHITELISTED, list(JOB_SYNTH_SURVIVOR, JOB_CO_SURVIVOR, JOB_PREDATOR, JOB_FAX_RESPONDER))
GLOBAL_LIST_INIT(ROLES_SPECIAL, list(JOB_SURVIVOR))

GLOBAL_LIST_INIT(ROLES_USCM, ROLES_CIC + GLOB.ROLES_POLICE + GLOB.ROLES_AUXIL_SUPPORT + GLOB.ROLES_MISC + GLOB.ROLES_ENGINEERING + GLOB.ROLES_REQUISITION + GLOB.ROLES_MEDICAL + GLOB.ROLES_MARINES - ROLES_WO)
GLOBAL_LIST_INIT(ROLES_GROUND, GLOB.ROLES_XENO + ROLES_SPECIAL + ROLES_WHITELISTED)

GLOBAL_LIST_INIT(ROLES_DISTRESS_SIGNAL, GLOB.ROLES_USCM + GLOB.ROLES_GROUND)
GLOBAL_LIST_INIT(ROLES_FACTION_CLASH, ROLES_USCM + JOB_PREDATOR)

GLOBAL_LIST_INIT(ROLES_CM_VS_UPP, (ROLES_USCM + UPP_JOB_LIST)- JOB_CAS_PILOT - JOB_ORDNANCE_TECH)


GLOBAL_LIST_INIT(ROLES_UNASSIGNED, list(JOB_SQUAD_MARINE))
//Role lists used for switch() checks in show_blurb_uscm(). Cosmetic, determines ex. "Engineering, USS Almayer", "2nd Bat. 'Falling Falcons'" etc.
#define BLURB_USCM_COMBAT JOB_CO, JOB_XO, JOB_SO, JOB_WO_CO, JOB_WO_XO, JOB_WO_CHIEF_POLICE, JOB_WO_SO, JOB_WO_CREWMAN, JOB_WO_POLICE, JOB_SEA,\
						JOB_SQUAD_LEADER, JOB_SQUAD_TEAM_LEADER, JOB_SQUAD_SPECIALIST, JOB_SQUAD_SMARTGUN, JOB_SQUAD_MEDIC, JOB_SQUAD_ENGI, JOB_SQUAD_MARINE
#define BLURB_USCM_FLIGHT JOB_CAS_PILOT, JOB_DROPSHIP_PILOT, JOB_DROPSHIP_CREW_CHIEF
#define BLURB_USCM_MP JOB_CHIEF_POLICE, JOB_WARDEN, JOB_POLICE
#define BLURB_USCM_ENGI JOB_CHIEF_ENGINEER, JOB_ORDNANCE_TECH, JOB_MAINT_TECH, JOB_WO_CHIEF_ENGINEER, JOB_WO_ORDNANCE_TECH, JOB_TANK_CREW, JOB_WO_PILOT
#define BLURB_USCM_MEDICAL JOB_CMO, JOB_RESEARCHER, JOB_DOCTOR, JOB_NURSE, JOB_WO_CMO, JOB_WO_RESEARCHER, JOB_WO_DOCTOR
#define BLURB_USCM_REQ JOB_CHIEF_REQUISITION, JOB_CARGO_TECH, JOB_WO_CHIEF_REQUISITION, JOB_WO_REQUISITION
#define BLURB_USCM_WY JOB_CORPORATE_LIAISON

//=================================================

#define WHITELIST_NORMAL "Normal"
#define WHITELIST_COUNCIL "Council"
#define WHITELIST_LEADER "Leader"

GLOBAL_LIST_INIT(whitelist_hierarchy, list(WHITELIST_NORMAL, WHITELIST_COUNCIL, WHITELIST_LEADER))

//=================================================

#define WHITELIST_YAUTJA (1<<0)
///Old holders of YAUTJA_ELDER
#define WHITELIST_YAUTJA_LEGACY (1<<1)
#define WHITELIST_YAUTJA_COUNCIL (1<<2)
///Old holders of YAUTJA_COUNCIL for 3 months
#define WHITELIST_YAUTJA_COUNCIL_LEGACY (1<<3)
#define WHITELIST_YAUTJA_LEADER (1<<4)
#define WHITELIST_PREDATOR (WHITELIST_YAUTJA|WHITELIST_YAUTJA_COUNCIL|WHITELIST_YAUTJA_LEADER)

#define WHITELIST_COMMANDER (1<<5)
#define WHITELIST_COMMANDER_COUNCIL (1<<6)
///Old holders of COMMANDER_COUNCIL for 3 months
#define WHITELIST_COMMANDER_COUNCIL_LEGACY (1<<7)
#define WHITELIST_COMMANDER_LEADER (1<<8)
///Former CO senator/whitelist overseer award
#define WHITELIST_COMMANDER_COLONEL (1<<9)

#define WHITELIST_JOE (1<<10)
#define WHITELIST_SYNTHETIC (1<<11)
#define WHITELIST_SYNTHETIC_COUNCIL (1<<12)
///Old holders of SYNTHETIC_COUNCIL for 3 months
#define WHITELIST_SYNTHETIC_COUNCIL_LEGACY (1<<13)
#define WHITELIST_SYNTHETIC_LEADER (1<<14)

///Senior Enlisted Advisor, auto granted by R_MENTOR
#define WHITELIST_MENTOR (1<<15)

///Fax Responder
#define WHITELIST_FAX_RESPONDER (1<<16)

#define COUNCIL_LIST list(WHITELIST_COMMANDER_COUNCIL, WHITELIST_SYNTHETIC_COUNCIL, WHITELIST_YAUTJA_COUNCIL)
#define SENATOR_LIST list(WHITELIST_COMMANDER_LEADER, WHITELIST_SYNTHETIC_LEADER, WHITELIST_YAUTJA_LEADER)
#define isCouncil(A) (A.check_whitelist_status_list(COUNCIL_LIST))
#define isSenator(A) (A.check_whitelist_status_list(SENATOR_LIST))

DEFINE_BITFIELD(whitelist_status, list(
	"WHITELIST_YAUTJA" = WHITELIST_YAUTJA,
	"WHITELIST_YAUTJA_LEGACY" = WHITELIST_YAUTJA_LEGACY,
	"WHITELIST_YAUTJA_COUNCIL" = WHITELIST_YAUTJA_COUNCIL,
	"WHITELIST_YAUTJA_COUNCIL_LEGACY" = WHITELIST_YAUTJA_COUNCIL_LEGACY,
	"WHITELIST_YAUTJA_LEADER" = WHITELIST_YAUTJA_LEADER,
	"WHITELIST_COMMANDER" = WHITELIST_COMMANDER,
	"WHITELIST_COMMANDER_COUNCIL" = WHITELIST_COMMANDER_COUNCIL,
	"WHITELIST_COMMANDER_COUNCIL_LEGACY" = WHITELIST_COMMANDER_COUNCIL_LEGACY,
	"WHITELIST_COMMANDER_COLONEL" = WHITELIST_COMMANDER_COLONEL,
	"WHITELIST_COMMANDER_LEADER" = WHITELIST_COMMANDER_LEADER,
	"WHITELIST_JOE" = WHITELIST_JOE,
	"WHITELIST_SYNTHETIC" = WHITELIST_SYNTHETIC,
	"WHITELIST_SYNTHETIC_COUNCIL" = WHITELIST_SYNTHETIC_COUNCIL,
	"WHITELIST_SYNTHETIC_COUNCIL_LEGACY" = WHITELIST_SYNTHETIC_COUNCIL_LEGACY,
	"WHITELIST_SYNTHETIC_LEADER" = WHITELIST_SYNTHETIC_LEADER,
	"WHITELIST_MENTOR" = WHITELIST_MENTOR,
	"WHITELIST_FAX_RESPONDER" = WHITELIST_FAX_RESPONDER,
))

//=================================================

// Objective priorities
#define OBJECTIVE_NO_VALUE 0
#define OBJECTIVE_LOW_VALUE 0.1
#define OBJECTIVE_MEDIUM_VALUE 0.2
#define OBJECTIVE_HIGH_VALUE 0.35
#define OBJECTIVE_EXTREME_VALUE 0.7
#define OBJECTIVE_ABSOLUTE_VALUE 1.4
#define OBJECTIVE_POWER_VALUE 5

// Objective states
#define OBJECTIVE_INACTIVE (1<<0)
#define OBJECTIVE_ACTIVE (1<<1)
#define OBJECTIVE_COMPLETE (1<<2)

// Functionality flags
#define OBJECTIVE_DO_NOT_TREE (1<<0) // Not part of the 'clue' tree
#define OBJECTIVE_DEAD_END (1<<1) // Should this objective unlock zero clues?
#define OBJECTIVE_START_PROCESSING_ON_DISCOVERY (1<<2) // Should this objective process() every subsystem 'tick' once its breadcrumb trail of clues have been finished?

/// Misc. defines for objectives
#define APC_SCORE_INTERVAL 10 MINUTES

//=================================================

// Faction names
#define FACTION_NEUTRAL "Neutral"
#define FACTION_MARINE "USCM"
#define FACTION_SURVIVOR "Survivor"
#define FACTION_UPP "UPP"
#define FACTION_TWE "TWE"
#define FACTION_WY "Wey-Yu"
#define FACTION_CLF "CLF"
#define FACTION_PMC "PMC"
#define FACTION_CONTRACTOR "VAI"
#define FACTION_MARSHAL "Colonial Marshal"
#define FACTION_WY_DEATHSQUAD "WY Death Squad"
#define FACTION_MERCENARY "Mercenary"
#define FACTION_FREELANCER "Freelancer"
#define FACTION_HEFA "HEFA Order"
#define FACTION_DUTCH "Dutch's Dozen"
#define FACTION_PIRATE "Pirate"
#define FACTION_GLADIATOR "Gladiator"
#define FACTION_PIZZA "Pizza Delivery"
#define FACTION_SOUTO "Souto Man"
#define FACTION_COLONIST "Colonist"
#define FACTION_YAUTJA "Yautja"
#define FACTION_HUNTED "Hunted"
#define FACTION_ZOMBIE "Zombie"
#define FACTION_MONKEY "Monkey" // Nanu
#define FACTION_FAX "Fax Responder"

#define FACTION_LIST_MARINE list(FACTION_MARINE)
#define FACTION_LIST_HUMANOID list(FACTION_MARINE, FACTION_PMC, FACTION_WY, FACTION_WY_DEATHSQUAD, FACTION_CLF, FACTION_CONTRACTOR, FACTION_MARSHAL, FACTION_UPP, FACTION_FREELANCER, FACTION_SURVIVOR, FACTION_NEUTRAL, FACTION_COLONIST, FACTION_MERCENARY, FACTION_DUTCH, FACTION_HEFA, FACTION_GLADIATOR, FACTION_PIRATE, FACTION_PIZZA, FACTION_SOUTO, FACTION_YAUTJA, FACTION_ZOMBIE, FACTION_TWE, FACTION_HUNTED, FACTION_FAX)
#define FACTION_LIST_ERT_OTHER list(FACTION_HEFA, FACTION_GLADIATOR, FACTION_PIRATE, FACTION_PIZZA, FACTION_SOUTO)
#define FACTION_LIST_ERT_ALL list(FACTION_PMC, FACTION_WY_DEATHSQUAD, FACTION_WY, FACTION_CLF, FACTION_CONTRACTOR, FACTION_UPP, FACTION_FREELANCER, FACTION_MERCENARY, FACTION_DUTCH, FACTION_HEFA, FACTION_GLADIATOR, FACTION_PIRATE, FACTION_PIZZA, FACTION_SOUTO, FACTION_MARSHAL, FACTION_TWE, FACTION_HUNTED)
#define FACTION_LIST_WY list(FACTION_PMC, FACTION_WY_DEATHSQUAD, FACTION_WY)
#define FACTION_LIST_UPP list(FACTION_UPP)
#define FACTION_LIST_CLF list(FACTION_CLF)
#define FACTION_LIST_TWE list(FACTION_TWE)
#define FACTION_LIST_FREELANCER list(FACTION_FREELANCER)
#define FACTION_LIST_CONTRACTOR list(FACTION_CONTRACTOR)
#define FACTION_LIST_MERCENARY list(FACTION_MERCENARY)
#define FACTION_LIST_MARSHAL list(FACTION_MARSHAL)
#define FACTION_LIST_DUTCH list(FACTION_DUTCH)
#define FACTION_LIST_SURVIVOR_WY list(FACTION_SURVIVOR, FACTION_PMC, FACTION_WY_DEATHSQUAD, FACTION_WY)
#define FACTION_LIST_MARINE_WY list(FACTION_MARINE, FACTION_PMC, FACTION_WY_DEATHSQUAD, FACTION_WY)
#define FACTION_LIST_MARINE_UPP list(FACTION_MARINE, FACTION_UPP)
#define FACTION_LIST_MARINE_TWE list(FACTION_MARINE, FACTION_TWE)
#define FACTION_LIST_YAUTJA list(FACTION_YAUTJA)
#define FACTION_LIST_HUNTED list(FACTION_HUNTED)

// Xenomorphs
#define FACTION_PREDALIEN "Predalien"

#define FACTION_XENOMORPH "Xenomorph"
#define FACTION_XENOMORPH_CORRPUTED "Corrupted Xenomoprh"
#define FACTION_XENOMORPH_ALPHA "Alpha Xenomorph"
#define FACTION_XENOMORPH_BRAVO "Bravo Xenomorph"
#define FACTION_XENOMORPH_CHARLIE "Charlie Xenomorph"
#define FACTION_XENOMORPH_DELTA "Delta Xenomorph"

#define FACTION_LIST_XENOMORPH list(FACTION_XENOMORPH, FACTION_XENOMORPH_CORRPUTED, FACTION_XENOMORPH_ALPHA, FACTION_XENOMORPH_BRAVO, FACTION_XENOMORPH_CHARLIE, FACTION_XENOMORPH_DELTA)

// Faction allegiances within a certain faction.

#define FACTION_ALLEGIANCE_USCM_COMMANDER list("Doves", "Hawks", "Magpies", "Unaligned")

// global vars to prevent spam of the "one xyz alive" messages

GLOBAL_VAR(last_ares_callout)

GLOBAL_VAR(last_qm_callout)
