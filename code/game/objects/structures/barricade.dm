//Barricades!
/obj/structure/barricade
	name = "barricade"
	icon_state = "barricade"
	anchored = TRUE
	density = TRUE
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE
	layer = ABOVE_WINDOW_LAYER

	var/spiky = FALSE

/obj/structure/barricade/Initialize(mapload, material_name)
	. = ..(mapload)
	if(!material_name)
		material_name = MATERIAL_WOOD
	material = SSmaterials.get_material_by_name("[material_name]")
	if(!material)
		return INITIALIZE_HINT_QDEL
	desc = "A heavy, solid barrier made of [material.display_name]."
	color = material.icon_colour
	set_max_health(round(material.integrity * 1.33)) // Equivalent to a global resistance value of 0.75

/obj/structure/barricade/get_material()
	return material

/obj/structure/barricade/can_climb(mob/living/user, post_climb_check=FALSE, check_silicon=TRUE)
	. = ..()
	if (. && get_turf(user) == get_turf(src))
		var/turf/T = get_step(src, src.dir)
		if (T.density || T.turf_is_crowded(user))
			to_chat(user, SPAN_WARNING("You can't climb there, the way is blocked."))
			return 0

/obj/structure/barricade/do_climb(mob/living/user)
	. = ..()
	if (.)
		if (!anchored || material.is_brittle())
			kill_health() // Fatboy

		user.jump_layer_shift()
		addtimer(new Callback(user, TYPE_PROC_REF(/mob/living, jump_layer_shift_end)), 2)

/obj/structure/barricade/use_tool(obj/item/tool, mob/user, list/click_params)
	// Rods - Make barricade spiky
	if (istype(tool, /obj/item/stack/material/rods))
		if (spiky)
			USE_FEEDBACK_FAILURE("\The [src] already has spikes on it.")
			return TRUE
		var/obj/item/stack/material/rods/rods = tool
		if (!rods.can_use(5))
			USE_FEEDBACK_STACK_NOT_ENOUGH(rods, 5, "to build a cheval de frise.")
			return TRUE
		user.visible_message(
			SPAN_NOTICE("\The [user] starts adding some [tool.name] to \the [src]."),
			SPAN_NOTICE("You start adding some [tool.name] to \the [src].")
		)
		if (!user.do_skilled(4 SECONDS, SKILL_CONSTRUCTION, src, do_flags = DO_REPAIR_CONSTRUCT) || !user.use_sanity_check(src, tool))
			return TRUE
		if (spiky)
			USE_FEEDBACK_FAILURE("\The [src] already has spikes on it.")
			return TRUE
		if (!rods.use(5))
			USE_FEEDBACK_STACK_NOT_ENOUGH(rods, 5, "to build a cheval de frise.")
			return TRUE
		var/obj/structure/barricade/spike/CDF = new(loc, material.name, rods.material.name)
		CDF.set_dir(user.dir)
		transfer_fingerprints_to(CDF)
		user.visible_message(
			SPAN_NOTICE("\The [user] adds some [tool.name] to \the [src]."),
			SPAN_NOTICE("You add some [tool.name] to \the [src].")
		)
		qdel_self()
		return TRUE

	// Material Stack - Repair
	if (istype(tool, /obj/item/stack))
		var/obj/item/stack/material/stack = tool
		if (stack.material != material)
			USE_FEEDBACK_FAILURE("\The [tool] is the wrong type of material to repair \the [src].")
			return TRUE
		if (!get_damage_value())
			USE_FEEDBACK_FAILURE("\The [src] doesn't need repairs.")
			return TRUE
		if (!stack.can_use(1))
			USE_FEEDBACK_STACK_NOT_ENOUGH(stack, 1, "to repair \the [src].")
			return TRUE
		user.visible_message(
			SPAN_NOTICE("\The [user] starts repairing \the [src] with some [tool.name]."),
			SPAN_NOTICE("You start repairing \the [src] with some [tool.name].")
		)
		if (!user.do_skilled(2 SECONDS, SKILL_CONSTRUCTION, src, do_flags = DO_REPAIR_CONSTRUCT) || !user.use_sanity_check(src, tool))
			return TRUE
		if (!get_damage_value())
			USE_FEEDBACK_FAILURE("\The [src] doesn't need repairs.")
			return TRUE
		if (!stack.use(1))
			USE_FEEDBACK_STACK_NOT_ENOUGH(stack, 1, "to repair \the [src].")
			return TRUE
		revive_health()
		user.visible_message(
			SPAN_NOTICE("\The [user] repairs \the [src] with some [tool.name]."),
			SPAN_NOTICE("You repair \the [src] with some [tool.name].")
		)
		return TRUE

	return ..()


