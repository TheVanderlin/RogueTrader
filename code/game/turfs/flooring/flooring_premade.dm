// simulated/floor is currently plating by default, but there really should be an explicit plating type.
/turf/simulated/floor/plating
	name = "plating"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "plating"
	layer = PLATING_LAYER

/turf/simulated/floor/bluegrid
	name = "mainframe floor"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_state = "bcircuit"
	initial_flooring = /singleton/flooring/reinforced/circuit
	light_range = 2
	light_power = 1
	light_color = COLOR_BLUE

/turf/simulated/floor/greengrid
	name = "mainframe floor"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_state = "gcircuit"
	initial_flooring = /singleton/flooring/reinforced/circuit/green
	light_range = 2
	light_power = 3
	light_color = COLOR_GREEN

/turf/simulated/floor/redgrid
	name = "mainframe floor"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_state = "rcircuit"
	initial_flooring = /singleton/flooring/reinforced/circuit/red
	light_range = 2
	light_power = 2
	light_color = COLOR_RED

/turf/simulated/floor/selfestructgrid
	name = "self-destruct mainframe floor"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_state = "rcircuit_off"
	initial_flooring = /singleton/flooring/reinforced/circuit/selfdestruct
	light_range = 2
	light_power = 2
	light_color = COLOR_BLACK

/turf/simulated/floor/grass
	name = "grass patch"
	icon = 'icons/turf/flooring/grass.dmi'
	icon_state = "grass0"
	initial_flooring = /singleton/flooring/grass

/turf/simulated/floor/grass/use_tool(obj/item/I, mob/user)
	if(I.IsWirecutter())
		user.visible_message(SPAN_NOTICE("\The [user] trims \the [src] with \the [I]."), SPAN_NOTICE("You trim \the [src] with \the [I]."))
		ChangeTurf(/turf/simulated/floor/grass/cut)
		return TRUE
	return ..()

/turf/simulated/floor/grass/cut
	initial_flooring = /singleton/flooring/grass/cut

/turf/simulated/floor/reinforced
	name = "reinforced floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "reinforced"
	initial_flooring = /singleton/flooring/reinforced

/turf/simulated/floor/reinforced/airmix
	initial_gas = list(GAS_OXYGEN = MOLES_O2ATMOS, GAS_NITROGEN = MOLES_N2ATMOS)

/turf/simulated/floor/reinforced/nitrogen
	initial_gas = list(GAS_NITROGEN = ATMOSTANK_NITROGEN)

/turf/simulated/floor/reinforced/hydrogen
	initial_gas = list(GAS_HYDROGEN = ATMOSTANK_HYDROGEN)

/turf/simulated/floor/reinforced/oxygen
	initial_gas = list(GAS_OXYGEN = ATMOSTANK_OXYGEN)

/turf/simulated/floor/reinforced/phoron
	initial_gas = list(GAS_PHORON = ATMOSTANK_PHORON)

/turf/simulated/floor/reinforced/nitrogen/engine
	name = "engine floor"
	initial_gas = list(GAS_NITROGEN = MOLES_N2STANDARD)

/turf/simulated/floor/reinforced/phoron/fuel
	initial_gas = list(GAS_PHORON = ATMOSTANK_PHORON_FUEL)

/turf/simulated/floor/reinforced/hydrogen/fuel
	initial_gas = list(GAS_HYDROGEN = ATMOSTANK_HYDROGEN_FUEL)

/turf/simulated/floor/reinforced/carbon_dioxide
	initial_gas = list(GAS_CO2 = ATMOSTANK_CO2)

/turf/simulated/floor/reinforced/n20
	initial_gas = list(GAS_N2O = ATMOSTANK_NITROUSOXIDE)


/turf/simulated/floor/cult
	name = "engraved floor"
	icon = 'icons/turf/flooring/cult.dmi'
	icon_state = "cult"
	initial_flooring = /singleton/flooring/reinforced/cult

/turf/simulated/floor/cult/cultify()
	return

//Tiled floor + sub-types

/turf/simulated/floor/tiled
	name = "steel floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "steel"
	initial_flooring = /singleton/flooring/tiling

