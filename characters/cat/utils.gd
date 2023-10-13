extends Node

#onready var cat: Character = get_tree().get_nodes_in_group("cat")[0]
signal level_changed
signal abilities_changed

var enemies: Array
var abilities: Array

var level := {
    "vigor": 0,
    "strength": 0,
    "mind": 0
}

var orbs: int = 100
var slots: Array

var knowledges := []

func _ready():
    var f = File.new()
    f.open("res://assets/data.json", File.READ)
    enemies = parse_json(f.get_as_text())["enemies"]
    abilities = parse_json(f.get_as_text())["abilities"]
    f.close()
    
    slots.resize(level.mind + 1)

func get_base():
    var base = {}
    base.health = 100 + (level.vigor * 10)
    base.damage = 1
    if level.strength > 0: base.damage = level.strength * 5
    return base

func get_enemy(id: int) -> Dictionary:
    if id > enemies.size() - 1: return {}
    var enemy = self.enemies[id]
    var dict = { "name": enemy[0], "desc": enemy[1] }
    return dict

func get_ability(id: int) -> Dictionary:
    if id > abilities.size() - 1: return {}
    var ability = self.abilities[id]
    var dict = { "name": ability[0], "desc": ability[1] }
    return dict

func get_abilities() -> Array:
    var arr = []
    for slot in slots:
        if slot != null: arr.append(load("res://assets/abilities/" + str(slot) + ".tscn"))
    return arr

func add_orb():
    orbs += 1

func learn(id: int):
    if !knowledges.has(id): 
        knowledges.append(id)
        print("You learn ", get_enemy(id).name, ", ", get_enemy(id).desc)

func set_levels(val: Dictionary):
    orbs -= get_levels_requirement(val)
    for i in val:
        level[i] += val[i]
    emit_signal("level_changed")

func get_levels() -> int:
    var total = 0
    for i in level.values(): total += i
    return total

func get_levels_requirement(val: Dictionary) -> int:
    var total: int = 0
    for i in val:
        total += get_level_requirement(i, val[i])
    
    return total

func get_level_requirement(type: String, val: int) -> int:
    var total: int = 0
    
    for i in range(val + level[type] + 1):
        total += i * 2
    for i in range(level[type] + 1):
        total -= i * 2
    
    return total
