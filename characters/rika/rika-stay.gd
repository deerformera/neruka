extends InteractCharacter

export var velocity = Vector2.DOWN

func _physics_process(delta):
	$AnimationTree.set("parameters/idle/blend_position", velocity)
