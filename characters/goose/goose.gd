extends Enemy

func setBlendPos(velocity: Vector2):
	get_node("AnimationTree").set("parameters/Aggressive/blend_position", velocity.normalized())
	get_node("AnimationTree").set("parameters/Attack1/blend_position", velocity.normalized())
	get_node("AnimationTree").set("parameters/Attack2/blend_position", velocity.normalized())

func _ready():
	$AttackArea.connect("body_entered", self, "onHit")

func onHit(body: Character):
	body.emit_signal("damaged", self.damage)
	
