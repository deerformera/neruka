extends HBoxContainer

var item = preload("res://gui/tabs/inventoryItem.tscn")

var selected: int = 0

var abilities: Array
var current_abilities: Array

func _ready():
	$Right/Bottom/M/VB/EquipButton.connect("pressed",self, "onEquip")
	abilities = CatController.Abilities.abilities
	current_abilities = CatController.Abilities.current_abilities
	refresh()

func refresh():
	
	for i in $Left/Bottom/S/M/Equipments.get_children(): i.queue_free()
	for i in $Left/Top/Equipped.get_children(): i.queue_free()
	
	for i in abilities:
		if i in current_abilities: continue
		$Left/Bottom/S/M/Equipments.add_child(createItem(i))
	
	for i in current_abilities:
		$Left/Top/Equipped.add_child(createItem(i))

func createItem(id: int) -> Button:
	if id <= 0: return null
	var item_ins = item.instance()
	item_ins.get_node("M/Icon").texture = load("res://misc/abilities/" + str(id) + ".png")
	item_ins.name = id as String
	item_ins.connect("pressed", self, "onItemSelected", [id, item_ins])
	return item_ins

func onItemSelected(id: int, node: Button):
		if selected == id:
			setDescription(0)
		else: setDescription(id)
		for i in [$Left/Bottom/S/M/Equipments.get_children(), $Left/Top/Equipped.get_children()]: 
			for ii in i:
				if ii != node:
					ii.pressed = false

func setDescription(id: int) -> void:
	if id <= 0:
		$Right/Top/M/Name.text = ""
		$Right/Bottom/M/VB/Desc.text = ""
		$Right/Bottom/M/VB/EquipButton.text = ""
		$Right/Bottom/M/VB/EquipButton.disabled = true
		selected = 0
		return
	
	$Right/Top/M/Name.text = id as String
	$Right/Bottom/M/VB/Desc.text = "description of " + id as String
	$Right/Bottom/M/VB/EquipButton.disabled = false
	if id in current_abilities:
		$Right/Bottom/M/VB/EquipButton.text = "Unequip"
	else: $Right/Bottom/M/VB/EquipButton.text = "Equip"
	
	selected = id

func onEquip():
	if selected in current_abilities:
		current_abilities.erase(selected)
	else: current_abilities.append(selected)
	setDescription(0)
	refresh()
