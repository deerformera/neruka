extends HBoxContainer

var item = preload("res://gui/controlDesktopItem.tscn")

func enter():
	Utils.get_cat().get_node("AbilitiesController").connect("refreshed", self, "onCatRefreshed")
	onCatRefreshed()

func onCatRefreshed():
	for i in get_children(): i.free()
	
	for i in CatController.Abilities.current_abilities:
		var item_ins = item.instance()
		item_ins.name = str(i)
		item_ins.bind(Utils.get_cat().get_node("AbilitiesController").get_node(i as String))
		item_ins.get_node("M/Icon").texture = load("res://misc/abilities/" + str(i) + ".png")
		add_child(item_ins)
