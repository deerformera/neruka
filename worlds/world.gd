extends Node2D

var first_scene = false

func _ready():
	$RikaFirstScene.connect("body_entered", self, "rika_first_scene")
	$RikaFirstScene.set_as_toplevel(true)

func rika_first_scene(body):
	$RikaFirstScene.queue_free()
	first_scene = true

func _physics_process(delta):
	if first_scene:
		if $Path2D/PathFollow2D.unit_offset < 1:
			$Path2D/PathFollow2D.offset += 3
			print(Vector2.RIGHT.rotated($Path2D/PathFollow2D.rotation))
