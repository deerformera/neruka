extends CPUParticles2D

func _ready():
	emitting = true
	yield(get_tree().create_timer(1), "timeout")
	self.queue_free()
