/obj/item/projectile/ion
	name = "ion bolt"
	icon_state = "ion"
	fire_sound = 'sound/weapons/Laser.ogg'
	damage = 0
	damage_type = DAMAGE_BURN
	damage_flags = 0
	nodamage = TRUE
	var/heavy_effect_range = 1
	var/light_effect_range = 1

/obj/item/projectile/ion/on_impact(atom/A)
	empulse(A, heavy_effect_range, light_effect_range)
	return 1

/obj/item/projectile/ion/small
	name = "ion pulse"
	heavy_effect_range = 0
	light_effect_range = 1

/obj/item/projectile/ion/tiny
	heavy_effect_range = 0
	light_effect_range = 0

/obj/item/projectile/bullet/gyro
	name ="explosive bolt"
	icon_state= "bolter"
	damage = 50
	damage_flags = DAMAGE_FLAG_BULLET | DAMAGE_FLAG_SHARP | DAMAGE_FLAG_EDGE

/obj/item/projectile/bullet/gyro/on_hit(atom/target, blocked = 0)
	explosion(target, 2, EX_ACT_LIGHT)
	return 1

/obj/item/projectile/meteor
	name = "meteor"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "smallf"
	damage = 0
	damage_type = DAMAGE_BRUTE
	nodamage = TRUE

/obj/item/projectile/meteor/Bump(atom/A as mob|obj|turf|area, forced=0)
	if(A == firer)
		forceMove(A.loc)
		return

	sleep(-1) //Might not be important enough for a sleep(-1) but the sleep/spawn itself is necessary thanks to explosions and metoerhits

	if(src)//Do not add to this if() statement, otherwise the meteor won't delete them
		if(A)

			A.ex_act(EX_ACT_HEAVY)
			playsound(src.loc, 'sound/effects/meteorimpact.ogg', 40, 1)

			for(var/mob/M in range(10, src))
				if(!M.stat && !istype(M, /mob/living/silicon/ai))\
					shake_camera(M, 3, 1)
			qdel(src)
			return 1
	else
		return 0

/obj/item/projectile/energy/floramut
	name = "alpha somatoray"
	icon_state = "energy"
	fire_sound = 'sound/effects/stealthoff.ogg'
	damage = 0
	damage_type = DAMAGE_TOXIN
	nodamage = TRUE

/obj/item/projectile/energy/floramut/on_hit(atom/target, blocked = 0)
	var/mob/living/M = target
	if(ishuman(target))
		var/mob/living/carbon/human/H = M
		var/datum/pronouns/pronouns = M.choose_from_pronouns()
		if((H.species.species_flags & SPECIES_FLAG_IS_PLANT) && (H.nutrition < 500))
			if(prob(15))
				H.apply_damage((rand(30,80)), DAMAGE_RADIATION, damage_flags = DAMAGE_FLAG_DISPERSED)
				H.Weaken(5)
				for (var/mob/V in viewers(src))
					V.show_message(SPAN_WARNING("\The [M] writhes in pain as [pronouns.his] vacuoles boil."), 3, SPAN_WARNING("You hear the crunching of leaves."), 2)
			if(prob(35))
				if(prob(80))
					randmutb(M)
					domutcheck(M,null)
				else
					randmutg(M)
					domutcheck(M,null)
			else
				M.adjustFireLoss(rand(5,15))
				M.show_message(SPAN_DANGER("The radiation beam singes you!"))
	else if(istype(target, /mob/living/carbon))
		M.show_message(SPAN_NOTICE("The radiation beam dissipates harmlessly through your body."))
	else
		return 1

/obj/item/projectile/energy/floramut/gene
	name = "gamma somatoray"
	icon_state = "energy2"
	fire_sound = 'sound/effects/stealthoff.ogg'
	damage = 0
	damage_type = DAMAGE_TOXIN
	nodamage = TRUE
	var/singleton/plantgene/gene = null

/obj/item/projectile/energy/florayield
	name = "beta somatoray"
	icon_state = "energy2"
	fire_sound = 'sound/effects/stealthoff.ogg'
	damage = 0
	damage_type = DAMAGE_TOXIN
	nodamage = TRUE

/obj/item/projectile/energy/florayield/on_hit(atom/target, blocked = 0)
	var/mob/M = target
	if(ishuman(target)) //These rays make plantmen fat.
		var/mob/living/carbon/human/H = M
		if((H.species.species_flags & SPECIES_FLAG_IS_PLANT) && (H.nutrition < 500))
			H.adjust_nutrition(30)
	else if (istype(target, /mob/living/carbon))
		M.show_message(SPAN_NOTICE("The radiation beam dissipates harmlessly through your body."))
	else
		return 1


