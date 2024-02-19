extends Path2D

var index: int = 0

onready var timer = get_parent().create_timer(5, false)

func _ready():
	set_as_toplevel(true)
	self.global_position = get_parent().global_position
	
	add_child(timer)
	timer.connect("timeout", self, "move")
	timer.start()

func move():
	if get_parent().animstate.get_current_node() != "idle": return
	var pos = self.global_position + curve.get_point_position(index)
	get_parent().velocity = (pos - get_parent().global_position).normalized()
	create_tween().tween_property(get_parent(), "global_position", pos, 2)
	index += 1
	if index >= curve.get_point_count():
		index = 0
	
