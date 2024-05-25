extends StaticBody2D

var velocity: Vector2

onready var animstate = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	$AnimationTree.set("parameters/Idle/blend_position", velocity)
	$AnimationTree.set("parameters/Walk/blend_position", velocity)
	
