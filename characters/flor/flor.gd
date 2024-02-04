extends Character

onready var cat = get_tree().get_nodes_in_group("cat")[0]
onready var bullet = preload("res://assets/scenes/bullet.tscn")

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
	bullet_ins.init(self.global_position, (cat.global_position - self.global_position).normalized(), 1)
	get_parent().call_deferred("add_child", bullet_ins)
