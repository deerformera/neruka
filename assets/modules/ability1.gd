extends Node

func _ready():
	$"../../Camera2D".zoom -= Vector2(0.5, 0.5)

func _exit_tree():
	$"../../Camera2D".zoom += Vector2(0.5, 0.5)
