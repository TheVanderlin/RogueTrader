/obj/structure/statue
	name = "Stone Statue"
	desc = "A carved stone depecting a person, place or thing that held some importance to the maker. Also tell an admin you see this"
	anchored = 1
	density = 1
	layer = 4
	health_max = 1200


/obj/structure/statue/proc/rotater()
	set name = "Rotate statue Counter-Clockwise"
	set category = "Object"
	set src in oview(1)

	if(usr.incapacitated())
		return 0

	if(anchored)
		usr << "It is fastened to the floor therefore you can't rotate it!"
		return 0

	set_dir(turn(dir, 90))
	update_icon()
	return

/obj/structure/statue/verb/revrotate()
	set name = "Rotate Statue Clockwise"
	set category = "Object"
	set src in oview(1)

	if(usr.incapacitated())
		return 0

	if(anchored)
		usr << "It is fastened to the floor therefore you can't rotate it!"
		return 0

	set_dir(turn(dir, -90))
	update_icon()
	return


/obj/structure/statue/verina
	name = "statue"
	desc = "A statue of some ominous looking, robed, figure. There's barely a scratch on it."
	icon = 'icons/obj/64x64.dmi'
	icon_state = "statue"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 64

/obj/structure/statue/verina/broken
	name = "broken statue"
	desc = "A statue of some ominous looking, robed, figure. It's badly damaged."
	icon_state = "statue_broken"


/obj/structure/statue/aquilla
	name = "aquila altar"
	desc = "A glorious Nuln wood altar displaying a golden Aquila."
	icon = 'icons/obj/structures/aquilla.dmi'
	icon_state = "aquilla"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 64

/obj/structure/statue/bigstatue
	name = "big statue"
	desc = "A strange object of stone and malice."
	icon = 'icons/obj/structures/bigstatues.dmi'
	icon_state = "statue_b"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 64

/obj/structure/statue/bigstatue2
	name = "big statue"
	desc = "A strange object of stone and malice."
	icon = 'icons/obj/structures/bigstatues.dmi'
	icon_state = "statue_j"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 64

/obj/structure/statue/bigstatue3
	name = "big statue"
	desc = "A strange object of stone and malice."
	icon = 'icons/obj/structures/bigstatues.dmi'
	icon_state = "statue_rahl"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 64

/obj/structure/statue/prayer
	name = "prayer statue"
	desc = "A strange prayer statue."
	icon = 'icons/obj/structures/prayer.dmi'
	icon_state = "prophet_prayer"
	anchored = 1
	density = 1
	layer = 4

/obj/structure/statue/fountain
	name = "fountain"
	desc = "A glorious stone fountain."
	icon = 'icons/obj/structures/fountain.dmi'
	icon_state = "dark_fountain"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 96

/obj/structure/statue/column
	name = "column"
	desc = "A column carved from stone."
	icon = 'icons/obj/structures/mining.dmi'
	icon_state = "column2"
	anchored = 1
	density = 1
	layer = 4

/obj/structure/statue/column3
	name = "column"
	desc = "A column carved from stone."
	icon = 'icons/obj/structures/mining.dmi'
	icon_state = "column3"
	anchored = 1
	density = 1
	layer = 4

/obj/structure/statue/xenotube
	name = "xeno containment tube"
	desc = "An Inquisition containment tube housing some sort of horrific xenos for study."
	icon = 'icons/obj/structures/xenotube.dmi'
	icon_state = "xenotube"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 64

/obj/structure/statue/xenotube/off
	icon_state = "xenotube-off"

/obj/structure/statue/cage
	name = "hanging cage"
	desc = "A hanging cage used to torment heretics."
	icon = 'icons/obj/structures/cage.dmi'
	icon_state = "cage"
	anchored = 1
	density = 1
	layer = 4

/obj/structure/statue/gallows
	name = "gallows"
	desc = "Where filth is disposed of."
	icon = 'icons/obj/structures/gallows2.dmi'
	icon_state = "gallows"
	anchored = 1
	density = 1
	layer = 4

/obj/structure/statue/guardshrine
	name = "\improper shrine of the unknown guardsmen"
	desc = "A shrine commemorating the untold millions who lay down their lives everyday for the Imperium."
	icon = 'icons/obj/64x64.dmi'
	icon_state = "statue_guardsmen"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 64

