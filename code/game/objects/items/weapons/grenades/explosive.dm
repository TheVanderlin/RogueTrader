/obj/item/projectile/bullet/pellet/fragment
	damage = 22
	armor_penetration = 31
	range_step = 2 //controls damage falloff with distance. projectiles lose a "pellet" each time they travel this distance. Can be a non-integer.

	base_spread = 0 //causes it to be treated as a shrapnel explosion instead of cone
	spread_step = 40

	silenced = TRUE
	fire_sound = null
	no_attack_log = TRUE
	muzzle_type = null
	embed = TRUE // Maybe test out removing embed later. Be kinda silly for people in power armor to have to do surgery after an explosion. Or modify the code to not embed unless full pen?

/obj/item/projectile/bullet/pellet/fragment/strong
	damage = 37
	armor_penetration = 33

/obj/item/grenade/frag
	name = "fragmentation grenade"
	desc = "A military fragmentation grenade, designed to explode in a deadly shower of fragments, while avoiding massive structural damage."
	icon_state = "frggrenade"

	var/list/fragment_types = list(/obj/item/projectile/bullet/pellet/fragment = 1)
	var/num_fragments = 45  //total number of fragments produced by the grenade
	var/explosion_size = 2   //size of the center explosion

	//The radius of the circle used to launch projectiles. Lower values mean less projectiles are used but if set too low gaps may appear in the spread pattern
	var/spread_range = 7 //leave as is, for some reason setting this higher makes the spread pattern have gaps close to the epicenter

/obj/item/grenade/frag/attack_self(mob/living/user)
	if(!active)
		if(clown_check(user))
			to_chat(user, SPAN_WARNING("You prime \the [name]! [det_time/10] seconds!"))
			activater(user)
			add_fingerprint(user)
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.throw_mode_on()

/obj/item/grenade/frag/proc/activater(mob/living/user)
	if (active)
		return
	if (user)
		msg_admin_attack("[user.name] ([user.ckey]) primed \a [src] (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[user.x];Y=[user.y];Z=[user.z]'>JMP</a>)")
	active = TRUE
	playsound(loc, arm_sound, 75, 0, -3)
	addtimer(new Callback(src, PROC_REF(detonate), user), det_time)

/obj/item/grenade/frag/detonate(mob/living/user)
	..()

	var/turf/O = get_turf(src)
	if(!O) return

	if(explosion_size)
		on_explosion(O)

	src.fragmentate(O, num_fragments, spread_range, fragment_types)

	qdel(src)


/obj/proc/fragmentate(turf/T=get_turf(src), fragment_number = 30, spreading_range = 5, list/fragtypes=list(/obj/item/projectile/bullet/pellet/fragment))
	set waitfor = 0
	var/list/target_turfs = getcircle(T, spreading_range)
	var/fragments_per_projectile = round(fragment_number/length(target_turfs))

	for(var/turf/O in target_turfs)
		sleep(0)
		var/fragment_type = pickweight(fragtypes)
		var/obj/item/projectile/bullet/pellet/fragment/P = new fragment_type(T)
		P.pellets = fragments_per_projectile
		P.shot_from = src.name
		P.hitchance_mod = 50

		P.launch(O)

		// Handle damaging whatever the grenade's inside. Currently only checks for mobs.
		if (loc != get_turf(src))
			var/recursion_limit = 3 // Prevent infinite loops
			var/atom/current_check = src
			while (recursion_limit)
				current_check = current_check.loc
				if (isturf(current_check))
					break
				if (ismob(current_check))
					P.attack_mob(current_check, 0, 25)
				recursion_limit--

		//Make sure to hit any mobs in the source turf
		for(var/mob/living/M in T)
			//lying on a frag grenade while the grenade is on the ground causes you to absorb most of the shrapnel.
			//you will most likely be dead, but others nearby will be spared the fragments that hit you instead.
			if(M.lying && isturf(src.loc))
				P.attack_mob(M, 0, 5)
			else
				P.attack_mob(M, 0, 50)

/obj/item/grenade/frag/proc/on_explosion(turf/O)
	if(explosion_size)
		explosion(O, explosion_size, EX_ACT_LIGHT, 0)

/obj/item/grenade/frag/shell
	name = "fragmentation grenade"
	desc = "A light fragmentation grenade, designed to be fired from a launcher. It can still be activated and thrown by hand if necessary."
	icon_state = "fragshell"

	num_fragments = 40 //less powerful than a regular frag grenade

/obj/item/grenade/frag/high_yield
	name = "fragmentation bomb"
	desc = "Larger and heavier than a standard fragmentation grenade, this device is extremely dangerous. It cannot be thrown as far because of its weight."
	icon_state = "frag"

	w_class = ITEM_SIZE_NORMAL
	throw_speed = 3
	throw_range = 7

	fragment_types = list(/obj/item/projectile/bullet/pellet/fragment=1,/obj/item/projectile/bullet/pellet/fragment/strong=4)
	num_fragments = 50  //total number of fragments produced by the grenade
	explosion_size = 2

