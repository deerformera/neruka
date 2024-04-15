extends Enemy

func _ready():
	yield(get_tree().create_timer(1), "timeout")
	$AlertArea.emit_signal("body_entered", null)