/obj/structure/statue/aphroditestatue1
	name = "sultry statue"
	desc = "A statue of a half-nude woman."
	icon = 'icons/obj/96x96.dmi'
	icon_state = "aphrodite"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 64

/obj/structure/statue/aphroditestatue2
	name = "sultry statue"
	desc = "A statue of a half-nude woman."
	icon = 'icons/obj/96x96.dmi'
	icon_state = "aphrodite2"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 64

/obj/structure/statue/aphroditestatue3
	name = "sultry statue"
	desc = "A statue of a half-nude woman."
	icon = 'icons/obj/96x96.dmi'
	icon_state = "aphrodite3"
	anchored = 1
	density = 1
	layer = 4
	bound_width = 64

/obj/structure/hivedecor
	name = "Statue"
	desc = "A towering statue that just makes you feel more scared the more you gaze at it..Who the hell built these ?"
	icon = 'icons/map_project/spookystatues.dmi'
	icon_state = "angel_cool"
	anchored = 1
	density = 1
	health_max = 800

/obj/structure/hivedecor/oldclock
	name = "Old Clock"
	desc = "An old yet pristine pendulum clock, it's still working."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "pclock"

/obj/structure/hivedecor/bookcase
	name = "Bookcase"
	desc = "An small antique bookcase full of books The sheer amount makes you not want to even bother taking one."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "bookcase_small"

/obj/structure/hivedecor/bookcase/huge
	name = "Bookcase"
	desc = "An antique bookcase full of books The sheer amount makes you not want to even bother taking one."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "bookcase_huge"

/obj/structure/hivedecor/statue1
	name = "Statue"
	desc = "A towering statue that just makes you feel more scared the more you gaze at it..Who the hell built these ?"
	icon = 'icons/map_project/spookystatues.dmi'
	icon_state = "openhelmet_guy"

/obj/structure/hivedecor/statue2
	name = "Statue"
	desc = "A towering statue that just makes you feel more scared the more you gaze at it..Who the hell built these ?"
	icon = 'icons/map_project/spookystatues.dmi'
	icon_state = "creepy"

/obj/structure/hivedecor/statue3
	name = "Statue"
	desc = "A towering statue that just makes you feel more scared the more you gaze at it..Who the hell built these ?"
	icon = 'icons/map_project/spookystatues.dmi'
	icon_state = "AngelRight"

/obj/structure/hivedecor/statue4
	name = "Statue"
	desc = "A towering statue that just makes you feel more scared the more you gaze at it..Who the hell built these ?"
	icon = 'icons/map_project/spookystatues.dmi'
	icon_state = "AngelLeft"

/obj/structure/hivedecor/statue5
	name = "Statue"
	desc = "A towering statue that just makes you feel more scared the more you gaze at it..Who the hell built these ?"
	icon = 'icons/map_project/spookystatues.dmi'
	icon_state = "pilar1"

/obj/structure/hivedecor/statue6
	name = "Statue"
	desc = "A towering statue that just makes you feel more scared the more you gaze at it..Who the hell built these ?"
	icon = 'icons/map_project/spookystatues.dmi'
	icon_state = "pilar2"

/obj/structure/hivedecor/statue7
	name = "Man statue"
	desc = "An statue of some sort of man."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "statue6"

/obj/structure/hivedecor/statue8
	name = "Angel Statue"
	desc = "A statue of an angel holding a large sword."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "angel2"

/obj/structure/hivedecor/sarcofagus
	name = "Old sarcofagus"
	desc = "An old sarcofagus, who knows who's inside even."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "sarcofagus"

/obj/structure/hivedecor/sarcofagus2
	name = "Old sarcofagus"
	desc = "An old sarcofagus crafted to fit certain individuals, possibly rich nobles, who knows who's inside even."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "scustom"

/obj/structure/hivedecor/anvil
	name = "Anvil"
	desc = "A nice, heavy and strong anvil to perform metalworking works on it, shame it's missing the tools."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "anvil"

