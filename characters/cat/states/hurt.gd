extends State

var valid = false

func enter(msg):
	valid = false
	owner.animstate.travel("Hurt")
	if msg.has("knockback"):
		create_tween().tween_property(owner, "global_position", owner.global_position + msg.knockback * 20, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)

func update():
	if owner.animstate.get_current_node() == "Hurt":
		if !valid: valid = true
	
	if valid && owner.animstate.get_current_node() == "Walk":
		machine.travel("Normal")