/obj/structure/barricade/on_death()
	dismantle()

/obj/structure/barricade/proc/dismantle()
	visible_message(SPAN_DANGER("The barricade is smashed apart!"))
	material.place_dismantled_product(get_turf(src))
	qdel(src)

/obj/structure/barricade/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)//So bullets will fly over and stuff.
	if(air_group || (height==0))
		return 1
	if(istype(mover) && mover.checkpass(PASS_FLAG_TABLE))
		return 1
	else
		return 0

//spikey barriers
/obj/structure/barricade/boards
	name = "wooden boards"
	desc = "Heavy wooden boards. Made with haste."
	icon = 'icons/obj/warfare.dmi'
	icon_state = "wood"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE
	spiky = TRUE // use for now so you cant put spikes on these warfare barricades.
	material = MATERIAL_WOOD

/obj/structure/barricade/Initialize(mapload, material_name)
	. = ..(mapload)
	color = null
	set_max_health(140)

/obj/structure/barricade/barrels
	name = "metal barrel"
	desc = "An empty metal barrel"
	icon = 'icons/obj/warfare.dmi'
	icon_state = "one_b"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE
	spiky = TRUE
	material = MATERIAL_STEEL

/obj/structure/barricade/barrels/Initialize(mapload, material_name)
	. = ..(mapload)
	color = null
	set_max_health(140)

/obj/structure/barricade/barrels/two
	name = "metal barrels"
	desc = "Empty metal barrels"
	icon = 'icons/obj/warfare.dmi'
	icon_state = "two_b"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE
	spiky = TRUE
	material = MATERIAL_STEEL

/obj/structure/barricade/barrels/two/Initialize(mapload, material_name)
	. = ..(mapload)
	color = null
	set_max_health(190)

/obj/structure/barricade/barrels/three
	name = "metal barrels"
	desc = "Empty metal barrels"
	icon = 'icons/obj/warfare.dmi'
	icon_state = "three_b"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE
	spiky = TRUE
	material = MATERIAL_STEEL

/obj/structure/barricade/barrels/three/Initialize(mapload, material_name)
	. = ..(mapload)
	color = null
	set_max_health(260)

/obj/structure/barricade/barrels/four
	name = "metal barrels"
	desc = "Empty metal barrels"
	icon = 'icons/obj/warfare.dmi'
	icon_state = "four_b"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE
	spiky = TRUE
	material = MATERIAL_STEEL

/obj/structure/barricade/barrels/four/Initialize(mapload, material_name)
	. = ..(mapload)
	color = null
	set_max_health(340)


/obj/structure/barricade/sandbag
	name = "heavy duty sandbag"
	desc = "Effective at blocking bullets, but it gets in the way."
	icon = 'icons/map_project/sandbags.dmi'
	icon_state = "sandbag"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE
	spiky = TRUE
	material = MATERIAL_STEEL

/obj/structure/barricade/sandbag/Initialize(mapload, material_name)
	. = ..(mapload)
	color = null
	set_max_health(240)

/obj/structure/barricade/sandbag/on_update_icon()
	if(dir == SOUTH && density)
		layer = ABOVE_HUMAN_LAYER
	return ..()