/obj/structure/hivedecor/forge
	name = "Stone forge"
	desc = "An stone forge, sadly it requires tongs to work. It does make you want to make a dozen iron daggers to become an skilled weaponsmith."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "smelter1"

/obj/structure/hivedecor/grindingstone
	name = "Grinding Stone"
	desc = "A key structure to mantain your sharp blades to pierce and cut better."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "grinding"

/obj/structure/hivedecor/skulls
	name = "Skull Pillar"
	desc = "A pillar made out of skulls, spooky."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "skullpillar"

/obj/structure/hivedecor/defender_statue
	name = "Statue of the Defender"
	desc = "An statue of Baron Guimer on his armor, whom single handedly slain 34 hungry heretical pilgrims who tried to enter into the manor's food storage during the great drought on Elipharius with his trusty power sword, truly a tale of heroism."
	icon = 'icons/map_project/spookystatues.dmi'
	icon_state = "defender"

/obj/structure/hivedecor/artillery // It's gonna be decoration until someone decides to port the Lebensraum artillery system or something like it - Graf
	name = "Earthshaker Cannon"
	desc = "An older and more portable model of the Earthshaker Cannon, intended to work as heavy artillery equipment, although this one seems to be missing certain vital components."
	icon = 'icons/obj/cannon.dmi'
	icon_state = "modern_cannon"
	density = 1
	atom_flags = ATOM_FLAG_CLIMBABLE
	anchored = 0

/obj/structure/hivedecor/lasplacement // Decoration too, dont ask me to code it
	name = "Heavy Lasgun Turret"
	desc = "When you want something dead and to defend a position, the guard uses these, unfortunately, this one seems to be missing the ammo..And getting a handful of ammo from this older model is going to be a nightmare in logistic terms."
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "lasgun_emplacement"
	anchored = 0

/obj/item/fluff_items/artyshell
	name = "Earthshaker round"
	desc = "A massive round for an Earthshaker Cannon, it could possibly turn an heretical space marine into red mist if just being near the explosion."
	icon = 'icons/obj/cannon_ball.dmi'
	icon_state = "shellHE"
	w_class = ITEM_SIZE_HUGE

/obj/structure/hivedecor/reactor
	name = "Dark Age Ship Reactor"
	desc = "A large reactor that was once used to power the ships that were once used to colonize distant planets for the Imperium, this one has been mantained by the Mechanicus and constantly produces enough power 24/7 to power most of the planet structures and buildings."
	icon = 'icons/map_project/reactor.dmi'
	icon_state = "reactor_on"

// Fluff & Misc Items

/obj/item/fluff_items // These do absolutely nothing, just some artifacts that could be sold and the like, aswell as to decorate, mainly references.
	name = "strange stone slab"
	desc = "An stone slab recovered during an exploration on the planet of Kronus, how it arrived here is unknown."
	icon = 'icons/map_project/fluff_items.dmi'
	icon_state = "necronstuff"
	w_class = ITEM_SIZE_SMALL
	sales_price = 15

/obj/item/fluff_items/paperwork
	name = "unholy pile of paperwork"
	desc = "A pile of papers, no wonder why the Imperium cannot send supplies that quick."
	icon_state = "paperwork"
	w_class = ITEM_SIZE_HUGE
	sales_price = 1

/obj/item/fluff_items/jojo
	name = "stone mask"
	desc = "An strange stone mask, the surface has been cracked and it still smells of iron, it does feel somewhat familiar."
	icon_state = "stone"
	w_class = ITEM_SIZE_SMALL
	sales_price = 10

/obj/item/fluff_items/bfg
	name = "A big fucking gun."
	desc = "An unknown weapon that does not seem from anywhere in this existance, rumours say that it was recovered from the Immaterium and was carried by a guardsmen all dressed in green which slaughtered demons with his bare hands."
	icon_state = "BFG"
	w_class = ITEM_SIZE_HUGE
	sales_price = 10 // RIP AND TEAAAAAR

/obj/item/fluff_items/atlantis
	name = "strange rock"
	desc = "A rock which has been made by some unknown alloy, there's tales of an old myth of a civilization in Terra that was called 'Atlantis' that had structures like that, but what are the odds it's true ?"
	icon_state = "wtf2"
	w_class = ITEM_SIZE_HUGE
	sales_price = 10

