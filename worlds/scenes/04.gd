extends Cutscene

var interacting = false

func _ready():
	$Rika.connect("activated", self, "rika_activated")

func rika_activated():
	if interacting: return
	interacting = true
	yield(Interface.chat("Rika", [
		"Dia ada di sekitar sini",
		"Pintu masuknya hanya ada di sebelah kanan"
	]), "completed")
	interacting = false

func illusion_entered(body):
	var next = preload("res://worlds/scenes/05.tscn").instance()
	get_parent().call_deferred("add_child", next)
	self.queue_free()
