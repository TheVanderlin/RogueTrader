var/global/list/possible_genestealer_IDs = list("Alpha","Beta","Gamma","Delta","Epsilon","Zeta","Eta","Theta","Iota","Kappa","Lambda","Mu","Nu","Xi","Omicron","Pi","Rho","Sigma","Tau","Upsilon","Phi","Chi","Psi","Omega")

/datum/genestealer //stores genestealer powers, genestealer recharge thingie, genestealer absorbed DNA and genestealer ID (for genestealer hivemind)
	var/list/datum/absorbed_dna/absorbed_dna = list()
	var/list/absorbed_languages = list()
	var/absorbedcount = 0
	var/chem_charges = 20
	var/chem_recharge_rate = 0.5
	var/chem_storage = 45
	var/sting_range = 1
	var/genestealerID = "Genestealer"
	var/geneticdamage = 0
	var/isabsorbing = 0
	var/geneticpoints = 25
	var/purchasedpowers = list()
	var/mimicing = ""

/datum/genestealer/Destroy()
	purchasedpowers = null
	absorbed_languages.Cut()
	absorbed_dna.Cut()
	. = ..()

/datum/genestealer/New()
	..()
	if(length(possible_genestealer_IDs))
		genestealerID = pick(possible_genestealer_IDs)
		possible_genestealer_IDs -= genestealerID
		genestealerID = "[genestealerID]"
	else
		genestealerID = "[rand(1,999)]"

/datum/genestealer/proc/regenerate()
	chem_charges = min(max(0, chem_charges+chem_recharge_rate), chem_storage)
	geneticdamage = max(0, geneticdamage-1)

/datum/genestealer/proc/GetDNA(dna_owner)
	for(var/datum/absorbed_dna/DNA in absorbed_dna)
		if(dna_owner == DNA.name)
			return DNA

/mob/proc/absorbDNA(datum/absorbed_dna/newDNA)
	var/datum/genestealer/genestealer = null
	if(src.mind && src.mind.genestealer)
		genestealer = src.mind.genestealer
	if(!genestealer)
		return

	for(var/language in newDNA.languages)
		genestealer.absorbed_languages |= language

	genestealer_update_languages(genestealer.absorbed_languages)

	if(!genestealer.GetDNA(newDNA.name)) // Don't duplicate - I wonder if it's possible for it to still be a different DNA? DNA code could use a rewrite
		genestealer.absorbed_dna += newDNA

//Restores our verbs. It will only restore verbs allowed during lesser (monkey) form if we are not human
/mob/proc/make_genestealer()

	// if(!mind)				return
	if(!mind.genestealer)	mind.genestealer = new /datum/genestealer(gender)

	verbs += /datum/genestealer/proc/EvolutionMenu
	add_language(LANGUAGE_CHANGELING_GLOBAL)

	var/lesser_form = !ishuman(src)

	if(!length(powerinstances))
		for(var/P in powers)
			powerinstances += new P()

	// Code to auto-purchase free powers.
	for(var/datum/power/genestealer/P in powerinstances)
		if(!P.genomecost) // Is it free?
			if(!(P in mind.genestealer.purchasedpowers)) // Do we not have it already?
				mind.genestealer.purchasePower(mind, P.name, 0)// Purchase it. Don't remake our verbs, we're doing it after this.

	for(var/datum/power/genestealer/P in mind.genestealer.purchasedpowers)
		if(P.isVerb)
			if(lesser_form && !P.allowduringlesserform)	continue
			if(!(P in src.verbs))
				src.verbs += P.verbpath

	for(var/language in languages)
		mind.genestealer.absorbed_languages |= language

	var/mob/living/carbon/human/H = src
	if(istype(H))
		var/datum/absorbed_dna/newDNA = new(H.real_name, H.dna, H.species.name, H.languages)
		absorbDNA(newDNA)

	return 1

//removes our genestealer verbs
/mob/proc/remove_genestealer_powers()
	if(!mind || !mind.genestealer)	return
	for(var/datum/power/genestealer/P in mind.genestealer.purchasedpowers)
		if(P.isVerb)
			verbs -= P.verbpath


