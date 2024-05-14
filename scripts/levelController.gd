extends Node
class_name LevelController
var level = {
	"vitality": 0,
	"strength": 0,
	"mind": 0
}

var level_data = {
	"vitality": "Increase cat's healths",
	"strength": "Attack do more damage",
	"mind": "Add more ability slot"
}

var point = 2

func getLevel() -> int:
	var total = 1
	for i in level.values(): total += i
	return total

func getLevelValue() -> Dictionary:
	return {
		"health": (level.vitality * 2) + 5,
		"damage": (level.strength * 2) + 1
	}

func upgrade(val):
	if !level.has(val): return
	print(val + " Upgraded!")
	level[val] += 1
	point -= 1
