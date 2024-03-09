extends Node2D
class_name Cutscene

onready var cat: Character = Global.get_cat()

export var id: int = 0

var hook: Array = []

func _ready():
	for i in $Areas.get_children():
		if i is Area2D:
			i.connect("body_entered", self, i.name + "_entered")

func cat_look_start(animation_name: String, camera_position = cat.global_position):
	if Global.debug: 
		yield(get_tree().create_timer(0.1), "timeout")
		return
	
	cat.get_node("AnimationTree").active = false
	cat.get_node("AnimationPlayer").play(animation_name)
	cat.get_node("HUD").hide()
	var tw = create_tween()
	tw.tween_property(cat.get_node("Camera2D"), "global_position", camera_position, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	yield(tw, "finished")
	return

func cat_look_stop():
	if Global.debug: 
		yield(get_tree().create_timer(0.1), "timeout")
		return
	
	cat.get_node("AnimationPlayer").stop()
	cat.get_node("HUD").show()
	var tw = create_tween()
	tw.tween_property(cat.get_node("Camera2D"), "global_position", cat.global_position, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	yield(tw, "finished")
	cat.get_node("AnimationTree").active = true

func get_between(vector: Vector2) -> Vector2:
	return cat.global_position + (vector - cat.global_position) / 2

func hook(character: Node2D, path: String): 
	self.hook = [character, get_node("Points/" + path + "/PathFollow2D")]

func unhook(): hook = []

func _physics_process(delta):
	if hook != []:
		if self.hook[1].unit_offset >= 0.99:
			self.hook = []
			return
		
		self.hook[0].velocity = Vector2.RIGHT.rotated(self.hook[1].rotation)
		self.hook[0].global_position = self.hook[1].global_position
		self.hook[1].offset += 2.5
