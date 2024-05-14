extends Character

func heal():
	var parent: Boss = get_parent()
	if parent:
		parent.health += 1
		$CPUParticles2D.emitting = true
