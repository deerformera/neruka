extends Node

var Abilities: AbilitiesController = preload("res://scripts/abilitiesController.gd").new()
var Level: LevelController = preload("res://scripts/levelController.gd").new()

func _ready():
	Abilities.abilities_data = getData("abilities")
	Abilities.boss_data = getData("boss")

func getData(val: String):
	var file = File.new()
	var data
	
	file.open("res://misc/json/" + val + ".json", File.READ)
	data = file.get_as_text()
	data = parse_json(data)
	file.close()
	
	return data
