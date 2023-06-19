extends StaticBody2D

signal interacted
signal uninteracted
signal activated

func _ready():
	interacted.connect(func(): $Tag.show())
	uninteracted.connect(func(): $Tag.hide())
	activated.connect(func(): pass)
