extends Node
class_name StateMachine

export var initial_state: String = "Idle"
var state: Node

func _ready():
	state = get_node(initial_state)
	
	for i in get_children(): i.machine = self
	yield(owner, "ready")
	state.enter({})


func _physics_process(delta):
	state.update()

func travel(new_state, msg = {}):
	if not has_node(new_state):
		return
	
	if state.name == new_state:
		return
	
	state.exit()
	state = get_node(new_state)
	state.enter(msg)
