extends KinematicBody2D
class_name Character

export var id: int = 0
export var health: int = 1
export var damage: int = 1

onready var animstate: AnimationNodeStateMachinePlayback = get_node("AnimationTree").get("parameters/playback")
var orb = preload("res://assets/scenes/orb.tscn")

signal damaged(damage)

func _init():
	self.connect("damaged", self, "damaged")

func damaged(damage: int):
	self.health -= damage
	if self.health <= 0:
		die()

func die():
	Utils.identify(id)
	get_parent().call_deferred("add_child", create_orb())
	queue_free()

func create_orb():
	var orb_ins = orb.instance()
	orb_ins.global_position = self.global_position
	return orb_ins

func create_timer(time, oneshot = true) -> Timer:
	var timer = Timer.new()
	timer.wait_time = time
	timer.one_shot = oneshot
	return timer

func create_rng() -> RandomNumberGenerator:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng
