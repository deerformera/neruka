extends Node

#onready var cat: Character = get_tree().get_nodes_in_group("cat")[0]
signal level_changed
signal abilities_changed

var enemies: Array

var level := {
    "vigor": 0,
    "strength": 0,
    "mind": 3
}

var orbs: int = 7

var abilities_data: Array
var abilities: Array
var current_abilities: Array = [2,1,0]
var knowledges: Array = [1,2,0]

func _ready():
    var f = File.new()
    f.open("res://assets/data.json", File.READ)
    enemies = parse_json(f.get_as_text())["enemies"]
    abilities_data = parse_json(f.get_as_text())["abilities"]
    f.close()
    
    if current_abilities.size() > level.mind + 1:
        current_abilities.resize(level.mind + 1)

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

# ___Ability System___
func add_orb():
    orbs += 1

func set_ability(slots: Array):
    self.current_abilities = slots
    emit_signal("abilities_changed")

func get_ability(id: int) -> Dictionary:
    if id > abilities_data.size() - 1: return {}
    var ability = self.abilities_data[id]
    var dict = { "name": ability[0], "desc": ability[1], "price": ability[2] }
    return dict

func get_abilities_nodes() -> Array:
    var arr = []
    for slot in current_abilities:
        if slot != null: arr.append(load("res://assets/abilities/" + str(slot) + ".tscn"))
    return arr

func get_abilities() -> Array:
    var arr = []
    for ability in abilities:
        arr.append(get_ability(ability))
    return arr

func learn(id: int):
    if !abilities.has(id):
        orbs -= get_ability(id).price
        abilities.append(id)

func identify(id: int):
    if !knowledges.has(id): 
        knowledges.append(id)
        print("You learn ", get_enemy(id).name, ", ", get_enemy(id).desc)
# ___End of Ability System___

# ___Level System___
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
# ___End of Level System___