//Helper proc. Does all the checks and stuff for us to avoid copypasta
/mob/proc/genestealer_power(required_chems=0, required_dna=0, max_genetic_damage=100, max_stat=0)

	if(!src.mind)		return
	if(!iscarbon(src))	return

	var/datum/genestealer/genestealer = src.mind.genestealer
	if(!genestealer)
		to_world_log("[src] has the genestealer_transform() verb but is not a genestealer.")
		return

	if(src.stat > max_stat)
		to_chat(src, SPAN_WARNING("We are incapacitated."))
		return

	if(length(genestealer.absorbed_dna) < required_dna)
		to_chat(src, SPAN_WARNING("We require at least [required_dna] samples of compatible DNA."))
		return

	if(genestealer.chem_charges < required_chems)
		to_chat(src, SPAN_WARNING("We require at least [required_chems] units of chemicals to do that!"))
		return

	if(genestealer.geneticdamage > max_genetic_damage)
		to_chat(src, SPAN_WARNING("Our genomes are still reassembling. We need time to recover first."))
		return

	return genestealer


//Used to dump the languages from the genestealer datum into the actual mob.
/mob/proc/genestealer_update_languages(updated_languages)

	languages = list()
	for(var/language in updated_languages)
		languages += language

	//This isn't strictly necessary but just to be safe...
	add_language(LANGUAGE_CHANGELING_GLOBAL)

	return

//Absorbs the victim's DNA making them uncloneable. Requires a strong grip on the victim.
//Doesn't cost anything as it's the most basic ability.
/mob/proc/genestealer_absorb_dna()
	set category = "Genestealer"
	set name = "Absorb DNA"

	var/datum/genestealer/genestealer = genestealer_power(0,0,100)
	var/mob/living/carbon/C = src
	if(!genestealer)	return

	var/obj/item/grab/G = src.get_active_hand()
	if(!istype(G))
		to_chat(src, SPAN_WARNING("We must be grabbing a creature in our active hand to absorb them."))
		return

	var/mob/living/carbon/human/T = G.affecting
	if(!istype(T))
		to_chat(src, SPAN_WARNING("[T] is not compatible with our biology."))
		return

	if((T.species.species_flags & SPECIES_FLAG_NO_SCAN) || T.isSynthetic())
		to_chat(src, SPAN_WARNING("We cannot extract DNA from this creature!"))
		return

	if(MUTATION_HUSK in T.mutations)
		to_chat(src, SPAN_WARNING("This creature's DNA is ruined beyond useability!"))
		return

	if(!G.can_absorb())
		to_chat(src, SPAN_WARNING("We must have a tighter grip to absorb this creature."))
		return

	if(genestealer.isabsorbing)
		to_chat(src, SPAN_WARNING("We are already absorbing!"))
		return

	var/obj/item/organ/external/affecting = T.get_organ(src.zone_sel.selecting)
	if(!affecting)
		to_chat(src, SPAN_WARNING("They are missing that body part!"))

	genestealer.isabsorbing = 1
	for(var/stage = 1, stage<=3, stage++)
		switch(stage)
			if(1)
				to_chat(src, SPAN_NOTICE("This creature is compatible. We must hold still..."))
			if(2)
				to_chat(src, SPAN_NOTICE("We extend a proboscis."))
				src.visible_message(SPAN_WARNING("[src] extends a proboscis!"))
			if(3)
				to_chat(src, SPAN_NOTICE("We stab [T] with the proboscis."))
				src.visible_message(SPAN_DANGER("[src] stabs [T] with the proboscis!"))
				to_chat(T, SPAN_DANGER("You feel a sharp stabbing pain!"))
				affecting.take_external_damage(39, 0, DAMAGE_FLAG_SHARP, "large organic needle")
		if(!do_after(src, 10 SECONDS, T, DO_PUBLIC_UNIQUE))
			to_chat(src, SPAN_WARNING("Our absorption of [T] has been interrupted!"))
			genestealer.isabsorbing = 0
			return

	to_chat(src, SPAN_NOTICE("We have absorbed [T]!"))
	src.visible_message(SPAN_DANGER("[src] sucks the fluids from [T]!"))
	to_chat(T, SPAN_DANGER("You have been absorbed by the genestealer!"))
	genestealer.chem_charges += 10
	genestealer.geneticpoints += 2
	C.species.brute_mod -= 0.05
	C.species.burn_mod -= 0.03
	C.species.toxins_mod -= 0.02
	C.species.radiation_mod -= 0.02
	C.species.stun_mod -= 0.03
	C.species.weaken_mod -= 0.02
	to_chat(src, SPAN_WARNING("We feel slightly stronger..."))

	//Steal all of their languages!
	for(var/language in T.languages)
		if(!(language in genestealer.absorbed_languages))
			genestealer.absorbed_languages += language

	genestealer_update_languages(genestealer.absorbed_languages)

	var/datum/absorbed_dna/newDNA = new(T.real_name, T.dna, T.species.name, T.languages, T.pronouns)
	absorbDNA(newDNA)

	if(mind && T.mind)
		T.mind.CopyMemories(mind)

	if(T.mind && T.mind.genestealer)
		if(T.mind.genestealer.absorbed_dna)
			for(var/datum/absorbed_dna/dna_data in T.mind.genestealer.absorbed_dna)	//steal all their loot
				if(genestealer.GetDNA(dna_data.name))
					continue
				absorbDNA(dna_data)
				genestealer.absorbedcount++
			T.mind.genestealer.absorbed_dna.Cut(2)

		if(T.mind.genestealer.purchasedpowers)
			for(var/datum/power/genestealer/Tp in T.mind.genestealer.purchasedpowers)
				if(Tp in genestealer.purchasedpowers)
					continue
				else
					genestealer.purchasedpowers += Tp

					if(!Tp.isVerb)
						call(Tp.verbpath)()
					else
						src.make_genestealer()

		genestealer.chem_charges += T.mind.genestealer.chem_charges
		genestealer.geneticpoints += T.mind.genestealer.geneticpoints
		T.mind.genestealer.chem_charges = 0
		T.mind.genestealer.geneticpoints = 0
		T.mind.genestealer.absorbedcount = 0

	genestealer.absorbedcount++
	genestealer.isabsorbing = 0

	T.death(0)
	T.ChangeToHusk()
	return 1


