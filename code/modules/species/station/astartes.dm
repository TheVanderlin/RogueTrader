/datum/species/human/astartes
	name = SPECIES_ASTARTES
	name_plural = "Astartes"
	icobase = 'icons/mob/human_races/species/astartes/r_astartes.dmi'
	hidden_from_codex = FALSE
	skin_material =   MATERIAL_SKIN_GENERIC

	unarmed_types = list(/datum/unarmed_attack/stomp/astartes, /datum/unarmed_attack/punch/astartes, /datum/unarmed_attack/bite/sharp/astartes)
	primitive_form = "Human"
	darksight_range = 8
	darksight_tint = DARKTINT_GOOD
	strength = STR_HIGH
	breath_pressure = 12
	slowdown = -1
	brute_mod = 0.60
	burn_mod = 0.65
	stun_mod = 0.65
	oxy_mod = 0.8
	weaken_mod = 0.6
	flash_mod = 0.5
	toxins_mod = 0.3
	radiation_mod = 0.05 //Melanochrome.
	blood_volume = 1000
	silent_steps = TRUE

	health_hud_intensity = 2
	hunger_factor = DEFAULT_HUNGER_FACTOR * 0.2

	min_age = 25
	max_age = 250

	description = "The Space Marines or Adeptus Astartes are foremost amongst the defenders of Humanity, the greatest of the Emperor of Mankind's Warriors. They are barely human at all, but superhuman; having been made superior in all respects to a normal man by a harsh regime of genetic modification, psycho-conditioning and rigorous training. Untouched by disease and can take a wound that could kill a normal human instantly. Using ancient power armor that can augment their abilities and wielding the best weapons known to man."
  
	cold_level_1 = SYNTH_COLD_LEVEL_1
	cold_level_2 = SYNTH_COLD_LEVEL_2 //Astartes can survive plagues and injuries that would kill most humans five times over. Should survive hostile planets. Still need to breath tho.
	cold_level_3 = SYNTH_COLD_LEVEL_3

	heat_level_1 = 520
	heat_level_2 = 580
	heat_level_3 = 1900

	hazard_high_pressure = HAZARD_HIGH_PRESSURE * 0.4
	warning_high_pressure = WARNING_HIGH_PRESSURE * 0.4
	warning_low_pressure = 50
	hazard_low_pressure = -1
	species_flags = SPECIES_FLAG_NO_SCAN | SPECIES_FLAG_NEED_DIRECT_ABSORB | SPECIES_FLAG_NO_SLIP | SPECIES_FLAG_NO_MINOR_CUT | SPECIES_FLAG_NO_TANGLE
	spawn_flags = SPECIES_NO_FBP_CONSTRUCTION | SPECIES_NO_FBP_CHARGEN | SPECIES_CAN_JOIN
	appearance_flags = SPECIES_APPEARANCE_HAS_HAIR_COLOR | SPECIES_APPEARANCE_HAS_LIPS | SPECIES_APPEARANCE_HAS_UNDERWEAR | SPECIES_APPEARANCE_HAS_SKIN_TONE_NORMAL |SPECIES_APPEARANCE_HAS_SKIN_COLOR | SPECIES_APPEARANCE_HAS_EYE_COLOR
	blood_color = "#dc143c" 

	move_trail = /obj/decal/cleanable/blood/tracks

	heat_discomfort_level = 450
	heat_discomfort_strings = list(
		"You feel too warm.",
		"You feel the heat start to become uncomfortable.",
		"You feel very warm."
		)

	cold_discomfort_level = 50
	cold_discomfort_strings = list(
		"You feel chilly.",
		"You feel cold.",
		"Your skin chills."
		)

	base_auras = list(
		/obj/aura/regenerating/human/astartes
		)

	inherent_verbs = list(
	/mob/living/carbon/human/proc/astachaos,
	/mob/living/carbon/human/proc/astacharge,
	/mob/living/carbon/human/proc/astacrush,
	/mob/living/carbon/human/proc/astadamage,
	/mob/living/carbon/human/proc/astadiescum,
	/mob/living/carbon/human/proc/astaeatboltgun,
	/mob/living/carbon/human/proc/astafaithshield,
	/mob/living/carbon/human/proc/astafallback,
	/mob/living/carbon/human/proc/astaforglory,
	/mob/living/carbon/human/proc/astagrenades,
	/mob/living/carbon/human/proc/astakill,
	/mob/living/carbon/human/proc/astanonestopus,
	/mob/living/carbon/human/proc/astaourwrath,
	/mob/living/carbon/human/proc/astaready,
	/mob/living/carbon/human/proc/astatoglory,
	/mob/living/carbon/human/proc/astaxenos
	)

	has_organ = list(
		BP_HEART =    /obj/item/organ/internal/heart/astartes,
		BP_STOMACH =  /obj/item/organ/internal/stomach,
		BP_LUNGS =    /obj/item/organ/internal/lungs/astartes,
		BP_LIVER =    /obj/item/organ/internal/liver/astartes,
		BP_KIDNEYS =  /obj/item/organ/internal/kidneys/astartes,
		BP_EYES =   /obj/item/organ/internal/eyes/astartes,
		BP_BRAIN =  /obj/item/organ/internal/brain/astartes,
		BP_PROGENOID_LOWER = /obj/item/organ/internal/progenoid,
		BP_PROGENOID_UPPER = /obj/item/organ/internal/progenoid/upper
		)

	descriptors = list(
		/datum/mob_descriptor/height = 2,
		/datum/mob_descriptor/build = 2
		)

	available_cultural_info = list(
		TAG_CULTURE = list(
			CULTURE_HUMAN_IMPERIAL
		)
	)

	traits = list(
		/singleton/trait/boon/filtered_blood = TRAIT_LEVEL_EXISTS,
		/singleton/trait/boon/cast_iron_stomach = TRAIT_LEVEL_EXISTS
	)

