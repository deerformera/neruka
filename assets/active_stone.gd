extends StaticBody2D

signal activated

@onready var active_timer = Utils.create_timer(self, 0.2, func():
	active = false
	self.modulate = Color(0.25, 0.25, 0.25, 1))
var active = false

func _ready():
	self.activated.connect(func():
		active = true
		active_timer.start()
		$AudioStreamPlayer.play()
		self.modulate = Color(1,1,1,1))
