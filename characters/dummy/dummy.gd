extends CharacterBody2D

@export_range(0, 9999) var health: int
@export_range(0, 9999) var damage: int

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

func damaged(value):
	animstate.travel("hurt")
	self.health -= value
	if self.health <= 0: self.die()

func knocked(value):
	animstate.travel("knock")
	create_tween().tween_property(self, "global_position", global_position + value * 25, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func die():
	print(self.name, " died")
	queue_free()
