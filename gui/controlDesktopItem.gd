extends Panel

var timer = null

func bind(node):
	$Cooldown.max_value = node.cooldownTime * 100
	timer = node.cooldownTimer

func _physics_process(delta):
	if timer:
		$Cooldown.value = timer.time_left * 100
