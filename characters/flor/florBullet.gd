extends Area2D

var vec: Vector2

func _ready():
	self.connect("body_entered", self, "onHit")

func _physics_process(delta):
	self.position += vec * 3
	get_node("Sprite").rotation_degrees += 15
	if self.position.length() > 1000:
		self.queue_free()

func onHit(body: Character):
	body.emit_signal("damaged", 1)
