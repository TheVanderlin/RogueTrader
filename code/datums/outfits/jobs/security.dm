/singleton/hierarchy/outfit/job/security
	hierarchy_type = /singleton/hierarchy/outfit/job/security
	glasses = /obj/item/clothing/glasses/hud/security/prot
	l_ear = /obj/item/device/radio/headset/headset_sec
	gloves = /obj/item/clothing/gloves/thick
	shoes = /obj/item/clothing/shoes/jackboots
	backpack_contents = list(/obj/item/handcuffs = 1)

/singleton/hierarchy/outfit/job/security/hos
	name = OUTFIT_JOB_NAME("Head of security")
	l_ear = /obj/item/device/radio/headset/heads/hos
	uniform = /obj/item/clothing/under/rank/head_of_security
	id_types = list(/obj/item/card/id/security/head)
	pda_type = /obj/item/modular_computer/pda/heads/hos
	backpack_contents = list(/obj/item/handcuffs = 1)

/singleton/hierarchy/outfit/job/security/warden
	name = OUTFIT_JOB_NAME("Warden")
	uniform = /obj/item/clothing/under/rank/warden
	l_pocket = /obj/item/device/flash
	id_types = list(/obj/item/card/id/security/warden)
	pda_type = /obj/item/modular_computer/pda/security

/singleton/hierarchy/outfit/job/security/detective
	name = OUTFIT_JOB_NAME("Detective")
	head = /obj/item/clothing/head/det
	uniform = /obj/item/clothing/under/det
	suit = /obj/item/clothing/suit/armor/grim/storage/det_trench
	l_pocket = /obj/item/flame/lighter/zippo
	shoes = /obj/item/clothing/shoes/laceup
	r_hand = /obj/item/storage/briefcase/crimekit
	id_types = list(/obj/item/card/id/security/detective)
	pda_type = /obj/item/modular_computer/pda/forensics
	backpack_contents = list(/obj/item/storage/box/evidence = 1)

/singleton/hierarchy/outfit/job/security/detective/forensic
	name = OUTFIT_JOB_NAME("Forensic technician")
	head = null
	suit = /obj/item/clothing/suit/armor/grim/storage/forensics/blue

/singleton/hierarchy/outfit/job/security/officer
	name = OUTFIT_JOB_NAME("Security Officer")
	uniform = /obj/item/clothing/under/rank/security
	l_pocket = /obj/item/device/flash
	r_pocket = /obj/item/handcuffs
	id_types = list(/obj/item/card/id/security)
	pda_type = /obj/item/modular_computer/pda/security
