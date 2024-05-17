extends Character
class_name Boss

var target: Character = null

var orb = preload("res://misc/scenes/orb.tscn")

func enter(target: Character):
	self.target = target
	target.connect("die", self, "onTargetDie")
	get_node("StateMachine").travel("Aggressive")

func damaged(val):
	.damaged(val)
	get_node("StateMachine").travel("Hurt")

func die():
	.die()
	get_tree().root.get_node("World").call_deferred("add_child", create_orb())
	emit_signal("die")
	

func onTargetDie():
	get_node("StateMachine").travel("Idle")
	target = null

func create_orb():
	var orb_ins = orb.instance()
	orb_ins.global_position = self.global_position
	return orb_ins
