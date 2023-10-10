extends KinematicBody2D

signal damaged
signal knocked

export(int, 0, 99999) var health_base = 1
export(int, 0, 99999) var damage = 1
export(int, 0, 99999) var speed = 1

onready var health = health_base
onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

func _damaged(val):
	animstate.travel("hurt")
	self.health -= val
	if self.health <= 0: self.die()

func _knocked(val):
	animstate.travel("knock")
	create_tween().tween_property(self, "global_position", global_position + val * 25, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _ready():
	self.connect("damaged", self, "_damaged")
	self.connect("knocked", self, "_knocked")

func _physics_process(_delta):
	if animstate.get_current_node() == "":
		var cat = get_tree().get_nodes_in_group("cat")[0]
#		self.global_position -= (cat.global_position - self.global_position).normalized() * speed

func die():
	print(self.name, " died")
	queue_free()

#func calm(): animstate.travel("normal")
