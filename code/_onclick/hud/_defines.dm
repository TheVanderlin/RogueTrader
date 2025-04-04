/*
	These defines specificy screen locations.  For more information, see the byond documentation on the screen_loc var.

	The short version:

	Everything is encoded as strings because apparently that's how Byond rolls.

	"1,1" is the bottom left square of the user's screen.  This aligns perfectly with the turf grid.
	"1:2,3:4" is the square (1,3) with pixel offsets (+2, +4); slightly right and slightly above the turf grid.
	Pixel offsets are used so you don't perfectly hide the turf under them, that would be crappy.

	The size of the user's screen is defined by client.view (indirectly by world.view), in our case "15x15".
	Therefore, the top right corner (except during admin shenanigans) is at "15,15"
*/

#define ui_entire_screen "WEST,SOUTH to EAST,NORTH"

//Lower left, persistant menu
#define ui_inventory "SOUTH-1,4"

//Lower center, persistant menu
#define ui_sstore1 "SOUTH-1,13"
#define ui_id "SOUTH-2,1"
#define ui_belt "SOUTH-2,3"
#define ui_back "SOUTH-1,6"
#define ui_rhand "SOUTH-1,1"
#define ui_lhand "SOUTH-1,3"
#define ui_equip "CENTER-1:16,SOUTH+1:5"
#define ui_swaphand2 "8:16,2:5"
#define ui_storage1 "SOUTH-2,4"
#define ui_storage2 "SOUTH-2,5"

#define ui_alien_head "CENTER-3:12,SOUTH:5"		//aliens
#define ui_alien_oclothing "CENTER-2:14,SOUTH:5"//aliens

#define ui_inv1 "CENTER-1,SOUTH:5"			//borgs
#define ui_inv2 "CENTER,SOUTH:5"			//borgs
#define ui_inv3 "CENTER+1,SOUTH:5"			//borgs
#define ui_borg_store "CENTER+2,SOUTH:5"	//borgs
#define ui_borg_inventory "CENTER-2,SOUTH:5"//borgs

#define ui_monkey_mask "WEST+4:14,SOUTH:5"	//monkey
#define ui_monkey_back "WEST+5:14,SOUTH:5"	//monkey

#define ui_construct_health "EAST:00,CENTER:15" //same height as humans, hugging the right border
#define ui_construct_purge "EAST:00,CENTER-1:15"
#define ui_construct_fire "EAST-1:16,CENTER+1:13" //above health, slightly to the left
#define ui_construct_pull "EAST-1:28,SOUTH+1:10" //above the zone_sel icon

//Lower right, persistant menu
#define ui_swaphand1 "SOUTH-2,6"
#define ui_dropbutton "SOUTH-2,7"
#define ui_drop_throw "SOUTH-2,13"
#define ui_pull "SOUTH-2,10"
#define ui_jmp_kck "SOUTH-2, 9"
#define ui_atk "SOUTH-2, 14"//atk_intents
#define ui_resist "EAST+1,SOUTH-2"
#define ui_acti "SOUTH-2,9"
#define ui_combat "SOUTH-2,12"//COMBAT MODE!
#define ui_combat_intent "SOUTH-2, 8"
#define ui_movi "EAST,SOUTH-2"
#define ui_zonesel "EAST+1, NORTH-2"
#define ui_acti_alt "SOUTH-2,9" //alternative intent switcher for when the interface is hidden (F12)

#define ui_borg_pull "EAST-3:24,SOUTH+1:7"
#define ui_borg_module "EAST-2:26,SOUTH+1:7"
#define ui_borg_panel "EAST-1:28,SOUTH+1:7"

//Gun buttons
#define ui_gun1 "9, SOUTH"
#define ui_gun2 "10, SOUTH"
#define ui_gun3 "11, SOUTH"
#define ui_gun_select "10, SOUTH-1"
#define ui_gun4 "EAST-3:24,SOUTH+2:7"

//Upper-middle right (damage indicators)
#define ui_toxin "EAST+1, NORTH-8"//6
#define ui_fire "EAST+1, NORTH-9"//8
#define ui_oxygen "EAST+1, NORTH-7"//NORTH-3"
#define ui_pressure "EAST+1, NORTH-11"//7
#define ui_surrender "EAST+1, NORTH-5"
#define ui_fixeye "EAST+1, NORTH-6"

#define ui_alien_toxin "EAST-1:28,NORTH-2:25"
#define ui_alien_fire "EAST-1:28,NORTH-3:25"
#define ui_alien_oxygen "EAST-1:28,NORTH-4:25"

//Middle right (status indicators)
#define ui_stamina "EAST+1, NORTH-14"
#define ui_temp "EAST+1, NORTH-12"
#define ui_health "EAST+1, NORTH-13"
#define ui_happiness "EAST+1, NORTH-4"
#define ui_nutrition "EAST+1, NORTH-10"
#define ui_internal "EAST+1, NORTH-3"
									//borgs
#define ui_borg_health "EAST-1:28,CENTER-1:13" //borgs have the health display where humans have the pressure damage indicator.
#define ui_alien_health "EAST-1:28,CENTER-1:13" //aliens have the health display where humans have the pressure damage indicator.

//Pop-up inventory
#define ui_shoes "SOUTH-1,7"

#define ui_iclothing "SOUTH-2,2"
#define ui_oclothing "SOUTH-1,2"
#define ui_gloves "SOUTH-1,8"

#define ui_glasses "SOUTH-1,12"
#define ui_mask "SOUTH-1,4"
#define ui_l_ear "SOUTH-1,10"
#define ui_r_ear "SOUTH-1,11"
#define ui_neck "SOUTH-1,9"

#define ui_head "SOUTH-1,5"

//Intent small buttons
#define ui_help_small "EAST-3:8,SOUTH:1"
#define ui_disarm_small "EAST-3:15,SOUTH:18"
#define ui_grab_small "EAST-3:32,SOUTH:18"
#define ui_harm_small "EAST-3:39,SOUTH:1"

//#define ui_swapbutton "6:-16,1:5" //Unused

//#define ui_headset "SOUTH,8"
#define ui_hand "CENTER-1:14,SOUTH:5"
#define ui_hstore1 "5,5"
//#define ui_resist "EAST+1,SOUTH-1"
#define ui_sleep "EAST+1, NORTH-14"
#define ui_rest "EAST+1, NORTH-15"


#define ui_iarrowleft "SOUTH-2,11"
#define ui_iarrowright "SOUTH-2,13"

#define ui_spell_master "EAST-1:16,NORTH-1:16"
#define ui_genetic_master "EAST-1:16,NORTH-3:16"

//pai
#define ui_pai_software "NORTH,WEST:6"
#define ui_pai_subsystems "NORTH,WEST+1:6"
#define ui_pai_shell "NORTH,WEST+2:6"
#define ui_pai_light "NORTH,WEST+3:6"
#define ui_pai_rest "NORTH,WEST+4:6"
