extends CharacterBody2D

var SPEED: int = 200
var velocity_static: Vector2 = Vector2.ZERO

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var timer_leap: Timer = Utils.create_timer(self, 0.25, func(): animstate.travel("walk"))
@onready var timer_dash_reg: Timer = Utils.create_timer(self, 0.4, dash_reg_timeout)
@onready var timer_dash: Timer = Utils.create_timer(self, 0.2, func():
	animstate.travel("walk")
	$DashCollision/CollisionShape2D.disabled = true)

@onready var timer_attack: Timer = Utils.create_timer(self, 0.15, func(): 
	animstate.travel("walk")
	$AttackCollision/CollisionShape2D.disabled = true)

func _ready():
	$AttackCollision.body_entered.connect(func(body): body.damaged(1))
	$DashCollision.body_entered.connect(func(body): 
		body.knocked(velocity_static)
		animstate.travel("walk"))
	
func _physics_process(delta):
	match animstate.get_current_node():
		"walk":
			velocity = Input.get_vector("n_left", "n_right", "n_up", "n_down")
			$Line2D.set_point_position(1, Vector2(lerpf($Line2D.get_point_position(1).x, 160, 0.4), 0))
			if velocity != Vector2():
				$AnimationTree.set("parameters/walk/blend_position", velocity)
				$AnimationTree.active = true
				velocity_static = velocity
			else:
				$AnimationTree.active = false
			velocity = velocity * SPEED
		"leap":
			velocity = velocity_static * 400
		"dash":
			velocity = velocity_static * 800
		"attack":
			velocity = Vector2.ZERO
	
	move_and_slide()
	
	$Line2D.rotation = velocity_static.angle()
	$AttackCollision.rotation = velocity_static.angle()
	$Camera2D.offset = lerp($Camera2D.offset, velocity_static * 20, 0.1)



func _input(event):
	if animstate.get_current_node() == "walk":
		if event.is_action_pressed("n_attack"):
			animstate.travel("attack")
			$AttackCollision/CollisionShape2D.disabled = false
			global_position += velocity_static * 10
			timer_attack.start()
		
		if event.is_action_pressed("n_leap"):
			timer_dash_reg.start()
		if event.is_action_released("n_leap"):
			if timer_dash_reg.is_stopped():
				print(animstate.get_current_node())
				animstate.travel("dash")
				$DashCollision/CollisionShape2D.disabled = false
				timer_dash.start()
				SPEED = 200
			else:
				animstate.travel("leap")
				velocity = Vector2.ZERO
				timer_leap.start()
			
			timer_dash_reg.stop()
			$Line2D.visible = false

func dash_reg_timeout():
	$Line2D.set_point_position(1, Vector2())
	$Line2D.visible = true
	SPEED = 50

