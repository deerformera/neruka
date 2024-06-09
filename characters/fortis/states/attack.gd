extends State

func enter(msg):
	var rng = Utils.create_rng()
	if rng.randi_range(0, 1) == 0:
		create_tween().tween_property(
			owner, 
			"global_position", 
			owner.target.global_position - owner.getDistance().normalized() * 300,
			0.8).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	else:
		create_tween().tween_property(
			owner,
			"global_position",
			owner.global_position + owner.getDistance().normalized() * 50,
			0.2
		)
	
	yield(get_tree().create_timer(1), "timeout")
	machine.travel("Aggressive")
