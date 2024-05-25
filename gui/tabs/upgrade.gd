extends VBoxContainer

onready var item = preload("res://gui/tabs/upgradeItem.tscn")

var selected: String

func _ready():
	$UpgradeButton.connect("pressed", self, "onUpgrade")
	refresh()

func refresh():
	$Level.text = "Level: " + str(CatController.Level.getLevel())
	$Available.text = "Point available: " + str(CatController.Level.point)
	
	for i in $Center/Items.get_children(): i.free()
	
	for i in CatController.Level.level:
		$Center/Items.add_child(createItem(i))

func createItem(val) -> VBoxContainer:
	var item_ins = item.instance()
	item_ins.name = val
	item_ins.get_node("Name").text = val
	item_ins.get_node("Button/Level").text = CatController.Level.level[val] as String
	item_ins.get_node("Button").connect("toggled", self, "onItemSelected", [val])
	return item_ins

func onItemSelected(pressed: bool, val):
	if pressed:
		selected = val
		for i in $Center/Items.get_children():
			if i.name != val:
				i.get_node("Button").pressed = false
	else:
		if selected == val: selected = ""
	
	setDescription()

func setDescription():
	if selected == "":
		$Center/Desc.text = ""
		$UpgradeLabel.text = ""
		$UpgradeButton.disabled = true
		return
	
	$Center/Desc.text = CatController.Level.level_data[selected]
	
	if CatController.Level.point <= 0:
		$UpgradeLabel.text = "No Point available!"
		$UpgradeButton.disabled = true
	else:
		$UpgradeLabel.text = ""
		$UpgradeButton.disabled = false

func onUpgrade():
	if selected == "": return
	
	CatController.Level.upgrade(selected)
	selected = ""
	setDescription()
	refresh()