/obj/item/fluff_items/alien_blaster
	name = "strange pistol"
	desc = "It seems to be some sort of lasgun but with an smaller size, sadly it's got no ammo and whatever powered the weapon is long gone."
	icon_state = "egun6"
	w_class = ITEM_SIZE_SMALL
	sales_price = 22

/obj/item/fluff_items/redalert
	name = "old flask"
	desc = "An old flask created back on Terra, the number '1927', alongside the name of 'Anatoly Cherdenko' written on there."
	icon_state = "anatoly_cherdenko"
	w_class = ITEM_SIZE_SMALL
	sales_price = 13

/obj/item/fluff_items/gramophone
	name = "old gramophone"
	desc = "A very old gramophone, it seems to be still working but without a vinyl it's useless."
	icon_state = "gramophone"
	w_class = ITEM_SIZE_SMALL
	sales_price = 11

/obj/item/fluff_items/goldsword
	name = "golden sword"
	desc = "A gold sword that was used by a previous governor to slay an important cultist leader on Elipharius 150 years ago."
	icon_state = "gold_sword"
	w_class = ITEM_SIZE_SMALL
	sales_price = 45

/obj/item/fluff_items/ultrabanner
	name = "ultramarine banner"
	desc = "An actual real banner from an Ultramarine company, legends say the wearer will never fall and neither the banner will and that it has powers."
	icon_state = "umbanner"
	w_class = ITEM_SIZE_SMALL
	sales_price = 25

/obj/item/fluff_items/power_bat
	name = "deactivated power bat"
	desc = "Sacraors say that there's a group of a chapter called the 'Angry marines', they supposedly use stools, tables, folding chairs and the like to bash to death the enemies of the emperor, how this arrived here is uncertain."
	icon_state = "powerbat"
	w_class = ITEM_SIZE_SMALL
	sales_price = 35

/obj/item/fluff_items/vietnam
	name = "ancient helmet"
	desc = "This helmet shows an extensive amount of wear, let alone the amount of marks of bullets that hit the wearer several times, suprisingly with no holes, there's even some old cig pack attached to it, you can see written on the side of the helmet 'WAR IS A FUCK'."
	icon_state = "vietnamordinator"
	w_class = ITEM_SIZE_SMALL
	sales_price = 8

/obj/item/fluff_items/spessmanhelm
	name = "space helmet"
	desc = "Something that is as old as the start of Terra, apparently these helmets were used back when mankind reached for the stars."
	icon_state = "space"
	w_class = ITEM_SIZE_SMALL
	sales_price = 15

/obj/item/fluff_items/bonehelm
	name = "animal skull helmet"
	desc = "This helmet was made with the head of an old creature from Terra."
	icon_state = "chariot"
	w_class = ITEM_SIZE_SMALL
	sales_price = 16

/obj/item/fluff_items/goldmask
	name = "golden mask"
	desc = "A mask made out of pure gold, whoever created this was either a legendary craftsman or knew their trade very well."
	icon_state = "goldmask2_icon"
	w_class = ITEM_SIZE_SMALL
	sales_price = 55

/obj/item/fluff_items/silvermask
	name = "silver mask"
	desc = "A mask made out of silver, its still as shining as it was back when it was crafted."
	icon_state = "nsilvermask_icon"
	w_class = ITEM_SIZE_SMALL
	sales_price = 35

/obj/item/fluff_items/skull
	name = "skull"
	desc = "A very old skull, who knows how long it's been there."
	icon_state = "skull"
	w_class = ITEM_SIZE_SMALL
	sales_price = 1


/obj/structure/hivedecor/scrapper
	name = "recycler"
	desc = "Some kind of recycling maching"
	icon = 'icons/map_project/furniture_and_decor.dmi'
	icon_state = "recycler"

/obj/structure/hivedecor/watertreatment
	name = "water treatement equipment"
	desc = "Uh oh! Stinky!"
	icon = 'icons/obj/32x64.dmi'
	icon_state = "water"

/obj/structure/hivedecor/watertreatment2
	name = "water treatement equipment"
	desc = "Uh oh! Stinky!"
	icon = 'icons/obj/32x64.dmi'
	icon_state = "dity"

