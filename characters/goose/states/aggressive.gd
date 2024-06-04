extends State

var distance: Vector2

func enter(msg):
	owner.animstate.travel("Aggressive")

func update():
	distance = (owner.target.global_position - owner.global_position)
	owner.move_and_slide(distance.normalized() * 100)
	owner.setBlendPos(distance.normalized())
	
	if distance.length() <= 50:
		machine.travel("Attack")
