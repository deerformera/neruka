extends Area2D

var dir: Vector2

func _ready():
	self.connect("body_entered", self, "body_entered")

func body_entered(body: Character):
	body.emit_signal("damaged", get_parent().damage)
	self.set_deferred("monitoring", false)

func _physics_process(delta):
	self.position += dir * 2
	if self.position.length() > 1000:
		self.queue_free()