/obj/structure/hivedecor/watertreatment3
	name = "water treatement equipment"
	desc = "Uh oh! Stinky!"
	icon = 'icons/obj/32x64.dmi'
	icon_state = "empty"

/obj/structure/hivedecor/watertreatment5
	name = "water treatement equipment"
	desc = "Uh oh! Stinky!"
	icon = 'icons/obj/96x96.dmi'
	icon_state = "filtration2"

/obj/structure/hivedecor/watertreatment6
	name = "water treatement equipment"
	desc = "Uh oh! Stinky!"
	icon = 'icons/obj/96x96.dmi'
	icon_state = "disinfection"

// This is not very good code and could use cleanup and optimization, but
// I am very tired and will probably forget in the morning. C'est la vie. ~Z

/obj/item/torch
	icon = 'icons/obj/torches.dmi'
	icon_state = "torch0"
	item_state = "torch0"
	name = "Torch"
	desc = "In radiance may we find victory."
	var/lit = FALSE
	var/self_lighting = 0

/obj/item/torch/self_lit
	name = "Self-igniting Torch"
	desc = "In radiance may we find victory. This torch provides its own."
	self_lighting = 1

/obj/item/torch/Initialize()
	. = ..()
	update_icon()

/obj/item/torch/update_icon()
	..()
	overlays = overlays.Cut()
	if(lit)
		icon_state = "torch1"
		item_state = "torch1"
		set_light(5, 4, "#E38F46")
	else
		icon_state = "torch0"
		item_state = "torch0"
		set_light(0,0)
		if(self_lighting == 1)
			overlays += overlay_image(icon, "lighter")
	update_held_icon()

/obj/item/torch/Process()
	..()
	var/datum/gas_mixture/mixture = src.loc.return_air()
	if(submerged()) // Check if the torch is submerged
		snuff()
		return
	if(mixture)
		var/pressure = mixture.return_pressure()
		if(pressure < 16) // Adjust threshold as necessary
			snuff()
			return
	if(prob(1)) //Needs playtesting. This seems a little high.
		if(istype(src.loc, /obj/structure/torchwall))
			return //Please don't put out torches that are on the walls.
		visible_message("The torch flickers in the wind.")
		if(prob(30))
			snuff()

/obj/item/torch/proc/light(mob/user, manually_lit = FALSE)
	lit = TRUE
	if(manually_lit && self_lighting == 1)
		user.visible_message("<span class='notice'>\The [user] rips the lighting sheath off their [src].</span>")
	update_icon()
	START_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_light.ogg', 50, 1)


/obj/item/torch/proc/snuff()
	lit = FALSE
	update_icon()
	STOP_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_snuff.ogg', 50, 1)


/obj/item/torch/attack_self(mob/user)
	..()
	if(self_lighting == 1)
		light(user, TRUE)
		self_lighting = -1
		return
	if(lit)
		snuff()


/obj/item/torch/IsFlameSource()
	return lit

/obj/item/torch/use_tool(obj/item/W, mob/user, list/click_params)
	..()
	if(isflamesource(W))
		light(user, TRUE)
	else
		return

/obj/structure/torchwall
	name = "torch fixture"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "torchwall0"
	desc = "A torch fixture."
	anchored = TRUE
	layer = ABOVE_DOOR_LAYER

	var/obj/item/torch/lighttorch

/obj/structure/torchwall/Initialize()
	. = ..()
	if(prob(98))
		lighttorch = new /obj/item/torch(src)
		if(prob(75))
			lighttorch.light(null, FALSE)
		lighttorch.update_icon()
	update_icon()

/obj/structure/torchwall/Destroy()
	QDEL_NULL(lighttorch)
	return ..()


/obj/structure/torchwall/update_icon()
	..()
	if(lighttorch)
		if(lighttorch.lit)
			icon_state = "torchwall1"
			set_light(5, 4,"#E38F46")

		else
			icon_state = "torchwall0"
			set_light(0,0)
	else
		icon_state = "torchwall"
		set_light(0,0)


/obj/structure/torchwall/proc/insert_torch(obj/item/torch/T)
	if(!istype(T, /obj/item/torch)) // Ensure only torches can be inserted
		return
	T.forceMove(src)
	lighttorch = T
	update_icon()
	playsound(src, 'sound/items/torch_fixture1.ogg', 50, 0, -1)

