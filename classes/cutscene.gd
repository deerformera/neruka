extends Node
class_name Cutscene

onready var cat: Character = Utils.get_cat()

var walk_node: Node2D = null
var walk_path: PathFollow2D = null

func _ready():
	for i in $Areas.get_children():
		i.connect("body_entered", self, "on" + i.name)

func watch():
	cat.get_node("StateMachine").travel("Idle")
	HUD.hide()
	Tab.hide()

func unwatch():
	cat.get_node("StateMachine").travel("Normal")
	HUD.show()

func look(vec = Vector2(), vec2 = Vector2()):
	var cam = cat.get_node("Camera2D")
	var tw = create_tween()
	var dir: Vector2
	
	if vec: 
		dir = vec - cat.global_position
		if vec2: dir = dir / 2
	
	tw.tween_property(cam, "position", dir, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	yield(tw, "finished")

func unlook():
	var cam = cat.get_node("Camera2D")
	var tw = create_tween()
	tw.tween_property(cam, "position", Vector2(), 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	yield(tw, "finished")

func transition(path: String):
	if path == "": return
	get_parent().add_child(load(path).instance())
	self.queue_free()