/turf/simulated/floor/tiled/dark
	name = "dark floor"
	icon_state = "dark"
	initial_flooring = /singleton/flooring/tiling/dark

/turf/simulated/floor/tiled/dark/monotile
	name = "floor"
	icon_state = "monotiledark"
	initial_flooring = /singleton/flooring/tiling/mono/dark

/turf/simulated/floor/tiled/white
	name = "white floor"
	icon_state = "white"
	initial_flooring = /singleton/flooring/tiling/white

/turf/simulated/floor/tiled/white/monotile
	name = "floor"
	icon_state = "monotile_light"
	initial_flooring = /singleton/flooring/tiling/mono/white

/turf/simulated/floor/tiled/monofloor
	name = "floor"
	icon_state = "steel_monofloor"
	initial_flooring = /singleton/flooring/tiling/mono

/turf/simulated/floor/tiled/freezer
	name = "tiles"
	icon_state = "freezer"
	initial_flooring = /singleton/flooring/tiling/freezer

/turf/simulated/floor/tiled/techmaint
	name = "floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "techmaint"
	initial_flooring = /singleton/flooring/tiling/new_tile/techmaint

/turf/simulated/floor/tiled/monofloor
	name = "floor"
	icon_state = "monofloor"
	initial_flooring = /singleton/flooring/tiling/new_tile/monofloor

/turf/simulated/floor/tiled/techfloor
	name = "floor"
	icon = 'icons/turf/flooring/techfloor.dmi'
	icon_state = "techfloor_gray"
	initial_flooring = /singleton/flooring/tiling/tech

/turf/simulated/floor/tiled/monotile
	name = "floor"
	icon_state = "steel_monotile"
	initial_flooring = /singleton/flooring/tiling/mono

/turf/simulated/floor/tiled/steel_grid
	name = "floor"
	icon_state = "steel_grid"
	initial_flooring = /singleton/flooring/tiling/new_tile/steel_grid

/turf/simulated/floor/tiled/steel_ridged
	name = "floor"
	icon_state = "steel_ridged"
	initial_flooring = /singleton/flooring/tiling/new_tile/steel_ridged

/turf/simulated/floor/tiled/old_tile
	name = "floor"
	icon_state = "tile_full"
	initial_flooring = /singleton/flooring/tiling/new_tile

/turf/simulated/floor/tiled/old_cargo
	name = "floor"
	icon_state = "cargo_one_full"
	initial_flooring = /singleton/flooring/tiling/new_tile/cargo_one

/turf/simulated/floor/tiled/kafel_full
	name = "floor"
	icon_state = "kafel_full"
	initial_flooring = /singleton/flooring/tiling/new_tile/kafel

/turf/simulated/floor/tiled/stone
	name = "stone slab floor"
	icon_state = "stone_full"
	initial_flooring = /singleton/flooring/tiling/stone

/turf/simulated/floor/tiled/techfloor/grid
	name = "floor"
	icon_state = "techfloor_grid"
	initial_flooring = /singleton/flooring/tiling/tech/grid

/turf/simulated/floor/tiled/tau
	icon = 'icons/turf/skrellturf.dmi'
	icon_state = "skrellblack"
	initial_flooring = /singleton/flooring/reinforced/shuttle/skrell

/turf/simulated/floor/tiled/tau/white
	icon_state = "skrellwhite"
	initial_flooring = /singleton/flooring/reinforced/shuttle/skrell/white

/turf/simulated/floor/tiled/tau/red
	icon_state = "skrellred"
	initial_flooring = /singleton/flooring/reinforced/shuttle/skrell/red

/turf/simulated/floor/tiled/tau/blue
	icon_state = "skrellblue"
	initial_flooring = /singleton/flooring/reinforced/shuttle/skrell/blue

/turf/simulated/floor/tiled/tau/orange
	icon_state = "skrellorange"
	initial_flooring = /singleton/flooring/reinforced/shuttle/skrell/orange

/turf/simulated/floor/tiled/tau/green
	icon_state = "skrellgreen"
	initial_flooring = /singleton/flooring/reinforced/shuttle/skrell/green

/turf/simulated/floor/lino
	name = "lino"
	icon = 'icons/turf/flooring/linoleum.dmi'
	icon_state = "lino"
	initial_flooring = /singleton/flooring/linoleum

