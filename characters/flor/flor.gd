extends CharacterBody2D

@export_category("Properties")
@export_range(0, 9999) var health = 1
@export_range(0, 9999) var damage = 1
@export_range(0, 9999) var speed = 1

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var bullets := preload("res://assets/projectiles/flor_bullet.tscn")
@onready var orbs := preload("res://assets/orb.tscn")

func shoot():
	add_child(bullets.instantiate())

func damaged(value):
	animstate.travel("hurt")
	self.health -= value
	if self.health <= 0: self.die()

func knocked(value):
	animstate.travel("knock")
	create_tween().tween_property(self, "global_position", global_position + value * 25, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func die():
	var orb = orbs.instantiate()
	orb.global_position = self.global_position
	get_tree().root.get_node("World").add_child(orb)
	queue_free()
