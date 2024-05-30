extends Boss

func _ready():
	$AttackArea.connect("body_entered", self, "onAttack")

func onAttack(body):
	body.emit_signal("damaged", self.damage)

func die():
	.die()
	$StateMachine/Aggressive.timer.stop()