//ATMOS PREMADES
/turf/simulated/floor/greengrid/nitrogen
	initial_gas = list(GAS_NITROGEN = MOLES_N2STANDARD)

// Placeholders
/turf/simulated/floor/airless
	map_airless = TRUE

/turf/simulated/floor/airless/lava
	name = "lava"
	icon = 'icons/turf/flooring/lava.dmi'
	icon_state = "lava"

/turf/simulated/floor/ice
	name = "ice"
	icon = 'icons/turf/snow.dmi'
	icon_state = "ice"

/turf/simulated/floor/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	icon_state = "snow"

/turf/simulated/floor/snow/New()
	icon_state = pick("snow[rand(1,12)]","snow0")
	..()

/turf/simulated/floor/light
/turf/simulated/floor/ceiling

/turf/simulated/floor/beach
	name = "beach"
	icon = 'icons/misc/beach.dmi'

/turf/simulated/floor/beach/sand
	name = "sand"
	icon_state = "sand"

/turf/simulated/floor/beach/sand/desert
	icon_state = "desert"
	has_resources = 1

/turf/simulated/floor/beach/sand/desert/New()
	icon_state = "desert[rand(0,5)]"
	..()

/turf/simulated/floor/beach/coastline
	name = "coastline"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "sandwater"
	turf_flags = TURF_IS_WET

/turf/simulated/floor/beach/water
	name = "water"
	icon_state = "water"
	turf_flags = TURF_IS_WET

/turf/simulated/floor/beach/water/is_flooded(lying_mob, absolute)
	. = absolute ? ..() : lying_mob

/turf/simulated/floor/beach/water/update_dirt()
	return	// Water doesn't become dirty

/turf/simulated/floor/beach/water/ocean
	icon_state = "seadeep"

/turf/simulated/floor/beach/water/New()
	..()
	AddOverlays(image("icon"='icons/misc/beach.dmi',"icon_state"="water5","layer"=MOB_LAYER+0.1))

/turf/simulated/floor/crystal
	name = "crystal floor"
	icon = 'icons/turf/flooring/crystal.dmi'
	icon_state = ""
	initial_flooring = /singleton/flooring/crystal

/turf/simulated/floor/scales
	name = "scale floor"
	icon = 'icons/turf/flooring/flesh.dmi'
	icon_state = "scales0"
	initial_flooring = /singleton/flooring/flesh

//Water go splish
/turf/simulated/floor/pool
	name = "pool floor"
	icon = 'icons/turf/flooring/pool.dmi'
	icon_state = "pool"
	initial_flooring = /singleton/flooring/pool

/turf/simulated/floor/bluespace
	name = "warp"
	icon = 'icons/turf/space.dmi'
	color = "#ca0054"
	icon_state = "bluespace"
	initial_flooring = /singleton/flooring/bluespace

/turf/simulated/floor/bluespace/Entered(mob/living/L)
	. = ..()

	if(istype(L) && prob(75))
		L.visible_message(
			SPAN_WARNING("\The [L] starts flickering in and out of existence as they step onto the bluespace!"),
			SPAN_WARNING("You feel your entire body tingle, and something pulling you away!")
		)
		addtimer(new Callback(GLOBAL_PROC, GLOBAL_PROC_REF(do_unstable_teleport_safe), L, GetConnectedZlevels(L.z)), rand(5, 15))

// WARHAMMER 40k //

/turf/simulated/floor/wood
	name = "wooden floor"
	icon = 'icons/turf/flooring/wood.dmi'
	icon_state = "wood"
	color = WOOD_COLOR_GENERIC
	initial_flooring = /singleton/flooring/wood

/turf/simulated/floor/wood/mahogany
	color = WOOD_COLOR_RICH
	initial_flooring = /singleton/flooring/wood/mahogany

/turf/simulated/floor/wood/maple
	color = WOOD_COLOR_PALE
	initial_flooring = /singleton/flooring/wood/maple

/turf/simulated/floor/wood/ebony
	color = WOOD_COLOR_BLACK
	initial_flooring = /singleton/flooring/wood/ebony

