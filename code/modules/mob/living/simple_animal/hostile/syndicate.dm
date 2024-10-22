/mob/living/simple_animal/hostile/human/heretic
	name = "Infardi" // Basic melee militia with a knife.
	desc = "A cult militia member of the Infardi zealots who serve the Anarch as mainline shocktroopers."
	icon = 'icons/mob/animal2.dmi'
	icon_state = "guard_wounded1"
	icon_living = "guard_wounded1"
	icon_dead = "guard_wounded1d"
	icon_gib = "syndicate_gib"
	turns_per_move = 5
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 4
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	natural_weapon = /obj/item/natural_weapon/punch
	can_escape = TRUE
	a_intent = I_HURT
	blocky = 20
	dodgey = 20
	var/corpse = /obj/landmark/corpse/infardi
	var/weapon1 = /obj/item/material/twohanded/ravenor/knife/trench
	var/weapon2
	unsuitable_atmos_damage = 15
	environment_smash = 1
	faction = "Chaos"
	status_flags = CANPUSH

/mob/living/simple_animal/hostile/human/heretic/death(gibbed, deathmessage, show_dead_message)
	..(gibbed, deathmessage, show_dead_message)
	if(corpse)
		new corpse (src.loc)
	if(weapon1)
		new weapon1 (src.loc)
	if(weapon2)
		new weapon2 (src.loc)
	qdel(src)
	return

///////////////Sword and shield////////////

/mob/living/simple_animal/hostile/human/heretic/use_weapon(obj/item/weapon, mob/user, list/click_params)
	if (!weapon.force)
		return ..()

	// Shield check
	if (prob(blocky))
		user.visible_message(
			SPAN_WARNING("\The [user] swings \a [weapon] at \the [src], but they block it with their [weapon]!"),
			SPAN_WARNING("You swing \the [weapon] at \the [src], but they block it with their [weapon]!"),
			exclude_mobs = list(src)
		)
		to_chat(src, SPAN_WARNING("\The [user] swings \a [weapon] at you, but you block it with your [weapon]!"))
		return TRUE

	// Block pain damage
	if (weapon.damtype == DAMAGE_PAIN)
		user.visible_message(
			SPAN_WARNING("\The [user] swings \a [weapon] at \the [src], but it has no effect!"),
			SPAN_WARNING("You swing \the [weapon] at \the [src], but it has no effect!"),
			exclude_mobs = list(src)
		)
		to_chat(src, SPAN_WARNING("\The [user] swings \a [weapon] at you, but it has no effect!"))
		return TRUE

	// Apply damage
	health -= weapon.force
	user.visible_message(
		SPAN_WARNING("\The [user] swings \a [weapon] at \the [src]!"),
		SPAN_DANGER("You swing \the [weapon] at \the [src]!"),
		exclude_mobs = list(src)
	)
	to_chat(src, SPAN_DANGER("\The [user] swings \a [weapon] at you!"))
	return TRUE


/mob/living/simple_animal/hostile/human/heretic/bullet_act(obj/item/projectile/Proj)
	if(!Proj)	return
	if (status_flags & GODMODE)
		return PROJECTILE_FORCE_MISS
	if(!prob(dodgey)) // If they fail dodge do this.
		src.health -= Proj.damage
	else
		visible_message(SPAN_DANGER("\The [src] dodges \the [Proj]!"))
	return 0

/mob/living/simple_animal/hostile/human/heretic/berserker
	natural_weapon = /obj/item/material/twohanded/ravenor/sword/chopper/heavy
	weapon1 = /obj/item/material/twohanded/ravenor/sword/chopper/heavy
	weapon2 = null
	status_flags = 0
	blocky = 35
	dodgey = 15