/obj/structure/barricade/sandbag/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if (!istype(mover) || mover.checkpass(PASS_FLAG_TABLE))
		return TRUE
	if (get_dir(loc, target) == dir)
		return !density
	return TRUE

/obj/structure/barricade/sandbag/CheckExit(atom/movable/O, turf/target)
	if (istype(O) && O.checkpass(PASS_FLAG_TABLE))
		return 1
	if (get_dir(O.loc, target) == dir)
		if (!density)
			return 1
		return 0
	return 1

/obj/structure/barricade/sandbag/rotate(mob/user)
	if(!CanPhysicallyInteract(user))
		to_chat(user, SPAN_NOTICE("You can't interact with \the [src] right now!"))
		return

	set_dir(turn(dir, 90))
	update_icon()

/obj/structure/barricade/sandbagwall
	name = "sandbag wall"
	desc = "A big sandbag that serves as a barricade of sorts."
	icon = 'icons/map_project/sandbag_wall.dmi'
	icon_state = "solo"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE
	spiky = TRUE
	material = MATERIAL_STEEL

/obj/structure/barricade/sandbagwall/Initialize(mapload, material_name)
	. = ..(mapload)
	color = null
	set_max_health(440)

/obj/structure/barricade/concrete
	name = "concrete barrier"
	desc = "Very effective at blocking bullets, but it gets in the way."
	icon = 'icons/obj/warfare.dmi'
	icon_state = "concrete_block"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE
	spiky = TRUE
	material = MATERIAL_STEEL

/obj/structure/barricade/concrete/Initialize(mapload, material_name)
	. = ..(mapload)
	color = null
	set_max_health(640)


/obj/structure/barricade/concrete/rotate(mob/user)
	if(!CanPhysicallyInteract(user))
		to_chat(user, SPAN_NOTICE("You can't interact with \the [src] right now!"))
		return

	set_dir(turn(dir, 90))
	update_icon()

/obj/structure/barricade/concrete/sandbag/on_update_icon()
	if(dir == SOUTH && density)
		layer = ABOVE_HUMAN_LAYER
	return ..()

/obj/structure/barricade/concrete/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if (!istype(mover) || mover.checkpass(PASS_FLAG_TABLE))
		return TRUE
	if (get_dir(loc, target) == dir)
		return !density
	return TRUE

/obj/structure/barricade/concrete/CheckExit(atom/movable/O, turf/target)
	if (istype(O) && O.checkpass(PASS_FLAG_TABLE))
		return 1
	if (get_dir(O.loc, target) == dir)
		if (!density)
			return 1
		return 0
	return 1

/obj/item/stack/barbwire
	name = "barbed wire"
	desc = "Use this to place down barbwire in front of your position."
	icon = 'icons/obj/warfare.dmi'
	icon_state = "barbwire_item"
	amount = 5
	max_amount = 5
	w_class = ITEM_SIZE_LARGE //fuck off you're not putting 30 stacks in your satchel

/obj/item/stack/barbwire/attack_self(mob/user)
	var/mob/living/carbon/human/H = user
	var/turf/T = get_step(user, user.dir)
	var/target_zone = pick(BP_L_HAND, BP_R_HAND)

	if(T)
		if(isopenspace(T))
			return
		if(turf_contains_dense_objects(T)) //no 20 structures of barbed wire in one tile/in walls
			to_chat(H, "There's already something there!")
			return
		for(var/obj/structure/object in T)
			to_chat(H, "There's already something there!")
			return
		visible_message("[user] begins to place the [src]!")
		if (do_after(user, 15 SECONDS,  DO_DEFAULT | DO_USER_UNIQUE_ACT | DO_PUBLIC_PROGRESS))
			if(user.skill_check(SKILL_CONSTRUCTION, SKILL_TRAINED))
				to_chat(H, "You assemble the [src]!")
				amount--
				if(amount<=0)
					qdel(src)
				new /obj/structure/barricade/barbed(T)
				return
			else
				playsound(loc, 'sound/weapons/stab2.ogg', 50, TRUE)
				H.apply_damage(14, DAMAGE_BRUTE, target_zone, damage_flags = DAMAGE_FLAG_SHARP, used_weapon = src)
				to_chat(H, "You fail to assemble the [src], cutting your hand!")


