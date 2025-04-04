/mob/living/proc/show_psi_assay(mob/viewer, obj/machinery/psi_meter/machine)

	if(!viewer) viewer = usr

	var/use_He_is =  "You are"
	var/use_He_has = "You have"
	if(istype(machine) || viewer != src)
		var/datum/gender/G = GLOB.gender_datums[gender]
		use_He_is =  "[G.He] [G.is]"
		use_He_has = "[G.He] [G.has]"

	var/list/dat = list()

	dat += "<h2>Summary</h2>"
	dat += "<hr>"

	if(psi)

		// Hi Warhammer 40k rating system, how are you?
		// I hope you get along with the Galactic Milieu metapsychics.
		//Revamping this, more 40K.
		var/use_rating
		var/effective_rating = psi.rating
		if(effective_rating > 1 && psi.suppressed)
			effective_rating = max(0, psi.rating-2)
		var/rating_descriptor
		if(mind && !psi.suppressed)
			if(GLOB.paramounts.is_antagonist(mind))
				use_rating = SPAN_COLOR("#ff0000", "<b>[effective_rating]-Alpha</b>")
				rating_descriptor = "This indicates a completely deviant psi complexus, within the very highest levels of recorded ability. Approach with care."
			// This space intentionally left blank (for Omega-Minus psi vampires. todo)
			if(viewer != usr && GLOB.thralls.is_antagonist(mind) && ishuman(viewer))
				var/mob/living/H = viewer
				if(H.psi && H.psi.get_rank(PSI_BIOMANCY) >= PSI_RANK_DELTA)
					dat += SPAN_COLOR("#ff0000", "<b>Their mind has been cored like an apple, and enslaved by another operant psychic.</b>")

		if(!use_rating)
			switch(effective_rating)
				if(1)
					use_rating = "[effective_rating]-Nu"
					rating_descriptor = "This indicates the presence of minor latent Psyker potential."
				if(2)
					use_rating = "[effective_rating]-Iota"
					rating_descriptor = "This indicates the presence of minor Psyker capabilities."
				if(3)
					use_rating = SPAN_COLOR("#f4f441", "[effective_rating]-Zeta")
					rating_descriptor = "This indicates the presence of Psyker capabilities."
				if(4)
					use_rating = SPAN_COLOR("#f4bc42", "[effective_rating]-Delta")
					rating_descriptor = "This indicates the presence of significant Psyker capabilities."
				if(5)
					use_rating = SPAN_COLOR("#ff0000", "[effective_rating]-Gamma")
					rating_descriptor = "This indicates the presence of major Psyker capabilities."
				if(6)
					use_rating = SPAN_COLOR("#f4bc42", "[effective_rating]-Beta")
					rating_descriptor = "This indicates the presence of exceptional Psyker capabilities."
				if(7)
					use_rating = SPAN_COLOR("#ff0000", "[effective_rating]-Alpha")
					rating_descriptor = "This indicates the presence of overwhelming Psyker capabilities."
				else
					use_rating = "[effective_rating]-Rho"
					rating_descriptor = "This indicates the presence of trace latent psi capabilities."

		dat += "[use_He_has] an overall psi rating of [use_rating].<br><i>[rating_descriptor]</i><hr>"

		if(!istype(machine))

			dat += "[use_He_is] currently <b>[psi.suppressed ? "suppressing" : "not suppressing"]</b> your psyker abilities.<br>"
			dat += "[use_He_has] <b>[psi.stamina]/[psi.max_stamina]</b> psi stamina remaining.<br>"
			dat += "<hr>"

			for(var/faculty_id in psi.ranks)
				var/singleton/psionic_faculty/faculty = SSpsi.get_faculty(faculty_id)
				if(psi.ranks[faculty.id] > 0)
					dat += "[use_He_is] assayed at the rank of <b>[GLOB.psychic_ranks_to_strings[psi.ranks[faculty.id]]]</b> for the <b>[faculty.name] faculty</b>.<br>"
				else
					dat += "[use_He_has] no notable power within the <b>[faculty.name] faculty</b>.<br>"
			dat += "<hr>"

			if(viewer == usr)
				dat += "<table width = 100% border = 1><tr><td colspan = 2><h2>Psi-power Usage</h2></td></tr>"
				for(var/faculty_id in psi.ranks)
					var/list/check_powers = psi.get_powers_by_faculty(faculty_id)
					if(LAZYLEN(check_powers))
						var/singleton/psionic_faculty/faculty = SSpsi.get_faculty(faculty_id)
						dat += "<tr><td colspan = 2>[use_He_has] access to the following psi-powers within the <b>[faculty.name] faculty</b>:</td></tr>"
						for(var/singleton/psionic_power/power in check_powers)
							dat += "<tr><td><b>[power.name]</b></td><td>[power.use_description]</td></tr>"
				dat += "</table>"
	else
		dat += "[use_He_has] no notable Psyker sensitivity."

	if(istype(machine))
		dat += "<a href='byond://?src=\ref[machine];print=1'>Print</a> <a href='byond://?src=\ref[machine];clear=1'>Clear Buffer</a>"
		machine.last_assay = dat
		return

	var/datum/browser/popup = new(viewer, "psi_assay_\ref[src]", "Psi-Assay")
	popup.set_content(jointext(dat,null))
	popup.open()
