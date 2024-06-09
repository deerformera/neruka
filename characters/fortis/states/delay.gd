extends State

func enter(msg):
	yield(get_tree().create_timer(1), "timeout")
	machine.travel("Aggressive")
