/obj/item/clothing/accessory/armor_plate
	name = "light flak plates"
	desc = "Constructed from steel-reinforced synthetic fibers, this light flak plate offers basic protection against shrapnel and low-velocity projectiles."
	icon = 'icons/obj/clothing/obj_suit.dmi'
	icon_state = "armor_light"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	cold_protection = UPPER_TORSO|LOWER_TORSO
	heat_protection = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-20
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+200
	slowdown = 0.05
	armor = list(
		melee = ARMOR_MELEE_FLAK-1,
		bullet = ARMOR_BALLISTIC_FLAK-2,
		laser = ARMOR_LASER_FLAK-2,
		energy = ARMOR_ENERGY_MINOR-2,
		bio = ARMOR_BIO_MINOR-2,
		rad = ARMOR_RAD_MINOR,
		bomb = ARMOR_BOMB_MINOR-2
		)
	slot = ACCESSORY_SLOT_ARMOR_CHEST
	flags_inv = null

/obj/item/clothing/accessory/armor_plate/flak
	name = "medium flak plates"
	desc = "A plasteel-reinforced flak plate, providing enhanced protection against ballistic impacts and energy discharge."
	icon_state = "armor_medium"
	item_flags = ITEM_FLAG_THICKMATERIAL
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-30
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+300
	armor = list(
		melee = ARMOR_MELEE_FLAK,
		bullet = ARMOR_BALLISTIC_FLAK+1,
		laser = ARMOR_LASER_FLAK+1,
		energy = ARMOR_ENERGY_MINOR+1,
		bio = ARMOR_BIO_MINOR+5,
		rad = ARMOR_RAD_MINOR+10,
		bomb = ARMOR_BOMB_MINOR+2
		)
	slowdown = 0.06

/obj/item/clothing/accessory/armor_plate/flakheavy
	name = "heavy flak plates"
	desc = "A plasteel-reinforced flak plate, providing enhanced protection against ballistic impacts and energy discharge."
	icon_state = "armor_medium"
	item_flags = ITEM_FLAG_THICKMATERIAL
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-400
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+400
	armor = list(
		melee = ARMOR_MELEE_FLAK+1,
		bullet = ARMOR_BALLISTIC_FLAK+2,
		laser = ARMOR_LASER_FLAK+2,
		energy = ARMOR_ENERGY_MINOR+2,
		bio = ARMOR_BIO_MINOR+8,
		rad = ARMOR_RAD_MINOR+15,
		bomb = ARMOR_BOMB_MINOR+8
		)
	slowdown = 0.08

/obj/item/clothing/accessory/armor_plate/flaklamellar
	name = "lamellar flak plates"
	desc = "A plasteel-reinforced flak plate, providing enhanced protection against ballistic impacts and energy discharge."
	icon_state = "armor_medium"
	item_flags = ITEM_FLAG_THICKMATERIAL
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-45
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+450
	armor = list(
		melee = ARMOR_MELEE_FLAK,
		bullet = ARMOR_BALLISTIC_FLAK-1,
		laser = ARMOR_LASER_FLAK-1,
		energy = ARMOR_ENERGY_MINOR-1,
		bio = ARMOR_BIO_MINOR,
		rad = ARMOR_RAD_MINOR+5,
		bomb = ARMOR_BOMB_MINOR-2
	)
	slowdown = 0.04 // Lighter weight, allows for better mobility


/obj/item/clothing/accessory/armor_plate/carapace
	name = "carapace plates"
	desc = "A carapace plate reinforced with ablative coatings, designed to dissipate energy and deflect high-velocity rounds. Provides robust defense in high-risk environments."
	icon_state = "armor_tactical"
	item_flags = ITEM_FLAG_THICKMATERIAL
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-50
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+500
	armor = list(
		melee = ARMOR_MELEE_CARAPACE,
		bullet = ARMOR_BALLISTIC_CARAPACE+1,
		laser = ARMOR_LASER_CARAPACE+1,
		energy = ARMOR_ENERGY_MINOR+10,
		rad = ARMOR_RAD_MINOR+10,
		bio = ARMOR_BIO_MINOR,
		bomb = ARMOR_BOMB_PADDED-5
		)

	slowdown = 0.07

/obj/item/clothing/accessory/armor_plate/carapacemaster
	name = "masterwork carapace plates"
	desc = "A carapace plate reinforced with ablative coatings, designed to dissipate energy and deflect high-velocity rounds. Provides robust defense in high-risk environments."
	icon_state = "armor_tactical"
	item_flags = ITEM_FLAG_THICKMATERIAL
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-60
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+600
	armor = list(
		melee = ARMOR_MELEE_CARAPACE+1,
		bullet = ARMOR_BALLISTIC_CARAPACE+2,
		laser = ARMOR_LASER_CARAPACE+2,
		energy = ARMOR_ENERGY_MINOR+12,
		rad = ARMOR_RAD_MINOR+25,
		bio = ARMOR_BIO_MINOR+15,
		bomb = ARMOR_BOMB_PADDED+5
		)

	slowdown = 0.07

