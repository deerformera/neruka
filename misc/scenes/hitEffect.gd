extends AnimatedSprite

func _ready():
	self.play("default")
	connect("animation_finished", self, "onFinished")

func onFinished(): self.queue_free()
