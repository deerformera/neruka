extends Node2D

func refresh():
	for i in $Maps.get_children(): i.queue_free()
	
	var maps = {
		"grora": preload("res://worlds/maps/grora.tscn").instance(),
		"savanna": preload("res://worlds/maps/savanna.tscn").instance(),
		"tundra": preload("res://worlds/maps/tundra.tscn").instance()
	}
	
	maps.grora.global_position = Vector2()
	maps.savanna.global_position = Vector2(4096, 0)
	maps.tundra.global_position = Vector2(4096, -4096)
	
	for i in maps:
		$Maps.call_deferred("add_child", maps[i])
