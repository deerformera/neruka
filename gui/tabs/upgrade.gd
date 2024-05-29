extends VBoxContainer

var selected: String = ""

func _ready():
	$UpgradeButton.connect("pressed", self, "onUpgrade")
	refresh()

func refresh():
	$Level.text = "level: " + CatController.Level.getLevel() as String
	$OrbsAvailable.text = "orbs available : " + CatController.Abilities.orbs as String
	
	for i in $Items.get_children(): i.free()
	
	for i in CatController.Level.level:
		$Items.add_child(createItem(i))
	

func createItem(val: String) -> Button:
	var item_ins = preload("res://gui/tabs/upgradeItem.tscn").instance()
	item_ins.name = val
	item_ins.get_node("Label").text = "level: "+ CatController.Level.level[val] as String
	item_ins.get_node("Button").icon = load("res://misc/resources/levels/" + val + ".png")
	item_ins.get_node("Button").connect("toggled", self, "onItemSelected", [val])
	return item_ins

func onItemSelected(pressed: bool, val: String):
	if pressed:
		selected = val
		for i in $Items.get_children():
			if i.name != val:
				i.get_node("Button").pressed = false
	else:
		if selected == val: selected = ""
	
	setDescription()

func setDescription():
	if selected == "":
		$ItemDescription.text = ""
		$OrbsRequired.text = ""
		$UpgradeButton.text = ""
		$UpgradeButton.disabled = true
		return
	
	$ItemDescription.text = CatController.Level.level_data[selected]
	
	if selected == "mind" && CatController.Level.level["mind"] >= 4:
		$UpgradeButton.text = "Max Level!"
		$UpgradeButton.disabled = true
		return
	
	var cost = CatController.Level.getLevelCost()[selected]
	$OrbsRequired.text = "orbs required: " + cost as String
	$UpgradeButton.text = "Upgrade"
	$UpgradeButton.disabled = CatController.Abilities.orbs < cost

func onUpgrade():
	CatController.Level.upgrade(selected)
	selected = ""
	setDescription()
	refresh()
