extends CanvasLayer

signal exited

func _ready():
	for i in $C/P/M/VB.get_children(): i.connect("pressed", self, "on" + i.name)

func onInventory():
	Tab.open("inventory")

func onUpgrade():
	Tab.open("upgrade")

func onExit():
	HUD.show()
	emit_signal("exited")
	self.queue_free()

