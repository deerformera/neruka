extends Character

onready var cat = Global.get_cat()

var velocity: Vector2

func damaged(damage):
	.damaged(damage)
	if animstate.get_current_node() == "idle": animstate.travel("spike")

func _physics_process(delta):
	if animstate.get_current_node() == "idle":
		velocity = (cat.global_position - self.global_position).normalized()
		$AnimationTree.set("parameters/idle/blend_position", velocity)
		$AnimationTree.set("parameters/spike/blend_position", velocity)
		$AnimationTree.set("parameters/curl/blend_position", velocity)

func spike():
	$SpikeArea/CollisionShape2D.disabled = false
	yield(get_tree().create_timer(0.1), "timeout")
	$SpikeArea/CollisionShape2D.disabled = true


func spike_entered(body):
	cat.emit_signal("damaged", 2)
