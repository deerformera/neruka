extends Path2D

var node: Node2D = null

export var speed = 1

func _physics_process(delta):
	if node:
		node.global_position = $PathFollow2D.global_position
		node.velocity = Vector2.RIGHT.rotated($PathFollow2D.rotation)
		$PathFollow2D.offset += speed
		if $PathFollow2D.unit_offset >= 1:
			self.queue_free()