/obj/item/projectile/beam/mindflayer
	name = "flayer ray"

/obj/item/projectile/beam/mindflayer/on_hit(atom/target, blocked = 0)
	if(ishuman(target))
		var/mob/living/carbon/human/M = target
		M.mod_confused(rand(5, 8))

/obj/item/projectile/chameleon
	name = "bullet"
	icon_state = "bullet"
	damage = 1 // stop trying to murderbone with a fake gun dumbass!!!
	embed = FALSE // nope
	nodamage = TRUE
	damage_type = DAMAGE_PAIN
	damage_flags = 0
	muzzle_type = /obj/projectile/bullet

/obj/item/projectile/bola
	name = "bola"
	icon_state = "bola"
	damage = 5
	embed = FALSE
	damage_type = DAMAGE_STUN
	muzzle_type = null

/obj/item/projectile/bola/on_hit(atom/target, blocked = 0)
	if (isliving(target))
		var/mob/living/M = target
		M.Weaken(3)
		M.visible_message(
			SPAN_WARNING("\The [M] is hit with a glob of webbing!"),
			SPAN_DANGER("You are hit with a glob of webbing, causing you to trip!"),
			SPAN_DANGER("Some sort of sticky substance hits you and causes you to fall over!")
		)
	..()

/obj/item/projectile/webball
	name = "ball of web"
	icon_state = "bola"
	damage = 1
	embed = FALSE
	damage_type = DAMAGE_BRUTE
	muzzle_type = null

/obj/item/projectile/webball/on_hit(atom/target, blocked = 0)
	if (isturf(target.loc))
		var/obj/spider/stickyweb/W = locate() in get_turf(target)
		if (!W && prob(75))
			visible_message(SPAN_DANGER("\The [src] splatters a layer of web on \the [target]!"))
			new /obj/spider/stickyweb(target.loc)

			if (isliving(target))
				var/mob/living/M = target
				var/has_webs = FALSE
				for (var/obj/aura/A in M.auras)
					if (istype(A, /obj/aura/web))
						has_webs = TRUE
						break
				if (!has_webs)
					M.add_aura(new /obj/aura/web(M))
	..()

/obj/item/projectile/venom
	name = "venom bolt"
	icon_state = "venom"
	damage = 5 //most damage is in the reagent
	damage_type = DAMAGE_TOXIN
	damage_flags = 0

/obj/item/projectile/venom/on_hit(atom/target, blocked, def_zone)
	. = ..()
	var/mob/living/L = target
	if(L.reagents)
		L.reagents.add_reagent(/datum/reagent/toxin/venom, 5)

/obj/item/missile
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "missile"
	var/primed = null
	throwforce = 15

/obj/item/missile/throw_impact(atom/hit_atom)
	if(primed)
		explosion(hit_atom, 2, EX_ACT_HEAVY)
		qdel(src)
	else
		..()
	return

/obj/item/projectile/hotgas
	name = "gas vent"
	icon_state = null
	damage_type = DAMAGE_BURN
	damage_flags = 0
	life_span = 3
	silenced = TRUE

/obj/item/projectile/hotgas/on_hit(atom/target, blocked, def_zone)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		to_chat(target, SPAN_WARNING("You feel a wave of heat wash over you!"))
		L.adjust_fire_stacks(rand(5,8))
		L.IgniteMob()


#define CALLBACK new /datum/callback

/obj/flamer_fire
	name = "fire"
	desc = "Ouch!"
	anchored = 1
	mouse_opacity = 0
	icon = 'icons/effects/fire.dmi'
	icon_state = "red_2"
	layer = BELOW_OBJ_LAYER
	var/firelevel = 1 //Tracks how much "fire" there is. Basically the timer of how long the fire burns
	var/burnlevel = 10 //Tracks how HOT the fire is. This is basically the heat level of the fire and determines the temperature.
	var/flame_color = "red"
	var/canSpreadDir = NORTH | SOUTH | EAST | WEST