/turf/simulated/floor/wood/walnut
	color = WOOD_COLOR_CHOCOLATE
	initial_flooring = /singleton/flooring/wood/walnut

/turf/simulated/floor/wood/bamboo
	color = WOOD_COLOR_PALE2
	initial_flooring = /singleton/flooring/wood/bamboo

/turf/simulated/floor/wood/yew
	color = WOOD_COLOR_YELLOW
	initial_flooring = /singleton/flooring/wood/yew

/turf/simulated/floor/new_wood
	name = "wooden floor"
	icon = 'icons/turf/flooring/wood.dmi'
	icon_state = "new_wood"
	initial_flooring = /singleton/flooring/new_wood

/turf/simulated/floor/new_wood/two
	icon_state = "new_wood2"

/turf/simulated/floor/new_wood/three
	icon_state = "new_wood3"

/turf/simulated/floor/new_wood/four
	icon_state = "new_wood4"
/turf/simulated/floor/new_wood/five
	icon_state = "new_wood5"
/turf/simulated/floor/new_wood/six
	icon_state = "new_wood6"
/turf/simulated/floor/new_wood/seven
	icon_state = "new_wood7"
/turf/simulated/floor/new_wood/eight
	icon_state = "new_wood8"
/turf/simulated/floor/new_wood/nine
	icon_state = "new_wood9"

/turf/simulated/floor/warhammer/stone
	name = "stone floor"
	icon = 'icons/turf/flooring/stonefloor.dmi'
	icon_state = "MAIN"
	initial_flooring = /singleton/flooring/stone

/turf/simulated/floor/warhammer/stone/chapel
	name = "monastic stone floor"
	holy = 1

/turf/simulated/floor/warhammer/stone/New()
	icon_state = pick("MAIN","extra","extra1","extra2","extra3")
	..()



/turf/simulated/floor/seolite
	name = "Seolite floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "cluster"

/turf/simulated/floor/tiled/stone
	name = "stone tiled floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "stone"
	color = "#808080"
	initial_flooring = /singleton/flooring/tiling/stone

/turf/simulated/floor/carpet
	name = "brown carpet"
	icon = 'icons/turf/flooring/carpet.dmi'
	icon_state = "brown"
	initial_flooring = /singleton/flooring/carpet

/turf/simulated/floor/carpet/blue
	name = "blue carpet"
	icon_state = "blue1"
	initial_flooring = /singleton/flooring/carpet/blue

/turf/simulated/floor/carpet/blue2
	name = "pale blue carpet"
	icon_state = "blue2"
	initial_flooring = /singleton/flooring/carpet/blue2

/turf/simulated/floor/carpet/blue3
	name = "sea blue carpet"
	icon_state = "blue3"
	initial_flooring = /singleton/flooring/carpet/blue3

/turf/simulated/floor/carpet/magenta
	name = "magenta carpet"
	icon_state = "magenta"
	initial_flooring = /singleton/flooring/carpet/magenta

/turf/simulated/floor/carpet/purple
	name = "purple carpet"
	icon_state = "purple"
	initial_flooring = /singleton/flooring/carpet/purple

/turf/simulated/floor/carpet/orange
	name = "orange carpet"
	icon_state = "orange"
	initial_flooring = /singleton/flooring/carpet/orange

/turf/simulated/floor/carpet/green
	name = "green carpet"
	icon_state = "green"
	initial_flooring = /singleton/flooring/carpet/green

/turf/simulated/floor/carpet/red
	name = "red carpet"
	icon_state = "red"
	initial_flooring = /singleton/flooring/carpet/red

/turf/simulated/floor/carpet/black
	name = "black carpet"
	icon_state = "black"
	initial_flooring = /singleton/flooring/carpet/black

/turf/simulated/floor/tiled/dark
	name = "dark floor"
	icon_state = "dark"
	initial_flooring = /singleton/flooring/tiling/dark

/turf/simulated/floor/tiled/ramp
	name = "foot ramp"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "ramptop"
	initial_flooring = /singleton/flooring/reinforced/ramp

/turf/simulated/floor/tiled/ramp/bottom
	name = "foot ramp"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "rampbot"
	initial_flooring = /singleton/flooring/reinforced/ramp/bottom

