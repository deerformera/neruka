extends CharacterBody2D

signal damaged
signal knocked
signal health_changed

@export_category("Properties")
@export_range(0, 9999) var damage = 1
@export_range(0, 9999) var health = 1 :
	set(value):
		health_changed.emit(value)
		health = value

@onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var bullet := preload("res://assets/projectiles/fiora_bullet.tscn")
@onready var orb := preload("res://assets/orb.tscn")

func _ready():
	add_child(load("res://assets/indicator_boss.tscn").instantiate())
	
	damaged.connect(func(value: int):
		self.health -= value
		if self.health <= 0: self.die())
	
	$AnimationTree.animation_started.connect(func(anim):print("anim: ",anim))

func die():
	var orb_ins = orb.instantiate()
	orb_ins.global_position = self.global_position
	orb_ins.id = 5
	get_tree().root.get_node("World").add_child(orb_ins)
	queue_free()

func move():
	create_tween().tween_property(self, "global_position", (get_tree().get_first_node_in_group("cat").global_position * 0.8), 1).set_trans(Tween.TRANS_LINEAR)

func shoot0():
	var bullet_ins = bullet.instantiate()
	bullet_ins.dir = (get_tree().get_first_node_in_group("cat").global_position - self.global_position).normalized()
	bullet_ins.global_position = self.global_position
	get_parent().add_child(bullet_ins)

func shoot1():
	var dir = (get_tree().get_first_node_in_group("cat").global_position - self.global_position).normalized()
	var bullets = []
	for x in range(4):
		bullets.append(bullet.instantiate())
	
	bullets[0].dir = dir
	bullets[1].dir = Vector2(-dir.x, -dir.y)
	bullets[2].dir = Vector2(-dir.y, dir.x)
	bullets[3].dir = Vector2(dir.y, -dir.x)
	
	for bullet_ins in bullets:
		bullet_ins.global_position = self.global_position
		get_parent().add_child(bullet_ins)
