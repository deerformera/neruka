extends State

var valid = false

func enter(msg):
	valid = false
	owner.animstate.travel("Cast")
	if msg.has("heal"): owner.animstate.travel("heal")

func update():
	if owner.animstate.get_current_node() == "Cast" or owner.animstate.get_current_node() == "heal":
		if !valid: valid = true
	
	if valid && owner.animstate.get_current_node() == "Walk":
		machine.travel("Normal")
