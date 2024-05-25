extends Ability

var healTimer = Utils.create_timer(0.8)

func _ready():
	add_child(healTimer)

func activate():
	cat.get_node("StateMachine").travel("Cast", {"heal": true})
	cat.get_node("Sprite").material.set_shader_param("color_key", Vector3(0.1,0.5,0.1))
	healTimer.start()
	
	yield(healTimer, "timeout")
	
	if cat.get_node("StateMachine").state.name != "Cast":
		return
	
	cat.heal(2)
	cat.add_child(preload("res://misc/scenes/healEffect.tscn").instance())
