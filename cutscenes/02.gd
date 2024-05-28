extends Cutscene

func _ready():
	$Curos.velocity = Vector2.UP
	var pincho: Boss = get_tree().get_nodes_in_group("pincho")[0]
	pincho.connect("die", self, "onPinchoDie")
	
#	yield(get_tree().create_timer(0.5), "timeout")
#
#	Card.open("ceritane knock")

func onPinchoDie():
	yield(get_tree().create_timer(1), "timeout")
	
	watch()
	look($LookPoint.global_position)

	yield(get_tree().create_timer(1), "timeout")

	CheckpointMenu.connect("exited", self, "onMenuExit")

	yield(get_tree().create_timer(1), "timeout")
	
	unwatch()
	unlook()
	

func onMenuExit():
	CheckpointMenu.disconnect("exited", self, "onMenuExit")
	
	watch()
	look($LookPoint.global_position)
	
	$Curos.global_position = cat.global_position + Vector2(0, 200)
	create_tween().tween_property($Curos, "global_position", cat.global_position + Vector2(0, 100), 1)
	
	yield(get_tree().create_timer(1), "timeout")
	
	cat.get_node("StateMachine").travel("Idle")
	cat.velocity_static = Vector2.DOWN
	look($Curos.global_position)
	
	yield(get_tree().create_timer(1), "timeout")
	
	Dialogue.chat($Curos, ["kau seorang sentinel?", "Suwun om", "Aku bakul"])
	
	yield(Dialogue, "chat_end")
	
	unlook()
	unwatch()
	
	$Curos.interactable = true