/obj/structure/torchwall/attack_hand(mob/living/user)
	if(lighttorch) // Check if there's a torch in the fixture
		var/obj/item/torch/T = lighttorch
		lighttorch = null // Clear the fixture's reference
		if(user.put_in_active_hand(T)) // Attempt to put the torch into the user's hand
			to_chat(user, "You take the torch from the fixture.")
		else
			to_chat(user, "Your hands are full! The torch drops to the ground.")
			T.loc = user.loc // Drop the torch at the user's location
		T.update_icon() // Sync the torch's icon state
		T.set_light(T.lit ? 4 : 0, T.lit ? 5 : 0, "#E38F46")
		update_icon()
		playsound(src, 'sound/items/torch_fixture0.ogg', 50, 0, -1)
		return TRUE

	to_chat(user, "There is no torch here to take.")
	return ..()

/obj/structure/torchwall/proc/remove_torch()
	if(!lighttorch) // Ensure there's a torch to remove
		return
	var/obj/item/torch/T = lighttorch
	lighttorch = null
	T.loc = loc // Drop the torch at the torchwall's location
	T.update_icon()
	update_icon()
	playsound(src, 'sound/items/torch_fixture0.ogg', 50, 0, -1)
	return T

/obj/structure/torchwall/use_tool(obj/item/tool, mob/user, list/click_params)
	var/obj/item/torch/W

	if(istype(tool, /obj/item/torch)) // If the tool is a torch
		W = tool
		if(lighttorch) // Prevent inserting a second torch if one already exists
			to_chat(user, "There is already a torch in the fixture.")
			return
		if(user.unEquip(W)) // Remove the torch from the user's hand or inventory
			insert_torch(W)
			to_chat(user, "You place the torch into the fixture.")
		else
			to_chat(user, "You can't seem to place the torch.")
		return

	// Handle lighting the torch if it's unlit and there's a valid flame source
	if(lighttorch && !lighttorch.lit)
		if(isFlameOrHeatSource(tool)) // Check if the tool is a valid flame source
			lighttorch.light()
			update_icon()
			to_chat(user, "You light the torch in the fixture.")
			return

	return ..()

//Pyres
/obj/item/pyre
	icon = 'icons/obj/structures/fireplace.dmi'
	icon_state = "fireplacestand"
	item_state = "fireplacestand"
	name = "Pyre"
	desc = "In radiance may we find victory."
	anchored = 1
	density = 1
	var/lit = FALSE
	var/self_lighting = 0

/obj/item/pyre/self_lit
	name = "Pyre"
	desc = "In radiance may we find victory. This pyre provides its own."
	self_lighting = 1
	anchored = 1
	lit = 1
	density = 1

/obj/item/pyre/Initialize()
	. = ..()
	update_icon()

/obj/item/pyre/update_icon()
	..()
	overlays = overlays.Cut()
	if(lit)
		icon_state = "fireplacestand_f"
		item_state = "fireplacestand_f"
		set_light(5, 4, "#E38F46")
	else
		icon_state = "fireplacestand"
		item_state = "fireplacestand"
		set_light(0,0)
		if(self_lighting == 1)
			overlays += overlay_image(icon, "lighter")
	update_held_icon()

/obj/item/pyre/proc/light(mob/user, manually_lit = FALSE)//This doesn't seem to update the icon appropiately, not idea why.
	lit = TRUE
	if(manually_lit && self_lighting == 1)
		user.visible_message("<span class='notice'>\The [user] rips the lighting sheath off their [src].</span>")
	update_icon()
	START_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_light.ogg', 50, 0, -1)

/obj/item/pyre/proc/snuff()
	lit = FALSE
	update_icon()
	STOP_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_snuff.ogg', 50, 0, -1)


/obj/item/pyre/attack_self(mob/user)
	..()
	if(self_lighting == 1)
		light(user, TRUE)
		self_lighting = -1
		return
	if(lit)
		snuff()

/obj/item/pyre/use_tool(obj/item/W, mob/user, list/click_params)
	..()
	if(isflamesource(W))
		light()

