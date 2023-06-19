extends Node

var perks: Array = [0, 1, 2, 3]
var perks_equipped: Array = [-1, -1, -1, -1]:
	set(new_perks_equipped):
		print(new_perks_equipped)

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

func perk_add(id: int):
	if !perks.has(id):
		perks.append(id)

func perk_equip(id):
	if perks_equipped.has(id):
		return false
	perks_equipped[perks_equipped.find(-1)] = id
	perks_equipped = perks_equipped

func buy(orb_id: int, orb_val: int, perk_id: int) -> bool:
	for orb in orbs:
		if orb[0] == orb_id:
			if orb[1] >= orb_val && !perks.has(perk_id):
				orb[1] -= orb_val
				perks.append(perk_id)
				if orb[1] == 0: orbs.erase(orb)
				return true
	return false
