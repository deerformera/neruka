extends State

var velocity: Vector2
var timer = Utils.create_timer(1, false, false)

func _ready():
	add_child(timer)
	timer.connect("timeout", self, "hop")
	timer.start()

func update():
	owner.move_and_slide(velocity)
	
	if owner.get_node("WallRay").is_colliding():
		velocity = Vector2()


func hop():
	velocity = (owner.target.global_position - owner.global_position).normalized() * 200
	owner.get_node("WallRay").look_at(owner.target.global_position)
	owner.get_node("AnimationTree").set("parameters/Hop/blend_position", velocity)
	owner.get_node("AnimationTree").set("parameters/Idle/blend_position", velocity)
	
	owner.animstate.travel("Hop")
	yield(get_tree().create_timer(0.5), "timeout")
	velocity = Vector2()
