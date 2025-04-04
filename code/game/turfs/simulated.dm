/turf/simulated
	name = "station"
	var/wet = 0
	var/image/wet_overlay = null

	//Mining resources (for the large drills).
	var/has_resources
	var/list/resources

	var/thermite = 0
	initial_gas = list(GAS_OXYGEN = MOLES_O2STANDARD, GAS_NITROGEN = MOLES_N2STANDARD)
	var/to_be_destroyed = 0 //Used for fire, if a melting temperature was reached, it will be destroyed
	var/max_fire_temperature_sustained = 0 //The max temperature of the fire which it was subjected to
	var/dirt = 0

	var/timer_id

// This is not great.
/turf/simulated/proc/wet_floor(wet_val = 1, overwrite = FALSE)
	if(wet_val < wet && !overwrite)
		return

	if(!wet)
		wet = wet_val
		wet_overlay = image('icons/effects/water.dmi',src,"wet_floor")
		AddOverlays(wet_overlay)

	timer_id = addtimer(new Callback(src,TYPE_PROC_REF(/turf/simulated, unwet_floor)),8 SECONDS, TIMER_STOPPABLE|TIMER_UNIQUE|TIMER_NO_HASH_WAIT|TIMER_OVERRIDE)

/turf/simulated/proc/unwet_floor(check_very_wet = TRUE)
	if(check_very_wet && wet >= 2)
		wet--
		timer_id = addtimer(new Callback(src,TYPE_PROC_REF(/turf/simulated, unwet_floor)), 8 SECONDS, TIMER_STOPPABLE|TIMER_UNIQUE|TIMER_NO_HASH_WAIT|TIMER_OVERRIDE)
		return

	wet = 0
	if(wet_overlay)
		CutOverlays(wet_overlay)
		wet_overlay = null

/turf/simulated/clean_blood()
	for(var/obj/decal/cleanable/blood/B in contents)
		B.clean_blood()
	..()

/turf/simulated/New()
	..()
	if(istype(loc, /area/chapel))
		holy = 1
	levelupdate()

/turf/simulated/proc/AddTracks(typepath,bloodDNA,comingdir,goingdir,bloodcolor=COLOR_BLOOD_HUMAN)
	var/obj/decal/cleanable/blood/tracks/tracks = locate(typepath) in src
	if(!tracks)
		tracks = new typepath(src)
	tracks.AddTracks(bloodDNA,comingdir,goingdir,bloodcolor)

/turf/simulated/proc/update_dirt()
	dirt = min(dirt+0.5, 101)
	var/obj/decal/cleanable/dirt/dirtoverlay = locate(/obj/decal/cleanable/dirt, src)
	if (dirt > 50)
		if (!dirtoverlay)
			dirtoverlay = new/obj/decal/cleanable/dirt(src)
		dirtoverlay.alpha = min((dirt - 50) * 5, 255)

/turf/simulated/remove_cleanables()
	dirt = 0
	. = ..()

/turf/simulated/Entered(atom/A, atom/OL)
	. = ..()
	if (istype(A,/mob/living))
		var/mob/living/M = A

		// Dirt overlays.
		update_dirt()

		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			// Tracking blood
			var/list/bloodDNA = null
			var/bloodcolor=""
			if(H.shoes)
				var/obj/item/clothing/shoes/S = H.shoes
				if(istype(S))
					S.handle_movement(src, MOVING_QUICKLY(H))
					if(S.track_blood && S.blood_DNA)
						bloodDNA = S.blood_DNA
						bloodcolor = S.blood_color
						S.track_blood--
			else
				if(H.track_blood && H.feet_blood_DNA)
					bloodDNA = H.feet_blood_DNA
					bloodcolor = H.feet_blood_color
					H.track_blood--

			if (bloodDNA && H.species.get_move_trail(H))
				src.AddTracks(H.species.get_move_trail(H),bloodDNA,H.dir,0,bloodcolor) // Coming
				var/turf/simulated/from = get_step(H,reverse_direction(H.dir))
				if(istype(from) && from)
					from.AddTracks(H.species.get_move_trail(H),bloodDNA,0,H.dir,bloodcolor) // Going

				bloodDNA = null

		if(M.lying)
			return

		if(src.wet)

			if(M.buckled || (!MOVING_QUICKLY(M) && prob(min(100, 100/(wet/10))) ) )
				return

			// skillcheck for slipping
			if(!prob(min(100, M.skill_fail_chance(SKILL_VIGOR, 100, SKILL_MAX+1)/(3/wet))))
				return

			var/slip_dist = 1
			var/slip_stun = 6
			var/floor_type = "wet"

			if(2 <= src.wet) // Lube
				floor_type = "slippery"
				slip_dist = 4
				slip_stun = 10

			if(M.slip("the [floor_type] floor", slip_stun))
				addtimer(new Callback(M, TYPE_PROC_REF(/mob, slip_handler), M.dir, slip_dist - 1, 1), 1)