/obj/flamer_fire/New(loc, fire_lvl, burn_lvl, f_color, fire_spread_amount, BlockedDirs)
	..()
	if (f_color)
		flame_color = f_color

	icon_state = "[flame_color]_2"
	if(fire_lvl) firelevel = fire_lvl
	if(burn_lvl) burnlevel = burn_lvl
	if(BlockedDirs)
		canSpreadDir &= ~BlockedDirs
	START_PROCESSING(SSobj,src)

	if(fire_spread_amount > 0)
		var/turf/T
		for(var/dirn in GLOB.cardinal)
			if(!(dirn & canSpreadDir))
				continue
			T = get_step(loc, dirn)
			if(istype(T,/turf/simulated/open)) continue
			if(locate(/obj/flamer_fire) in T) continue //No stacking
			var/new_spread_amt = T.density ? 0 : fire_spread_amount - 1 //walls stop the spread
			if(new_spread_amt)
				for(var/obj/O in T)
					if(!O.CanPass(src, loc))
						new_spread_amt = 0
						break
			addtimer(CALLBACK(src, PROC_REF(make_more_fire),T, fire_lvl, burn_lvl, f_color, new_spread_amt, ~canSpreadDir), 0) //Do not put spawns in recursive things.

/obj/flamer_fire/proc/make_more_fire(T, f_level, b_level, fcolor, new_spread, blockedDirs)
	new /obj/flamer_fire(T, f_level, b_level, fcolor, new_spread, blockedDirs)

/obj/flamer_fire/Destroy()
	set_light(0)
	STOP_PROCESSING(SSobj,src)
	. = ..()

/obj/flamer_fire/Crossed(mob/living/M) //Only way to get it to reliable do it when you walk into it.
	if(istype(M))
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(istype(H.wear_suit, /obj/item/clothing/suit/fire))
				H.show_message(text("Your suit protects you from the flames."), 1)
				H.adjustFireLoss(rand(0 ,burnlevel*0.25)) //Does small burn damage to a person wearing one of the suits.
			if(istype(H.wear_suit, /obj/item/clothing/suit/armor/astartes))
				H.show_message(text("Your suit protects you from the flames."), 1)
				H.adjustFireLoss(0) //Does no burn damage
		M.adjust_fire_stacks(burnlevel) //Make it possible to light them on fire later.
		if (prob(firelevel + 2*M.fire_stacks)) //the more soaked in fire you are, the likelier to be ignited
			M.IgniteMob()

		M.adjustFireLoss(round(burnlevel*0.5)) //This makes fire stronk.
		to_chat(M, "<span class='danger'>You are burned!</span>")

/obj/flamer_fire/proc/updateicon()
	if(burnlevel < 15)
		color = "#c1c1c1" //make it darker to make show its weaker.
	switch(firelevel)
		if(1 to 9)
			icon_state = "[flame_color]_1"
			set_light(2, l_color = "#E38F46")
		if(10 to 25)
			icon_state = "[flame_color]_2"
			set_light(4, l_color = "#E38F46")
		if(25 to INFINITY) //Change the icons and luminosity based on the fire's intensity
			icon_state = "[flame_color]_3"
			set_light(6, l_color = "#E38F46")

/obj/flamer_fire/Process()
	var/turf/T = loc
	firelevel = max(0, firelevel)
	if(!istype(T)) //Is it a valid turf? Has to be on a floor
		qdel(src)
		return

	updateicon()

	if(!firelevel)
		qdel(src)
		return

	for(var/mob/living/I in loc)
		if(istype(I,/mob/living/carbon/human))
			var/mob/living/carbon/human/M = I
			if(istype(M.wear_suit, /obj/item/clothing/suit/fire))
				M.show_message(text("Your suit protects you from the flames."), 1)
				M.adjustFireLoss(rand(0 ,burnlevel*0.25)) //Does small burn damage to a person wearing one of the suits.
			if(istype(M.wear_suit, /obj/item/clothing/suit/armor/astartes))
				M.show_message(text("Your suit protects you from the flames."), 1)
				M.adjustFireLoss(0) //Does no burn damage
				continue
		I.adjust_fire_stacks(burnlevel) //If i stand in the fire i deserve all of this. Also Napalm stacks quickly.
		if(prob(firelevel)) I.IgniteMob()
		I.show_message(text("<span class='warning'>You are burned!</span>"),1)

	//This has been made a simple loop, for the most part flamer_fire_act() just does return, but for specific items it'll cause other effects.
	firelevel -= 2 //reduce the intensity by 2 per tick
	return


//this is the PHOSPHOR energy gun, its really fucking OP in lore because it burns through almost anything until they are dead, im not sure why the pain is so huge tho.
/obj/item/projectile/energy/phosphor
	name = "phosphor splash"
	icon_state = "pulse1"
	fire_sound = 'sound/weapons/gunshot/gunshot_pistol.ogg'
	damage = 35 //phosphor blasters are incredibly powerful weapons, almost never used
	armor_penetration = 40 //phosphor blasters are incredibly good at penetrating heavy armor
	//range =  6 //extremely close ranged, normal vision is 8 but technically 7 if you don't count your own tile.


