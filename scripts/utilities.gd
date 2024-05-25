extends Node

func get_cat() -> Character:
	var nodes: Array = get_tree().get_nodes_in_group("cat")
	if nodes: return nodes[0]
	return null

func create_rng() -> RandomNumberGenerator:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng

func create_timer(wait_time: float) -> Timer:
	var timer = Timer.new()
	timer.wait_time = wait_time
	timer.autostart = false
	timer.one_shot = true
	return timer
