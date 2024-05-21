extends Ability

func activate():
	cat.get_node("StateMachine").travel("Cast")