/datum/species/human/astartes/handle_post_spawn(mob/living/carbon/human/H)
	if(H.mind)
		H.mind.reset()
		H.mind.assigned_role = "Astartes"
		H.mind.special_role = "Astartes"
	H.fully_replace_character_name(random_astartes_name())
	H.status_flags |= NO_ANTAG
	..()

/mob/living/carbon/human/proc/astaforemperor()
	set name = "For The Emperor"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("For The Emperor")
		playsound(src, 'sound/effects/quotes/astartes/foremperor.ogg', 80, 0, 5)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astaforemperorl()
	set name = "For The Emperor!"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("For The Emperor!")
		if(prob(50))
			playsound(src, 'sound/effects/quotes/astartes/foremperorl.ogg', 80, 0, 12)
		else
			playsound(src, 'sound/effects/quotes/astartes/foremperorla.ogg', 80, 0, 12)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astachaos()
	set name = "Chaos sighted"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Chaos sighted")
		playsound(src, 'sound/effects/quotes/astartes/chaos.ogg', 80, 0, 5)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astacharge()
	set name = "Charge!"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Chaaaaarge!")
		playsound(src, 'sound/effects/quotes/astartes/charge.ogg', 80, 0, 15)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astacrush()
	set name = "We'll crush enemies"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("We will crush the enemies of The Imperium")
		playsound(src, 'sound/effects/quotes/astartes/crush.ogg', 80, 0, 5)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astadamage()
	set name = "Taking damage"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Taking damage")
		playsound(src, 'sound/effects/quotes/astartes/damage.ogg', 80, 0, 5)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astadiescum()
	set name = "Die, scum!"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Die, scum!")
		playsound(src, 'sound/effects/quotes/astartes/diescum.ogg', 80, 0, 15)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astaeatboltgun()
	set name = "Eat boltgun!"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Eat boltgun!")
		playsound(src, 'sound/effects/quotes/astartes/eatboltgun.ogg', 80, 0, 10)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astafaithshield()
	set name = "Faith is our shield"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Faith is our shield")
		playsound(src, 'sound/effects/quotes/astartes/faithshield.ogg', 80, 0, 5)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astafallback()
	set name = "Fall back"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Fall back and regroup!")
		playsound(src, 'sound/effects/quotes/astartes/fallback.ogg', 80, 0, 10)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astaforglory()
	set name = "For the Imperium"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("For the glory of the Imperium")
		playsound(src, 'sound/effects/quotes/astartes/forglory.ogg', 80, 0, 5)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astagrenades()
	set name = "Let grenades fly!"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Let the grenades fly!")
		playsound(src, 'sound/effects/quotes/astartes/grenades.ogg', 80, 0, 8)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astakill()
	set name = "Cleanse, purge, kill!"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Cleanse, purge, kill!")
		playsound(src, 'sound/effects/quotes/astartes/kill.ogg', 80, 0, 8)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astanonestopus()
	set name = "None stop us"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("None shall stop us")
		playsound(src, 'sound/effects/quotes/astartes/nonestopus.ogg', 80, 0, 5)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astaourwrath()
	set name = "Feel our wrath"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Feel our wrath")
		playsound(src, 'sound/effects/quotes/astartes/ourwrath.ogg', 80, 0, 5)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astaready()
	set name = "Weapon at ready"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Weapons at ready, it is time")
		playsound(src, 'sound/effects/quotes/astartes/ready.ogg', 80, 0, 7)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astatoglory()
	set name = "To glory"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Onward, to glory")
		playsound(src, 'sound/effects/quotes/astartes/toglory.ogg', 80, 0, 9)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return

/mob/living/carbon/human/proc/astaxenos()
	set name = "Xenos spotted"
	set category = "Astartes"
	if(!ishuman(src))
		return
	if(src.stat == DEAD)
		return
	if(src.quote_cd == 0)
		src.say("Xenos spotted")
		playsound(src, 'sound/effects/quotes/astartes/xenos.ogg', 80, 0, 5)
		src.quote_cd = 1
		sleep(50)
		src.quote_cd = 0
		return
