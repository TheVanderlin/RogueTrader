/datum/department/medbay
	name = "Medicae"
	flag = MED
	goals = list(
		/datum/goal/department/medical_fatalities
	)

/datum/goal/department/medical_fatalities
	var/max_fatalities

/datum/goal/department/medical_fatalities/New()
	max_fatalities = rand(15,20)
	..()

/datum/goal/department/medical_fatalities/update_strings()
	description = "Avoid having more than [max_fatalities] [max_fatalities == 1 ? "fatality" : "fatalities"] by end of mission."

/datum/goal/department/medical_fatalities/get_summary_value()
	return " ([GLOB.crew_death_count] death\s so far)"

/datum/goal/department/medical_fatalities/check_success()
	return GLOB.crew_death_count <= max_fatalities




// End the shift with % suit sensors set to at least trackers
// Perform an autopsy