/obj/structure/fireplacebl
	icon = 'icons/obj/structures/fireplacebig.dmi'
	icon_state = "fireplace"
	name = "fireplace"
	desc = "In radiance may we find victory."
	anchored = 1
	density = 1
	var/lit = FALSE
	var/self_lighting = 0
	lit = 1
	bound_width = 64

/obj/item/pyre/Initialize()
	. = ..()
	update_icon()

/obj/structure/fireplacebl/proc/light(mob/user, manually_lit = FALSE)//This doesn't seem to update the icon appropiately, no idea why.
	lit = TRUE
	if(manually_lit && self_lighting == 1)
		user.visible_message("<span class='notice'>\The [user] rips the lighting sheath off their [src].</span>")
	update_icon()
	START_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_light.ogg', 50, 0, -1)

/obj/structure/fireplacebl/update_icon()
	..()
	overlays = overlays.Cut()
	if(lit)
		icon_state = "fire_bl"
		set_light(5, 5, "#E38F46")
	else
		icon_state = "fire_bl"
		set_light(0,0)
		if(self_lighting == 1)
			overlays += overlay_image(icon, "lighter")

/obj/structure/fireplacebl/proc/snuff()
	lit = FALSE
	update_icon()
	STOP_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_snuff.ogg', 50, 0, -1)

/obj/structure/fireplacebl/use_tool(obj/item/W, mob/user, list/click_params)
	..()
	if(isflamesource(W))
		light()

/obj/item/pyre/self_lit/church // Pyre specially for the catacombs since it looks nicer than the standard one
	name = "Pyre"
	icon = 'icons/map_project/fluff_items.dmi'
	icon_state = "pyreplace1"
	item_state = "pyreplace1"

/obj/item/pyre/self_lit/church/update_icon()
	..()
	overlays = overlays.Cut()
	if(lit)
		icon_state = "pyreplace1"
		item_state = "pyreplace1"
		set_light(5, 4, "#E38F46")
	else
		icon_state = "pyreplace0"
		item_state = "pyreplace0"
		set_light(0,0)
		if(self_lighting == 1)
			overlays += overlay_image(icon, "lighter")
	update_held_icon()

/obj/item/campfire
	icon = 'icons/obj/firepit.dmi'
	icon_state = "cauldron0"
	item_state = "cauldron0"
	name = "Camp Fire"
	desc = "In radiance may we find victory."
	anchored = 1
	density = 1
	var/lit = FALSE
	var/self_lighting = 0
	var/destroyed = 0

/obj/item/campfire/self_lit
	name = "Self-igniting Pyre"
	desc = "In radiance may we find victory. This pyre provides its own."
	self_lighting = 1
	anchored = 1
	lit = 0
	density = 1

/obj/item/campfire/Initialize()
	. = ..()
	update_icon()

/obj/item/campfire/update_icon()
	..()
	overlays = overlays.Cut()
	if(lit)
		icon_state = "cauldron1"
		item_state = "cauldron1"
		set_light(5, 4, "#E38F46")
	else
		icon_state = "cauldron0"
		item_state = "cauldron0"
		set_light(0,0)
		if(self_lighting == 1)
			overlays += overlay_image(icon, "lighter")
	update_held_icon()


/obj/item/campfire/proc/light(mob/user, manually_lit = FALSE)//This doesn't seem to update the icon appropiately, not idea why.
	lit = TRUE
	if(manually_lit && self_lighting == 1)
		user.visible_message("<span class='notice'>\The [user] rips the lighting sheath off their [src].</span>")
	update_icon()
	START_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_light.ogg', 50, 0, -1)


/obj/item/campfire/proc/snuff()
	lit = FALSE
	update_icon()
	STOP_PROCESSING(SSprocessing, src)
	playsound(src, 'sound/items/torch_snuff.ogg', 50, 0, -1)


/obj/item/campfire/attack_self(mob/user)
	..()
	if(self_lighting == 1)
		light(user, TRUE)
		self_lighting = -1
		return
	if(lit)
		snuff()

/obj/item/campfire/use_tool(obj/item/W, mob/user, list/click_params)
	..()
	if(isflamesource(W))
		light()
