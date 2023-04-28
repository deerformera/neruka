extends CharacterBody2D

@export_range(0, 9999) var health: int
@export_range(0, 9999) var damage: int

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

func damaged(value):
	animstate.travel("hurt")
	self.health -= value
	if self.health <= 0: self.queue_free()

func knocked(value):
	animstate.travel("knock")
	self.global_position += value * 10
