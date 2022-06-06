/* Diffrent misc types of sheets
 * Contains:
 * Iron
 * Plasteel
 * Wood
 * Cloth
 * Plastic
 * Cardboard
 * Paper Frames
 * Runed Metal (cult)
 * Bronze (bake brass)
 */

/*
 * Iron
 */
GLOBAL_LIST_INIT(metal_recipes, list ( \
	new/datum/stack_recipe("Табурет", /obj/structure/chair/stool, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("кровать", /obj/structure/bed, 2, one_per_turf = TRUE, on_floor = TRUE), \
	new /datum/stack_recipe_list("шахматные фигуры", list( \
		new /datum/stack_recipe("Белый Pawn", /obj/structure/chess/whitepawn, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Белый Rook", /obj/structure/chess/whiterook, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Белый Knight", /obj/structure/chess/whiteknight, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Белый Bishop", /obj/structure/chess/whitebishop, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Белый Queen", /obj/structure/chess/whitequeen, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Белый King", /obj/structure/chess/whiteking, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный Pawn", /obj/structure/chess/blackpawn, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный Rook", /obj/structure/chess/blackrook, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный Knight", /obj/structure/chess/blackknight, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный Bishop", /obj/structure/chess/blackbishop, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный Queen", /obj/structure/chess/blackqueen, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
		new /datum/stack_recipe("Чёрный King", /obj/structure/chess/blackking, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
	)),
	null, \
	new/datum/stack_recipe("части стойки", /obj/item/rack_parts), \
	new/datum/stack_recipe("шкаф", /obj/structure/closet, 2, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("плитка для пола", /obj/item/stack/tile/plasteel, 1, 4, 20), \
	new/datum/stack_recipe("желез. стержень", /obj/item/stack/rods, 1, 2, 60), \
	null, \
	new/datum/stack_recipe("каркас стены", /obj/structure/girder, 2, time = 40, one_per_turf = TRUE, on_floor = TRUE, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75), \
	null, \
	new/datum/stack_recipe("пестик", /obj/item/pestle, 1, time = 50), \
	new/datum/stack_recipe("баррикада", /obj/structure/deployable_barricade/metal, 2, time = 1 SECONDS, one_per_turf = TRUE, on_floor = TRUE), \
))

/obj/item/stack/sheet/iron
	name = "железо"
	desc = "Листы из железа."
	singular_name = "лист железа"
	icon = 'white/valtos/icons/items.dmi'
	icon_state = "sheet-metal"
	inhand_icon_state = "sheet-metal"
	mats_per_unit = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)
	throwforce = 10
	flags_1 = CONDUCT_1
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/iron
	grind_results = list(/datum/reagent/iron = 20)
	point_value = 2
	tableVariant = /obj/structure/table
	material_type = /datum/material/iron
	matter_amount = 4
	cost = 500

/obj/item/stack/sheet/iron/fifty
	amount = 50

/obj/item/stack/sheet/iron/twenty
	amount = 20

/obj/item/stack/sheet/iron/ten
	amount = 10

/obj/item/stack/sheet/iron/five
	amount = 5

/obj/item/stack/sheet/iron/get_main_recipes()
	. = ..()
	. += GLOB.metal_recipes

/obj/item/stack/sheet/iron/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] начинает лупить [user.ru_na()]себя по голове <b>[src.name]</b>! Похоже на то, что [user.p_theyre()] пытается покончить с собой!"))
	return BRUTELOSS

/*
 * Wood
 */
GLOBAL_LIST_INIT(wood_recipes, list ( \
	new/datum/stack_recipe("деревянный пол", /obj/item/stack/tile/wood, 1, 4, 20), \
	new/datum/stack_recipe("деревянный корпус стола", /obj/structure/table_frame/wood, 2, time = 10), \
	new/datum/stack_recipe("приклад винтовки", /obj/item/weaponcrafting/stock, 10, time = 40), \
	new/datum/stack_recipe("скалка", /obj/item/kitchen/rollingpin, 2, time = 30), \
	new/datum/stack_recipe("деревянный стул", /obj/structure/chair/wood/, 3, time = 10, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("крылатый стул", /obj/structure/chair/wood/wings, 3, time = 10, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("баррикада", /obj/structure/deployable_barricade/wooden, 2, time = 50, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("гроб", /obj/structure/closet/crate/coffin, 5, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("собачья кровать", /obj/structure/bed/dogbed, 10, time = 10, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("комод", /obj/structure/dresser, 10, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("рамка для рисунка", /obj/item/wallframe/painting, 1, time = 10),\
	new/datum/stack_recipe("деревянный ящик", /obj/structure/closet/crate/wooden, 6, time = 50, one_per_turf = TRUE, on_floor = TRUE),\
	new/datum/stack_recipe("ткацкий станок", /obj/structure/loom, 10, time = 15, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("ступка", /obj/item/reagent_containers/glass/mortar, 3), \
	new/datum/stack_recipe("головешка", /obj/item/match/firebrand, 2, time = 100), \
	new/datum/stack_recipe("рукоять скипетра", /obj/item/scepter_shaft, 3, time=5),\
	null, \
	new/datum/stack_recipe_list("церковные скамьи", list(
		new /datum/stack_recipe("скамья (центральная)", /obj/structure/chair/pew, 3, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("скамья (левая)", /obj/structure/chair/pew/left, 3, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("скамья (правая)", /obj/structure/chair/pew/right, 3, one_per_turf = TRUE, on_floor = TRUE)
		)),
	null, \
	))

/obj/item/stack/sheet/mineral/wood
	name = "деревянные доски"
	desc = "Можно лишь предположить что это куча дерева."
	singular_name = "деревянная доска"
	icon_state = "sheet-wood"
	inhand_icon_state = "sheet-wood"
	icon = 'white/valtos/icons/items.dmi'
	mats_per_unit = list(/datum/material/wood=MINERAL_MATERIAL_AMOUNT)
	sheettype = "wood"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	full_w_class = WEIGHT_CLASS_NORMAL
	merge_type = /obj/item/stack/sheet/mineral/wood
	novariants = TRUE
	material_type = /datum/material/wood
	grind_results = list(/datum/reagent/cellulose = 20) //no lignocellulose or lignin reagents yet,

/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.wood_recipes

/obj/item/stack/sheet/mineral/wood/fifty
	amount = 50

/*
 * Bamboo
 */

GLOBAL_LIST_INIT(bamboo_recipes, list ( \
	new/datum/stack_recipe("бамбуковое копьё", /obj/item/spear/bamboospear, 25, time = 90), \
	new/datum/stack_recipe("духовая трубка", /obj/item/gun/syringe/blowgun, 10, time = 70), \
	new/datum/stack_recipe("примитивный шприц", /obj/item/reagent_containers/syringe/crude, 5, time = 10), \
	null, \
	new/datum/stack_recipe("бамбуковый стул", /obj/structure/chair/stool/bamboo, 2, time = 10, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("бамбуковый пол", /obj/item/stack/tile/bamboo, 1, 4, 20), \
	null, \
	new/datum/stack_recipe_list("бамбуковая скамья", list(
		new /datum/stack_recipe("бамбуковая скамья (центр)", /obj/structure/chair/sofa/bamboo, 3, time = 10, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("бамбуковая скамья (левая)", /obj/structure/chair/sofa/bamboo/left, 3, time = 10, one_per_turf = TRUE, on_floor = TRUE),
		new /datum/stack_recipe("бамбуковая скамья (правая)", /obj/structure/chair/sofa/bamboo/right, 3, time = 10, one_per_turf = TRUE, on_floor = TRUE)
		)),	\
	))

/obj/item/stack/sheet/mineral/bamboo
	name = "черенки бамбука"
	desc = "Мелко нарезанные бамбуковые палочки."
	singular_name = "обрезанная бамбуковая палочка"
	icon_state = "sheet-bamboo"
	inhand_icon_state = "sheet-bamboo"
	icon = 'icons/obj/stack_objects.dmi'
	sheettype = "bamboo"
	mats_per_unit = list(/datum/material/bamboo = MINERAL_MATERIAL_AMOUNT)
	throwforce = 15
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/sheet/mineral/bamboo
	grind_results = list(/datum/reagent/cellulose = 10)

/obj/item/stack/sheet/mineral/bamboo/get_main_recipes()
	. = ..()
	. += GLOB.bamboo_recipes

/*
 * Cloth
 */
GLOBAL_LIST_INIT(cloth_recipes, list ())

/obj/item/stack/sheet/cloth
	name = "ткань"
	desc = "Это хлопок? Лен? Джинса? Мешковина? Канва? Не могу сказать."
	singular_name = "рулон ткани"
	icon_state = "sheet-cloth"
	inhand_icon_state = "sheet-cloth"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cloth
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	grind_results = list(/datum/reagent/cellulose = 20)

/obj/item/stack/sheet/cloth/get_main_recipes()
	. = ..()
	. += GLOB.cloth_recipes

/obj/item/stack/sheet/cloth/ten
	amount = 10

/obj/item/stack/sheet/cloth/five
	amount = 5

/obj/item/stack/sheet/durathread
	name = "дюраткань"
	desc = "Ткань сшитая из невероятно прочных нитей, часто полезна при производстве брони."
	singular_name = "дюратканевый рулон"
	icon_state = "sheet-durathread"
	inhand_icon_state = "sheet-cloth"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/durathread
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'

/obj/item/stack/sheet/cotton
	name = "пучок необработанного хлопка"
	desc = "Куча необработанного хлопка готовая к пряже на ткакцом станке."
	singular_name = "шарик хлопка-сырца"
	icon_state = "sheet-cotton"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cotton
	var/pull_effort = 10
	var/loom_result = /obj/item/stack/sheet/cloth
	grind_results = list(/datum/reagent/cellulose = 20)

/obj/item/stack/sheet/cotton/durathread
	name = "пучок необработанной дюраткани"
	desc = "Куча необработанной дюраткани готовая к пряже на ткацком станке."
	singular_name = "шарик необработанной дюраткани"
	icon_state = "sheet-durathreadraw"
	merge_type = /obj/item/stack/sheet/cotton/durathread
	loom_result = /obj/item/stack/sheet/durathread
	grind_results = list()

/*
 * Cardboard
 */
GLOBAL_LIST_INIT(cardboard_recipes, list (					 \
	new/datum/stack_recipe("коробка", /obj/item/storage/box),\
	new/datum/stack_recipe("папка", /obj/item/folder),		 \
))

/obj/item/stack/sheet/cardboard	//BubbleWrap //it's cardboard you fuck
	name = "картон"
	desc = "Большие листы картона, выглядят как плоские коробки."
	singular_name = "лист картона"
	icon_state = "sheet-card"
	inhand_icon_state = "sheet-card"
	mats_per_unit = list(/datum/material/cardboard = MINERAL_MATERIAL_AMOUNT)
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cardboard
	novariants = TRUE
	grind_results = list(/datum/reagent/cellulose = 10)
	material_type = /datum/material/cardboard

/obj/item/stack/sheet/cardboard/get_main_recipes()
	. = ..()
	. += GLOB.cardboard_recipes

/obj/item/stack/sheet/cardboard/fifty
	amount = 50

/*
 * Bronze
 */

/obj/item/stack/tile/bronze
	name = "латунь"
	desc = "При внимательном рассмотрении становится понятно, что совершенно-непригодная-для-строительства латунь на самом деле куда более структурно устойчивая латунь."
	singular_name = "лист латуни"
	icon_state = "sheet-brass"
	inhand_icon_state = "sheet-brass"
	icon = 'white/valtos/icons/items.dmi'
	lefthand_file = 'icons/mob/inhands/misc/sheets_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/sheets_righthand.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	force = 5
	throwforce = 10
	max_amount = 50
	throw_speed = 1
	throw_range = 3
	turf_type = /turf/open/floor/bronze
	novariants = FALSE
	grind_results = list(/datum/reagent/iron = 5, /datum/reagent/copper = 3) //we have no "tin" reagent so this is the closest thing
	merge_type = /obj/item/stack/tile/bronze
	tableVariant = /obj/structure/table/bronze

/obj/item/stack/sheet/paperframes/Initialize(mapload, new_amount, merge = TRUE, list/mat_override=null, mat_amt=1)
	. = ..()
	if(loc)
		forceMove(loc, 0, 0)

/obj/item/stack/tile/bronze/thirty
	amount = 30

/obj/item/stack/tile/bronze/cyborg
	custom_materials = list()
	cost = 500

/*
 * Lesser and Greater gems - unused
 */
/obj/item/stack/sheet/lessergem
	name = "самоцветы поменьше"
	desc = "Редкий вид самоцветов, которые можно получить только путем кровавых жертвоприношений младшим богам. Они нужны для созданиможнощественных объектов."
	singular_name = "самоцвет поменьше"
	icon_state = "sheet-lessergem"
	inhand_icon_state = "sheet-lessergem"
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/lessergem

/obj/item/stack/sheet/greatergem
	name = "самоцветы побольше"
	desc = "Редкий вид самоцветов, которые можно получить только путем кровавых жертвоприношений младшим богам. Они нужны для созданиможнощественных объектов."
	singular_name = "самоцвет побольше"
	icon_state = "sheet-greatergem"
	inhand_icon_state = "sheet-greatergem"
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/greatergem

/*
 * Bones
 */
/obj/item/stack/sheet/bone
	name = "кости"
	icon = 'icons/obj/mining.dmi'
	icon_state = "bone"
	inhand_icon_state = "sheet-bone"
	mats_per_unit = list(/datum/material/bone = MINERAL_MATERIAL_AMOUNT)
	singular_name = "кость"
	desc = "Кто-то пил своё молоко."
	force = 7
	throwforce = 5
	max_amount = 12
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 1
	throw_range = 3
	grind_results = list(/datum/reagent/carbon = 10)
	merge_type = /obj/item/stack/sheet/bone
	material_type = /datum/material/bone

GLOBAL_LIST_INIT(paperframe_recipes, list(
new /datum/stack_recipe("paper frame separator", /obj/structure/window/paperframe, 2, one_per_turf = TRUE, on_floor = TRUE, time = 10)))

/obj/item/stack/sheet/paperframes
	name = "бумажные рамки"
	desc = "Тонкая деревянная рамка с прикрепленной бумагой."
	singular_name = "бумажная рамка"
	icon_state = "sheet-paper"
	inhand_icon_state = "sheet-paper"
	mats_per_unit = list(/datum/material/paper = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/paperframes
	resistance_flags = FLAMMABLE
	grind_results = list(/datum/reagent/cellulose = 20)
	material_type = /datum/material/paper

/obj/item/stack/sheet/paperframes/get_main_recipes()
	. = ..()
	. += GLOB.paperframe_recipes
/obj/item/stack/sheet/paperframes/five
	amount = 5
/obj/item/stack/sheet/paperframes/twenty
	amount = 20
/obj/item/stack/sheet/paperframes/fifty
	amount = 50

/obj/item/stack/sheet/meat
	name = "листы мяса"
	desc = "Чье-то окровавленное мясо, спресованное в неплохой твердый лист."
	singular_name = "лист мяса"
	icon = 'white/valtos/icons/items.dmi'
	icon_state = "sheet-meat"
	material_flags = MATERIAL_COLOR
	mats_per_unit = list(/datum/material/meat = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/meat
	material_type = /datum/material/meat
	material_modifier = 1 //None of that wussy stuff

/obj/item/stack/sheet/meat/fifty
	amount = 50
/obj/item/stack/sheet/meat/twenty
	amount = 20
/obj/item/stack/sheet/meat/five
	amount = 5

/obj/item/stack/sheet/sandblock
	name = "блоки песка"
	desc = "Я уже слишком стар для того чтобы играться с песочными замками. Теперь я строю... Песочные станции."
	singular_name = "блок песка"
	icon_state = "sheet-sandstone"
	mats_per_unit = list(/datum/material/sand = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/sandblock
	material_type = /datum/material/sand
	material_modifier = 1

/obj/item/stack/sheet/sandblock/fifty
	amount = 50
/obj/item/stack/sheet/sandblock/twenty
	amount = 20
/obj/item/stack/sheet/sandblock/five
	amount = 5


/obj/item/stack/sheet/hauntium
	name = "листы привидениума"
	desc = "Эти листы выглядят проклятыми."
	singular_name = "haunted sheet"
	icon_state = "sheet-meat"
	material_flags = MATERIAL_COLOR
	mats_per_unit = list(/datum/material/hauntium = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/hauntium
	material_type = /datum/material/hauntium
	material_modifier = 1 //None of that wussy stuff

/obj/item/stack/sheet/hauntium/fifty
	amount = 50
/obj/item/stack/sheet/hauntium/twenty
	amount = 20
/obj/item/stack/sheet/hauntium/five
	amount = 5
