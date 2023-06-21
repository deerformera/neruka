extends Node

var equipment: Dictionary = {
	"sight": [1,2,3,4],
	"consumable": [1,2,3,4],
	"claw": [2,3,4],
	"ability": [1,2,3,4]
}

var equipped: Dictionary = {
	"sight": 0,
	"consumable": 0,
	"claw": 0,
	"ability": 0
}

var orbs: Array = []

func orb_add(id: int):
	for orb in orbs:
		if orb[0] == id:
			orb[1] += 1
			return
	orbs.append([id, 1])

func orb_del(id: int, val: int) -> bool:
	for orb in orbs:
		if orb[0] == id:
			if orb[1] >= val:
				orb[1] -= val
				if orb[1] == 0: orbs.erase(orb)
				return true
	return false

func buy(item: Dictionary):
	for orb in orbs:
		if orb[0] == item.price[0] && orb[1] >= item.price[1]:
			if !equipment[item.type].has(item.id):
				equipment[item.type].append(item.id)
				orb[1] -= item.price[1]
				if orb[1] == 0: orbs.erase(orb)
				return true
	return false
