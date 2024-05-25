extends State

var valid = false
var current: String
var slash = preload("res://misc/slash/slash.tscn")

func enter(msg):
	valid = false
	owner.animstate.travel("Attack1")

func update():
	var animnode = owner.animstate.get_current_node()
	if Input.is_action_just_pressed("n_attack"):
		if animnode == "Attack1": owner.animstate.travel("Attack2")
		elif animnode == "Attack2": owner.animstate.travel("Attack1")
	
	if animnode == "Attack1" && !valid: valid = true
	
	if animnode == "Walk" && valid: machine.travel("Normal")
	
	owner.get_node("WallRay").rotation = owner.velocity_static.angle()

func attack(flip: bool):
	var slash_ins = slash.instance()
	slash_ins.global_position = owner.global_position + (owner.velocity_static * 40)
	slash_ins.rotation = owner.velocity_static.angle()
	if flip: slash_ins.get_node("AnimatedSprite").flip_v = true
	owner.get_parent().add_child(slash_ins)
	
	var ray: RayCast2D = owner.get_node("WallRay")
	
	if !ray.is_colliding():
		create_tween().tween_property(
			owner, 
			"global_position", 
			owner.global_position + owner.velocity_static * 10, 
			0.05).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
