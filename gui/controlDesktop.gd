extends HBoxContainer

var item = preload("res://gui/controlDesktopItem.tscn")

func _ready():
	refresh()
	CatController.Abilities.connect("abilities_changed", self, "refresh")

func refresh():
	for i in get_children(): i.free()
	
	for i in CatController.Abilities.current_abilities:
		var item_ins = item.instance()
		item_ins.name = str(i)
		item_ins.get_node("M/Icon").texture = load("res://misc/abilities/" + str(i) + ".png")
		add_child(item_ins)
