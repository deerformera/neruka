extends State

func enter(msg):
	owner.animstate.travel("Hurt")

func update():
	if owner.animstate.get_current_node() == "Aggressive":
		machine.travel("Aggressive")
