/obj/item/mech_component/sensors
	name = "head"
	icon_state = "loader_head"
	gender = NEUTER

	var/vision_flags = 0
	var/see_invisible = 0
	var/obj/item/robot_parts/robot_component/radio/radio
	var/obj/item/robot_parts/robot_component/camera/camera
	has_hardpoints = list(HARDPOINT_HEAD)
	var/active_sensors = 0
	power_use = 15
	w_class = ITEM_SIZE_NORMAL

/obj/item/mech_component/sensors/Destroy()
	QDEL_NULL(camera)
	QDEL_NULL(radio)
	. = ..()

/obj/item/mech_component/sensors/show_missing_parts(mob/user)
	if(!radio)
		to_chat(user, SPAN_WARNING("It is missing a radio."))
	if(!camera)
		to_chat(user, SPAN_WARNING("It is missing a camera."))

/obj/item/mech_component/sensors/prebuild()
	radio = new(src)
	camera = new(src)

/obj/item/mech_component/sensors/update_components()
	radio = locate() in src
	camera = locate() in src

/obj/item/mech_component/sensors/proc/get_sight(powered)
	var/flags = 0
	if(total_damage >= max_damage || !powered || !camera)
		flags |= BLIND
	else if(active_sensors && powered)
		flags |= vision_flags

	return flags

/obj/item/mech_component/sensors/proc/get_invisible(powered)
	var/invisible = 0
	if(total_damage <= max_damage && active_sensors && powered && camera)
		invisible = see_invisible
	return invisible

/obj/item/mech_component/sensors/use_tool(obj/item/thing, mob/living/user, list/click_params)
	if(istype(thing,/obj/item/robot_parts/robot_component/radio))
		if(radio)
			to_chat(user, SPAN_WARNING("\The [src] already has a radio installed."))
			return TRUE
		if(install_component(thing, user))
			radio = thing
			return TRUE

	else if(istype(thing,/obj/item/robot_parts/robot_component/camera))
		if(camera)
			to_chat(user, SPAN_WARNING("\The [src] already has a camera installed."))
			return TRUE
		if(install_component(thing, user))
			camera = thing
			return TRUE
	else
		return ..()

/obj/item/mech_component/sensors/return_diagnostics(mob/user)
	..()
	if(radio)
		to_chat(user, SPAN_NOTICE(" Radio Integrity: <b>[round((((radio.max_dam - radio.total_dam) / radio.max_dam)) * 100)]%</b>"))
	else
		to_chat(user, SPAN_WARNING(" Radio Missing or Non-functional."))
	if(camera)
		to_chat(user, SPAN_NOTICE(" Camera Integrity: <b>[round((((camera.max_dam - camera.total_dam) / camera.max_dam)) * 100)]%</b>"))
	else
		to_chat(user, SPAN_WARNING(" Camera Missing or Non-functional."))

/obj/item/mech_component/sensors/powerloader
	name = "exosuit sensors"
	gender = PLURAL
	exosuit_desc_string = "simple collision detection sensors"
	desc = "A primitive set of sensors designed to work in tandem with most MKI Eyeball platforms."
	max_damage = 150
	power_use = 0

/obj/item/mech_component/sensors/light
	name = "light sensors"
	gender = PLURAL
	exosuit_desc_string = "advanced sensor array"
	icon_state = "light_head"
	max_damage = 75
	vision_flags = SEE_TURFS
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	power_use = 50
	desc = "A series of high resolution optical sensors. They can overlay several images to give the pilot a sense of location even in total darkness. "

/obj/item/mech_component/sensors/heavy
	name = "heavy sensors"
	exosuit_desc_string = "a reinforced monoeye"
	desc = "A solitary sensor moves inside a recessed slit in the armour plates."
	icon_state = "heavy_head"
	max_damage = 300
	power_use = 0

/obj/item/mech_component/sensors/combat
	name = "combat sensors"
	gender = PLURAL
	exosuit_desc_string = "high-resolution thermal sensors"
	icon_state = "combat_head"
	max_damage = 75
	vision_flags = SEE_MOBS
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	power_use = 200
