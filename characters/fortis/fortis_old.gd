extends Character

onready var cat: Character = get_tree().get_nodes_in_group("cat")[0]
onready var attacking = create_timer(1.2)
onready var delay = create_timer(1)

var velocity: Vector2
var initial_count = 0

func _ready():
	animstate = $AnimationTree.get("parameters/one/playback")
	add_child(attacking)
	add_child(delay)
	
	delay.connect("timeout", self, "action")
	$AttackArea.connect("body_entered", self, "attack_entered")

func _physics_process(delta):
	if !delay.is_stopped():
		print(delay.time_left)
	if animstate.get_current_node() == "center":
		velocity = (cat.global_position - self.global_position).normalized()
		$AnimationTree.set("parameters/one/attack1/blend_position", velocity)
		$AnimationTree.set("parameters/one/attack2/blend_position", velocity)
		$AnimationTree.set("parameters/one/backstep/blend_position", velocity)
		$AnimationTree.set("parameters/one/initial/blend_position", velocity)

func center():
	if initial_count < 2:
		animstate.travel("initial")
		initial_count += 1
		initial()
		return
	
	delay.start()

func action():
	delay.stop()
	var length = (cat.global_position - self.global_position).length()
	if length < 80:
		if !attacking.is_stopped():
			animstate.travel("attack2")
			attack2()
			return
		
		var index = randi() % 5
		if index == 0:
			animstate.travel("backstep")
		else: animstate.travel("attack1")

func attack_entered(body: Character):
	body.emit_signal("damaged", damage)

func initial():
	damage = 20
	var tween = create_tween()
	tween.tween_property(self, "global_position", cat.global_position, 1.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	$AttackArea/CollisionShape2D.position.y = 0
	$AttackArea/CollisionShape2D.disabled = false
	yield(get_tree().create_timer(1), "timeout")
	tween.kill()
	$AttackArea/CollisionShape2D.disabled = true

func attack1():
	damage = 10
	$AttackArea/CollisionShape2D.position.y = 16
	attacking.start()

func attack2():
	damage = 10
	$AttackArea/CollisionShape2D.position.y = -16

func backstep():
	$AttackArea/CollisionShape2D.position.y = 0
	create_tween().tween_property(self, "global_position", self.global_position - velocity * 50, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
