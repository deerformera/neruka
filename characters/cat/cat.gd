extends CharacterBody2D

@export_category("Properties")
@export_range(0, 9999) var health = 1
@export_range(0, 9999) var damage = 1
@export_range(0, 9999) var speed = 1

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var leap_timer: Timer = Utils.create_timer(self, 0.6, func(): $Line2D.visible = true)

var velocity_static: Vector2

func _physics_process(delta):
	match animstate.get_current_node():
		"normal":
			velocity = Input.get_vector("n_left", "n_right", "n_up", "n_down") * speed
			if velocity: 
				velocity_static = velocity
				$AnimationTree.get("parameters/normal/playback").travel("walk")
			else: $AnimationTree.get("parameters/normal/playback").travel("sit")
			$Line2D.set_point_position(1, velocity_static)
			$KnockArea/CollisionShape2D.disabled = true
		"leap":
			velocity = (velocity_static * 2)
		"dash":
			velocity = velocity_static * 2.5
			$KnockArea/CollisionShape2D.disabled = false
		"attack1":
			velocity = Vector2()
	move_and_slide()

func _input(event):
	match animstate.get_current_node():
		"normal":
			if event.is_action_pressed("n_attack"):
				animstate.travel("attack1")
				global_position += velocity_static.normalized() * 15
				$AttackArea/CollisionShape2D.disabled = false
				await get_tree().create_timer(0.02).timeout
				$AttackArea/CollisionShape2D.disabled = true
			
			if event.is_action_pressed("n_leap"):
				leap_timer.start()
			if event.is_action_released("n_leap"):
				if leap_timer.is_stopped():
					animstate.travel("dash")
					$Line2D.visible = false
				else:
					leap_timer.stop()
					animstate.travel("leap")
		
		"attack1":
			if event.is_action_pressed("n_attack"):
				animstate.travel("attack2")
				global_position += velocity_static.normalized() * 5
				$AttackArea/CollisionShape2D.disabled = false
				await get_tree().create_timer(0.02).timeout
				$AttackArea/CollisionShape2D.disabled = true
		"attack2":
			if event.is_action_pressed("n_attack"):
				animstate.travel("attack1")
				global_position += velocity_static.normalized() * 5
				$AttackArea/CollisionShape2D.disabled = false
				await get_tree().create_timer(0.02).timeout
				$AttackArea/CollisionShape2D.disabled = true

func damaged(value):
	animstate.travel("hurt")
	self.health -= value
	if self.health <= 0: self.queue_free()