/mob/proc/slip_handler(dir, dist, delay)
	if (dist > 0)
		addtimer(new Callback(src, PROC_REF(slip_handler), dir, dist - 1, delay), delay)
	step(src, dir)

//returns 1 if made bloody, returns 0 otherwise
/turf/simulated/add_blood(mob/living/carbon/human/M as mob)
	if (!..())
		return 0

	if(istype(M))
		for(var/obj/decal/cleanable/blood/B in contents)
			if(!B.blood_DNA)
				B.blood_DNA = list()
			if(!B.blood_DNA[M.dna.unique_enzymes])
				B.blood_DNA[M.dna.unique_enzymes] = M.dna.b_type
			return 1 //we bloodied the floor
		blood_splatter(src,M.get_blood(M.vessel),1)
		return 1 //we bloodied the floor
	return 0

// Only adds blood on the floor -- Skie
/turf/simulated/proc/add_blood_floor(mob/living/carbon/M as mob)
	if( istype(M, /mob/living/carbon/alien ))
		var/obj/decal/cleanable/blood/xeno/this = new /obj/decal/cleanable/blood/xeno(src)
		this.blood_DNA["UNKNOWN BLOOD"] = "X*"
	else if( istype(M, /mob/living/silicon/robot ))
		new /obj/decal/cleanable/blood/oil(src)

/turf/simulated/proc/can_build_cable(mob/user)
	return 0

/turf/simulated/use_tool(obj/item/thing, mob/living/user, list/click_params)
	if(isCoil(thing) && can_build_cable(user))
		var/obj/item/stack/cable_coil/coil = thing
		coil.PlaceCableOnTurf(src, user)
		return TRUE
	return ..()

/turf/simulated/attack_hand(mob/living/user)
	. = ..()

	if (Adjacent(user))
		add_fingerprint(user)

	if (!get_max_health() || !ishuman(user) || user.a_intent != I_HURT)
		return

	var/mob/living/carbon/human/assailant = user
	var/datum/unarmed_attack/attack = assailant.get_unarmed_attack(src)
	if (!attack)
		return
	assailant.do_attack_animation(src)
	assailant.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	var/damage = attack.damage + rand(1,5)
	var/attack_verb = "[pick(attack.attack_verb)]"

	if (MUTATION_FERAL in user.mutations)
		attack_verb = "smashes"
		damage = 15

	playsound(src, damage_hitsound, 25, TRUE, -1)
	if (!can_damage_health(damage, attack.get_damage_type()))
		user.visible_message(
			SPAN_WARNING("\The [user] [attack_verb] \the [src], but doesn't even leave a dent!"),
			SPAN_WARNING("You [attack_verb] \the [src], but cause no visible damage and hurt yourself!")
		)
		if (!(MUTATION_FERAL in user.mutations))
			user.apply_damage(3, DAMAGE_BRUTE, user.hand ? BP_L_HAND : BP_R_HAND)
		return TRUE

	assailant.visible_message(
			SPAN_WARNING("\The [assailant] [attack_verb] \the [src]!"),
			SPAN_WARNING("You [attack_verb] \the [src]!")
			)
	damage_health(damage, attack.get_damage_type(), attack.damage_flags())
	return TRUE

