extends Character

onready var bullet = preload("res://characters/pincho/pincho-bullet.tscn")
onready var minion = preload("res://characters/pincho/pincho-minion.tscn")
onready var cat = get_cat()

signal health_changed

func _ready():
	$Area2D.connect("body_entered", self, "body_entered")

func shoot():
	if cat == null: 
		animstate.travel("idle")
		return
	var bullet_ins = bullet.instance()
	bullet_ins.dir = (cat.global_position - self.global_position).normalized()
	add_child(bullet_ins)

func damaged(damage: int):
	.damaged(damage)
	var rng = create_rng()
	var location = Vector2(rng.randf_range(-200, 200), rng.randf_range(-200, 200))
	if location.x < 32 && location.x > -32: location.x += 32
	if location.y < 32 && location.y > -32: location.y += 32
	
	var minion_ins: Node2D = minion.instance()
	minion_ins.position = location
	call_deferred("add_child", minion_ins)
	
	emit_signal("health_changed")

func heal(value):
	self.health += value
	emit_signal("health_changed")

func body_entered(body: Character):
	animstate.travel("initial")
	$Area2D.queue_free()
	$Healthbar.show()
