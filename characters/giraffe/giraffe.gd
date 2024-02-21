extends Character

var velocity: Vector2

func _physics_process(delta):
	$AnimationTree.set("parameters/idle/blend_position", velocity)
