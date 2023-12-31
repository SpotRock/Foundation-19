/atom/proc/DefaultTopicState()
	return GLOB.default_state

/atom/Topic(href, href_list = list(), datum/topic_state/state)
	if((. = ..()))
		return
	var/client/usr_client = usr.client
	var/list/paramslist = list()

	if(href_list["statpanel_item_click"])
		switch(href_list["statpanel_item_click"])
			if("left")
				paramslist[LEFT_CLICK] = "1"
			if("right")
				paramslist[RIGHT_CLICK] = "1"
			if("middle")
				paramslist[MIDDLE_CLICK] = "1"
			else
				return

		if(href_list["statpanel_item_shiftclick"])
			paramslist[SHIFT_CLICK] = "1"
		if(href_list["statpanel_item_ctrlclick"])
			paramslist[CTRL_CLICK] = "1"
		if(href_list["statpanel_item_altclick"])
			paramslist[ALT_CLICK] = "1"

		var/mouseparams = list2params(paramslist)
		usr_client.Click(src, loc, null, mouseparams)

	state = state || DefaultTopicState() || GLOB.default_state
	if(CanUseTopic(usr, state, href_list) == STATUS_INTERACTIVE)
		CouldUseTopic(usr)
		return OnTopic(usr, href_list, state)
	CouldNotUseTopic(usr)
	return TRUE

/atom/proc/OnTopic(mob/user, href_list, datum/topic_state/state)
	return TOPIC_NOACTION

// Override prescribes default state argument.
/atom/CanUseTopic(mob/user, datum/topic_state/state = DefaultTopicState() || GLOB.default_state, href_list)
	return ..()

/obj/CanUseTopic(mob/user, datum/topic_state/state = DefaultTopicState() || GLOB.default_state, href_list)
	return min(..(), user.CanUseObjTopic(src, state))

/mob/living/CanUseObjTopic(obj/O, datum/topic_state/state)
	. = ..()
	if(state.check_access && !O.check_access(src))
		. = min(., STATUS_UPDATE)

/mob/proc/CanUseObjTopic()
	return STATUS_INTERACTIVE

/atom/proc/CouldUseTopic(mob/user)
	user.AddTopicPrint(src)

/mob/proc/AddTopicPrint(atom/target)
	if(!istype(target))
		return
	target.add_hiddenprint(src)

/mob/living/AddTopicPrint(atom/target)
	if(!istype(target))
		return
	if(Adjacent(target))
		target.add_fingerprint(src)
	else
		target.add_hiddenprint(src)

/mob/living/silicon/ai/AddTopicPrint(atom/target)
	if(!istype(target))
		return
	target.add_hiddenprint(src)

/atom/proc/CouldNotUseTopic(mob/user)
