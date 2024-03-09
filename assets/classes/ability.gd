extends Node2D
class_name Ability

signal cast
signal ability

onready var cat: Character = $"../.."

export var cooldown: float = 1.0
export var passive = false
export(float, 0.1, 50) var passive_duration

var duration_timer: Timer
var cooldown_timer: Timer = Timer.new()

func _ready():
	cat.connect("attack", self, "attack")
	self.connect("cast", self, "cast")
	
	if passive:
		duration_timer = Timer.new()
		duration_timer.wait_time = passive_duration
		duration_timer.one_shot = true
		duration_timer.connect("timeout", self, "passive_timeout")
		add_child(duration_timer)
	
	cooldown_timer.wait_time = cooldown
	cooldown_timer.one_shot = true
	add_child(cooldown_timer)

func cast():
	if cooldown_timer.is_stopped():
		if passive:
			duration_timer.start()
			passive()
		else:
			cooldown_timer.start()
			ability()
			emit_signal("ability")

func passive_timeout(): cooldown_timer.start()
func passive(): pass
func ability(): pass
func attack(): pass