//Change our DNA to that of somebody we've absorbed.
/mob/proc/genestealer_transform()
	set category = "Genestealer"
	set name = "Transform (5)"

	var/datum/genestealer/genestealer = genestealer_power(5,1,0)
	if(!genestealer)	return

	var/list/names = list()
	for(var/datum/absorbed_dna/DNA in genestealer.absorbed_dna)
		names += "[DNA.name]"

	var/S = input("Select the target DNA: ", "Target DNA", null) as null|anything in names
	if(!S)	return

	var/datum/absorbed_dna/chosen_dna = genestealer.GetDNA(S)
	if(!chosen_dna)
		return

	genestealer.chem_charges -= 5
	genestealer.geneticdamage = 30

	var/S_name = chosen_dna.speciesName
	var/datum/species/S_dat = all_species[S_name]
	var/changeTime = 2 SECONDS
	if(mob_size != S_dat.mob_size)
		src.visible_message(SPAN_WARNING("[src]'s body begins to twist, their mass changing rapidly!"))
		changeTime = 8 SECONDS
	else
		src.visible_message(SPAN_WARNING("[src]'s body begins to twist, changing rapidly!"))

	if(!do_after(src, changeTime, do_flags = DO_DEFAULT | DO_USER_UNIQUE_ACT))
		to_chat(src, SPAN_NOTICE("You fail to change shape."))
		return
	handle_genestealer_transform(chosen_dna)

	src.verbs -= /mob/proc/genestealer_transform
	spawn(10)
		src.verbs += /mob/proc/genestealer_transform

	genestealer_update_languages(genestealer.absorbed_languages)
	return 1

/mob/proc/handle_genestealer_transform(datum/absorbed_dna/chosen_dna)
	src.visible_message(SPAN_WARNING("[src] transforms!"))

	src.dna = chosen_dna.dna
	src.real_name = chosen_dna.name
	src.flavor_text = ""
	src.pronouns = chosen_dna.pronouns

	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		var/newSpecies = chosen_dna.speciesName
		H.set_species(newSpecies,1)
		H.b_type = chosen_dna.dna.b_type
		H.sync_organ_dna()

	domutcheck(src, null)
	src.UpdateAppearance()


