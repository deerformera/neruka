extends Character

onready var cat = get_cat()
onready var bullet = preload("res://characters/flor/flor-bullet.tscn")

func _ready():
	$AttackArea.connect("body_entered", self, "body_entered")
	$AttackArea.connect("body_exited", self, "body_exited")

func body_entered(body):
	if body.is_in_group("cat"): 
		animstate.travel("chase")

func body_exited(body):
	animstate.travel("normal")

func shoot():
	var bullet_ins = bullet.instance()
	bullet_ins.dir = (cat.global_position - self.global_position).normalized()
	add_child(bullet_ins)
