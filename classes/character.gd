extends KinematicBody2D
class_name Character

export var health: int = 1
export var damage: int = 1

onready var animstate: AnimationNodeStateMachinePlayback = get_node("AnimationTree").get("parameters/playback")

signal damaged(val)

func _init(): self.connect("damaged", self, "damaged")

func damaged(val):
	self.health -= val
	if self.health <= 0:
		die()

func die():
	self.queue_free()
