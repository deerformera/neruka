extends Character

onready var cat = get_cat()

var velocity: Vector2
var sliding = false

func idle():
	if $DetectArea.get_overlapping_bodies().empty(): return
	var detected = $DetectArea.get_overlapping_bodies()[0]
	$Collider/CollisionShape2D.disabled = true
	velocity = (cat.global_position - self.global_position).normalized()
	$AnimationTree.set("parameters/slide/blend_position", velocity)
	$AnimationTree.set("parameters/idle/blend_position", velocity)
	animstate.travel("slide")

func slide():
	print("Y")

func _physics_process(delta):
	if animstate.get_current_node() == "slide":
		self.global_position += velocity * 3