/obj/item/grenade/frag/high_yield/on_explosion(turf/O)
	if(explosion_size)
		explosion(O, round(explosion_size * 1.5), EX_ACT_HEAVY, 0) //has a chance to blow a hole in the floor

/obj/item/grenade/frag/high_yield/krak
	name = "Krak Grenade"
	desc = "A potent anti armor grenade used by the Imperium of Man, mind the blast radius."
	icon_state = "krak_grenade"
	fragment_types = list(/obj/item/projectile/bullet/pellet/fragment/strong=1)
	explosion_size = 3
	throw_range = 5
	num_fragments = 40
	w_class = ITEM_SIZE_NORMAL

/obj/item/grenade/frag/high_yield/krak/detpack
	name = "Det Pack"
	desc = "A standard issue imperial detpack, while simple these explosives when combined with grenades or further detpacks are capable of destroying even baneblades. Stand well clear!"
	explosion_size = 4
	num_fragments = 45 // Same number as a krak grenade but larger explosion radius and can destroy floor tiles.
	throw_range = 3
	throw_speed = 2
	w_class = ITEM_SIZE_LARGE // So nobody carries 10 of them and blows up the entire ship in a minute.
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "plastic-explosive0"
	item_state = "plasticx"

/obj/item/grenade/frag/high_yield/krak/detpack/on_explosion(turf/O)
	if(explosion_size)
		explosion(O, round(explosion_size * 1.5), EX_ACT_HEAVY, 0, turf_breaker = TRUE)

/obj/item/grenade/frag/high_yield/krak2
	name = "Mechanicus Krak Grenade"
	desc = "An incredibly dangerous and unstable plasma-enchanced Krak Grenade. Stand well clear!"
	icon_state = "krak_grenade"
	fragment_types = list(/obj/item/projectile/bullet/pellet/fragment/strong=1)
	explosion_size = 4
	num_fragments = 30 // Mechanicus make it more anti-armor but worse at fragmentation.
	w_class = ITEM_SIZE_SMALL

/obj/item/grenade/frag/homemade
	name = "Pipe Grenade"
	desc = "A low yield explosive used by miners to clear out caves and demolish stone."
	icon_state = "fire_grenade"
	explosion_size = 1
	num_fragments = 30
	throw_speed = 4.5
	throw_range = 8
	w_class = ITEM_SIZE_SMALL

/obj/item/grenade/frag/high_yield/plasma
	name = "Plasma Grenade"
	desc = "A highly lethal plasma grenade, which fires a burst of high-energy plasma when detonating."
	icon_state = "smoke1"
	fragment_types = list(/obj/item/projectile/energy/ion/plasma/pellet=1)
	explosion_size = 2
	num_fragments = 40
	throw_speed = 3
	throw_range = 6
	w_class = ITEM_SIZE_SMALL

/obj/item/grenade/frag/high_yield/plasma/on_explosion(turf/O)
	if(explosion_size)
		explosion(O, round(explosion_size * 1.5), EX_ACT_HEAVY, 0, turf_breaker = TRUE)

/obj/item/grenade/frag/makeshift
	name = "improvised explosive device"
	desc = "An aluminum can with a wire fuse leading inside of it. Partially guaranteed to blow your mind AND hands!"
	icon_state = "ghetto"
	arm_sound = 'sound/effects/flare.ogg'

	num_fragments = 20  // Its a /can/ , not nearly as strong as an industrially produced grenade.
	explosion_size = 1

	det_time = 3

	var/shrapnel_reinforced = 0 //But, with some patience, you can make it worth your time.

	var/possible_reinforcements = list(
		/obj/item/ammo_casing,
		/obj/item/material/coin,
		/obj/item/material/shard,
		/obj/item/reagent_containers/syringe,
		/obj/item/pen,
		/obj/item/material/knife/table,
		/obj/item/material/kitchen/utensil
		)

/obj/item/grenade/frag/makeshift/Initialize()
	det_time = rand(5,100) // Fuse is randomized.
	. = ..()

/obj/item/grenade/frag/makeshift/use_tool(obj/item/W, mob/living/user, list/click_params)
	if(isScrewdriver(W)) //overrides the act to screwdrive a grenade to set its fuse.
		to_chat(user, SPAN_WARNING("You can't adjust the timer on \the [src]!"))
		return TRUE

	if (is_type_in_list(W, possible_reinforcements))
		if(shrapnel_reinforced<10) //you can only add 10 items inside the can
			user.visible_message(
				SPAN_WARNING("\The [user] pries \the [src] open and drops \a [W] inside."),
				SPAN_DANGER("You open \the [src], carefully adding \a [W] before sealing the lid again."),
				SPAN_WARNING("You hear a metallic crack, followed by clinking.")
			)
			num_fragments += rand(1,2) // add 1 to 2 pellets. If you're /REALLY/ lucky, you'll end up with something similar to a standard grenade
			shrapnel_reinforced += 1
			qdel(W)
		else
			to_chat(user, SPAN_WARNING("You can't add any more items to \the [src]!"))
		return TRUE

	return ..()
