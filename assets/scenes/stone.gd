extends StaticBody2D

signal damaged

signal activated
signal deactivated

var active = false
var time = 2

func _ready():
	$Timer.wait_time = time
	
	self.connect("damaged", self, "damaged")
	$Timer.connect("timeout", self, "timeout")

func damaged(_val):
	$AnimationPlayer.play("activated")
	$Timer.start()
	if !active: emit_signal("activated")
	active = true

func timeout():
	active = false
	$AnimationPlayer.play("deactivated")
	emit_signal("deactivated")

func disable():
	self.disconnect("damaged", self, "damaged")
	$Timer.disconnect("timeout", self, "timeout")
	$AnimationPlayer.play("disabled")
