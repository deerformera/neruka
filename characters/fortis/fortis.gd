extends Character

onready var cat = get_tree().get_nodes_in_group("cat")[0]
onready var rng = create_rng()
onready var attack_timer = create_timer(0.9)

var initial = 0
var velocity: Vector2

func _ready():
	animstate = $AnimationTree.get("parameters/phase1/playback")
	add_child(attack_timer)

func _physics_process(delta):
	if animstate.get_current_node() == "initial":
		velocity = (cat.global_position - self.global_position).normalized()
		$AnimationTree.set("parameters/phase1/dash/blend_position", velocity)
		$AnimationTree.set("parameters/phase1/audash/blend_position", velocity)
		$AnimationTree.set("parameters/phase1/attack1/blend_position", velocity)
		$AnimationTree.set("parameters/phase1/attack2/blend_position", velocity)
		$AnimationTree.set("parameters/phase1/backslash/blend_position", velocity)
		$AnimationTree.set("parameters/phase1/conslash/blend_position", velocity)

func is_in_range() -> bool:
	if (cat.global_position - self.global_position).length() < 70: return true
	return false

func initial():
	if initial < 2:
		if initial == 0: yield(get_tree().create_timer(1), "timeout")
		animstate.travel("dash")
		initial += 1
		return
	
	if is_in_range(): 
		var random = rng.randi_range(0, 4)
		if random == 0:
			animstate.travel("backslash")
		elif random == 1:
			animstate.travel("conslash")
		else: animstate.travel("attack1")

func dash():
	create_tween().tween_property(self, "global_position", cat.global_position, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func attack1():
	print("attack1")
	yield(get_tree().create_timer(0.9), "timeout")
	if is_in_range(): animstate.travel("attack2")

func attack2(): 
	print("attack2")

func backslash():
	create_tween().tween_property(self, "global_position", global_position - velocity * 100, 1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)

func conslash(): # Consecutive Slash
	create_tween().tween_property(self, "global_position", global_position + (velocity * 20), 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func audash(): # audax dash
	print("audash")