//Transform into a monkey.
/mob/proc/genestealer_lesser_form()
	set category = "Genestealer"
	set name = "Lesser Form (60)"

	var/datum/genestealer/genestealer = genestealer_power(60,0,0)
	if(!genestealer)	return

	if(src.has_brain_worms())
		to_chat(src, SPAN_WARNING("We cannot perform this ability at the present time!"))
		return

	var/mob/living/carbon/human/H = src

	if(!istype(H) || !H.species.primitive_form)
		to_chat(src, SPAN_WARNING("We cannot perform this ability in this form!"))
		return

	genestealer.chem_charges--
	H.visible_message(SPAN_WARNING("[H] transforms!"))
	genestealer.geneticdamage = 30
	to_chat(H, SPAN_WARNING("Our genes cry out!"))
	H = H.monkeyize()
	return 1

//Transform into a human
/mob/proc/genestealer_lesser_transform()
	set category = "Genestealer"
	set name = "Transform (60)"

	var/datum/genestealer/genestealer = genestealer_power(60,1,0)
	if(!genestealer)	return

	if(HAS_TRANSFORMATION_MOVEMENT_HANDLER(src))
		return

	var/list/names = list()
	for(var/datum/dna/DNA in genestealer.absorbed_dna)
		names += "[DNA.real_name]"

	var/S = input("Select the target DNA: ", "Target DNA", null) as null|anything in names
	if(!S)	return

	var/datum/dna/chosen_dna = genestealer.GetDNA(S)
	if(!chosen_dna)
		return

	var/mob/living/carbon/human/C = src

	genestealer.chem_charges--
	C.remove_genestealer_powers()
	C.visible_message(SPAN_WARNING("[C] transforms!"))
	C.dna = chosen_dna.Clone()

	var/list/implants = list()
	for (var/obj/item/implant/I in C) //Still preserving implants
		implants += I

	ADD_TRANSFORMATION_MOVEMENT_HANDLER(C)
	C.icon = null
	C.ClearOverlays()
	C.set_invisibility(INVISIBILITY_ABSTRACT)
	var/atom/movable/fake_overlay/animation = new /atom/movable/fake_overlay(src)
	animation.icon_state = "blank"
	animation.icon = 'icons/mob/mob.dmi'
	flick("monkey2h", animation)
	sleep(48)
	qdel(animation)

	for(var/obj/item/W in src)
		C.drop_from_inventory(W)

	var/mob/living/carbon/human/O = new /mob/living/carbon/human( src )
	if (C.dna.GetUIState(DNA_UI_GENDER))
		O.gender = FEMALE
	else
		O.gender = MALE
	O.dna = C.dna.Clone()
	C.dna = null
	O.real_name = chosen_dna.real_name

	for(var/obj/T in C)
		qdel(T)

	O.dropInto(C.loc)

	O.UpdateAppearance()
	domutcheck(O, null)
	O.setToxLoss(C.getToxLoss())
	O.adjustBruteLoss(C.getBruteLoss())
	O.setOxyLoss(C.getOxyLoss())
	O.adjustFireLoss(C.getFireLoss())
	O.set_stat(C.stat)
	for (var/obj/item/implant/I in implants)
		I.forceMove(O)
		I.implanted = O

	C.mind.transfer_to(O)
	O.make_genestealer()
	O.genestealer_update_languages(genestealer.absorbed_languages)
	qdel(C)
	return 1


