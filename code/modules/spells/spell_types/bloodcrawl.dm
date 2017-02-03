/obj/effect/proc_holder/spell/bloodcrawl
	name = "Blood Crawl"
	desc = "Use pools of blood to phase out of existence."
	charge_max = 0
	clothes_req = 0
	//If you couldn't cast this while phased, you'd have a problem
	phase_allowed = 1
	selection_type = "range"
	range = 1
	cooldown_min = 0
	overlay = null
	action_icon_state = "bloodcrawl"
	action_background_icon_state = "bg_demon"
	var/phased = 0

/obj/effect/proc_holder/spell/bloodcrawl/choose_targets(mob/user = usr)
	for(var/obj/effect/decal/cleanable/target in range(range, get_turf(user)))
		if(target.can_bloodcrawl_in())
			perform(target)
			return
	revert_cast()
	user << "<span class='warning'>There must be a nearby source of blood!</span>"

/obj/effect/proc_holder/spell/bloodcrawl/perform(obj/effect/decal/cleanable/target, recharge = 1, mob/living/user = usr)
	if(istype(user))
		if(phased)
			if(user.phasein(target))
				phased = 0
		else
			if(user.phaseout(target))
				phased = 1
		start_recharge()
		return
	revert_cast()
	user << "<span class='warning'>You are unable to blood crawl!</span>"