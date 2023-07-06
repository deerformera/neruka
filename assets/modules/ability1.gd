extends Node

var slash_projectile = preload("res://assets/slash_projectile.tscn")
@onready var cooldown = Utils.create_timer(self, 0.5, func(): pass)

func _ready():
	Player.get_node("HUD").set_ability_timer(cooldown)

func _input(event):
	if event.is_action_pressed("n_ability") && cooldown.is_stopped():
		cooldown.start()
		$"../..".add_child(slash_projectile.instantiate())
