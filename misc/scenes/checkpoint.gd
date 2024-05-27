extends Area2D

onready var cat = Utils.get_cat()

export var active = false
var grew = false

func _ready():
	self.connect("body_entered", self, "onEnter")
	if active: $AnimationPlayer.play("grow0")

func activate():
	if active: return
	$AnimationPlayer.play("grow0")

func onEnter(body: Character):
	if grew: 
		$AnimationPlayer.play("grow2")
		cat.get_node("StateMachine").travel("Idle")
		create_tween().tween_property(cat, "global_position", self.global_position, 0.2)
		cat.heal(999)
	
	else: 
		grew = true
		$AnimationPlayer.play("grow1")
