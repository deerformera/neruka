extends Character

onready var cat = Global.get_cat()
onready var bullet = preload("res://characters/cinpho/cinpho-bullet.tscn")

func shoot():
	if cat == null: 
		animstate.travel("idle")
		return
	var bullet_ins = bullet.instance()
	bullet_ins.dir = (cat.global_position - (self.global_position + Vector2(0, -20))).normalized()
	bullet_ins.position.y -= 20
	add_child(bullet_ins)

func entered(body: Character):
	$EnterArea/CollisionShape2D.set_deferred("disabled", true)
	animstate.travel("shoot")
