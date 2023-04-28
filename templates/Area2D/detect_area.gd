extends Area2D

@onready var detect_timer: Timer = Utils.create_timer(self, 1, func(): 
	if get_parent().animstate.get_current_node() == "": return
	get_parent().animstate.travel(""))

func _ready():
	self.body_entered.connect(func(body): detect_timer.start())
	self.body_exited.connect(func(body): detect_timer.stop())

func detect():
	if self.get_overlapping_bodies().is_empty(): 
		get_parent().animstate.travel("normal")
