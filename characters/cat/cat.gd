extends CharacterBody2D

signal damaged
signal pick

@export_category("Properties")
@export_range(0, 9999) var health = 1
@export_range(0, 9999) var damage = 1
@export_range(0, 9999) var speed = 1

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var tween: Tween
@onready var leap_timer: Timer = Utils.create_timer(self, 0.8, func(): 
	$LeapSprite.scale = Vector2(0, 1)
	$LeapSprite.visible = true
	create_tween().tween_property($LeapSprite, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT))
@onready var slash = preload("res://assets/slash.tscn")

var velocity_static: Vector2
var charge = false

func _ready():
	self.damaged.connect(func(value: int):
		animstate.travel("hurt")
		velocity = Vector2.ZERO
		self.health -= value
		if self.health <= 0: self.die())
	
	var t = Utils.create_timer(self, 1, func(): print(Player.perks_equipped))
#	var t = Utils.create_timer(self, 1, func(): print("health: ",health, " - ", "speed: ", speed))
	t.one_shot = false
#	t.start()

func _physics_process(_delta):
	match animstate.get_current_node():
		"normal":
			velocity = Input.get_vector("n_left", "n_right", "n_up", "n_down")
			if Utils.android_mode: velocity = $Analog.velocity
			if $LeapSprite.visible:
				velocity = velocity * speed / 2
			else: velocity = velocity * speed
			
			if velocity: 
				velocity_static = velocity.normalized()
				$AnimationTree.get("parameters/normal/playback").travel("walk")
			else: $AnimationTree.get("parameters/normal/playback").travel("sit")
			
			$LeapSprite.rotation = velocity_static.angle()
		"attack1":
			velocity = Vector2()
	move_and_slide()

func _input(event):
	match animstate.get_current_node():
		"normal":
			if event.is_action_pressed("n_attack"):
				if $InteractArea.get_overlapping_bodies().is_empty():
					animstate.travel("attack1")
				else:
					$InteractArea.get_overlapping_bodies()[0].activated.emit()
			
			if event.is_action_pressed("n_leap"):
				leap_timer.start()
			if event.is_action_released("n_leap"):
				animstate.travel("leap")
				if leap_timer.is_stopped() && $LeapSprite.visible:
					$LeapSprite.visible = false
					$KnockArea/CollisionShape2D.disabled = false
					tween = create_tween()
					tween.tween_property(self, "global_position", global_position + velocity_static * 150, 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
					await tween.finished
					$KnockArea/CollisionShape2D.disabled = true
				else:
					create_tween().tween_property(self, "global_position", global_position + velocity_static * 100, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
					leap_timer.stop()
		
		"attack1":
			if event.is_action_pressed("n_attack"):
				animstate.travel("attack2")
		"attack2":
			if event.is_action_pressed("n_attack"):
				animstate.travel("attack1")


func attack():
	tween = create_tween()
	tween.tween_property(self, "global_position", global_position + velocity_static * 10, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(0.05).timeout
	$AttackArea/CollisionShape2D.disabled = false
	add_child(slash.instantiate())
	await get_tree().create_timer(0.05).timeout
	$AttackArea/CollisionShape2D.disabled = true

func die():
	queue_free()
