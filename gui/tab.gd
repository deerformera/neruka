extends CanvasLayer

func _ready():
	self.hide()
	$M/P/VB/Top/Button.connect("pressed", self, "pressed")

func pressed():
	for i in $M/P/VB/Main.get_children(): i.queue_free()
	self.hide()
	
func open(val: String):
	self.show()
	var tab: Control = load("res://gui/tabs/" + val + ".tscn").instance()
	
	for i in $M/P/VB/Main.get_children(): i.queue_free()
	$M/P/VB/Main.add_child(tab)
