/area/derelict/ship
	name = "\improper Abandoned Ship"
	icon_state = "yellow"
	turfs_airless = TRUE

/area/constructionsite/AIsattele
	name = "\improper AI Satellite Teleporter Room"
	icon_state = "teleporter"
	ambience = list('sound/ambience/ambimalf.ogg')

/area/constructionsite
	name = "\improper Construction Site"
	icon_state = "storage"
	ambience = list('sound/ambience/spookyspace1.ogg', 'sound/ambience/spookyspace2.ogg')
	turfs_airless = TRUE

/area/constructionsite/storage
	name = "\improper Construction Site Storage Area"

/area/constructionsite/bridge
	name = "\improper Construction Site Bridge"
	icon_state = "bridge"

/area/constructionsite/hallway/aft
	name = "\improper Construction Site Aft Hallway"
	icon_state = "hallP"

/area/constructionsite/hallway/fore
	name = "\improper Construction Site Fore Hallway"
	icon_state = "hallS"

/area/constructionsite/atmospherics
	name = "\improper Construction Site Atmospherics"
	icon_state = "green"

/area/constructionsite/medical
	name = "\improper Construction Site Medbay"
	icon_state = "medbay"

/area/constructionsite/ai
	name = "\improper Construction Cogitator Core"
	icon_state = "ai"

/area/constructionsite/engineering
	name = "\improper Construction Site Engine Bay"
	icon_state = "engine"

/area/constructionsite/teleporter
	name = "Construction Site Teleporter"
	icon_state = "yellow"

/area/constructionsite/solar
	name = "\improper Construction Site Solars"
	icon_state = "solar"
	area_flags = AREA_FLAG_EXTERNAL
	requires_power = 1
	always_unpowered = 1
	has_gravity = FALSE
	base_turf = /turf/space

/area/constructionsite/maintenance
	name = "\improper Construction Site Maintenance"
	icon_state = "yellow"
