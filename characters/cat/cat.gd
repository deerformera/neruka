extends CharacterBody2D

@export_category("Properties")
@export_range(0, 9999) var health = 1
@export_range(0, 9999) var damage = 1
@export_range(0, 9999) var speed = 1

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var leap_timer: Timer = Utils.create_timer(self, 0.8, func(): 
	charge = true
	$Line2D.visible = true)
@onready var slash = preload("res://assets/slash.tscn")

var velocity_static: Vector2
var charge = false

func _physics_process(delta):
	match animstate.get_current_node():
		"normal":
			velocity = Input.get_vector("n_left", "n_right", "n_up", "n_down")
			if Utils.android_mode: velocity = $Analog.velocity
			if charge: velocity = velocity * speed / 3
			else: velocity = velocity * speed
			
			if velocity: 
				velocity_static = velocity.normalized()
				$AnimationTree.get("parameters/normal/playback").travel("walk")
			else: $AnimationTree.get("parameters/normal/playback").travel("sit")
			
			$Line2D.set_point_position(1, (velocity_static * 200))
			$KnockArea/CollisionShape2D.disabled = true
		"leap":
			velocity = (velocity_static * speed) * 2
		"dash":
			velocity = (velocity_static * speed) * 2.5
			$KnockArea/CollisionShape2D.disabled = false
		"attack1":
			velocity = Vector2()
	move_and_slide()

func _input(event):
	match animstate.get_current_node():
		"normal":
			if event.is_action_pressed("n_attack"):
				animstate.travel("attack1")
			
			if event.is_action_pressed("n_leap"):
				leap_timer.start()
				
			if event.is_action_released("n_leap"):
				if charge:
					animstate.travel("dash")
					charge = false
					$Line2D.visible = false
				else:
					leap_timer.stop()
					animstate.travel("leap")
		
		"attack1":
			if event.is_action_pressed("n_attack"):
				animstate.travel("attack2")
		"attack2":
			if event.is_action_pressed("n_attack"):
				animstate.travel("attack1")

func damaged(value):
	animstate.travel("hurt")
	velocity = Vector2.ZERO
	self.health -= value
	if self.health <= 0: self.die()

func attack():
	var tw = create_tween()
	tw.tween_property(self, "global_position", global_position + velocity_static * 10, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(0.05).timeout
	$AttackArea/CollisionShape2D.disabled = false
	add_child(slash.instantiate())
	await get_tree().create_timer(0.05).timeout
	$AttackArea/CollisionShape2D.disabled = true

func die():
	queue_free()

func pick(obj):
	for inv in Utils.player["inventory"]:
		if inv[0] == obj:
			inv[1] += 1
			return
	
	Utils.player.inventory.append([obj, 1])
