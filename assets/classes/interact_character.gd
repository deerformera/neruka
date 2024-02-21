extends KinematicBody2D
class_name InteractCharacter

signal interacted
signal uninteracted
signal activated

onready var tag = preload("res://assets/textures/tag.png")

func _init():
	var sprite = Sprite.new()
	sprite.texture = tag
	sprite.name = "Tag"
	add_child(sprite)

func interacted():
	$Tag.show()

func uninteracted():
	$Tag.hide()

func activated():
	pass
