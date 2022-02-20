/obj/item/blacksmith
	name = "item"
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "iron_ingot"
	lefthand_file = 'white/valtos/icons/lefthand.dmi'
	righthand_file = 'white/valtos/icons/righthand.dmi'
	custom_materials = list(/datum/material/iron = 10000)
	var/real_force = 0
	var/grade = ""
	var/level = 1

/obj/item/blacksmith/smithing_hammer
	name = "smithing hammer"
	desc = "Used for forging."
	icon_state = "molotochek"
	w_class = WEIGHT_CLASS_HUGE
	force = 20
	throwforce = 25
	throw_range = 4

/obj/item/blacksmith/smithing_hammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE, force_unwielded=20, force_wielded=20)

/obj/item/blacksmith/smithing_hammer/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	..()

	if(iswallturf(target) && proximity_flag)
		var/turf/closed/wall/W = target
		var/chance = (W.hardness * 0.5)
		if(chance < 10)
			return FALSE

		if(prob(chance))
			playsound(src, 'sound/effects/meteorimpact.ogg', 100, 1)
			W.dismantle_wall(TRUE)

		else
			playsound(src, 'sound/effects/bang.ogg', 50, 1)
			W.add_dent(WALL_DENT_HIT)
			visible_message(span_danger("<b>[user]</b> hits the <b>[W]</b> with [src]!") , null, COMBAT_MESSAGE_RANGE)
	return TRUE

/obj/item/blacksmith/chisel
	name = "chisel"
	desc = "Used for carving on stone."
	icon_state = "chisel"
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_SMALL
	force = 10
	throwforce = 12
	throw_range = 7

/obj/item/blacksmith/tongs
	name = "tongs"
	desc = "Essential tool for smithing."
	icon_state = "tongs"
	w_class = WEIGHT_CLASS_SMALL
	force = 4
	throwforce = 6
	throw_range = 7

/obj/item/blacksmith/tongs/attack_self(mob/user)
	. = ..()
	if(contents.len)
		var/obj/O = contents[contents.len]
		O.forceMove(drop_location())
		icon_state = "tongs"

/obj/item/blacksmith/tongs/attack(mob/living/carbon/C, mob/user)
	if(tearoutteeth(C, user))
		return FALSE
	else
		..()

/obj/item/blacksmith/ingot
	name = "iron ingot"
	desc = "Can be forged into something."
	icon_state = "iron_ingot"
	w_class = WEIGHT_CLASS_NORMAL
	force = 2
	throwforce = 5
	throw_range = 7
	var/datum/smithing_recipe/recipe = null
	var/durability = 6
	var/progress_current = 0
	var/progress_need = 10
	var/heattemp = 0
	var/type_metal = "iron"
	var/mod_grade = 1

/obj/item/blacksmith/ingot/gold
	name = "golden ingot"
	icon_state = "gold_ingot"
	type_metal = "gold"

/obj/item/blacksmith/ingot/examine(mob/user)
	. = ..()
	var/ct = ""
	switch(heattemp)
		if(200 to INFINITY)
			ct = "red-hot"
		if(100 to 199)
			ct = "very hot"
		if(1 to 99)
			ct = "hot enough"
		else
			ct = "cold"

	. += "\the [src] is [ct]."

/obj/item/blacksmith/ingot/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/blacksmith/ingot/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/blacksmith/ingot/process()
	if(heattemp >= 25)
		heattemp -= 25
		if(!overlays.len)
			add_overlay("ingot_hot")
	else if(overlays.len)
		cut_overlays()


/obj/item/blacksmith/ingot/attackby(obj/item/I, mob/living/user, params)

	if(user.a_intent == INTENT_HARM)
		return ..()

	if(istype(I, /obj/item/blacksmith/tongs))
		if(I.contents.len)
			to_chat(user, span_warning("You are already holding something with [I]!"))
			return
		else
			src.forceMove(I)
			if(heattemp > 0)
				I.icon_state = "tongs_hot"
			else
				I.icon_state = "tongs_cold"
			to_chat(user, span_notice("You grab \the [src] with \the [I]."))
			return

/obj/item/storage/belt/dagger_sneath
	name = "dagger sneath"
	desc = "Perfect habitat for your little friend."

	icon = 'white/valtos/icons/clothing/belts.dmi'
	worn_icon = 'white/valtos/icons/clothing/mob/belt.dmi'

	icon_state = "dagger_sneath"
	inhand_icon_state = "dagger_sneath"
	worn_icon_state = "dagger_sneath"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/dagger_sneath/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.rustle_sound = FALSE
	STR.quickdraw = TRUE
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/blacksmith/dagger
		))

