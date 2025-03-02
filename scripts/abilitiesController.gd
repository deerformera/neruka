extends Node
class_name AbilitiesController

var knowledges := []
var abilities := []
var current_abilities := [1]

var orbs: int = 1000

var abilities_data := {}
var boss_data = {}

signal abilities_changed

func setAbilities(val: Array) -> void:
	current_abilities = val
	emit_signal("abilities_changed")

func learn(id: int):
	if id in abilities: return
	if id <= 0: return
	
	var data = getAbilityData(id)
	if data.price > orbs: return

	orbs -= data.price
	
	abilities.append(id)
	print("You Learned ", data.name)

func identify(id: int):
	if id in knowledges: return
	if id <= 0: return
	
	var data = getBossData(id)
	
	knowledges.append(id)
	print("You identify ", data.name, ", ", data.desc)

func getAbilityData(val: int):
	if abilities_data.has(str(val)):
		return abilities_data[str(val)]
	
	return {}

func getBossData(val: int):
	if boss_data.has(str(val)):
		return boss_data[str(val)]
	
	return {}
