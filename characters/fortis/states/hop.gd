extends State

var valid = false

func enter(msg):
	valid = false
	owner.velocity = (owner.target.global_position - owner.global_position).normalized()
	owner.get_node("WallRay").rotation = owner.velocity.angle()
	owner.animstate.travel("Hop")

func update():
	var animnode = owner.animstate.get_current_node()
	if !valid && animnode == "Hop": valid = true
	
	if valid && animnode == "Delay": 
		machine.travel("Delay")
	
	if owner.get_node("WallRay").is_colliding():
		pass
	else:
		owner.move_and_slide(owner.velocity * 360)
		
	
