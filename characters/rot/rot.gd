extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
@export_range(0, 9999) var health: int

func _physics_process(delta):
	var vec = (direction - global_position)
	if vec.length() < 1:
		vec = Vector2()
	else:
		velocity = vec.normalized() * 50
		move_and_slide()

func damaged(value) -> void:
	pass

func move() -> void:
	var random = Vector2(randi_range(-100, 100), randi_range(-100, 100))
	direction = global_position + random
