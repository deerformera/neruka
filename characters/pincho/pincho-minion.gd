extends Character

func die(): queue_free()

func heal():
	get_parent().heal(1)
