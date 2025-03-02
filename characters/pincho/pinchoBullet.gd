extends Area2D

var vec: Vector2

func _ready():
	self.connect("body_entered", self, "onHit")

func _physics_process(delta):
	self.position += vec * 3
	if self.position.length() > 1000:
		self.queue_free()

func onHit(body: Character):
	body.emit_signal("damaged", get_parent().damage)