/obj/item/storage/belt/dagger_sneath/update_icon_state()
	icon_state = "dagger_sneath"
	worn_icon_state = "dagger_sneath"
	if(contents.len)
		icon_state += "-sword"
		worn_icon_state += "-sword"
	return ..()

/obj/item/blacksmith/torch_handle
	name = "torch handle"
	desc = "Can be attached to a wall."
	icon_state = "torch_handle"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = 10000)
	var/result_path = /obj/machinery/torch_fixture

/obj/item/blacksmith/torch_handle/proc/try_build(turf/on_wall, mob/user)
	if(get_dist(on_wall, user)>1)
		return
	var/ndir = get_dir(on_wall, user)
	if(!(ndir in GLOB.cardinals))
		return
	var/turf/T = get_turf(user)
	if(!isfloorturf(T))
		to_chat(user, span_warning("You can't place [src] on the floor!"))
		return
	if(locate(/obj/machinery/torch_fixture) in view(1))
		to_chat(user, span_warning("There is something already attached to it!"))
		return

	return TRUE

/obj/item/blacksmith/torch_handle/proc/attach(turf/on_wall, mob/user)
	if(result_path)
		playsound(src.loc, 'sound/machines/click.ogg', 75, TRUE)
		user.visible_message(span_notice("[user.name] attaches [src] to the wall.") ,
			span_notice("You attach the handle to the wall.") ,
			span_hear("You hear a metal click."))
		var/ndir = get_dir(on_wall, user)

		new result_path(get_turf(user), ndir, TRUE)
	qdel(src)

/obj/machinery/torch_fixture
	name = "torch"
	desc = "Provides light."
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "torch_handle_wall"
	layer = BELOW_MOB_LAYER
	max_integrity = 100
	use_power = NO_POWER_USE
	var/light_type = /obj/item/flashlight/flare/torch
	var/status = LIGHT_EMPTY
	var/fuel = 0
	var/on = FALSE

/obj/machinery/torch_fixture/Initialize(mapload, ndir)
	if(on)
		fuel = 5000
		status = LIGHT_OK
		recalculate_light()
	dir = turn(ndir, 180)
	switch(dir)
		if(WEST)	pixel_x = -32
		if(EAST)	pixel_x = 32
		if(NORTH)	pixel_y = 32
	. = ..()

/obj/machinery/torch_fixture/process(delta_time)
	if(on)
		fuel = max(fuel -= delta_time, 0)
		recalculate_light()

/obj/machinery/torch_fixture/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/machinery/torch_fixture/proc/recalculate_light()
	if(status == LIGHT_EMPTY)
		set_light(0, 0, LIGHT_COLOR_ORANGE)
		cut_overlays()
		on = FALSE
		return
	if(on)
		var/mutable_appearance/torch_underlay = mutable_appearance(icon, "torch_handle_overlay_on", HIGH_OBJ_LAYER)
		cut_overlays()
		add_overlay(torch_underlay)
	else if(fuel)
		var/mutable_appearance/torch_underlay = mutable_appearance(icon, "torch_handle_overlay_off", HIGH_OBJ_LAYER)
		cut_overlays()
		add_overlay(torch_underlay)
		return
	else
		var/mutable_appearance/torch_underlay = mutable_appearance(icon, "torch_handle_overlay_burned", HIGH_OBJ_LAYER)
		cut_overlays()
		add_overlay(torch_underlay)
		return
	switch(fuel)
		if(-INFINITY to 0)
			set_light(0, 0, LIGHT_COLOR_ORANGE)
			var/mutable_appearance/torch_underlay = mutable_appearance(icon, "torch_handle_overlay_burned", HIGH_OBJ_LAYER)
			cut_overlays()
			add_overlay(torch_underlay)
			on = FALSE
		if(1 to 1000)
			set_light(4, 1, LIGHT_COLOR_ORANGE)
		if(1001 to 2000)
			set_light(6, 1, LIGHT_COLOR_ORANGE)
		if(2001 to INFINITY)
			set_light(9, 1, LIGHT_COLOR_ORANGE)

/obj/machinery/torch_fixture/attackby(obj/item/W, mob/living/user, params)

	if(istype(W, /obj/item/flashlight/flare/torch))
		if(status == LIGHT_OK)
			to_chat(user, span_warning("There is a torch already!"))
		else
			src.add_fingerprint(user)
			var/obj/item/flashlight/flare/torch/L = W
			if(istype(L, light_type))
				if(!user.temporarilyRemoveItemFromInventory(L))
					return
				src.add_fingerprint(user)
				to_chat(user, span_notice("You place [L] inside."))
				status = LIGHT_OK
				fuel = L.fuel
				on = L.on
				recalculate_light()
				qdel(L)
				START_PROCESSING(SSobj, src)
			else
				to_chat(user, span_warning("It supports regulat torches only!"))
	else
		return ..()

