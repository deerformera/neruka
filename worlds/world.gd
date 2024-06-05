extends Node2D

func _ready():
	if Saver.loadData():
		$Cat.global_position = Saver.cat_pos
	
	yield(get_tree().create_timer(0.5), "timeout")
	Saver.timer.start()
	$Canvas.unfade()
	HUD.enter()