/turf/simulated/Initialize()
	if(GAME_STATE >= RUNLEVEL_GAME)
		fluid_update()
	. = ..()

/turf/simulated/damage_health(damage, damage_type, damage_flags, severity, skip_can_damage_check = FALSE)
	if (HAS_FLAGS(damage_flags, DAMAGE_FLAG_TURF_BREAKER))
		damage *= 4
	. = ..()

/* fix me later

// 40k Dirt

//Dirt!
/turf/simulated/floor/dirty
	name = "dirt" //"snowy dirt"
	icon = 'icons/turf/dirt.dmi'
	icon_state = "dirt1"
	movement_delay = 0.1
	atom_flags = ATOM_FLAG_CLIMBABLE
	has_coldbreath = FALSE // No more freezing to death indoors.
	var/has_light = FALSE
	var/can_generate_water = FALSE // NO MORE RNG WATER> PLACE THE TILES YOURSELF YOU LAZY MAPPERS
	var/can_be_dug = TRUE

/turf/simulated/floor/dirty/fake
	desc = "This dirt isn't climbable"
	atom_flags = null
	can_generate_water = FALSE
	can_be_dug = TRUE

/turf/simulated/floor/dirty/tough //this is meant to be the default undiggiable. You can dig it for now though
	name = "tough dirt"
	desc = "This dirt may or may not be diggable"
	can_be_dug = TRUE

/turf/simulated/floor/dirty/tough/lightless
	can_be_dug = TRUE
	has_light = FALSE

/turf/simulated/floor/dirty/tough/fake //Can't be click dragged on.
	desc = "This dirt isn't climbable"
	atom_flags = null

/turf/simulated/floor/dirty/tough/lightless/fake
	atom_flags = null

/turf/simulated/floor/dirty/tough/ex_act(severity)//Can't be blown up.
	return

/turf/simulated/floor/dirty/CanPass(atom/movable/mover, turf/target)
	if(ishuman(mover))
		if(istype(get_turf(mover), /turf/simulated/floor/trench))
			if(!mover.pulledby)
				return FALSE

	return TRUE

/turf/simulated/floor/dirty/can_climb(var/mob/living/user, post_climb_check=0)
	if (!(atom_flags & ATOM_FLAG_CLIMBABLE) || !can_touch(user))
		return FALSE

	if (!user.Adjacent(src))
		to_chat(user, "<span class='danger'>You can't climb there, the way is blocked.</span>")
		return FALSE

	return TRUE

/turf/simulated/floor/dirty/do_climb(var/mob/living/user)
	if(!can_climb(user))
		return
/*
	if(istype(get_area(src), /area/warfare/battlefield/no_mans_land))//We're trying to go into no man's land?
		if(locate(/obj/item/device/boombox) in user)//Locate the boombox.
			to_chat(user, "I can't bring this with me onto the battlefield. Wouldn't want to lose it.")//No you fucking don't.
			return //Keep that boombox at base asshole.
		if(locate(/obj/item/storage) in user)//Gotta check storage as well.
			var/obj/item/storage/S = locate() in user
			if(locate(/obj/item/device/boombox) in S)
				to_chat(user, "I can't bring this with me onto the battlefield. Wouldn't want to lose it.")
				return
*/
	user.visible_message("<span class='warning'>[user] starts climbing onto \the [src]!</span>")
	climbers |= user

	if(!can_climb(user))
		climbers -= user
		return

	if(!do_after(user,15))
		climbers -= user
		return

	user.forceMove(get_turf(src))
	user.visible_message("<span class='warning'>[user] climbed onto \the [src]!</span>")
	climbers -= user

/turf/simulated/floor/dirty/MouseDrop_T(mob/target, mob/user)
	var/mob/living/H = user
	if(istype(H) && can_climb(H) && target == user)
		do_climb(target)
	else
		return ..()

/turf/simulated/floor/dirty/indestructable/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"

/turf/simulated/floor/dirty/indestructable/snow/New()
	icon_state = pick("snow[rand(1,12)]","snow0")
	..()

