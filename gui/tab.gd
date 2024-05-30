extends CanvasLayer

signal tab_closed

func _ready():
	$M/P/VB/Top/Button.connect("pressed", self, "onExit")

func onExit():
	for i in $M/P/VB/Main.get_children(): i.queue_free()
	self.hide()
	emit_signal("tab_closed")
	
	if !get_tree().root.get_node("CheckpointMenu").visible: HUD.show()
	
func open(val: String):
	HUD.hide()
	self.show()
	
	$M/P/VB/Top/Label.text = val
	
	var tab: Control = load("res://gui/tabs/" + val + ".tscn").instance()
	for i in $M/P/VB/Main.get_children(): i.queue_free()
	$M/P/VB/Main.add_child(tab)
