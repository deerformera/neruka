extends CanvasLayer

var item = preload("res://characters/cat/tabs/levelup_item.tscn")

var level: Dictionary

signal closed

func _ready():
	$Margin/Panel/VBox/CloseButton.connect("pressed", self, "close")
	$Margin/Panel/VBox/Margin/VBox/UpButton.connect("pressed", self, "levelup")
	
	items()

func close(): 
	self.queue_free()
	emit_signal("closed")

func items():
	set_required()
	$Margin/Panel/VBox/Margin/VBox/AvailableOrbs.text = "available: " + str(Utils.orbs)
	for i in Utils.level.keys():
		level[i] = 0
		
		var item_ins = item.instance()
		item_ins.get_node("Label").text = i + ": " + str(Utils.level[i])
		item_ins.get_node("Inc").connect("pressed", self, "increment", [item_ins, i])
		item_ins.get_node("Dec").connect("pressed", self, "decrement", [item_ins, i])
		$Margin/Panel/VBox/Margin/VBox/Items.add_child(item_ins)

func increment(node, type):
	level[type] += 1
	node.get_node("Label").text = type + ": " + str(Utils.level[type] + level[type])
	set_required()

func decrement(node, type):
	if level[type] > 0: level[type] -= 1
	node.get_node("Label").text = type + ": " + str(Utils.level[type] + level[type])
	set_required()

func set_required():
	$Margin/Panel/VBox/Margin/VBox/RequiredOrbs.text = "required: " + str(Utils.get_levels_requirement(level))
	if Utils.get_levels_requirement(level) > Utils.orbs: 
		$Margin/Panel/VBox/Margin/VBox/UpButton.disabled = true
	else: $Margin/Panel/VBox/Margin/VBox/UpButton.disabled = false

func levelup():
	Utils.set_levels(level)
	close()