/turf/simulated/floor/dirty/New()
	..()
	temperature = T0C - 60
	//icon_state = pick("snow[rand(1,12)]","snow0")
	dir = pick(GLOB.alldirs)
	if(!(locate(/obj/effect/lighting_dummy/daylight) in src) && has_light)
		new /obj/effect/lighting_dummy/daylight(src)
	spawn(1)
		overlays.Cut()
	if(loc.type != /area/warfare/battlefield/no_mans_land) // no base puddles
		return
	if(!can_generate_water)//This type can't generate water so don't bother.
		return

/turf/simulated/floor/dirty/attackby(obj/O as obj, mob/living/user as mob)
	if(istype(O, /obj/item/shovel))
		if(!user.doing_something)
			user.doing_something = TRUE
			if(src.density)
				user.doing_something = FALSE
				return
			for(var/obj/structure/object in contents)
				if(object)
					to_chat(user, "There are things in the way.")
					user.doing_something = FALSE
					return
			playsound(src, 'sound/effects/dig_shovel.ogg', 50, 0)
			visible_message("[user] begins to dig some dirt cover!")
			if(do_after(user, (backwards_skill_scale(user.SKILL_LEVEL(engineering)) * 10)))
				new /obj/structure/dirt_wall(src)
				visible_message("[user] finishes digging the dirt cover.")
				playsound(src, 'sound/effects/empty_shovel.ogg', 50, 0)

			user.doing_something = FALSE

		else
			to_chat(user, "You're already digging.")

/turf/simulated/floor/dirty/RightClick(mob/living/user)
	if(!CanPhysicallyInteract(user))
		return
	var/obj/item/shovel/S = user.get_active_hand()
	if(!istype(S))
		return
	if(!can_be_dug)//No escaping to mid early.
		return
	if(!user.doing_something)
		user.doing_something = TRUE
		if(src.density)
			user.doing_something = FALSE
			return
		for(var/obj/structure/object in contents)
			if(object)
				to_chat(user, "There are things in the way.")
				user.doing_something = FALSE
				return
		playsound(src, 'sound/effects/dig_shovel.ogg', 50, 0)
		visible_message("[user] begins to dig a trench!")
		if(do_after(user, backwards_skill_scale(user.SKILL_LEVEL(engineering)) * 10))
			ChangeTurf(/turf/simulated/floor/trench)
			visible_message("[user] finishes digging the trench.")
			playsound(src, 'sound/effects/empty_shovel.ogg', 50, 0)
			user.doing_something = FALSE

		user.doing_something = FALSE

	else
		to_chat(user, "You're already digging.")


/turf/simulated/floor/snow/RightClick(mob/living/user)
	if(!CanPhysicallyInteract(user))
		return
	var/obj/item/shovel/S = user.get_active_hand()
	if(!istype(S))
		return
	if(!can_be_dug)//No escaping to mid early.
		return
	if(!user.doing_something)
		user.doing_something = TRUE
		if(src.density)
			user.doing_something = FALSE
			return
		for(var/obj/structure/object in contents)
			if(object)
				to_chat(user, "There are things in the way.")
				user.doing_something = FALSE
				return
		playsound(src, 'sound/effects/dig_shovel.ogg', 50, 0)
		visible_message("[user] begins to dig a trench!")
		if(do_after(user, backwards_skill_scale(user.SKILL_LEVEL(engineering)) * 10))
			ChangeTurf(/turf/simulated/floor/trench)
			visible_message("[user] finishes digging the trench.")
			playsound(src, 'sound/effects/empty_shovel.ogg', 50, 0)
			user.doing_something = FALSE

		user.doing_something = FALSE

	else
		to_chat(user, "You're already digging.")