/turf/simulated/floor/warhammer
	name = "grimy floor"
	icon = 'icons/turf/flooring/floors.dmi'
	icon_state = "grimy"
	layer = DECAL_LAYER
	initial_flooring = null
	dirty = 15

/turf/simulated/floor/warhammer/nf2
	name = "stone floor"
	icon = 'icons/turf/flooring/floors.dmi'
	icon_state = "nf2"
	dirty = 20
	initial_flooring = /singleton/flooring/warhammer/nf2

/turf/simulated/floor/warhammer/lfloorscorched1
	name = "scorched floor"
	icon = 'icons/turf/flooring/floors.dmi'
	icon_state = "lfloorscorched1"
	dirty = 35
	initial_flooring = /singleton/flooring/warhammer/lfloorscorched1

/turf/simulated/floor/warhammer/basalt
	name = "volcanic floor"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "basalt0" // ignore basalt, oldsmoothdirt and necro floors. they should not have any initial_flooring
	footstep_type = /singleton/footsteps/dirt
	dirty = 0

/turf/simulated/floor/warhammer/basalt/one
	icon_state = "basalt1"

/turf/simulated/floor/warhammer/basalt/two
	icon_state = "basalt3"

/turf/simulated/floor/warhammer/basalt/three
	icon_state = "basalt9"

/turf/simulated/floor/warhammer/basalt/four
	icon_state = "basalt10"

/turf/simulated/floor/warhammer/necro1
	name = "infestation"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "necro1"
	footstep_type = /singleton/footsteps/mud
	dirty = 0

/turf/simulated/floor/warhammer/necro2
	name = "infestation"
	icon = 'icons/map_project/eldritch/Flesh_Ground.dmi'
	icon_state = "flesh_floor-1"
	footstep_type = /singleton/footsteps/mud
	dirty = 0

/turf/simulated/floor/warhammer/necro3
	name = "infestation"
	icon = 'icons/map_project/eldritch/Flesh_Ground.dmi'
	icon_state = "flesh_floor-2"
	footstep_type = /singleton/footsteps/mud
	dirty = 0

/turf/simulated/floor/warhammer/necro4
	name = "infestation"
	icon = 'icons/map_project/eldritch/Flesh_Ground.dmi'
	icon_state = "flesh_floor-3"
	footstep_type = /singleton/footsteps/mud
	dirty = 0

/turf/simulated/floor/warhammer/oldsmoothdirt
	name = "dirt floor"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "oldsmoothdirt"
	footstep_type = /singleton/footsteps/dirt
	dirty = 100

/turf/simulated/floor/warhammer/tunneldirty
	name = "tunnel floor"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "tunneldirty"
	initial_flooring = /singleton/flooring/warhammer/tunneldirty
	dirty = 50

/turf/simulated/floor/warhammer/tunnelchess
	name = "tunnel floor"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "tunnelchess"
	initial_flooring = /singleton/flooring/warhammer/tunnelchess
	dirty = 100

/turf/simulated/floor/warhammer/carpetn00
	name = "carpet floor"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "n00"
	initial_flooring = /singleton/flooring/warhammer/carpetn00
	dirty = 10

/turf/simulated/floor/warhammer/surgerynew
	name = "surgery floor"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "surgery2"
	initial_flooring = /singleton/flooring/warhammer/surgerynew
	dirty = 30

/turf/simulated/floor/warhammer/brothel
	name = "stone floor"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "brothel"
	initial_flooring = /singleton/flooring/warhammer/brothel
	dirty = 35

/turf/simulated/floor/warhammer/clockwork
	name = "alien floor"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "clockwork"
	initial_flooring = /singleton/flooring/warhammer/clockwork
	dirty = 35

/turf/simulated/floor/warhammer/aesculapius
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "aesculapius"
	initial_flooring = /singleton/flooring/warhammer/aesculapius

/turf/simulated/floor/warhammer/aesculapius/mem
	icon_state = "mem"
	initial_flooring = /singleton/flooring/warhammer/aesculapius/mem

/turf/simulated/floor/warhammer/aesculapius/mento
	icon_state = "mento"
	initial_flooring = /singleton/flooring/warhammer/aesculapius/mento

