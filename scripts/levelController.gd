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

func upgrade(val):
	if !stats.has(val): return
	print(val + " Upgraded!")
	stats[val] += 1
