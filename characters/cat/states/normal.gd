extends State

func update():
	var vec = Input.get_vector("n_left", "n_right", "n_up", "n_down")
	if vec:
		owner.velocity_static = vec
		owner.animstate.travel("Walk")
		owner.get_node("InteractRay").rotation = vec.angle()
	else: owner.animstate.travel("Idle")
	
	owner.velocity = lerp(owner.velocity, vec * 200, 0.22)
	
	if Input.is_action_just_pressed("n_ability1"):
		machine.travel("Cast")
	
	if Input.is_action_just_pressed("n_attack"):
		machine.travel("Attack")
	
	owner.move_and_slide(owner.velocity)

func exit(): owner.velocity = Vector2()
