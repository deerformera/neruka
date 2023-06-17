extends StaticBody2D

signal damaged
signal knocked

@export_category("Properties")
@export_range(0, 9999) var health = 1
@export_range(0, 9999) var damage = 1
@export_range(0, 9999) var speed = 1

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

func _ready():
	damaged.connect(func(value: int):
		animstate.travel("hurt")
		self.health -= value
		if self.health <= 0: self.die())
	
	knocked.connect(func(value: Vector2):
		animstate.travel("knock")
		create_tween().tween_property(self, "global_position", global_position + value * 25, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT))

func _physics_process(_delta):
	if animstate.get_current_node() == "chase":
		var cat: CharacterBody2D = get_tree().get_first_node_in_group("cat")
		self.global_position += (cat.global_position - self.global_position).normalized() * speed

func die():
	print(self.name, " died")
	queue_free()
