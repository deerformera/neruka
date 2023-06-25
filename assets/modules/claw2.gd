extends Node

@onready var attack_col = $"../../AttackArea/CollisionShape2D"

func _ready():
	attack_col.shape.size += Vector2(40, 40)
	attack_col.position.x = attack_col.shape.size.x / 2
	$"../../SlashSprite".scale *= 2

func _exit_tree():
	attack_col.shape.size -= Vector2(40, 40)
	attack_col.position.x = attack_col.shape.size.x / 2
	$"../../SlashSprite".scale /= 2
