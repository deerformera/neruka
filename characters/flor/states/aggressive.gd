extends State

var bullet = preload("res://characters/flor/florBullet.tscn")

func enter(msg):
	owner.animstate.travel("Aggressive")

func shoot():
	var bullet_ins = bullet.instance()
	bullet_ins.vec = (owner.target.global_position - (owner.global_position + Vector2(0, -20))).normalized()
	owner.add_child(bullet_ins)
	bullet_ins.global_position.y -= 6
