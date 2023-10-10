extends Area2D

onready var detect_timer = Player.NTimer.new(self, 1, "_detect_timer_timeout")

func _detect_timer_timeout():
	if get_parent().animstate.get_current_node() == "": return
	get_parent().animstate.travel("")

func _body_entered(body): detect_timer.start()
func _body_exited(body): detect_timer.stop()

func _ready():
	self.connect("body_entered", self, "_body_entered")
	self.connect("body_exited", self, "_body_exited")

func detect():
	if self.get_overlapping_bodies().empty(): 
		get_parent().animstate.travel("normal")
