/obj/item/weapon/gun/energy/gun
	name = "energy gun"
	desc = "A basic hybrid energy gun with two settings: stun and kill."
	icon_state = "energy"
	item_state = null	//so the human update icon uses the icon_state instead.
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	origin_tech = "combat=4;magnets=3"
	modifystate = 2
	can_flashlight = 1
	ammo_x_offset = 3
	flight_x_offset = 15
	flight_y_offset = 10

/obj/item/weapon/gun/energy/gun/mini
	name = "miniature energy gun"
	desc = "A small, pistol-sized energy gun with a built-in flashlight. It has two settings: stun and kill."
	icon_state = "mini"
	item_state = "gun"
	w_class = 2
	cell_type = /obj/item/weapon/stock_parts/cell{charge = 600; maxcharge = 600}
	ammo_x_offset = 2
	charge_sections = 3
	can_flashlight = 0 // Can't attach or detach the flashlight, and override it's icon update

/obj/item/weapon/gun/energy/gun/mini/New()
	F = new /obj/item/device/flashlight/seclite(src)
	..()

/obj/item/weapon/gun/energy/gun/mini/update_icon()
	..()
	if(F && F.on)
		add_overlay("mini-light")

/obj/item/weapon/gun/energy/gun/hos
	name = "\improper X-01 MultiPhase Energy Gun"
	desc = "This is an expensive, modern recreation of an antique laser gun. This gun has several unique firemodes, but lacks the ability to recharge over time."
	icon_state = "hoslaser"
	origin_tech = null
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/hos, /obj/item/ammo_casing/energy/laser/hos, /obj/item/ammo_casing/energy/disabler)
	ammo_x_offset = 4

/obj/item/weapon/gun/energy/gun/dragnet
	name = "\improper DRAGnet"
	desc = "The \"Dynamic Rapid-Apprehension of the Guilty\" net is a revolution in law enforcement technology."
	icon_state = "dragnet"
	origin_tech = "combat=4;magnets=3;bluespace=4"
	ammo_type = list(/obj/item/ammo_casing/energy/net, /obj/item/ammo_casing/energy/trap)
	can_flashlight = 0
	ammo_x_offset = 1

/obj/item/weapon/gun/energy/gun/dragnet/snare
	name = "Energy Snare Launcher"
	desc = "Fires an energy snare that slows the target down"
	ammo_type = list(/obj/item/ammo_casing/energy/trap)

/obj/item/weapon/gun/energy/gun/turret
	name = "hybrid turret gun"
	desc = "A heavy hybrid energy cannon with two settings: Stun and kill."
	icon_state = "turretlaser"
	item_state = "turretlaser"
	slot_flags = null
	w_class = 5
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	weapon_weight = WEAPON_MEDIUM
	can_flashlight = 0
	trigger_guard = TRIGGER_GUARD_NONE
	ammo_x_offset = 2

/obj/item/weapon/gun/energy/gun/nuclear
	name = "advanced energy gun"
	desc = "An energy gun with an experimental miniaturized nuclear reactor that automatically charges the internal power cell."
	icon_state = "nucgun"
	item_state = "nucgun"
	origin_tech = "combat=4;magnets=4;powerstorage=4"
	charge_delay = 5
	can_charge = 0
	ammo_x_offset = 1
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/disabler)
	selfcharge = 1
	var/fail_tick = 0
	var/fail_chance = 0

/obj/item/weapon/gun/energy/gun/nuclear/process()
	if(fail_tick > 0)
		fail_tick--
	..()

/obj/item/weapon/gun/energy/gun/nuclear/shoot_live_shot()
	failcheck()
	update_icon()
	..()

/obj/item/weapon/gun/energy/gun/nuclear/proc/failcheck()
	if(prob(fail_chance) && istype(loc, /mob/living))
		var/mob/living/M = loc
		switch(fail_tick)
			if(0 to 200)
				fail_tick += (2*(fail_chance))
				M.rad_act(40)
				M << "<span class='userdanger'>Your [name] feels warmer.</span>"
			if(201 to INFINITY)
				SSobj.processing.Remove(src)
				M.rad_act(80)
				crit_fail = 1
				M << "<span class='userdanger'>Your [name]'s reactor overloads!</span>"

/obj/item/weapon/gun/energy/gun/nuclear/emp_act(severity)
	..()
	fail_chance = min(fail_chance + round(15/severity), 100)

/obj/item/weapon/gun/energy/gun/nuclear/update_icon()
	..()
	if(crit_fail)
		add_overlay("[icon_state]_fail_3")
	else
		switch(fail_tick)
			if(0)
				add_overlay("[icon_state]_fail_0")
			if(1 to 150)
				add_overlay("[icon_state]_fail_1")
			if(151 to INFINITY)
				add_overlay("[icon_state]_fail_2")
