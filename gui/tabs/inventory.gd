extends HBoxContainer

var item = preload("res://gui/tabs/inventoryItem.tscn")

var selected: int

func _ready():
	$Right/Bottom/M/VB/EquipButton.connect("pressed", self, "onEquip")
	refresh()

func refresh():
	$Right/Bottom/M/VB/Desc.text = ""
	$Right/Top/M/Name.text = ""
	$Right/Bottom/M/VB/EquipButton.disabled = true
	
	for i in [$Left/Top/Equipped.get_children(), $Left/Bottom/S/M/Equipments.get_children()]:
		for ii in i:
			ii.free()

	for i in CatController.current_abilities:
		if i <= 0: continue
		$Left/Top/Equipped.add_child(createItem(i))
	
	for i in CatController.abilities:
		if i <= 0: continue
		if i in CatController.current_abilities: continue
		$Left/Bottom/S/M/Equipments.add_child(createItem(i))

func onItemSelected(pressed: bool, id: int):
	if pressed:
		selected = id
		
		$Right/Bottom/M/VB/EquipButton.disabled = false
		
		for i in [$Left/Top/Equipped.get_children(), $Left/Bottom/S/M/Equipments.get_children()]:
			for ii in i:
				if not ii.name as int == id: ii.pressed = false
		
		$Right/Top/M/Name.text = id as String
		$Right/Bottom/M/VB/Desc.text = "Ini deskripsi dari " + id as String
		
		if id in CatController.current_abilities: $Right/Bottom/M/VB/EquipButton.text = "Unequip"
		else:
			if CatController.current_abilities.size() >= 4: $Right/Bottom/M/VB/EquipButton.disabled = true 
			$Right/Bottom/M/VB/EquipButton.text = "Equip"
	else:
		if id == selected:
			$Right/Bottom/M/VB/EquipButton.disabled = true
			$Right/Bottom/M/VB/Desc.text = ""
			$Right/Top/M/Name.text = ""

func createItem(id: int) -> Button:
	if id <= 0: return null
	var item_ins = item.instance()
	item_ins.name = str(id)
	item_ins.get_node("M/Icon").texture = load("res://misc/abilities/" + str(id) + ".png")
	item_ins.connect("toggled", self, "onItemSelected", [id])
	return item_ins

func onEquip():
	if selected in CatController.current_abilities:
		CatController.current_abilities.remove(CatController.current_abilities.find(selected))
	else: 
		if CatController.current_abilities.size() == 4: return
		CatController.current_abilities.append(selected)
	
	refresh()
