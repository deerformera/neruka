extends Ability

func activate():
	cat.get_node("StateMachine").travel("Cast")
	cat.get_node("Sprite").material.set_shader_param("color_key", Vector3(0.5,0.5,0.5))
