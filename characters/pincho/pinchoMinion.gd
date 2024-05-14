extends Character

func _ready():
	heal()

func heal():
	var parent: Boss = get_parent()
	yield(get_tree().create_timer(1), "timeout")
	if parent:
		parent.health += 1
	
	self.queue_free()