/turf/simulated/floor/warhammer/aesculapius/mori
	icon_state = "mori"
	initial_flooring = /singleton/flooring/warhammer/aesculapius/mori

/turf/simulated/floor/warhammer/plating
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "platingfull"
	initial_flooring = /singleton/flooring/warhammer/plating

/turf/simulated/floor/warhammer/plate
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "plate"
	initial_flooring = /singleton/flooring/warhammer/plate

/turf/simulated/floor/warhammer/barnew
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "barnew"
	initial_flooring = /singleton/flooring/warhammer/barnew

/turf/simulated/floor/warhammer/splate
	icon_state = "shaftplating"
	icon = 'icons/turf/flooring/decals.dmi'
	initial_flooring = /singleton/flooring/warhammer/splate

/turf/simulated/floor/warhammer/checkers
	icon_state = "checkers1"
	initial_flooring = /singleton/flooring/warhammer/checkers

/turf/simulated/floor/warhammer/checkers/two
	icon_state = "checkers2"
	initial_flooring = /singleton/flooring/warhammer/checkers/two

/turf/simulated/floor/warhammer/rectangles
	icon_state = "rectangles1"
	initial_flooring = /singleton/flooring/warhammer/rectangles

/turf/simulated/floor/warhammer/rectangles/two
	icon_state = "rectangles2"
	initial_flooring = /singleton/flooring/warhammer/rectangles/two

/turf/simulated/floor/warhammer/brick
	initial_flooring = /singleton/flooring/warhammer/brick
	icon_state = "brick1"

/turf/simulated/floor/warhammer/brick/two
	initial_flooring = /singleton/flooring/warhammer/brick/two
	icon_state = "brick2"

/turf/simulated/floor/warhammer/metal
	initial_flooring = /singleton/flooring/warhammer/metal
	icon_state = "metal5"

/turf/simulated/floor/warhammer/metal/east
	initial_flooring = /singleton/flooring/warhammer/metal/two
	icon_state = "metal2"

/turf/simulated/floor/warhammer/metal/south
	initial_flooring = /singleton/flooring/warhammer/metal/three
	icon_state = "metal3"

/turf/simulated/floor/warhammer/metal/north
	initial_flooring = /singleton/flooring/warhammer/metal/four
	icon_state = "metal4"

/turf/simulated/floor/warhammer/metal/west
	initial_flooring = /singleton/flooring/warhammer/metal/five
	icon_state = "metal1"

/turf/simulated/floor/warhammer/metal/alt
	initial_flooring = /singleton/flooring/warhammer/metal/six
	icon_state = "metal6"

/turf/simulated/floor/warhammer/metal/southeast
	initial_flooring = /singleton/flooring/warhammer/metal/seven
	icon_state = "metal7"

/turf/simulated/floor/warhammer/metal/southwest
	initial_flooring = /singleton/flooring/warhammer/metal/eight
	icon_state = "metal8"

/turf/simulated/floor/warhammer/metal/northwest
	initial_flooring = /singleton/flooring/warhammer/metal/nine
	icon_state = "metal9"

/turf/simulated/floor/warhammer/metal/northeast
	initial_flooring = /singleton/flooring/warhammer/metal/ten
	icon_state = "metal10"
/turf/simulated/floor/warhammer/concrete
	name = "concrete floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "concrete"
	initial_flooring = /singleton/flooring/warhammer/concrete

/turf/simulated/floor/warhammer/mudsteel
	name = "steel dark floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "steel_dark"
	initial_flooring = /singleton/flooring/warhammer/mudsteel

/turf/simulated/floor/warhammer/catwalkdark
	name = "steel floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "steelnew"
	initial_flooring = /singleton/flooring/warhammer/catwalkdark

/turf/simulated/floor/warhammer/surface_floor
	name = "surface"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "surface"
	initial_flooring = /singleton/flooring/warhammer/surface_floor

/turf/simulated/floor/warhammer/factory_floor
	name = "plated floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "lev"
	initial_flooring = /singleton/flooring/warhammer/factory_floor

/turf/simulated/floor/warhammer/bloodbar
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "bloodbar"
	initial_flooring = /singleton/flooring/warhammer/bloodbar

