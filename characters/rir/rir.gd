extends CharacterBody2D

@export_category("Properties")
@export_range(0, 9999) var health = 1
@export_range(0, 9999) var damage = 1
@export_range(0, 9999) var speed = 1

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var orbs := preload("res://assets/orb.tscn")

var phase: int = 0

func _physics_process(delta):
	print($AnimationTree.get("parameters/playback").get_current_node())

func damaged(value):
	animstate.travel("hurt")
	self.health -= value
	match health:
		15:
			$HornRSprite.hide()
		10:
			phase = 1
			$AnimationTree.phase_sync()
			$HornRSprite.show()
			$HornRSprite.frame = 1
			$HornLSprite.frame = 1
		5:
			$HornLSprite.hide()
		0:
			die()

func knocked(value):
	animstate.travel("knock")
	create_tween().tween_property(self, "global_position", global_position + value * 25, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
func die():
	print(self.name, " died")
	var orb = orbs.instantiate()
	orb.global_position = self.global_position
	orb.id = 5
	get_tree().root.get_node("World").add_child(orb)
	queue_free()
