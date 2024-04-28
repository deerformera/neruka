extends VBoxContainer

onready var item = preload("res://gui/tabs/upgradeItem.tscn")

var selected: String

func _ready():
	$UpgradeButton.connect("pressed", self, "onUpgrade")
	refresh()

func refresh():
	for i in $Center/Items.get_children(): i.queue_free()
	
	for i in CatController.Level.stats:
		var item_ins = item.instance()
		$Center/Items.add_child(createItem(i))

func createItem(val) -> VBoxContainer:
	var item_ins = item.instance()
	item_ins.get_node("Label").text = val
	item_ins.name = val
	item_ins.get_node("Button").connect("toggled", self, "onItemSelected", [val])
	return item_ins

func onItemSelected(pressed: bool, val):
	$UpgradeButton.disabled = false
	if pressed:
		selected = val
		$Center/Desc.text = "this is " + val
		for i in $Center/Items.get_children():
			if i.name != val:
				i.get_node("Button").pressed = false
	else:
		if selected == val:
			$UpgradeButton.disabled = true
			$Center/Desc.text = ""
			selected = ""

func onUpgrade():
	if selected == "": return
	CatController.Level.upgrade(selected)
	
