extends Ability

func ability():
	cat.animstate.travel("dash")
	
	yield(get_tree().create_timer(0.3), "timeout")
	