//Fake our own death and fully heal. You will appear to be dead but regenerate fully after a short delay.
/mob/proc/genestealer_fakedeath()
	set category = "Genestealer"
	set name = "Regenerative Stasis (40)"

	var/datum/genestealer/genestealer = genestealer_power(40,1,100,DEAD)
	if(!genestealer)	return

	var/mob/living/carbon/C = src
	if(!C.stat && alert("Are we sure we wish to enter regenerative stasis? There is a small chance we may not revive...",,"Compliance","No") == "No")//Confirmation for living genestealers if they want to fake their death
		return
	to_chat(C, SPAN_NOTICE("We will attempt to regenerate our form."))
	C.status_flags |= FAKEDEATH		//play dead
	C.UpdateLyingBuckledAndVerbStatus()
	C.remove_genestealer_powers()

	C.emote("gasp")

	spawn(rand(800,1000))
		if(genestealer_power(40,1,100,DEAD) && prob(75))
			// charge the genestealer chemical cost for stasis
			genestealer.chem_charges -= 40

			to_chat(C, SPAN_NOTICE(FONT_GIANT("We are ready to rise.  Use the <b>Revive</b> verb when you are ready.")))
			C.verbs += /mob/proc/genestealer_revive
		else
			to_chat(C, SPAN_NOTICE(FONT_GIANT("Something is wrong! Our DNA mutants and convulses!")))
			spawn(100)
			C.gib()
	return 1

/mob/proc/genestealer_revive()
	set category = "Genestealer"
	set name = "Revive"

	var/mob/living/carbon/C = src
	// restore us to health
	C.revive()
	// remove our fake death flag
	C.status_flags &= ~(FAKEDEATH)
	// let us move again
	C.UpdateLyingBuckledAndVerbStatus()
	// re-add out genestealer powers
	C.make_genestealer()
	// sending display messages
	to_chat(C, SPAN_NOTICE("We have regenerated."))
	C.verbs -= /mob/proc/genestealer_revive


//Boosts the range of your next sting attack by 1
/mob/proc/genestealer_boost_range()
	set category = "Genestealer"
	set name = "Ranged Sting (20)"
	set desc="Your next sting ability can be used against targets 2 squares away."

	var/datum/genestealer/genestealer = genestealer_power(20,0,100)
	if(!genestealer)	return 0
	genestealer.chem_charges -= 20
	to_chat(src, SPAN_NOTICE("Your throat adjusts to launch the sting."))
	genestealer.sting_range = 2
	src.verbs -= /mob/proc/genestealer_boost_range
	spawn(5)	src.verbs += /mob/proc/genestealer_boost_range
	return 1


//Recover from stuns.
/mob/proc/genestealer_unstun()
	set category = "Genestealer"
	set name = "Epinephrine Sacs (40)"
	set desc = "Removes all stuns"

	var/datum/genestealer/genestealer = genestealer_power(40,0,100,UNCONSCIOUS)
	if(!genestealer)	return 0
	genestealer.chem_charges -= 40

	var/mob/living/carbon/human/C = src
	C.set_stat(CONSCIOUS)
	C.SetParalysis(0)
	C.SetStunned(0)
	C.SetWeakened(0)
	C.lying = 0
	C.UpdateLyingBuckledAndVerbStatus()

	src.verbs -= /mob/proc/genestealer_unstun
	spawn(5)	src.verbs += /mob/proc/genestealer_unstun
	return 1


//Speeds up chemical regeneration
/mob/proc/genestealer_fastchemical()
	src.mind.genestealer.chem_recharge_rate *= 2
	return 1

//Increases macimum chemical storage
/mob/proc/genestealer_engorgedglands()
	src.mind.genestealer.chem_storage += 5
	return 1


//Prevents AIs tracking you but makes you easily detectable to the human-eye.
/mob/proc/genestealer_digitalcamo()
	set category = "Genestealer"
	set name = "Toggle Digital Camoflague"
	set desc = "The machine spirit can no longer track us, but we will look different if examined.  Has a constant cost while active."

	var/datum/genestealer/genestealer = genestealer_power()
	if(!genestealer)	return 0

	var/mob/living/carbon/human/C = src
	if(C.digitalcamo)	to_chat(C, SPAN_NOTICE("We return to normal."))
	else				to_chat(C, SPAN_NOTICE("We distort our form to prevent AI-tracking."))
	C.digitalcamo = !C.digitalcamo

	spawn(0)
		while(C && C.digitalcamo && C.mind && C.mind.genestealer)
			C.mind.genestealer.chem_charges = max(C.mind.genestealer.chem_charges - 1, 0)
			sleep(40)

	src.verbs -= /mob/proc/genestealer_digitalcamo
	spawn(5)	src.verbs += /mob/proc/genestealer_digitalcamo
	return 1