/obj/machinery/torch_fixture/attack_hand(mob/living/carbon/human/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	add_fingerprint(user)

	if(status == LIGHT_EMPTY)
		to_chat(user, span_warning("There is no torch!"))
		return

	var/obj/item/flashlight/flare/torch/L = new light_type()

	L.on = on
	L.fuel = fuel
	L.forceMove(loc)
	L.update_brightness()

	if(!fuel)
		L.icon_state = "torch-empty"

	if(user)
		L.add_fingerprint(user)
		user.put_in_active_hand(L)

	status = LIGHT_EMPTY
	STOP_PROCESSING(SSobj, src)
	recalculate_light()
	return

#define SHPATEL_BUILD_FLOOR 1
#define SHPATEL_BUILD_WALL 2
#define SHPATEL_BUILD_DOOR 3
#define SHPATEL_BUILD_TABLE 4
#define SHPATEL_BUILD_CHAIR 5

/obj/item/blacksmith/shpatel
	name = "trowel"
	desc = "Used for building purposes."
	icon_state = "shpatel"
	w_class = WEIGHT_CLASS_SMALL
	force = 8
	throwforce = 12
	throw_range = 3
	var/mode = SHPATEL_BUILD_FLOOR

/obj/item/blacksmith/shpatel/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	do_job(A, user)

/obj/item/blacksmith/shpatel/proc/check_resources()
	var/mat_to = 0
	var/mat_need = 0
	for(var/obj/item/stack/sheet/stone/B in view(1))
		mat_to += B.amount
	switch(mode)
		if(SHPATEL_BUILD_WALL) mat_need = 4
		if(SHPATEL_BUILD_FLOOR) mat_need = 1
	if(mat_to >= mat_need)
		return TRUE
	else
		return FALSE

/obj/item/blacksmith/shpatel/proc/use_resources(var/turf/open/floor/T, mob/user)
	switch(mode)
		if(SHPATEL_BUILD_WALL)
			var/blocks_need = 5
			for(var/obj/item/stack/sheet/stone/B in view(1))
				blocks_need -= B.amount
				B.amount = -blocks_need
				B.update_icon()
				if(B.amount <= 0)
					qdel(B)
				if(blocks_need <= 0)
					break
			T.ChangeTurf(/turf/closed/wall/stonewall, flags = CHANGETURF_IGNORE_AIR)
			user.visible_message(span_notice("<b>[user]</b> constructs a stone wall.") , \
								span_notice("You construct a stone wall."))
		if(SHPATEL_BUILD_FLOOR)
			var/blocks_need = 1
			for(var/obj/item/stack/sheet/stone/B in view(1))
				blocks_need -= B.amount
				B.amount = -blocks_need
				B.update_icon()
				if(B.amount <= 0)
					qdel(B)
				if(blocks_need <= 0)
					break
			T.ChangeTurf(/turf/open/floor/stone, flags = CHANGETURF_INHERIT_AIR)
			user.visible_message(span_notice("<b>[user]</b> constructs stone floor.") , \
								span_notice("You construct stone floor."))

/obj/item/blacksmith/shpatel/proc/do_job(atom/A, mob/user)
	if(!istype(A, /turf/open/floor))
		return
	if(mode != SHPATEL_BUILD_FLOOR && !istype(A, /turf/open/floor/stone))
		to_chat(user, span_warning("Can't build here!"))
		return
	var/turf/T = get_turf(A)
	if(check_resources())
		if(do_after(user, 5 SECONDS, target = A))
			if(check_resources())
				use_resources(T, user)
				playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
				return TRUE
	else
		to_chat(user, span_warning("Not enough materials!"))

/obj/item/blacksmith/shpatel/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/blacksmith/shpatel/attack_self(mob/user)
	..()
	var/list/choices = list(
		"Floor" = image(icon = 'white/kacherkin/icons/dwarfs/obj/turfs1.dmi', icon_state = "stone_floor"),
		"Wall" = image(icon = 'white/valtos/icons/stonewall.dmi', icon_state = "wallthefuck")
	)
	var/choice = show_radial_menu(user, src, choices, custom_check = CALLBACK(src, .proc/check_menu, user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user))
		return
	switch(choice)
		if("Floor")
			mode = SHPATEL_BUILD_FLOOR
		if("Wall")
			mode = SHPATEL_BUILD_WALL

/obj/item/blacksmith/scepter
	name = "scepter"
	desc = "Comes with a crown."
	icon_state = "scepter"
	w_class = WEIGHT_CLASS_HUGE
	force = 9
	throwforce = 4
	throw_range = 5
	custom_materials = list(/datum/material/gold = 10000)
	var/mode = SHPATEL_BUILD_FLOOR
	var/cur_markers = 0
	var/max_markers = 64

/obj/item/blacksmith/scepter/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/blacksmith/scepter/attack_self(mob/user)
	..()
	var/list/choices = list(
		"Floors"   = image(icon = 'white/valtos/icons/objects.dmi', icon_state = "plan_floor"),
		"Walls"  = image(icon = 'white/valtos/icons/objects.dmi', icon_state = "plan_wall"),
		"Doors"  = image(icon = 'white/valtos/icons/objects.dmi', icon_state = "plan_door"),
		"Tables"  = image(icon = 'white/valtos/icons/objects.dmi', icon_state = "plan_table"),
		"Chairs" = image(icon = 'white/valtos/icons/objects.dmi', icon_state = "plan_chair"),
		"Clear"= image(icon = 'white/valtos/icons/objects.dmi', icon_state = "clear")
	)
	var/choice = show_radial_menu(user, src, choices, custom_check = CALLBACK(src, .proc/check_menu, user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user))
		return
	switch(choice)
		if("Floors")
			mode = SHPATEL_BUILD_FLOOR
		if("Walls")
			mode = SHPATEL_BUILD_WALL
		if("Doors")
			mode = SHPATEL_BUILD_DOOR
		if("Tables")
			mode = SHPATEL_BUILD_TABLE
		if("Chairs")
			mode = SHPATEL_BUILD_CHAIR
		if("Clear")
			clear(user)

/obj/effect/plan_marker
	name = "marker"
	icon = 'white/valtos/icons/objects.dmi'
	anchored = TRUE
	icon_state = "plan_floor"
	layer = ABOVE_NORMAL_TURF_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 190

/obj/item/blacksmith/scepter/proc/clear(mob/user)
	var/i = 0
	for(var/obj/effect/plan_marker/M in view(7, user))
		qdel(M)
		i++
	to_chat(user, span_notice("Deleted [i] markers."))

/obj/item/blacksmith/scepter/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(QDELETED(target))
		return
	if(isturf(target))
		var/turf/T = get_turf(target)
		for(var/atom/A in T)
			if(istype(A, /obj/effect/plan_marker))
				qdel(A)
				to_chat(user, span_notice("You remove a marker."))
				cur_markers--
				return
		if(cur_markers >= max_markers)
			to_chat(user, span_warning("Max 64!"))
			return
		var/obj/visual = new /obj/effect/plan_marker(T)
		cur_markers++
		switch(mode)
			if(SHPATEL_BUILD_FLOOR)
				visual.icon_state = "plan_floor"
			if(SHPATEL_BUILD_WALL)
				visual.icon_state = "plan_wall"
			if(SHPATEL_BUILD_DOOR)
				visual.icon_state = "plan_door"
			if(SHPATEL_BUILD_TABLE)
				visual.icon_state = "plan_table"
			if(SHPATEL_BUILD_CHAIR)
				visual.icon_state = "plan_chair"

#undef SHPATEL_BUILD_FLOOR
#undef SHPATEL_BUILD_WALL
#undef SHPATEL_BUILD_DOOR
#undef SHPATEL_BUILD_TABLE
#undef SHPATEL_BUILD_CHAIR

/obj/item/blacksmith/partial
	desc = "Looks like a part of something bigger."
	var/item_grade = "*"

/obj/item/blacksmith/partial/Initialize()
	. = ..()
	force = 1

/obj/item/blacksmith/partial/zwei
	name = "zweihander blade"
	real_force = 40
	icon_state = "zwei_part"

/obj/item/blacksmith/partial/katanus
	name = "katanus blade"
	real_force = 16
	icon_state = "katanus_part"

/obj/item/blacksmith/partial/cep
	name = "ball on a chain"
	real_force = 20
	icon_state = "cep_part"

/obj/item/blacksmith/partial/dwarfsord
	name = "sword blade"
	real_force = 16
	icon_state = "dwarfsord_part"

/obj/item/blacksmith/partial/crown_empty
	name = "empty crown"
	icon_state = "crown_empty"

/obj/item/blacksmith/partial/scepter_part
	name = "scepter part"
	icon_state = "scepter_part"

/obj/item/scepter_shaft
	name = "scepter shaft"
	icon = 'white/valtos/icons/objects.dmi'
	icon_state = "scepter_shaft"
