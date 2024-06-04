extends Character
class_name Enemy

var target: Character = null

var orb = preload("res://misc/scenes/orb.tscn")

func _ready():
	get_node("AlertArea").connect("body_entered", self, "onAlert")
	get_node("LimitArea").connect("body_exited", self, "onLimit")

func damaged(val):
	.damaged(val)
	get_node("StateMachine").travel("Hurt")

func onAlert(body: Character):
	target = body
	get_node("StateMachine").travel("Aggressive")
	get_node("AlertArea/CollisionShape2D").set_deferred("disabled", true)

func onLimit(body: Character):
	target = null
	get_node("StateMachine").travel("Idle")
	get_node("AlertArea/CollisionShape2D").set_deferred("disabled", false)

func die():
	target = null
	get_node("StateMachine").travel("Idle")
	
	get_tree().root.get_node("World").call_deferred("add_child", create_orb())
	.die()

func create_orb():
	var orb_ins = orb.instance()
	orb_ins.global_position = self.global_position
	return orb_ins
