extends Node2D

func _ready():
	
	$Area2D.monitoring = false
	
	$Area2D/CollisionShape2D.disabled = true
