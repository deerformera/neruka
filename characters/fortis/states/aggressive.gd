extends State

var initial_val = 0
var distance = Vector2()

func _ready():
	var timer = Utils.create_timer(1, false, false)
	timer.connect("timeout", self, "onNavUpdate")
	add_child(timer)

func enter(msg):
	if initial_val < 2:
		machine.travel("Hop")
		initial_val += 1

func update():
	if initial_val >= 2:
		var navagent: NavigationAgent2D = owner.get_node("NavigationAgent2D")
		navagent.set_target_location(owner.target.global_position)
		var velocity = (navagent.get_next_location() - owner.global_position).normalized()
		owner.velocity = velocity
		owner.global_position += velocity * 2