/turf/simulated/floor/warhammer/bloodbar/off
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "bloodbar2"
	initial_flooring = /singleton/flooring/warhammer/bloodbar/off

/turf/simulated/floor/warhammer/bar
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "barfull"
	initial_flooring = /singleton/flooring/warhammer/bar

/turf/simulated/floor/warhammer/bar2
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "bar2"
	initial_flooring = /singleton/flooring/warhammer/bar2

/turf/simulated/floor/warhammer/bar3
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "bar3"
	initial_flooring = /singleton/flooring/warhammer/bar3

/turf/simulated/floor/warhammer/cafe
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "cafefull"
	initial_flooring = /singleton/flooring/warhammer/cafe

/turf/simulated/floor/warhammer/cafe2
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "cafe2"
	initial_flooring = /singleton/flooring/warhammer/cafe2

/turf/simulated/floor/warhammer/shaft
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "shaft"
	initial_flooring = /singleton/flooring/warhammer/shaft

/turf/simulated/floor/warhammer/coldroom
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "coldroom"
	initial_flooring = /singleton/flooring/warhammer/coldroom

// Ceramic Flooring

/turf/simulated/floor/warhammer/ceramic
	name = "ceramic flooring"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "newstone2"
	initial_flooring = /singleton/flooring/warhammer/ceramic

/turf/simulated/floor/warhammer/ceramic/surgery
	name = "grey ceramic flooring"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "surgery"
	initial_flooring = /singleton/flooring/warhammer/surgerynew

/turf/simulated/floor/warhammer/ceramic/surgery2
	name = "grey ceramic flooring"
	icon = 'icons/turf/flooring/decals.dmi'
	icon_state = "surgery2"
	initial_flooring = /singleton/flooring/warhammer/surgerynew

/turf/simulated/floor/warhammer/ceramic/old
	name = "ceramic flooring"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "newstone4"
	initial_flooring = /singleton/flooring/warhammer/ceramic/old

/turf/simulated/floor/warhammer/ceramic/blackstone
	name = "black ceramic flooring"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "bluestone2"
	initial_flooring = /singleton/flooring/warhammer/ceramic/blackstone

// Wooden Flooring

/turf/simulated/floor/warhammer/darkwood
	name = "wooden floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "dark_wood"
	dirty = 35
	initial_flooring = /singleton/flooring/warhammer/darkwood

/turf/simulated/floor/warhammer/darkwood2
	name = "decrepit wooden floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "troom3"
	dirty = 100
	initial_flooring = /singleton/flooring/warhammer/darkwood2



// Fancy floors (For the Gov or some housing)
// Fancy Flooring
/turf/simulated/floor/warhammer/fancyfloor
	name = "fancy floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "metrofull"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor

/turf/simulated/floor/warhammer/fancyfloor/edges
	name = "fancy floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "metroedges"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/edges

/turf/simulated/floor/warhammer/fancyfloor/marble
	name = "marble floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "marbletile"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/marble

/turf/simulated/floor/warhammer/coralg
	name = "coral granite floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "coralgranite"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/coralg

/turf/simulated/floor/warhammer/fancyfloor/gray_white
	name = "gray & white flooring"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "graywhite"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/gray_white

/turf/simulated/floor/warhammer/fancyfloor/carpet
	name = "red carpet"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "carpbet2side"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/carpet

/turf/simulated/floor/warhammer/fancyfloor/carpet/middle
	name = "red carpet"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "carpbet2"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/carpet/middle

/turf/simulated/floor/warhammer/fancyfloor/carpet/grey
	name = "grey carpet"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "carpet2side"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/carpet/grey

/turf/simulated/floor/warhammer/fancyfloor/carpet/grey/middle
	name = "grey carpet"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "carpet2"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/carpet/grey/middle

/turf/simulated/floor/warhammer/fancyfloor/carpet/blue
	name = "blue carpet"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "blucarpet2side"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/carpet/blue

/turf/simulated/floor/warhammer/fancyfloor/carpet/blue/middle
	name = "blue carpet"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "carpet3"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/carpet/blue/middle

/turf/simulated/floor/warhammer/fancyfloor/carpet/green
	name = "green carpet"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "carpbet23side"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/carpet/green

