extends CanvasLayer

func reload():
	HUD.bossExit()
	get_tree().reload_current_scene()
