extends StaticBody2D

signal damaged
signal knocked

@export_category("Properties")
@export_range(0, 9999) var health = 1
@export_range(0, 9999) var damage = 1
@export_range(0, 9999) var speed = 1

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")

func _ready():
	self.damaged.connect(func(value):
		animstate.travel("hurt"))
	
	self.knocked.connect(func(value: Vector2):
		animstate.travel("knock")
		create_tween().tween_property(self, "global_position", global_position + value * 25, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT))