/turf/simulated/floor/snow/attackby(obj/O as obj, mob/living/user as mob)
	if(istype(O, /obj/item/shovel))
		if(!user.doing_something)
			user.doing_something = TRUE
			if(src.density)
				user.doing_something = FALSE
				return
			for(var/obj/structure/object in contents)
				if(object)
					to_chat(user, "There are things in the way.")
					user.doing_something = FALSE
					return
			playsound(src, 'sound/effects/dig_shovel.ogg', 50, 0)
			visible_message("[user] begins to dig a grave!")
			if(do_after(user, (backwards_skill_scale(user.SKILL_LEVEL(engineering)) * 10)))
				new /obj/structure/closet/pit(src)
				visible_message("[user] finishes digging the grave!")
				playsound(src, 'sound/effects/empty_shovel.ogg', 50, 0)

			user.doing_something = FALSE

		else
			to_chat(user, "You're already digging.")


/turf/simulated/floor/dirty/update_dirt()
	return	// Dirt doesn't doesn't become dirty

/turf/simulated/floor/dirty/indestructable
	desc = "This dirt seems tougher than most other dirts."

/turf/simulated/floor/dirty/indestructable/mud
	name = "mud"
	desc = "This mud looks tougher than most other muds."
	icon_state = "mud"
	movement_delay = 0.1

/turf/simulated/floor/dirty/indestructable/mud/New()
	dir = pick(GLOB.alldirs)
	..()

/turf/simulated/floor/dirty/indestructable/ex_act(severity)//Can't be blown up.
	return

/turf/simulated/floor/dirty/indestructable/lightless
	has_light = FALSE

/turf/simulated/floor/dirty/indestructable/lightless/has_trees

/////////
//WATER//
/////////
/turf/simulated/floor/exoplanet/water/shallow
	name = "water"
	icon = 'icons/turf/dirt.dmi'//This appears under the water.
	icon_state = "mud"
	movement_delay = 1
	mudpit = 1
	has_coldbreath = TRUE
	var/has_light = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE

/turf/simulated/floor/exoplanet/water/shallow/update_dirt()
	return

/turf/simulated/floor/exoplanet/water/shallow/ex_act(severity)
	return

/turf/simulated/floor/exoplanet/water/shallow/CanPass(atom/movable/mover, turf/target)
	if(ishuman(mover))
		if(istype(get_turf(mover), /turf/simulated/floor/trench))
			if(!mover.pulledby)
				return FALSE

	return TRUE

/turf/simulated/floor/exoplanet/water/shallow/can_climb(var/mob/living/user, post_climb_check=0)
	if (!(atom_flags & ATOM_FLAG_CLIMBABLE) || !can_touch(user))
		return FALSE

	if (!user.Adjacent(src))
		to_chat(user, "<span class='danger'>You can't climb there, the way is blocked.</span>")
		return FALSE

	return TRUE

/turf/simulated/floor/exoplanet/water/shallow/do_climb(var/mob/living/user)
	if(!can_climb(user))
		return

	user.visible_message("<span class='warning'>[user] starts climbing onto \the [src]!</span>")
	climbers |= user

	if(!can_climb(user))
		climbers -= user
		return

	if(!do_after(user,15))
		climbers -= user
		return

	user.forceMove(get_turf(src))
	user.visible_message("<span class='warning'>[user] climbed onto \the [src]!</span>")
	climbers -= user

/turf/simulated/floor/exoplanet/water/shallow/MouseDrop_T(mob/target, mob/user)
	var/mob/living/H = user
	if(istype(H) && can_climb(H) && target == user)
		if(istype(get_area(src), /area/warfare/battlefield/no_mans_land))//We're trying to go into no man's land?
			if(locate(/obj/item/device/boombox) in user)//Locate the boombox.
				to_chat(user, "I can't bring this with me onto the battlefield. Wouldn't want to lose it.")//No you fucking don't.
				return //Keep that boombox at base asshole.
			if(locate(/obj/item/storage) in user)//Gotta check storage as well.
				var/obj/item/storage/S = locate() in user
				if(locate(/obj/item/device/boombox) in S)
					to_chat(user, "I can't bring this with me onto the battlefield. Wouldn't want to lose it.")
					return
		do_climb(target)
	else
		return ..()

/turf/simulated/floor/exoplanet/water/shallow/Cross(var/atom/A)//People who are on fire go out.
	if(isliving(A))
		var/mob/living/L = A
		L.ExtinguishMob()

