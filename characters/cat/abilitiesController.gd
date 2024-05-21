extends Node

func _ready():
	refresh()
	CatController.Abilities.connect("abilities_changed", self, "refresh")

func refresh():
	for i in get_children(): i.free()
	
	for i in CatController.Abilities.current_abilities:
		var item = load("res://misc/abilities/" + str(i) + ".tscn").instance()
		add_child(item)


func _input(event):
	if event is InputEventKey:
		for i in CatController.Abilities.current_abilities.size():
			if event.is_action_pressed("n_ability" + str(i + 1)):
				get_child(i).emit_signal("cast")
