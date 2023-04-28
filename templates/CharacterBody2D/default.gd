extends CharacterBody2D

@export_category("Properties")
@export_range(0, 9999) var health = 1
@export_range(0, 9999) var damage = 1
@export_range(0, 9999) var speed = 1

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	if animstate.get_current_node() == "":
		var cat: CharacterBody2D = get_tree().get_first_node_in_group("cat")
#		self.global_position -= (cat.global_position - self.global_position).normalized() * speed

func damaged(value):
	animstate.travel("hurt")
	self.health -= value
	if self.health <= 0: self.queue_free()

func knocked(value):
	animstate.travel("knock")
	self.global_position += value * 10

#func calm(): animstate.travel("normal")
