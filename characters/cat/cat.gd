extends Character

signal attack
signal health_changed

var android = false

var velocity: Vector2
var velocity_static = Vector2(1, 0)

var animnode: String

var slash_base = load("res://assets/scenes/slash.tscn")
var slash = null

func _ready():
	Utils.connect("level_changed", self, "level_changed")
	level_changed()

func level_changed():
	var base = Utils.get_base()
	self.health = base.health
	self.damage = base.damage

func _physics_process(delta):
	animnode = animstate.get_current_node()
	
	if animnode == "normal":
		if !android: velocity = Input.get_vector("n_left", "n_right", "n_up", "n_down")
		if velocity:
			velocity_static = velocity.normalized()
			$AnimationTree.get("parameters/normal/playback").travel("walk")
		else: $AnimationTree.get("parameters/normal/playback").travel("idle")
	
	elif animnode == "dash":
		velocity = velocity_static * 1.8
	
	elif animnode == "hurt":
		velocity = velocity_static * 0.5
	
	else:
		velocity = Vector2()
	
	move_and_slide(velocity * 200)

func _input(event):
	if event.is_action_pressed("n_attack"):
		if $InteractArea.interacting: $InteractArea.activate()
		else:
			if animnode == "normal" or animnode == "attack2": animstate.travel("attack1")
			if animnode == "attack1": animstate.travel("attack2")


func attack():
	emit_signal("attack")
	yield(get_tree().create_timer(0.3), "timeout")
	if slash: add_child(slash.instance())
	else: add_child(slash_base.instance())
	create_tween().tween_property(self, "global_position", global_position + velocity_static * 10, 0.1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func strike():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var vec = Vector2(randf(), randf()).normalized()
	$Camera2D.offset = vec * 5
	yield(get_tree().create_timer(0.05), "timeout")
	$Camera2D.offset = Vector2()

func damaged(damage: int):
	self.health -= damage
	animstate.travel("hurt")
	emit_signal("health_changed")
	if self.health <= 0: print("die")

func die(): pass

func heal(val: int):
	var base = Utils.get_base()
	self.health = clamp(self.health + val, 0, base.health)
	emit_signal("health_changed")
