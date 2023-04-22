extends CharacterBody2D

@onready var timer = Utils.create_timer(self, 0.2, func(): $Sprite2D.modulate = Color(1,1,1))

func damaged():
	$Sprite2D.modulate = Color(1,0,0)
	timer.start()

func knocked(vec):
	self.global_position += vec * 10
	$Sprite2D.modulate = Color(1, 1, 0)
	timer.start()
