extends State

var valid = false
var distance : Vector2

func enter(msg):
	valid = false
	
	distance = (owner.target.global_position - owner.global_position)
	owner.setBlendPos(distance)
	owner.get_node("AttackArea").rotation = distance.angle()
	
	owner.animstate.travel("Attack1")

func update():
	var animnode = owner.animstate.get_current_node()
	if !valid && animnode == "Attack1": valid = true
	
	if valid && animnode == "Aggressive":
		machine.travel("Aggressive")

func attack(second: bool = false):
	owner.get_node("AttackArea/CollisionShape2D").disabled = false
	create_tween().tween_property(owner, "global_position", owner.global_position + distance.normalized() * 10, 0.1)

	yield(get_tree().create_timer(0.3), "timeout")

	owner.get_node("AttackArea/CollisionShape2D").disabled = true
	
	if owner.target == null:
		machine.travel("Idle")
		return
	
	if (owner.target.global_position - owner.global_position).length() <= 70:
		owner.animstate.travel("Attack2")
