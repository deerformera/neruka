extends Cutscene

func _ready():
	$Curos.velocity = Vector2.UP
	var pincho: Boss = get_tree().get_nodes_in_group("pincho")[0]
	pincho.connect("die", self, "onPinchoDie")

func onPinchoDie():
	yield(get_tree().create_timer(1), "timeout")
	watch()

	$Curos.global_position = cat.global_position + Vector2(0, 250)
	var tw = create_tween()
	tw.tween_property($Curos, "global_position", cat.global_position + Vector2(0, 100), 0.8)

	yield(tw, "finished")
	cat.velocity_static = Vector2.DOWN
	yield(look($Curos.global_position), "completed")
	Dialogue.chat($Curos, ["Mungkinkah kau seorang sentinel?", "Aku bakul item boss lurr"])
	yield(Dialogue, "chat_end")
	unlook()
	unwatch()
