extends CanvasLayer

var item = preload("res://characters/cat/tabs/forge_item.tscn")

var selected: int

var data: Array

func _ready():
	$Margin/Panel/VBox/HBox/CloseButton.connect("pressed", self, "close")
	$Margin/Panel/VBox/Margin/HBox/VBox/ForgeButton.connect("pressed", self, "forge")
	$Margin/Panel/VBox/Margin/HBox/VBox/ForgeButton.disabled = true
	items()

func close(): self.queue_free()

func items():
	var container = $Margin/Panel/VBox/Margin/HBox/Scroll/Items
	for i in Utils.knowledges.size():
		data.append(Utils.get_ability(Utils.knowledges[i]))
		var item_ins = item.instance()
		item_ins.get_node("M/Label").text = str(data[i].price)
		item_ins.get_node("M/TextureRect").texture = load("res://assets/abilities/"+str(Utils.knowledges[i])+".png")
		item_ins.connect("pressed", self, "item_pressed", [i])
		container.add_child(item_ins)

func item_pressed(index):
	var forge = $Margin/Panel/VBox/Margin/HBox/VBox/ForgeButton
	selected = Utils.knowledges[index]
	if Utils.abilities.has(Utils.knowledges[index]):
		forge.disabled = true
	else: forge.disabled = false
	if Utils.orbs < data[index].price: forge.disabled = true
	else: forge.disabled = false
	
	$Margin/Panel/VBox/Margin/HBox/VBox/Name.text = data[index].name
	$Margin/Panel/VBox/Margin/HBox/VBox/Desc.text = data[index].desc
	$Margin/Panel/VBox/Margin/HBox/VBox/Price.text = "required: " + str(data[index].price) + "\navailable: " + str(Utils.orbs)

func forge():
	Utils.learn(selected)
