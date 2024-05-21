extends Ability

func activate():
	cat.get_node("StateMachine").travel("Cast", {"heal": true})
	cat.get_node("Sprite").material.set_shader_param("color_key", Vector3(0.1,0.5,0.1))
	
	yield(get_tree().create_timer(0.8), "timeout")
	
	cat.health += 2
	cat.add_child(preload("res://misc/scenes/healEffect.tscn").instance())
