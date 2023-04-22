extends Node

func create_timer(from, waittime: float, method: Callable):
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = waittime
	timer.timeout.connect(method)
	from.add_child(timer)
	return timer
