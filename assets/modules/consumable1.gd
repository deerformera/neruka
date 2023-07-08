extends Node

@onready var id = Player.equipped["consumable"]
var value: int :
	set(val):
		value = val
		Player.consumable_value_changed.emit(val)
		Player.equipment["consumable"].map(func(eq): if eq[0] == id: eq[1] = val)
		if val <= 0: Player.equip("consumable", 0)

func _ready():
	Player.equipment["consumable"].map(func(eq): if eq[0] == id: value = eq[1])

func _input(event):
	if event.is_action_pressed("n_consume") && $"../..".animstate.get_current_node() != "consume":
		value -= 1
		Player.health += 10
		$"../..".animstate.travel("consume")
		$"../../HealParticles".restart()