/turf/simulated/floor/warhammer/fancyfloor/carpet/green/middle
	name = "green carpet"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "carpet0"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/carpet/green/middle

/turf/simulated/floor/warhammer/fancyfloor/oldcobble
	name = "old cobblestone"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "stonefloor4"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/oldcobble

/turf/simulated/floor/warhammer/fancyfloor/ancient_cobble_old
	name = "dark cobble floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "stone_old"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/ancient_cobble_old

// Broken Wooden Flooring
/turf/simulated/floor/warhammer/fancyfloor/brokenfloor0
	icon = 'icons/turf/flooring/wood.dmi'
	icon_state = "wood_broken0"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/brokenfloor0

/turf/simulated/floor/warhammer/fancyfloor/brokenfloor1
	icon = 'icons/turf/flooring/wood.dmi'
	icon_state = "wood_broken1"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/brokenfloor1

/turf/simulated/floor/warhammer/fancyfloor/brokenfloor2
	icon = 'icons/turf/flooring/wood.dmi'
	icon_state = "wood_broken2"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/brokenfloor2

/turf/simulated/floor/warhammer/fancyfloor/brokenfloor3
	icon = 'icons/turf/flooring/wood.dmi'
	icon_state = "wood_broken3"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/brokenfloor3

/turf/simulated/floor/warhammer/fancyfloor/brokenfloor4
	icon = 'icons/turf/flooring/wood.dmi'
	icon_state = "wood_broken4"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/brokenfloor4

/turf/simulated/floor/warhammer/fancyfloor/brokenfloor5
	icon = 'icons/turf/flooring/wood.dmi'
	icon_state = "wood_broken5"
	initial_flooring = /singleton/flooring/warhammer/fancyfloor/brokenfloor5

// Stone Flooring
/turf/simulated/floor/warhammer/stone/crafted_floor
	name = "stone path"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "stonecrafted"
	initial_flooring = /singleton/flooring/warhammer/stone/crafted_floor

/turf/simulated/floor/warhammer/stone/old
	name = "old stone floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "stonefloor"
	initial_flooring = /singleton/flooring/warhammer/stone/old

/turf/simulated/floor/warhammer/stone/old2
	name = "old stone floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "stonefloor2"
	initial_flooring = /singleton/flooring/warhammer/stone/old2

/turf/simulated/floor/warhammer/stone/old3
	name = "old stone floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "stonefloor3"
	initial_flooring = /singleton/flooring/warhammer/stone/old3

/turf/simulated/floor/warhammer/stone/old4
	name = "old stone floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "stonefloor4"
	initial_flooring = /singleton/flooring/warhammer/stone/old4

/turf/simulated/floor/warhammer/stone/ancient
	name = "ancient stone floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "stoney"
	initial_flooring = /singleton/flooring/warhammer/stone/ancient

/turf/simulated/floor/warhammer/stone/ancient2
	name = "ancient stone floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "stone_old"
	initial_flooring = /singleton/flooring/warhammer/stone/ancient2

/turf/simulated/floor/warhammer/stone/ancient3
	name = "ancient stone floor"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "stoning"
	initial_flooring = /singleton/flooring/warhammer/stone/ancient3

/turf/simulated/floor/warhammer/stone/seabed
	name = "seabed"
	icon = 'icons/turf/flooring/plating.dmi'
	icon_state = "seabed"
	initial_flooring = /singleton/flooring/warhammer/stone/seabed

// DECALS PORTED TO FLOORING
/turf/simulated/floor/warhammer/newsteel
	name = "steel floor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "steel"
	initial_flooring = /singleton/flooring/newsteel
	dirty = 35

/turf/simulated/floor/warhammer/newsteel/light
	name = "steel foor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "steelold"
	initial_flooring = /singleton/flooring/newsteel/light

/turf/simulated/floor/warhammer/newsteel/dark
	name = "steel foor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "dark"
	initial_flooring = /singleton/flooring/newsteel/dark

/turf/simulated/floor/warhammer/newsteel/dark2
	name = "steel foor"
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_state = "dark1"
	initial_flooring = /singleton/flooring/newsteel/dark2
