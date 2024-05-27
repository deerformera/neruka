extends Area2D

var grew = false

func _ready():
	self.connect("body_entered", self, "onEnter")
	self.connect("body_exited", self, "onExit")

func onEnter(body):
	if grew: 
		$AnimationPlayer.play("close")
		Utils.get_cat().get_node("StateMachine").travel("Idle")
		Utils.get_cat().global_position = self.global_position
	else: 
		$AnimationPlayer.play("grow")
		grew = true

func onExit(body):
	$AnimationPlayer.play_backwards("close")
