extends Character

var velocity: Vector2 = Vector2.DOWN
var velocity_static: Vector2 = Vector2.DOWN

onready var animtree = $AnimationTree

func _ready():
	var base = CatController.Level.getLevelValue()
	self.damage = base.damage
	self.health = base.health

func _physics_process(delta):
	animtree.set("parameters/Idle/blend_position", velocity_static)
	animtree.set("parameters/Walk/blend_position", velocity_static)
	animtree.set("parameters/Sit/blend_position", velocity_static)
	animtree.set("parameters/Attack1/blend_position", velocity_static)
	animtree.set("parameters/Attack2/blend_position", velocity_static)
	animtree.set("parameters/Cast/blend_position", velocity_static)

func damaged(val):
	get_node("StateMachine").travel("Hurt")
	.damaged(val)

func heal(val: int):
	var base = CatController.Level.getLevelValue()
	self.health += val
	if self.health > base.health: self.health = base.health

func hit():
	var vec = Vector2(randf(), randf()).normalized()
	$Camera2D.offset = vec * 5
	yield(get_tree().create_timer(0.05), "timeout")
	$Camera2D.offset = Vector2()

func shake():
	var vec = Vector2(randf(), randf()).normalized()
	$Camera2D.offset = vec
	yield(get_tree().create_timer(0.05), "timeout")
	$Camera2D.offset = Vector2()

func onDie(): pass
