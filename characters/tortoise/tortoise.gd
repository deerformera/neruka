extends Character

onready var cat = get_cat()
var velocity: Vector2

func _ready():
	$AttackArea.connect("body_entered", self, "attack")

func attack(body: Character):
	body.emit_signal("damaged", 5)

func damaged(val):
	if animstate.get_current_node() == "idle": animstate.travel("attack")
	.damaged(val)

func _physics_process(delta):
	$AnimationTree.set("parameters/idle/blend_position", velocity)
	if animstate.get_current_node() == "chase":
		velocity = (cat.global_position - self.global_position).normalized()
		$AnimationTree.set("parameters/attack/blend_position", velocity)
		$AnimationTree.set("parameters/chase/blend_position", velocity)
		self.global_position += velocity
		if (cat.global_position - self.global_position).length() < 50:
			animstate.travel("attack")
