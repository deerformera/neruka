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

func damaged(val):
	get_node("StateMachine").travel("Hurt")
	.damaged(val)

func hit():
	var vec = Vector2(randf(), randf()).normalized()
	$Camera2D.offset = vec * 5
	yield(get_tree().create_timer(0.05), "timeout")
	$Camera2D.offset = Vector2()
