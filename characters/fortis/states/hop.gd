extends State

var velocity: Vector2

func update():
	owner.move_and_slide(velocity)
