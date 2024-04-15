extends State

func enter(msg):
	owner.animstate.travel("Aggressive")

func update():
	if Input.is_action_just_pressed("n_ability1"):
		machine.travel("Idle")
	if Input.is_action_just_pressed("n_ability2"):
		machine.travel("Hurt")
