extends Character

var velocity: Vector2
var velocity_static: Vector2

onready var animtree = $AnimationTree

func _physics_process(delta):
	animtree.set("parameters/Idle/blend_position", velocity_static)
	animtree.set("parameters/Walk/blend_position", velocity_static)
	animtree.set("parameters/Sit/blend_position", velocity_static)
	animtree.set("parameters/Attack1/blend_position", velocity_static)
	animtree.set("parameters/Attack2/blend_position", velocity_static)

func damaged(val, knockback = Vector2()):
	get_node("StateMachine").travel("Hurt")
	.damaged(val)
