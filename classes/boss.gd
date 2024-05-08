extends Character
class_name Boss

var target: Character = null

var orb = preload("res://misc/scenes/orb.tscn")

signal die

func enter(target):
	self.target = target
	get_node("StateMachine").travel("Aggressive")

func damaged(val):
	.damaged(val)
	get_node("StateMachine").travel("Hurt")

func die():
	get_tree().root.get_node("World").call_deferred("add_child", create_orb())
	emit_signal("die")
	.die()

func create_orb():
	var orb_ins = orb.instance()
	orb_ins.global_position = self.global_position
	return orb_ins
