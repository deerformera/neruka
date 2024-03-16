extends Cutscene

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	Interface.fade_out()
