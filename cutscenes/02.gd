extends Cutscene

func _ready():
	$Curos.velocity = Vector2.UP
	var pincho: Boss = get_tree().get_nodes_in_group("pincho")[0]
	pincho.connect("die", self, "onPinchoDie")

func onPinchoDie():
	yield(get_tree().create_timer(1), "timeout")
	
	watch()
	look($LookPoint.global_position)
	
	yield(get_tree().create_timer(1), "timeout")
	
	get_tree().get_nodes_in_group("pinchoCheckpoint")[0].activate()
	
	yield(get_tree().create_timer(1), "timeout")
	
	unlook()
	unwatch()
