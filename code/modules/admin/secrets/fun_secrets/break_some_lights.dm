/datum/admin_secret_item/fun_secret/break_some_lights
	name = "Break Some Lights"

/datum/admin_secret_item/fun_secret/break_some_lights/execute(mob/user)
	. = ..()
	if(.)
		for (var/datum/powernet/PN in SSmachines.powernets)
			PN.apcs_overload(overload_chance = 20)
