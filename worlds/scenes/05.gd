extends Cutscene

var dark = false

func _ready():
	get_tree().root.get_node("World/Maps/Tundra").queue_free()
	$TileMap.show()
	$TileMap.collision_mask = 2
	get_tree().root.get_node("World/Checkpoints/Hub").hide()
	get_tree().root.get_node("World/Checkpoints/Hub").collision_mask = 0

func darken_entered(body):
	$Areas/darken.queue_free()
	create_tween().tween_property($CanvasModulate, "color", Color("808080"), 2)
	create_tween().tween_property($CanvasLayer/TextureRect, "modulate:a", 1.0, 2)
	yield(get_tree().create_timer(1), "timeout")
	create_tween().tween_property($CatLight, "color:a", 1.0, 2)
	dark = true

func _physics_process(delta):
	if dark: $CatLight.global_position = cat.global_position

func exit():
	cat.global_position = Vector2(5664, -3096)
	get_tree().root.get_node("World/Checkpoints/Hub").show()
	get_tree().root.get_node("World/Checkpoints/Hub").collision_mask = 2
	get_tree().root.get_node("World").refresh()
	yield(get_tree().create_timer(1), "timeout")
	get_parent().add_child(preload("res://worlds/scenes/06.tscn").instance())
	Interface.fade_out()
	self.queue_free()
