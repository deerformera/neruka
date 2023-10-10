extends KinematicBody2D

signal damaged
signal knocked
signal health_changed

export(int, 0, 99999) var health_base = 1
export(int, 0, 99999) var damage = 1
export var bullet: PackedScene
export var orb: PackedScene

onready var health = health_base
onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

func _damaged(val):
	animstate.travel("hurt")
	self.health -= val
	emit_signal("health_changed")
	if self.health <= 0: self.die()

func _knocked(val):
	animstate.travel("knock")
	create_tween().tween_property(self, "global_position", global_position + val * 25, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _ready():
	self.connect("damaged", self, "_damaged")
	self.connect("knocked", self, "_knocked")

func shoot(): add_child(bullet.instance())

func die():
	print(self.name, " died")
	var orb_ins = orb.instance()
	orb_ins.global_position = self.global_position
	orb_ins.id = 1
	get_tree().root.get_node("World").add_child(orb_ins)
	queue_free()
