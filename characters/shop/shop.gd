extends StaticBody2D

signal interacted
signal uninteracted

func _ready():
	interacted.connect(func(): $Tag.show())
	uninteracted.connect(func(): $Tag.hide())
