/obj/item/paper/talisman
	icon_state = "paper_talisman"
	var/imbue = null
	info = "<center><img src='talisman.png'></center><br/><br/>"
	language = LANGUAGE_CULT

/obj/item/paper/talisman/attack_self(mob/living/user)
	if(iscultist(user))
		to_chat(user, "Attack your target to use this talisman.")
	else
		to_chat(user, "You see strange symbols on the paper. Are they supposed to mean something?")

/obj/item/paper/talisman/attack(mob/living/M, mob/living/user)
	return

/obj/item/paper/talisman/stun/attack_self(mob/living/user)
	if(iscultist(user))
		to_chat(user, "This is a stun talisman.")
	..()

/obj/item/paper/talisman/stun/attack(mob/living/M, mob/living/user)
	if(!iscultist(user))
		return
	user.say("Dream Sign: Evil Sealing Talisman!") //TODO: never change this shit
	var/obj/item/nullrod/nrod = locate() in M
	if(nrod)
		user.visible_message(SPAN_DANGER("\The [user] invokes \the [src] at [M], but they are unaffected."), SPAN_DANGER("You invoke \the [src] at [M], but they are unaffected."))
		return
	else
		user.visible_message(SPAN_DANGER("\The [user] invokes \the [src] at [M]."), SPAN_DANGER("You invoke \the [src] at [M]."))

	if(issilicon(M))
		M.Weaken(15)
		M.silent += 15
	else if(iscarbon(M))
		var/mob/living/carbon/C = M
		C.silent += 15
		C.Weaken(20)
		C.Stun(20)
	admin_attack_log(user, M, "Used a stun talisman.", "Was victim of a stun talisman.", "used a stun talisman on")
	user.unEquip(src)
	qdel(src)

/obj/item/paper/talisman/emp/attack_self(mob/living/user)
	if(iscultist(user))
		to_chat(user, "This is an emp talisman.")
	..()

/obj/item/paper/talisman/emp/afterattack(atom/target, mob/user, proximity)
	if(!iscultist(user))
		return
	if(!proximity)
		return
	user.say("Ta'gh fara[pick("'","`")]qha fel d'amar det!")
	user.visible_message(SPAN_DANGER("\The [user] invokes \the [src] at [target]."), SPAN_DANGER("You invoke \the [src] at [target]."))
	target.emp_act(1)
	user.unEquip(src)
	qdel(src)
