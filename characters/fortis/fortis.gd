extends Boss

var velocity: Vector2

func _physics_process(delta):
	if velocity:
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Aggressive/blend_position", velocity)
		$AnimationTree.set("parameters/Hop/blend_position", velocity)
