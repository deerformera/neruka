extends Node
class_name LevelController
var stats = {
	"vitality": 0,
	"strength": 0,
	"mind": 0
}

func getLevels() -> int:
	var total = 1
	for i in stats: stats += i
	return total


func upgradeLevels(val: Dictionary) -> void:
	for i in val.keys():
		if not stats.has(i): continue
		stats[i] += val[i]

func getLevelsRequirement(val: Dictionary) -> int:
	return 0
