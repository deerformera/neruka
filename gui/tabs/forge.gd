extends HBoxContainer

var item = preload("res://gui/tabs/forgeItem.tscn")
var selected = 0

func _ready():
	$Right/VB/ForgeButton.connect("pressed", self, "onForge")
	refresh()

func refresh():
	for i in $Left/S/Items.get_children(): i.free()
	
	for i in CatController.Abilities.knowledges:
		$Left/S/Items.add_child(createItem(i))

func createItem(val) -> Button:
	var item_ins = item.instance()
	item_ins.name = val as String
	item_ins.get_node("M/TextureRect").texture = load("res://misc/abilities/" + str(val) + ".png")
	if val in CatController.Abilities.abilities:
		item_ins.get_node("Status").visible = true
		item_ins.disabled = true
	else: item_ins.connect("toggled", self, "onItemSelected", [val])
	
	return item_ins

func onItemSelected(pressed: bool, val):
	if pressed:
		selected = val
		setDescription()
		for i in $Left/S/Items.get_children():
			if i.name != str(val): i.pressed = false
	else:
		if val == selected:
			selected = 0
			setDescription()

func setDescription():
	if selected <= 0:
		$Right/VB/Name.text = ""
		$Right/VB/Desc.text = ""
		$Right/VB/Requirement.text = ""
		$Right/VB/ForgeButton.disabled = true
		return
	
	$Right/VB/Name.text = str(selected)
	$Right/VB/Desc.text = "Description of " + str(selected)
	$Right/VB/Requirement.text = "Orbs required: 0\nOrbs Available: " + str(CatController.Abilities.orbs)
	$Right/VB/ForgeButton.disabled = false
	
	var data = CatController.Abilities.getAbilityData(selected)
	if data:
		$Right/VB/Name.text = data.name
		$Right/VB/Desc.text = data.desc
		$Right/VB/Requirement.text = "Orbs required: " + str(data.price) + "\nOrbs Available: " + str(CatController.Abilities.orbs)

func onForge():
	if selected <= 0: return
	CatController.Abilities.learn(selected)
	selected = 0
	setDescription()
	refresh()
