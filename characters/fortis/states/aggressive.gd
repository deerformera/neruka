extends State

var initial_val = 0

func enter(msg):
	if initial_val < 2:
		machine.travel("Hop")
