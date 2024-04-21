extends Node

func get_cat() -> Character:
	var nodes: Array = get_tree().get_nodes_in_group("cat")
	if nodes: return nodes[0]
	return null

func create_rng() -> RandomNumberGenerator:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng

