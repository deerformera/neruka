extends Node

var perks: Array = []
var orbs: Array = []

func orb_add(id):
	for orb in orbs:
		if orb[0] == id:
			orb[1] += 1
			return
	orbs.append([id, 1])

func orb_del(id, val) -> bool:
	for orb in orbs:
		if orb[0] == id:
			if orb[1] >= val:
				orb[1] -= val
				if orb[1] == 0: orbs.erase(orb)
				return true
	return false

func perk_add(id):
	if !perks.has(id):
		perks.append(id)

func buy(orb_id, orb_val, perk_id) -> bool:
	for orb in orbs:
		if orb[0] == orb_id:
			if orb[1] >= orb_val && !perks.has(perk_id):
				orb[1] -= orb_val
				perks.append(perk_id)
				if orb[1] == 0: orbs.erase(orb)
				return true
	return false
