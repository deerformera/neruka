extends CharacterBody2D

signal damaged

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var tween: Tween
@onready var leap_timer: Timer = Utils.create_timer(self, 0.8, func(): 
	$LeapSprite.scale = Vector2(0, 1)
	$LeapSprite.visible = true
	create_tween().tween_property($LeapSprite, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT))

var velocity_static: Vector2 = Vector2(0, 1)
var spin_slash = preload("res://assets/spin_slash.tscn")

func _ready():
	equipment()
	self.damaged.connect(func(value: int):
		animstate.travel("hurt")
		velocity = Vector2.ZERO
		Player.health -= value
		if Player.health <= 0: self.die())
	

func _physics_process(_delta):
	match animstate.get_current_node():
		"normal":
			velocity = Input.get_vector("n_left", "n_right", "n_up", "n_down")
			if Utils.android_mode: velocity = Player.get_node("Mobile").velocity
			if $LeapSprite.visible:
				velocity = velocity * Player.speed / 2
			else: velocity = velocity * Player.speed
			
			if velocity: 
				velocity_static = velocity.normalized()
				$AnimationTree.get("parameters/normal/playback").travel("walk")
			else: $AnimationTree.get("parameters/normal/playback").travel("sit")
			
			$LeapSprite.rotation = velocity_static.angle()
		"attack1":
			velocity = Vector2()
		"consume":
			velocity = Vector2()
	move_and_slide()

func _input(event):
	match animstate.get_current_node():
		"normal":
			if event.is_action_pressed("n_attack"):
				if !$InteractArea.get_overlapping_bodies().is_empty():
					$InteractArea.get_overlapping_bodies()[0].activated.emit()
			
			if Player.leap_charge:
				if event.is_action_pressed("n_leap"):
					leap_timer.start()
				if event.is_action_released("n_leap"):
					animstate.travel("leap")
					Player.leap_charge -= 1
					if leap_timer.is_stopped() && $LeapSprite.visible:
						$LeapSprite.visible = false
						$KnockArea/CollisionShape2D.disabled = false
						tween = create_tween()
						tween.tween_property(self, "global_position", global_position + velocity_static * 150, 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
						await tween.finished
						$KnockArea/CollisionShape2D.disabled = true
					else:
						create_tween().tween_property(self, "global_position", global_position + velocity_static * 150, 0.4).set_trans(Tween.TRANS_LINEAR)
						leap_timer.stop()

func attack():
	tween = create_tween()
	tween.tween_property(self, "global_position", global_position + velocity_static * 10, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	$SlashSprite.show()
	await get_tree().create_timer(0.05).timeout
	$AttackArea/CollisionShape2D.disabled = false
	await get_tree().create_timer(0.05).timeout
	$AttackArea/CollisionShape2D.disabled = true

func attack_spin():
	tween = create_tween()
	tween.tween_property(self, "global_position", global_position + velocity_static * 10, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	add_child(spin_slash.instantiate())

func die():
	queue_free()

func equipment():
	$Equipment.get_children().map(func(node): node.queue_free())
	for type in Player.equipped:
		var eq = load("res://assets/modules/"+type+str(Player.equipped[type])+".gd").new()
		$Equipment.add_child(eq)
