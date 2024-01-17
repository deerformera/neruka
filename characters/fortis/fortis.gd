extends Character

onready var cat = get_tree().get_nodes_in_group("cat")[0]

var velocity = Vector2()
var initial_count: int = 0

func _ready():
	animstate = $AnimationTree.get("parameters/phase1/playback")

func _physics_process(delta):
	if animstate.get_current_node() == "initial":
		velocity = (cat.global_position - self.global_position).normalized()
		$AnimationTree.set("parameters/phase1/dash/blend_position", velocity)
		$AnimationTree.set("parameters/phase1/attack1/blend_position", velocity)

func initial():
	if initial_count < 2:
		if initial_count == 0: yield(get_tree().create_timer(1), "timeout")
		initial_count += 1
		animstate.travel("dash")
		return
	
	if (cat.global_position - self.global_position).length() < 70:
		animstate.travel("attack1")

func dash():
	create_tween().tween_property(self, "global_position", cat.global_position, 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func attack1():
	pass
