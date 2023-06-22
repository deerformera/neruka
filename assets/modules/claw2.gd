extends Node

func _ready():
	$"../../AttackArea/CollisionShape2D".shape.size *= 2
	$"../../AttackArea/CollisionShape2D".position.x *= 2
	$"../../SlashSprite".scale *= 2

func _exit_tree():
	$"../../AttackArea/CollisionShape2D".shape.size /= 2
	$"../../AttackArea/CollisionShape2D".position.x /= 2
	$"../../SlashSprite".scale /= 2