/obj/structure/barricade/barbed
	name = "barbed wire barricade"
	icon = 'icons/obj/warfare.dmi'
	icon_state = "barbwire"
	anchored = TRUE
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE
	spiky = TRUE
	material = MATERIAL_STEEL
	var/damage = 22

/obj/structure/barricade/barbed/Initialize(mapload, material_name)
	. = ..(mapload)
	color = null
	set_max_health(240)

/obj/structure/barricade/barbed/Crossed(mob/living/victim)
	. = ..()
	if(!isliving(victim))
		return
	if(world.time - victim.last_bumped <= 5) //spam guard
		return FALSE
	victim.last_bumped = world.time
	var/damage_holder = damage
	var/target_zone = pick(BP_CHEST, BP_GROIN, BP_L_LEG, BP_R_LEG)

	if(MOVING_DELIBERATELY(victim)) //creeping into this is less hurty than walking
		damage_holder = (damage / 4)

	if(isanimal(victim)) //simple animals have simple health, reduce our damage
		damage_holder = (damage / 3)

	victim.apply_damage(damage_holder, DAMAGE_BRUTE, target_zone, damage_flags = DAMAGE_FLAG_SHARP, used_weapon = src)
	visible_message(SPAN_DANGER("\The [victim] is gored by \the [src]!"))

/obj/structure/barricade/barbed/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		return 1

/obj/structure/barricade/barbed/necro
	name = "infestor mouth"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "necro2"
	material = MATERIAL_BONE_CARTILAGE
	damage = 40

/obj/structure/barricade/spike
	name = "spiked barricade"
	icon_state = "cheval"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE
	spiky = TRUE

	var/spike_overlay = "cheval_spikes"
	var/material/rod_material
	var/damage //how badly it smarts when you run into this like a rube
	var/list/poke_description = list("gored", "spiked", "speared", "stuck", "stabbed")

/obj/structure/barricade/spike/Initialize(mapload, material_name, rod_material_name)
	. = ..(mapload, material_name)
	if(!rod_material_name)
		rod_material_name = MATERIAL_WOOD
	rod_material = SSmaterials.get_material_by_name("[rod_material_name]")
	SetName("spiked barricade")
	desc = "A rather simple [material.display_name] spiked barricade, also known as a cheval-de-frise. It menaces with spikes of [rod_material.display_name] which look like they would hurt to walk in to."
	damage = (rod_material.hardness * 0.85)
	AddOverlays(overlay_image(icon, spike_overlay, color = rod_material.icon_colour, flags = RESET_COLOR))

/obj/structure/barricade/spike/Bumped(mob/living/victim)
	. = ..()
	if(!isliving(victim))
		return
	if(world.time - victim.last_bumped <= 15) //spam guard
		return FALSE
	victim.last_bumped = world.time
	var/damage_holder = damage
	var/target_zone = pick(BP_CHEST, BP_GROIN, BP_L_LEG, BP_R_LEG)

	if(MOVING_DELIBERATELY(victim)) //creeping into this is less hurty than walking
		damage_holder = (damage / 4)

	if(isanimal(victim)) //simple animals have simple health, reduce our damage
		damage_holder = (damage / 4)

	victim.apply_damage(damage_holder, DAMAGE_BRUTE, target_zone, damage_flags = DAMAGE_FLAG_SHARP, used_weapon = src)
	visible_message(SPAN_DANGER("\The [victim] is [pick(poke_description)] by \the [src]!"))
