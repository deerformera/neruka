extends State

var valid = false

func enter(msg):
	valid = false
	owner.animstate.travel("Cast")

func update():
	if owner.animstate.get_current_node() == "Cast":
		if !valid: valid = true
	
	if valid && owner.animstate.get_current_node() == "Walk":
		machine.travel("Normal")
