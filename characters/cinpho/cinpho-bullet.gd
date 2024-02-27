extends Sprite

onready var bullet = preload("res://characters/cinpho/cinpho-subbullet.tscn")

var dir = Vector2()

func _ready():
	self.rotation = dir.angle() + (PI / 4)
	var tw = create_tween()
	dir = dir * 200
	tw.tween_property(self, "position", dir, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	create_tween().tween_property(self, "rotation", rotation + (PI * 4), 1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	
	yield(tw, "finished")
	
	var dirs = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT]
	
	for i in dirs:
		i = i as Vector2
		var sub_bullet = bullet.instance()
		sub_bullet.dir = i.rotated(dir.angle())
		sub_bullet.position = self.position
		get_parent().add_child(sub_bullet)
	
	
	queue_free()

