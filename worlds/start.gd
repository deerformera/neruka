extends CanvasLayer

func _ready():
	for i in $C/VB.get_children():
		i.connect("pressed", self, "on" + i.name)

func onPlay():
	get_tree().change_scene("res://worlds/world.tscn")

func onFullscreen():
	OS.window_fullscreen = !OS.window_fullscreen
	$C/VB/Fullscreen.text = "Fullscreen: " + OS.window_fullscreen as String

func onExit():
	get_tree().quit()