/mob/living/simple_animal/hostile/human/heretic/trooper
	min_gas = null
	max_gas = null
	minbodytemp = 0
	ranged = 1
	rapid = 1
	projectile_accuracy = -1
	projectile_dispersion = 2
	desc = "A cult militia member of the Infardi zealots who serve the Anarch as mainline shocktroopers."
	icon_state = "traitorguard2"
	icon_living = "traitorguard2"
	icon_dead = "traitorguard2_dead"
	name = "Infardi Trooper"
	projectilesound = 'sound/warhammer/guns/fire/smg_fire.ogg'
	natural_weapon = /obj/item/material/twohanded/ravenor/knife
	casingtype = /obj/item/ammo_casing/pistol/ap
	corpse = /obj/landmark/corpse/infardi/trooper
	ranged_attack_delay = 2 SECONDS
	speed = 0
	blocky = 15
	dodgey = 25
	weapon1 = /obj/item/gun/projectile/automatic/autogun
	projectiletype = /obj/item/projectile/bullet/pistol/ap

/mob/living/simple_animal/hostile/human/heretic/trooper/Process_Spacemove()
	return 1

/mob/living/simple_animal/hostile/human/heretic/bloodpact
	ranged = 1
	rapid = 1
	projectile_accuracy = 0
	projectile_dispersion = 1
	name = "Bloodpact Soldier"
	desc = "A cult militia soldier of the Blood Pact, serving the Archon as disciplined shock troops in the front lines of Chaos assaults."
	icon_state = "merc_standart"
	icon_living = "merc_standart"
	icon_dead = "merc_standartd"
	casingtype = /obj/item/ammo_casing/autogun
	ranged_attack_delay = 1.5 SECONDS
	corpse = /obj/landmark/corpse/bloodpact
	projectilesound = 'sound/warhammer/guns/fire/smg_fire.ogg'
	natural_weapon = /obj/item/material/twohanded/ravenor/knife/trench
	weapon1 = /obj/item/gun/projectile/automatic/autogun/valhalla
	projectiletype = /obj/item/projectile/bullet/rifle
	min_gas = null
	max_gas = null
	minbodytemp = 0
	speed = 0
	blocky = 15
	dodgey = 35

/mob/living/simple_animal/hostile/human/heretic/bloodpact/Process_Spacemove()
	return 1

/mob/living/simple_animal/hostile/human/heretic/bloodpact/commando
	icon_state = "merc_leader"
	icon_living = "merc_leader"
	icon_dead = "merc_leaderd"
	name = "Bloodpact Commando"
	projectile_accuracy = 0
	projectile_dispersion = 0
	ranged_attack_delay = 2.5 SECONDS // Heavier round. Beats carapace.
	projectilesound = 'sound/warhammer/gunshot/auto2.ogg'
	corpse = /obj/landmark/corpse/bloodpact/commando
	casingtype = /obj/item/ammo_casing/autogun/militarum/ap
	weapon1 = /obj/item/gun/projectile/automatic/autogun/stubber
	projectiletype = /obj/item/projectile/bullet/rifle/heavy/ap
	natural_weapon = /obj/item/material/twohanded/ravenor/knife/bowie
	blocky = 25
	dodgey = 39

/mob/living/simple_animal/hostile/viscerator
	name = "viscerator"
	desc = "A small, twin-bladed machine capable of inflicting very deadly lacerations."
	icon = 'icons/mob/simple_animal/critter.dmi'
	icon_state = "viscerator_attack"
	icon_living = "viscerator_attack"
	pass_flags = PASS_FLAG_TABLE
	health = 15
	maxHealth = 15
	natural_weapon = /obj/item/natural_weapon/rotating_blade
	faction = "syndicate"
	min_gas = null
	max_gas = null
	minbodytemp = 0

	meat_type =     null
	meat_amount =   0
	bone_material = null
	bone_amount =   0
	skin_material = null
	skin_amount =   0
/obj/item/natural_weapon/rotating_blade
	name = "rotating blades"
	attack_verb = list("sliced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	force = 15
	edge = 1
	sharp = 1

/mob/living/simple_animal/hostile/viscerator/death(gibbed, deathmessage, show_dead_message)
	..(null,"is smashed into pieces!", show_dead_message)
	qdel(src)

/mob/living/simple_animal/hostile/viscerator/hive
	faction = "hivebot"
