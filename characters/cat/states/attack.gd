extends State

var valid = false
var current: String

func enter(msg):
	valid = false
	owner.animstate.travel("Attack1")
	attack()

func update():
	var animnode = owner.animstate.get_current_node()
	if Input.is_action_just_pressed("n_attack"):
		if animnode == "Attack1": owner.animstate.travel("Attack2")
		elif animnode == "Attack2": owner.animstate.travel("Attack1")
	
	if current != animnode:
		current = animnode
		if animnode == "Attack1" or animnode == "Attack2": attack()
	
	if animnode == "Attack1" && !valid: valid = true
	
	if valid && animnode == "Walk": machine.travel("Normal")

func attack():
	yield(get_tree().create_timer(0.2), "timeout")
	create_tween().tween_property(
		owner, 
		"global_position", 
		owner.global_position + owner.velocity_static * 5, 
		0.05).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
