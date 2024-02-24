extends CanvasLayer

signal health_base_changed
signal health_changed
signal level_changed
signal dash_charge_changed
signal consumable_value_changed

class NTimer:
	extends Timer
	func _init(body, waittime: float, method: String, oneshot = true, start = false):
		self.wait_time = waittime
		self.one_shot = oneshot
		self.autostart = start
		self.connect("timeout", body, method)
		body.add_child(self)

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
	"dash": 0,
	"sense": 0
}

var android_mode = 0
var damage: int = 1
var speed: int = 200
var health_base: int = 100 setget _set_health_base
var dash_charge_base: int = 0 setget _set_dash_charge_base
onready var dash_charge: int = 0 setget _set_dash_charge
onready var health: int = health_base setget _set_health

onready var dash_cooldown: Timer = self.NTimer.new(self, 2, "_dash_cooldown_timeout")

# -- Signal Method --
func _dash_cooldown_timeout(): _set_dash_charge(dash_charge + 1)

# -- Setter Getter Method --
func _set_dash_charge_base(val):
	dash_charge_base = val
	dash_cooldown.start()

func _set_dash_charge(val):
	if val <= dash_charge_base:
		dash_charge = val
		emit_signal("dash_charge_changed")
		if val < dash_charge_base:
			dash_cooldown.start()

func _set_health(val):
	print("y")
	health = val
	if health > health_base: health = health_base
	emit_signal("health_changed")

func _set_health_base(val):
	health_base = val
	emit_signal("health_base_changed")

# -- Main --
func _ready():
	emit_signal("health_changed")
	emit_signal("health_base_changed")
	sync_level()

func get_cat() -> Character:
	var arr = get_tree().get_nodes_in_group("cat")
	if arr.empty(): return null
	else: return arr[0]

func get_panel(panel: String):
	for child in $Panel/P/VB/Main.get_children(): child.hide()
	$Panel.show()
	$Panel/P/VB/Top/Label.text = panel.capitalize()
	return $Panel/P/VB/Main.get_node(panel)

func get_level() -> int:
	var total: int = 0
	for val in level.values():
		total += val
	return total

func get_dict(path: String) -> Dictionary:
	var file = File.new()
	file.open(path, File.READ)
	var data = JSON.parse(file.get_as_text()).result
	file.close()
	return data

func up_level(type: String):
	level[type] += 1
	sync_level()
	emit_signal("level_changed")

func sync_level():
	_set_health_base(100 + (level["health"] * 10))
	_set_dash_charge_base(0 + level["dash"])
	damage = 1 + level["damage"]

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
	get_tree().get_nodes_in_group("cat")[0].equipment()

func buy(shop_item: Dictionary):
	var orb_arr: Array = []
	for price in shop_item.price:
		for orb in orbs:
			if orb[0] == price[0] && orb[1] >= price[1]:
				orb_arr.append(orb)
	if shop_item.price.size() == orb_arr.size():
		if shop_item.type == "consumable":
			for orb in orbs:
				for price in shop_item.price:
					if orb[0] == price[0]:
						orb[1] -= price[1]
						if orb[1] == 0: orbs.erase(orb)
			for consume in equipment["consumable"]:
				if consume[0] == shop_item.id:
					consume[1] += 1
					return
			equipment["consumable"].append([shop_item.id, 1])
		if !equipment[shop_item.type].has(shop_item.id):
			for orb in orbs:
				for price in shop_item.price:
					if orb[0] == price[0]:
						orb[1] -= price[1]
						if orb[1] == 0: orbs.erase(orb)
			equipment[shop_item.type].append(shop_item.id)
