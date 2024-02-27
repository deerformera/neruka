extends Character

onready var bullet = preload("res://characters/cactus/cactus-bullet.tscn")
onready var cat = Global.get_cat()

func entered(body):
	$EnterArea/CollisionShape2D.set_deferred("disabled", true)
	animstate.travel("attack")
	

func attack():
	var bullet_ins = bullet.instance()
	bullet_ins.dir = (cat.global_position - (self.global_position + Vector2(0, -20))).normalized()
	bullet_ins.position.y -= 10
	add_child(bullet_ins)
#	call_deferred("add_child", bullet_ins)
