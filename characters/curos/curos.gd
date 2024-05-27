extends StaticBody2D

var velocity: Vector2

export var interactable = false

onready var animstate = $AnimationTree.get("parameters/playback")

signal interacted

func _ready():
	self.connect("interacted", self, "onInteracted")

func _physics_process(delta):
	$AnimationTree.set("parameters/Idle/blend_position", velocity)
	$AnimationTree.set("parameters/Walk/blend_position", velocity)
	
func onInteracted():
	if !interactable: return
	
	Tab.open("forge")
