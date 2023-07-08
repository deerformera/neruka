extends CanvasLayer

signal health_base_changed
signal health_changed
signal level_changed
signal leap_charge_changed
signal consumable_value_changed

var equipment: Dictionary = {
	"consumable": [[1, 5], [2, 5]],
	"claw": [],
	"ability": [1]
}
var equipped: Dictionary = {
	"consumable": 0,
	"claw": 0,
	"ability": 0
}
var orbs: Array = [[1,5], [3,5], [2,5]]
var level: Dictionary = {
	"health": 0,
	"damage": 0,
	"leap": 0,
	"sense": 0
}

var damage: int = 1
var speed: int = 200
var health_base: int = 100:
	set(val):
		health_base = val
		health_base_changed.emit()
var leap_charge_base: int = 0 :
	set(val):
		leap_charge_base = val
		leap_cooldown.start()

@onready var leap_charge: int = 0 :
	set(val):
		if val <= leap_charge_base:
			leap_charge = val
			leap_charge_changed.emit()
			if val < leap_charge_base:
				leap_cooldown.start()

@onready var leap_cooldown: Timer = Utils.create_timer(self, 2, func(): leap_charge += 1)
@onready var health: int = health_base :
	set(val):
		health = val
		if health > health_base: health = health_base
		health_changed.emit()

func _ready():
	health_changed.emit()
	health_base_changed.emit()
	sync_level()

func get_panel(panel: String): 
	$Panel.show()
	$Panel/P/VB/HB/PanelLabel.text = panel
	$Panel/P/VB/MainMargin.get_children().map(func(child): child.hide())
	return $Panel/P/VB/MainMargin.get_node(panel)

func get_level() -> int:
	var total: int = 0
	for val in level.values():
		total += val
	return total

func up_level(type: String):
	level[type] += 1
	sync_level()
	level_changed.emit()

func sync_level():
	health_base = 100 + (level["health"] * 10)
	damage = 1 + level["damage"]
	leap_charge_base = 0 + level["leap"]


func orb_add(id: int) -> void:
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

func equip(type: String, id: int):
	equipped[type] = id
	get_tree().get_first_node_in_group("cat").equipment()

func buy(shop_item: Dictionary):
	var orb_arr: Array = []
	for price in shop_item.price:
		for orb in orbs:
			if orb[0] == price[0] && orb[1] >= price[1]:
				orb_arr.append(orb)
	if shop_item.price.size() == orb_arr.size():
		var subtract = func():
			for orb in orbs:
				for price in shop_item.price:
					if orb[0] == price[0]:
						orb[1] -= price[1]
						if orb[1] == 0: orbs.erase(orb)
		if shop_item.type == "consumable":
			subtract.call()
			for consume in equipment["consumable"]:
				if consume[0] == shop_item.id:
					consume[1] += 1
					return
			equipment["consumable"].append([shop_item.id, 1])
		if !equipment[shop_item.type].has(shop_item.id):
			subtract.call()
			equipment[shop_item.type].append(shop_item.id)

#	for orb in orbs:
#		for item in shop_item.price:
#			if orb[0] == item.price[0] && orb[1] >= item.price[1]:
#				if item.type == "consumable":
#					for consume in equipment["consumable"]:
#						if consume[0] == item.id:
#							consume[1] += 1
#							return true
#
#					equipment["consumable"].append([item.id, 1])
#
#				if !equipment[item.type].has(item.id):
#					equipment[item.type].append(item.id)
#					orb[1] -= item.price[1]
#					if orb[1] == 0: orbs.erase(orb)
#					return true
#	return false