/obj/item/clothing/accessory/armor_plate/carapaceheavy
	name = "heavy carapace plates"
	desc = "Crafted with ceramic composites and advanced synthetic materials, this heavy carapace plate maximizes protection against ballistic and energy-based attacks."
	icon_state = "armor_merc"
	item_flags = ITEM_FLAG_THICKMATERIAL
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-65
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+650
	armor = list(
		melee = ARMOR_MELEE_CARAPACE+1,
		bullet = ARMOR_BALLISTIC_CARAPACE+2,
		laser = ARMOR_LASER_CARAPACE+2,
		energy = ARMOR_ENERGY_MINOR+12,
		rad = ARMOR_RAD_MINOR+20,
		bio = ARMOR_BIO_MINOR+10,
		bomb = ARMOR_BOMB_PADDED
		)
	slowdown = 0.09

/obj/item/clothing/accessory/armor_plate/padding
	name = "light padding"
	desc = "The lining of someone's clothes, it seems like they cut it out..."
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-20
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+200
	icon = 'icons/obj/clothing/obj_suit.dmi'
	icon_state = "helmcover_green"
	color = COLOR_BEASTY_BROWN
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	slowdown = 0.02
	armor = list(
		melee = ARMOR_MELEE_PRIMAL-1,
		bullet = ARMOR_BALLISTIC_PRIMAL,
		laser = ARMOR_LASER_PRIMAL,
		energy = ARMOR_ENERGY_MINOR-4,
		bio = ARMOR_BIO_MINOR-6,
		rad = ARMOR_RAD_MINOR,
		bomb = ARMOR_BOMB_MINOR-6
		)

/obj/item/clothing/accessory/armor_plate/paddingheavy
	name = "heavy padding"
	desc = "The heavy lining of someone's clothes, it seems like they cut it out..."
	icon = 'icons/obj/clothing/obj_suit.dmi'
	icon_state = "helmcover_green"
	color = COLOR_BEASTY_BROWN
	item_flags = ITEM_FLAG_THICKMATERIAL
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-35
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+350
	slowdown = 0.03
	armor = list(
		melee = ARMOR_MELEE_PRIMAL,
		bullet = ARMOR_BALLISTIC_PRIMAL+1,
		laser = ARMOR_LASER_PRIMAL+1,
		energy = ARMOR_ENERGY_MINOR-3,
		bio = ARMOR_BIO_MINOR,
		rad = ARMOR_RAD_MINOR+10,
		bomb = ARMOR_BOMB_MINOR-4
		)

/obj/item/clothing/accessory/armor_plate/paddingbio
	name = "special padding"
	desc = "A special hazard lining used in standard medicae kits, it's been cut out..."
	icon = 'icons/obj/clothing/obj_suit.dmi'
	icon_state = "helmcover_green"
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-40
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+400
	item_flags = ITEM_FLAG_THICKMATERIAL
	color = COLOR_BEASTY_BROWN
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	slowdown = 0.03
	armor = list(
		melee = ARMOR_MELEE_PRIMAL-1,
		bullet = ARMOR_BALLISTIC_PRIMAL,
		laser = ARMOR_LASER_PRIMAL,
		energy = ARMOR_ENERGY_MINOR,
		rad = ARMOR_RAD_RESISTANT,
		bio = ARMOR_BIO_RESISTANT,
		bomb = ARMOR_BOMB_MINOR-4
		)

/obj/item/clothing/accessory/armor_plate/paddingmech
	name = "hazard padding"
	desc = "A special tech hazard lining used primarily by the mechanicus, it's been cut out..."
	icon = 'icons/obj/clothing/obj_suit.dmi'
	icon_state = "helmcover_green"
	item_flags = ITEM_FLAG_THICKMATERIAL
	color = COLOR_BEASTY_BROWN
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-55
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+550
	slowdown = 0.05
	armor = list(
		melee = ARMOR_MELEE_PRIMAL,
		bullet = ARMOR_BALLISTIC_PRIMAL+1,
		laser = ARMOR_LASER_PRIMAL+1,
		energy = ARMOR_ENERGY_MINOR+4,
		rad = ARMOR_RAD_RESISTANT+35,
		bio = ARMOR_BIO_RESISTANT+35,
		bomb = ARMOR_BOMB_MINOR-2
		)

/obj/item/clothing/accessory/armor_plate/bodyglovebio
	name = "biohazard bodyglove"
	desc = "Composed of layered polymer fibers, attached to a uniform, this chemical bodyglove offers lightweight and flexible protection, suitable for menial mechanicus duties and light exploration."
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	siemens_coefficient = 0.1
	color = COLOR_DARK_GREEN_GRAY
	icon = 'icons/obj/clothing/uniforms.dmi'
	item_icons = list(slot_wear_suit_str = 'icons/mob/onmob/onmob_under.dmi')
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-10
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	item_flags = ITEM_FLAG_THICKMATERIAL
	slot_flags = SLOT_OCLOTHING //can wear in suit slot as well
	slot = ACCESSORY_SLOT_UTILITY // Worn alongside a carrier plate.
	w_class = ITEM_SIZE_NORMAL
	blood_overlay_type = "armor" // Bodygloves use base armor_plate temp protection.
	icon_state = "jensen_s"
	item_state = "jensen_s"
	slowdown = 0.03
	flags_inv = null
	armor = list(
		melee = 0,
		bullet = 0,
		laser = 0,
		energy = 4,
		rad = 15,
		bio = 15,
		bomb = 5
		)

