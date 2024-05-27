extends CanvasLayer

signal exited

func _ready():
	for i in $C/P/M/VB.get_children(): i.connect("pressed", self, "on" + i.name)

func onInventory():
	Tab.open("inventory")

func onUpgrade():
	Tab.open("upgrade")

func onExit():
	self.hide()
	HUD.show()
	emit_signal("exited")

func open():
	self.show()
	HUD.hide()
	
