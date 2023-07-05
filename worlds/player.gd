extends CanvasLayer

signal health_base_changed
signal health_changed
signal leap_charge_base_changed
signal level_changed

var equipment: Dictionary = {
	"consumable": [],
	"claw": [],
	"ability": [2]
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
var sense: int = 0
var health_base: int = 100:
	set(val):
		health_base = val
		health_base_changed.emit()
var leap_charge_base: int = 0 :
	set(val):
		leap_charge_base = val
		leap_charge_base_changed.emit()

@onready var health: int = health_base :
	set(val):
		health = val
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

func buy(item: Dictionary):
	for orb in orbs:
		if orb[0] == item.price[0] && orb[1] >= item.price[1]:
			if !equipment[item.type].has(item.id):
				equipment[item.type].append(item.id)
				orb[1] -= item.price[1]
				if orb[1] == 0: orbs.erase(orb)
				return true
	return false

