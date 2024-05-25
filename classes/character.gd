extends KinematicBody2D
class_name Character

export var health: int = 1
export var damage: int = 1

onready var animstate: AnimationNodeStateMachinePlayback = get_node("AnimationTree").get("parameters/playback")

signal damaged(val)
signal die

func _init(): self.connect("damaged", self, "damaged")

func damaged(val):
	self.health -= val
	if self.health <= 0:
		die()

func die():
	get_node("AnimationTree").set_deferred("active", false)
	get_node("CollisionShape2D").set_deferred("disabled", true)
	emit_signal("die")

	var timer = Utils.create_timer(1)
	add_child(timer)
	timer.connect("timeout", self, "onDie")
	timer.start()

func onDie():
	var particle = preload("res://misc/scenes/deathParticle.tscn").instance()
	particle.global_position = self.global_position
	get_tree().root.add_child(particle)
	self.queue_free()
