extends Node
class_name AbilitiesController

var knowledge = []

var abilities = [1,2,3]
var current_abilities = [1, 2]

signal abilities_changed

func setAbilities(val: Array) -> void:
	current_abilities = val
	emit_signal("abilities_changed")

func learn(id: int):
	if id in abilities: return
	if id <= 0: return

	abilities.append(id)
	print("You Learned ", id)

func identify(id: int):
	if id in knowledge: return
	if id <= 0: return

	knowledge.append(id)
	print("You identify ", id)
