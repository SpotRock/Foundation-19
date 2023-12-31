/*
		name
		key
		description
		role
		comments
		chassis
		say_verb
		ready = 0
*/

/datum/paiCandidate/proc/savefile_path(mob/user)
	return "data/player_saves/[copytext(user.ckey, 1, 2)]/[user.ckey]/pai.sav"

/datum/paiCandidate/proc/savefile_save(mob/user)
	if(IsGuestKey(user.key))
		return 0

	var/savefile/F = new /savefile(src.savefile_path(user))

	to_save(F["name"], src.name)
	to_save(F["description"], src.description)
	to_save(F["role"], src.role)
	to_save(F["comments"], src.comments)
	to_save(F["chassis"], src.chassis)
	to_save(F["say_verb"], src.say_verb)
	to_save(F["version"], 1)

	return 1

// loads the savefile corresponding to the mob's ckey
// if silent=true, report incompatible savefiles
// returns 1 if loaded (or file was incompatible)
// returns 0 if savefile did not exist

/datum/paiCandidate/proc/savefile_load(mob/user, silent = 1)
	if (IsGuestKey(user.key))
		return 0

	var/path = savefile_path(user)

	if (!fexists(path))
		return 0

	var/savefile/F = new /savefile(path)

	if(!F) return //Not everyone has a pai savefile.

	var/version = null
	from_save(F["version"], version)

	if (isnull(version) || version != 1)
		fdel(path)
		if (!silent)
			alert(user, "Your savefile was incompatible with this version and was deleted.")
		return 0

	from_save(F["name"], src.name)
	from_save(F["description"], src.description)
	from_save(F["role"], src.role)
	from_save(F["comments"], src.comments)
	from_save(F["chassis"], src.chassis)
	from_save(F["say_verb"], src.say_verb)
	return 1