//Starts healing you every second for 10 seconds. Can be used whilst unconscious.
/mob/proc/genestealer_rapidregen()
	set category = "Genestealer"
	set name = "Rapid Regeneration (40)"
	set desc = "Begins rapidly regenerating.  Does not effect stuns or chemicals."

	var/datum/genestealer/genestealer = genestealer_power(40,0,100,UNCONSCIOUS)
	if(!genestealer)	return 0
	src.mind.genestealer.chem_charges -= 40

	var/mob/living/carbon/human/C = src
	spawn(0)
		for(var/i = 0, i<10,i++)
			if(C)
				C.adjustBruteLoss(-4)
				C.adjustToxLoss(-2)
				C.adjustOxyLoss(-2)
				C.adjustFireLoss(-2)
				sleep(10)

	src.verbs -= /mob/proc/genestealer_rapidregen
	spawn(5)	src.verbs += /mob/proc/genestealer_rapidregen
	return 1

// HIVE MIND UPLOAD/DOWNLOAD DNA

var/global/list/datum/absorbed_dna/hivemind_bank = list()

/mob/proc/genestealer_hiveupload()
	set category = "Genestealer"
	set name = "Hive Channel (40)"
	set desc = "Allows you to channel DNA in the airwaves to allow other genestealers to absorb it."

	var/datum/genestealer/genestealer = genestealer_power(40,1)
	if(!genestealer)	return

	var/list/names = list()
	for(var/datum/absorbed_dna/DNA in genestealer.absorbed_dna)
		var/valid = 1
		for(var/datum/absorbed_dna/DNB in hivemind_bank)
			if(DNA.name == DNB.name)
				valid = 0
				break
		if(valid)
			names += DNA.name

	if(length(names) <= 0)
		to_chat(src, SPAN_NOTICE("The airwaves already have all of our DNA."))
		return

	var/S = input("Select a DNA to channel: ", "Channel DNA", null) as null|anything in names
	if(!S)	return

	var/datum/absorbed_dna/chosen_dna = genestealer.GetDNA(S)
	if(!chosen_dna)
		return

	var/datum/species/spec = all_species[chosen_dna.speciesName]

	if(spec && spec.species_flags & SPECIES_FLAG_NEED_DIRECT_ABSORB)
		to_chat(src, SPAN_NOTICE("That species must be absorbed directly."))
		return

	genestealer.chem_charges -= 40
	hivemind_bank += chosen_dna
	to_chat(src, SPAN_NOTICE("We channel the DNA of [S] to the air."))
	return 1

/mob/proc/genestealer_hivedownload()
	set category = "Genestealer"
	set name = "Hive Absorb (60)"
	set desc = "Allows you to absorb DNA that is being channeled in the airwaves."

	var/datum/genestealer/genestealer = genestealer_power(60,1)
	if(!genestealer)	return

	var/list/names = list()
	for(var/datum/absorbed_dna/DNA in hivemind_bank)
		if(!(genestealer.GetDNA(DNA.name)))
			names[DNA.name] = DNA

	if(length(names) <= 0)
		to_chat(src, SPAN_NOTICE("There's no new DNA to absorb from the air."))
		return

	var/S = input("Select a DNA absorb from the air: ", "Absorb DNA", null) as null|anything in names
	if(!S)	return
	var/datum/dna/chosen_dna = names[S]
	if(!chosen_dna)
		return

	genestealer.chem_charges -= 60
	absorbDNA(chosen_dna)
	to_chat(src, SPAN_NOTICE("We absorb the DNA of [S] from the air."))
	return 1

// Fake Voice

