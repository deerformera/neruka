extends Node
class_name Ability

signal cast
signal activated

export var cooldownTime: int = 1
onready var cooldownTimer = Utils.create_timer(cooldownTime)
onready var cat = Utils.get_cat()

func _ready():
	self.connect("cast", self, "onCast")
	add_child(cooldownTimer)

func onCast():
	if !cooldownTimer.is_stopped(): return
	
	cooldownTimer.start()
	self.activate()
	self.emit_signal("activated")

func activate(): pass
