extends StaticBody2D
class_name Wall

func _ready():
	self.connect("visibility_changed", self, "onVisibility")
	self.hide()

func onVisibility():
	$CollisionShape2D.set_deferred("disabled", !self.visible)
