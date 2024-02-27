extends Area2D

var dir: Vector2

func _ready():
	yield(get_tree().create_timer(3),"timeout")
	self.queue_free()

func entered(body):
	body.emit_signal("damaged", 5)

func _physics_process(delta):
	self.position += dir * 2