/obj/item/projectile/energy/phosphor/on_hit(atom/target, blocked = 0)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(!istype(H.wear_suit, /obj/item/clothing/suit/armor/seolsuit))
			H.adjust_fire_stacks(5) //i know this aint lore accurate, but if you want to buff this, nerf pain.
			H.IgniteMob()
		new /obj/flamer_fire(H.loc, 12, 10, "red", 1)



//ARCHEOTECH

/obj/item/projectile/archeotech //Categorisation object.
	name = "Archeotech Shot"
	icon_state = "ion"
	fire_sound = 'sound/weapons/Laser.ogg'
	damage = 0
	damage_type = DAMAGE_BURN
	nodamage = 1

/obj/item/projectile/archeotech/explosion
	name = "Explosive Archeotech Shot"
	icon_state = "ion"
	fire_sound = 'sound/weapons/Laser.ogg'
	damage = 5
	armor_penetration = 60
	damage_type = DAMAGE_BURN

/obj/item/projectile/archeotech/explosion/on_hit(atom/target, blocked = 0)
	explosion(target, 3, EX_ACT_HEAVY)
	..()

/obj/item/projectile/archeotech/anticausality
	name = "Anticausal Archeotech Shot"
	icon_state = "bluespace"
	fire_sound = 'sound/weapons/Laser.ogg'
	damage = 5
	armor_penetration = 60
	damage_type = DAMAGE_BURN


/obj/item/projectile/archeotech/anticausality/on_hit(atom/target, blocked = 0)
	if(ismob(target))
		var/mobloc = get_turf(target.loc)
		var/atom/movable/fake_overlay/animation
		animation = new/atom/movable/fake_overlay(mobloc)
		animation.SetName("residue")
		animation.set_density(FALSE)
		animation.anchored = TRUE
		animation.icon = 'icons/mob/mob.dmi'
		animation.layer = FLY_LAYER
		visible_message("<span class='danger'>[target] vanishes in a flow of anticausal particles!</span>")
		animation.icon_state = "liquify"
		flick("liquify",animation)
		qdel(target)
		qdel(animation)
	if(istype(target, /turf/simulated/wall))
		var/turf/simulated/wall/W = target
		explosion(W, 1, EX_ACT_HEAVY)
		qdel(W)
	if(istype(target, /atom/movable/lighting_overlay))
		var/atom/movable/lighting_overlay/L = target
		explosion(L, 1, EX_ACT_HEAVY)
	if(istype(target, /mob/living/simple_animal))
		var/mob/living/simple_animal/S = target
		qdel(S)
	else
		if(!isturf(target))
			qdel(target)
			visible_message("<span class='danger'>[target] vanishes in a flow of anticausal particles!</span>")
		return
	..()

/obj/item/projectile/archeotech/capture
	name = "Capture Archeotech Shot"
	icon_state = "electricity2"
	fire_sound = 'sound/weapons/Laser.ogg'
	damage = 0
	armor_penetration = 60
	damage_type = DAMAGE_BURN

/obj/item/projectile/archeotech/capture/on_hit(atom/target, blocked = 0)
	if(istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		var/obj/item/handcuffs/archeotech/cuffs = new()
		cuffs.forceMove(H)
		H.handcuffed = cuffs
		H.update_inv_handcuffed()
		H.visible_message("Beams of light form around \the [H]'s hands!")
		H.Weaken(5)
	if(istype(target, /mob/living/simple_animal))
		var/mob/living/simple_animal/S = target
		S.in_stasis = 1
	..()

/obj/item/handcuffs/archeotech
	name = "Energy Cuffs"
	desc = "Strange beams of energy which restrain your hands."
	breakout_time = 300 //30 seconds

/obj/item/handcuffs/archeotech/dropped(mob/user)
	..()
	qdel(src)

/obj/item/projectile/archeotech/stun
	name = "Stun Archeotech Shot"
	icon_state = "spark"
	fire_sound = 'sound/weapons/Laser.ogg'
	damage = 0
	armor_penetration = 60
	damage_type = DAMAGE_BURN

/obj/item/projectile/archeotech/stun/on_hit(atom/target, blocked = 0)
	if(istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = target
		H.Weaken(15)
		H.Stun(15)
	..()

/obj/item/projectile/archeotech/kill
	name = "Lethal Archeotech Shot"
	icon_state = "heavylaser"
	fire_sound = 'sound/weapons/Laser.ogg'
	damage = 750 //Enough to instakill simplemobs.
	armor_penetration = 80
	damage_type = DAMAGE_BURN
	sharp = 1
