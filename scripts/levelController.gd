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
	"mind": "Add more ability slot",
}

func getLevel() -> int:
	var total = 1
	for i in level.values(): total += i
	return total

func getLevelValue() -> Dictionary:
	return {
		"health": (level.vitality * 4) + 20,
		"damage": (level.strength * 2) + 1
	}

func getLevelCost():
	var vitalityCost = 2
	var strengthCost = 2
	
	return {
		"vitality": 2 + (level.vitality * 2),
		"strength": 2 + (level.strength * 2),
		"mind": 5 + (level.mind * 5)
	}

func upgrade(val):
	if !level.has(val): return
	if val == "mind" && level.mind >= 4: return
	
	var cost = getLevelCost()
	if CatController.Abilities.orbs < cost[val]: return
	
	CatController.Abilities.orbs -= cost[val]
	level[val] += 1
	print(val + " Upgraded!")