/mob/proc/genestealer_mimicvoice()
	set category = "Genestealer"
	set name = "Mimic Voice"
	set desc = "Shape our vocal glands to form a voice of someone we choose. We cannot regenerate chemicals when mimicing."


	var/datum/genestealer/genestealer = genestealer_power()
	if(!genestealer)	return

	if(genestealer.mimicing)
		genestealer.mimicing = ""
		to_chat(src, SPAN_NOTICE("We return our vocal glands to their original location."))
		return

	var/mimic_voice = sanitize(input(usr, "Enter a name to mimic.", "Mimic Voice", null), MAX_NAME_LEN)
	if(!mimic_voice)
		return

	genestealer.mimicing = mimic_voice
	src.visible_message(SPAN_WARNING("[src]'s throat quivers inhumanly before returning to normal..."))
	to_chat(src, SPAN_NOTICE("We shape our glands to take the voice of <b>[mimic_voice]</b>, this will stop us from regenerating chemicals while active."))
	to_chat(src, SPAN_NOTICE("Use this power again to return to our original voice and reproduce chemicals again."))

	spawn(0)
		while(src && src.mind && src.mind.genestealer && src.mind.genestealer.mimicing)
			src.mind.genestealer.chem_charges = max(src.mind.genestealer.chem_charges - 1, 0)
			sleep(40)
		if(src && src.mind && src.mind.genestealer)
			src.mind.genestealer.mimicing = ""
	//////////
	//STINGS//	//They get a pretty header because there's just so fucking many of them ;_;
	//////////

/mob/proc/sting_can_reach(mob/M as mob, sting_range = 1)
	if(M.loc == src.loc)
		return 1 //target and source are in the same thing
	if(!isturf(src.loc) || !isturf(M.loc))
		to_chat(src, SPAN_WARNING("We cannot reach \the [M] with a sting!"))
		return 0 //One is inside, the other is outside something.
	// Maximum queued turfs set to 25; I don't *think* anything raises sting_range above 2, but if it does the 25 may need raising
	if(!AStar(src.loc, M.loc, TYPE_PROC_REF(/turf, AdjacentTurfs), TYPE_PROC_REF(/turf, Distance), max_nodes=25, max_node_depth=sting_range)) //If we can't find a path, fail
		to_chat(src, SPAN_WARNING("We cannot find a path to sting \the [M] by!"))
		return 0
	return 1

//Handles the general sting code to reduce on copypasta (seeming as somebody decided to make SO MANY dumb abilities)
/mob/proc/genestealer_sting(required_chems=0, verb_path, loud, sting_name = "unnamed sting")
	var/datum/genestealer/genestealer = genestealer_power(required_chems)
	if(!genestealer)								return

	var/list/victims = list()
	for(var/mob/living/carbon/human/C in oview(genestealer.sting_range))
		victims += C
	var/mob/living/carbon/human/T = input(src, "Who will we sting?") as null|anything in victims

	if(!T) return
	if(!(T in view(genestealer.sting_range))) return
	if(!sting_can_reach(T, genestealer.sting_range)) return
	if(!genestealer_power(required_chems)) return
	var/obj/item/organ/external/target_limb = T.get_organ(src.zone_sel.selecting)
	if (!target_limb)
		to_chat(src, SPAN_WARNING("[T] is missing that limb."))
		return
	genestealer.chem_charges -= required_chems
	genestealer.sting_range = 1
	src.verbs -= verb_path
	spawn(10)	src.verbs += verb_path
	if(!loud)
		to_chat(src, SPAN_NOTICE("We stealthily sting [T]."))
	else
		visible_message(SPAN_DANGER("[src] fires an organic shard into [T]!"))
	admin_attack_log(src, T, "Stung their victim using [sting_name]", "Was stung using [sting_name]", "stung using [sting_name]")

	for(var/obj/item/clothing/clothes in list(T.head, T.wear_mask, T.wear_suit, T.w_uniform, T.gloves, T.shoes))
		if(istype(clothes) && (clothes.body_parts_covered & target_limb.body_part) && (clothes.item_flags & ITEM_FLAG_THICKMATERIAL))
			to_chat(src, SPAN_WARNING("[T]'s armor has protected them."))
			return //thick clothes will protect from the sting

	if(T.isSynthetic() || BP_IS_ROBOTIC(target_limb)) return
	if(!T.mind || !T.mind.genestealer) return T	//T will be affected by the sting
	to_chat(T, SPAN_WARNING("You feel a tiny prick."))
	return


