extends HBoxContainer

var item = preload("res://gui/tabs/inventoryItem.tscn")

var selected: int = 0

func _ready():
	$Right/Bottom/M/VB/EquipButton.connect("pressed", self, "onEquip")
	refresh()

func refresh():
	pass

func createItem(id: int) -> Button:
	if id <= 0: return null
	var item_ins = item.instance()
	item_ins.name = str(id)
	item_ins.get_node("Label").text = str(id)
	return item_ins

func onEquip():
	pass
