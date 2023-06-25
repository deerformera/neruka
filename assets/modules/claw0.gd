extends Node

@onready var animstate = $"../..".animstate

func _input(event):
	match animstate.get_current_node():
		"normal":
			if event.is_action_pressed("n_attack"):
				if $"../../InteractArea".get_overlapping_bodies().is_empty():
					animstate.travel("attack1")
		"attack1":
			if event.is_action_pressed("n_attack"):
				animstate.travel("attack2")
		"attack2":
			if event.is_action_pressed("n_attack"):
				animstate.travel("attack1")