/mob/proc/genestealer_lsdsting()
	set category = "Genestealer"
	set name = "Hallucination Sting (15)"
	set desc = "Causes terror in the target."

	var/mob/living/carbon/human/T = genestealer_sting(15, /mob/proc/genestealer_lsdsting, sting_name = "Hallucination Sting")
	if(!T)	return 0
	spawn(rand(300,600))
		if(T)	T.hallucination(400, 80)
	return 1

/mob/proc/genestealer_silence_sting()
	set category = "Genestealer"
	set name = "Silence sting (10)"
	set desc="Sting target"

	var/mob/living/carbon/human/T = genestealer_sting(10,/mob/proc/genestealer_silence_sting, sting_name = "Silence Sting")
	if(!T)	return 0
	T.silent += 30
	return 1

/mob/proc/genestealer_blind_sting()
	set category = "Genestealer"
	set name = "Blind sting (60)"
	set desc="Sting target"

	var/mob/living/carbon/human/T = genestealer_sting(60,/mob/proc/genestealer_blind_sting, sting_name = "Blind Sting")
	if(!T)	return 0
	//to_chat(T, SPAN_DANGER("Your eyes burn horrificly!"))
	T.disabilities |= NEARSIGHTED
	spawn(300)	T.disabilities &= ~NEARSIGHTED
	T.eye_blind = 10
	T.eye_blurry = 20
	return 1

/mob/proc/genestealer_transform_sting()
	set category = "Genestealer"
	set name = "Transform sting (60)"
	set desc="Sting target"

	var/mob/living/carbon/human/T = genestealer_sting(60,/mob/proc/genestealer_transform_sting, sting_name = "Transform Sting")
	if(!T)	return 0
	to_chat(T, SPAN_DANGER("You feel your body changing!"))
	if(!do_after(src, 15 SECONDS, T, DO_PUBLIC_UNIQUE))
		return
	T.make_genestealer()
	return 1

/mob/proc/genestealer_deaf_sting()
	set category = "Genestealer"
	set name = "Deaf sting (5)"
	set desc="Sting target:"

	var/mob/living/carbon/human/T = genestealer_sting(5,/mob/proc/genestealer_deaf_sting, sting_name = "Deaf Sting")
	if(!T)	return 0
	to_chat(T, SPAN_DANGER("Your ears pop and begin ringing loudly!"))
	T.ear_deaf += 15
	return 1

/mob/proc/genestealer_DEATHsting()
	set category = "Genestealer"
	set name = "Death Sting (35)"
	set desc = "Inject your victim with lethal acid."
	var/loud = 1

	var/mob/living/carbon/human/T = genestealer_sting(35,/mob/proc/genestealer_DEATHsting,loud, sting_name = "Death Sting")
	if(!T)	return 0
	to_chat(T, SPAN_DANGER("You feel a small prick and your chest begins to burn..."))
	T.make_jittery(400)
	if(T.reagents)	T.reagents.add_reagent(/datum/reagent/acid/polyacid, 10)
	return 1

/mob/proc/genestealer_extract_dna_sting()
	set category = "Genestealer"
	set name = "Extract DNA Sting (60)"
	set desc="Stealthily sting a target to extract their DNA."

	var/datum/genestealer/genestealer = null
	if(src.mind && src.mind.genestealer)
		genestealer = src.mind.genestealer
	if(!genestealer)
		return 0

	var/mob/living/carbon/human/T = genestealer_sting(60, /mob/proc/genestealer_extract_dna_sting, sting_name = "Extract DNA Sting")
	if(!T)	return 0
	if((MUTATION_HUSK in T.mutations) || (T.species.species_flags & SPECIES_FLAG_NO_SCAN))
		to_chat(src, SPAN_WARNING("We cannot extract DNA from this creature!"))
		return 0

	if(T.species.species_flags & SPECIES_FLAG_NEED_DIRECT_ABSORB)
		to_chat(src, SPAN_NOTICE("That species must be absorbed directly."))
		return

	var/datum/absorbed_dna/newDNA = new(T.real_name, T.dna, T.species.name, T.languages)
	absorbDNA(newDNA)
	return 1
