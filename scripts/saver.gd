extends Node

var timer = Utils.create_timer(2, false, false)
var cat_pos: Vector2

func _ready():
	add_child(timer)
	timer.connect("timeout", self, "onCheck")

func onCheck():
	var cat = Utils.get_cat()
	if cat == null: return
	if cat.get_node("Saver").get_overlapping_areas(): return
	
	saveData()

func loadData() -> bool:
	
	var file = ConfigFile.new()
	if file.load("user://dat.cfg") != OK: return false
	
	CatController.Abilities.abilities = file.get_value("Cat", "abilities")
	CatController.Abilities.current_abilities = file.get_value("Cat", "current_abilities")
	CatController.Abilities.orbs = file.get_value("Cat", "orbs")
	CatController.Level.level = file.get_value("Cat", "level")
	cat_pos = file.get_value("Cat", "pos")
	return true

func saveData():
	var file = ConfigFile.new()
	
	file.set_value("Cat", "abilities", CatController.Abilities.abilities)
	file.set_value("Cat", "current_abilities", CatController.Abilities.current_abilities)
	file.set_value("Cat", "orbs", CatController.Abilities.orbs)
	file.set_value("Cat", "level", CatController.Level.level)
	file.set_value("Cat", "pos", Utils.get_cat().global_position)
	
	file.save("user://dat.cfg")
