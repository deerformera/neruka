extends State

var valid = false

func enter(msg):
	valid = false
	owner.animstate.travel("Hurt")

func update():
	var animnode = owner.animstate.get_current_node("Hurt")
	if !valid && animnode == "Hurt": valid = true
	if valid && animnode == "Aggressive": machine.travel("Aggressive")
