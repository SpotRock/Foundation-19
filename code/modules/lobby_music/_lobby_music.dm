// Include the lobby music tracks to automatically add them to the random selection.

/lobby_music
	var/artist
	var/title
	var/album
	var/license
	var/song
	var/url // Remember to include http:// or https://

/lobby_music/proc/play_to(listener)
	if(!song)
		return
	to_chat(listener, SPAN_GOOD("Now Playing:"))
	to_chat(listener, SPAN_GOOD("[title][artist ? " by [artist]" : ""][album ? " ([album])" : ""]"))
	if(url)
		to_chat(listener, url)
	if(license)
		var/license_url = license_to_url[license]
		to_chat(listener, SPAN_GOOD("License: [license_url ? "<a href='[license_url]'>[license]</a>" : license]"))
	sound_to(listener, sound(song, repeat = 1, wait = 0, volume = 70, channel = 1))
