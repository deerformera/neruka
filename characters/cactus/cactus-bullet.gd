extends Area2D

var dir: Vector2

func _ready():
	dir = dir * rand_range(50, 200)
	
	var tw = create_tween()
	tw.tween_property(self, "position", dir, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	yield(tw, "finished")
	$CollisionShape2D.disabled = false

func timeout():
	queue_free()

func entered(body):
	body.emit_signal("damaged", 2)