/turf/simulated/floor/exoplanet/water/shallow/lightless
	has_light = FALSE

/turf/simulated/floor/exoplanet/water/shallow/New()
	..()
	if((!locate(/obj/effect/lighting_dummy/daylight) in src) && has_light)
		new /obj/effect/lighting_dummy/daylight(src)
	temperature = T0C - 80
	for(var/obj/effect/water/bottom/B in src)
		if(B)
			qdel(B)
	for(var/obj/effect/water/top/T in src)
		if(T)
			qdel(T)

	new /obj/effect/water/bottom(src)//Put it right on top of the water so that they look like they're the same.
	new /obj/effect/water/top(src)
	spawn(5)
		update_icon()
		for(var/turf/simulated/floor/exoplanet/water/shallow/T in range(1))
			T.update_icon()

/turf/simulated/floor/exoplanet/water/shallow/update_icon()

	overlays.Cut()
	for(var/direction in GLOB.cardinal)
		var/turf/turf_to_check = get_step(src,direction)
		if(istype(turf_to_check, /turf/simulated/floor/exoplanet/water/shallow))
			continue

		else if(istype(turf_to_check, /turf/simulated))
			var/image/water_side = image('icons/obj/warfare.dmi', "over_water1", dir = direction)//turn(direction, 180))
			water_side.plane = EFFECTS_BELOW_LIGHTING_PLANE

			overlays += water_side
		var/image/wave_overlay = image('icons/obj/warfare.dmi', "waves")
		overlays += wave_overlay

/turf/simulated/floor/exoplanet/water/shallow/Destroy()
	. = ..()
	for(var/obj/effect/water/bottom/B in src)
		qdel(B)
	for(var/obj/effect/water/top/T in src)
		qdel(T)

/turf/simulated/floor/exoplanet/water/shallow/attackby(obj/item/O, mob/user)
	if(istype(O, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/RG = O
		if (istype(RG) && RG.is_open_container())
			RG.reagents.add_reagent(/datum/reagent/water, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
			user.visible_message("<span class='notice'>[user] fills \the [RG] using \the [src].</span>","<span class='notice'>You fill \the [RG] using \the [src].</span>")
			return 1

	if (istype(O, /obj/item/stack/duckboard))
		var/obj/item/stack/duckboard/S = O
		if (S.get_amount() < 1)
			return
		playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
		S.use(1)
		ChangeTurf(/turf/simulated/floor/trenches)
		return

/turf/simulated/floor/exoplanet/water/shallow/ChangeTurf(turf/N, tell_universe, force_lighting_update)
	var/obj/effect/water/top/T = locate() in loc
	if(T)
		qdel(T)
	var/obj/effect/water/bottom/B = locate() in loc
	if(B)
		qdel(B)
	. = ..()
	for(var/turf/simulated/floor/exoplanet/water/shallow/S in range(1))
		S.update_icon()


/obj/effect/water/top//This one appears over objects but under mobs.
	name = "water"
	icon = 'icons/obj/warfare.dmi'
	icon_state = "trench_water_top"
	plane = ABOVE_OBJ_PLANE
	layer = ABOVE_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	mouse_opacity = FALSE

/obj/effect/water/bottom//This one appears over mobs.
	name = "water"
	icon = 'icons/obj/warfare.dmi'
	icon_state = "trench_water_bottom"
	plane = ABOVE_HUMAN_PLANE
	layer = ABOVE_HUMAN_LAYER
	density = FALSE
	anchored = TRUE
	mouse_opacity = FALSE//Don't want this being clicked.

/turf/simulated/floor/exoplanet/water/update_dirt()
	return	// Water doesn't become dirty



/obj/item/stack/duckboard
	name = "duckboards"
	singular_name = "duckboard"
	w_class = 1
	force = 0
	throwforce = 0
	max_amount = 20
	gender = PLURAL
	desc = "For building over water."
	icon = 'icons/turf/trenches_turfs.dmi'
	icon_state = "wood0"
*/
