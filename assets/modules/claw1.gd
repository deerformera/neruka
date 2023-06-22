extends Node

func _ready():
	$"../..".damage += 10

func _exit_tree():
	$"../..".damage -= 10