/obj/item/clothing/accessory/armor_plate/bodyglovemech
	name = "mechanicus bodyglove"
	desc = "Composed of advanced tech polymer fibers, attached to a uniform, this carapace-mesh bodyglove offers lightweight and flexible protection, suitable for all mechanicus duties and exploration of death-worlds."
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	siemens_coefficient = 0.1
	color = COLOR_DARK_GREEN_GRAY
	icon = 'icons/obj/clothing/uniforms.dmi'
	item_icons = 'icons/mob/onmob/onmob_under.dmi'
	item_flags = ITEM_FLAG_THICKMATERIAL
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-40
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+50
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	slot_flags = SLOT_OCLOTHING //can wear in suit slot as well
	slot = ACCESSORY_SLOT_UTILITY // Worn alongside a carrier plate.
	w_class = ITEM_SIZE_NORMAL
	blood_overlay_type = "armor"
	icon_state = "jensen_s"
	item_state = "jensen_s"
	slowdown = 0.04
	flags_inv = null
	armor = list(
		melee = 0,
		bullet = 1,
		laser = 1,
		energy = 8,
		rad = 20,
		bio = 20,
		bomb = 10
		)

/obj/item/clothing/accessory/armor_plate/bodyglove
	name = "low-profile bodyglove"
	desc = "Composed of layered polymer fibers, attached to a uniform, this low-profile bodyglove offers lightweight and flexible protection, suitable for minimizing bulk without sacrificing defense."
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-10
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	siemens_coefficient = 0.1
	icon = 'icons/obj/clothing/uniforms.dmi'
	item_icons = 'icons/mob/onmob/onmob_under.dmi'
	slot_flags = SLOT_OCLOTHING
	slot = ACCESSORY_SLOT_UTILITY // Worn alongside a carrier plate.
	w_class = ITEM_SIZE_NORMAL
	blood_overlay_type = "armor"
	icon_state = "jensen_s"
	item_state = "jensen_s"
	slowdown = 0.03 // Almost the same as Mech but lighter and offers no decent bio/rad prot.
	flags_inv = null
	armor = list(
		melee = 0,
		bullet = 1,
		laser = 1,
		energy = 2,
		bio = 5,
		rad = 5,
		bomb = 5
		)

/obj/item/clothing/accessory/armor_plate/bodyglove2
	name = "low-profile bodyglove"
	desc = "Made from tech polymers, attached to a uniform, this experimental bodyglove balances flexibility with advanced defensive capabilities, providing enhanced protection at the cost of more cumbersome movement."
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-30
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+40
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	icon = 'icons/obj/clothing/uniforms.dmi'
	item_icons = list(slot_wear_suit_str = 'icons/mob/onmob/onmob_under.dmi')
	item_flags = ITEM_FLAG_THICKMATERIAL
	slot_flags = SLOT_OCLOTHING
	slot = ACCESSORY_SLOT_UTILITY // Attaches to uniform or can be worn as exosuit.
	w_class = ITEM_SIZE_NORMAL
	blood_overlay_type = "armor"
	icon_state = "robotics"
	item_state = "robotics_s"
	slowdown = 0.07 // This item is super OP if stacked with power armor. It can be the difference between a lasgun critting you or just causing an injury.
	flags_inv = null
	armor = list(
		melee = 1,
		bullet = 2,
		laser = 2,
		energy = 4,
		bio = 5,
		rad = 5,
		bomb = 5
		)

/obj/item/clothing/accessory/armor_plate/bodyglovecatachan
	name = "catachan under armor"
	desc = "Made from tech polymers, attached to a uniform, this death world variant balances energy protection with advanced bio defense systems, though it is vulnerable to primitive firearms and melee attacks, it's users rarely have to worry about losing when it comes to glorious melee."
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS // SLEEVES ARE BULLSHIT
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE-40
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE+50
	cold_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS // deathworlders ignore weather.
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	icon = 'icons/obj/clothing/uniforms.dmi'
	item_icons = list(slot_wear_suit_str = 'icons/mob/onmob/onmob_under.dmi')
	item_flags = ITEM_FLAG_THICKMATERIAL
	slot_flags = SLOT_OCLOTHING
	slot = ACCESSORY_SLOT_UTILITY // Attaches to uniform or can be worn as exosuit.
	w_class = ITEM_SIZE_NORMAL
	blood_overlay_type = "armor"
	icon_state = "catacomm" // Bulletproof pants and shirt.
	item_state = "catacomm_s"
	slowdown = 0.05 // better bodyglove since it doesn't protect arms and offers no melee protection. Catachan design since their weakness is only ranged fighting and rad/bio.
	flags_inv = null
	armor = list(
		melee = 0,
		bullet = 2,
		laser = 2,
		energy = 4,
		bio = 15,
		rad = 15,
		bomb = 15
		)
