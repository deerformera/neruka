extends KinematicBody2D

signal damaged
signal knocked
signal health_changed

export(int, 0, 99999) var health

onready var animstate: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
onready var orb = preload("res://assets/scenes/orb.tscn")
export var healthbar: PackedScene

var bullet = preload("res://assets/scenes/bullet.tscn")

func _damaged(val):
	if animstate.get_current_node() == "idle": 
		add_child(healthbar.instance())
		animstate.travel("reload")
	health -= 1
	if health <= 0:
		var orb_ins = orb.instance()
		orb_ins.id = 10
		orb_ins.global_position = self.global_position
		get_tree().root.get_node("World").add_child(orb_ins)
		queue_free()
	emit_signal("health_changed")

func shoot():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var dir = Vector2(rng.randf_range(-5, 5), rng.randf_range(-5, 5)) * 10
	
	$Tween.interpolate_property(self, "global_position", global_position, global_position + dir, 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	
	var bullet_ins = bullet.instance()
	bullet_ins.dir = (get_tree().get_nodes_in_group("cat")[0].global_position - self.global_position).normalized()
	bullet_ins.global_position = self.global_position
	bullet_ins.set_mask(2)
	get_parent().add_child(bullet_ins)

func shoot_round():
	yield(get_tree().create_tween().tween_property(self, "global_position", get_tree().get_nodes_in_group("cat")[0].global_position, 1), "finished")
	var dir = (get_tree().get_nodes_in_group("cat")[0].global_position - self.global_position).normalized()
	var bullets = []
	for x in range(4):
		bullets.append(bullet.instance())
	
	bullets[0].dir = dir
	bullets[1].dir = Vector2(-dir.x, -dir.y)
	bullets[2].dir = Vector2(-dir.y, dir.x)
	bullets[3].dir = Vector2(dir.y, -dir.x)
	
	for bullet_ins in bullets:
		bullet_ins.global_position = self.global_position
		get_parent().add_child(bullet_ins)

func _ready():
	self.connect("damaged", self, "_damaged")
