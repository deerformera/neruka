extends Boss

var minion = preload("res://characters/pincho/pinchoMinion.tscn")

func damaged(val):
	.damaged(val)
	summonMinion()

func summonMinion():
	var minion_ins = minion.instance()
	var rng = Utils.create_rng()
	var vec = Vector2()
	while vec.length() <= 50:
		vec = Vector2(rng.randi_range(-100, 100), rng.randi_range(-100, 100))

	minion_ins.position += vec
	call_deferred("add_child", minion_ins)
