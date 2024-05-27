extends CanvasLayer

func _ready():
	$C/P/M/VB/Exit.connect("pressed", self, "onExit")

func onExit():
	get_tree().paused = false
	self.hide()

func open(msg: String):
	get_tree().paused = true
	$C/P/M/VB/Label.text = msg
	self.show()
