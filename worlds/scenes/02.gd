extends Cutscene

func _ready():
	$Rika.global_position = $Points/PinchoDown/PathFollow2D.global_position
	$Rika.velocity = Vector2.UP
	
	var pincho = get_tree().get_nodes_in_group("pincho")[0]
	pincho.connect("died", self, "after_pincho")

func after_pincho():
	$Areas/after_pincho_down/CollisionShape2D.set_deferred("disabled", false)
	$Areas/after_pincho_right/CollisionShape2D.set_deferred("disabled", false)

func after_pincho_down_entered(body):
	$Areas/after_pincho_down.queue_free()
	$Areas/after_pincho_right.queue_free()
	
	yield(cat_look_start("idle_down", $Rika.global_position), "completed")
	yield(Interface.chat("Rika", [
		"Terima kasih telah membantuku", 
		"Ku melihat kau tadi bereaksi setelah membunuh tanaman jahat itu",
		"Apakah kau seorang Sentinel?!",
		"ikutlah denganku sebentar"
	]), "completed")
	
	cat_look_stop()
	
	hook($Rika, "PinchoDown")
	
	yield(self, "unhook")
	self.queue_free()
	var next_scene = preload("res://worlds/scenes/03.tscn")
	get_parent().add_child(next_scene.instance())

func after_pincho_right_entered(body):
	$Areas/after_pincho_down.queue_free()
	$Areas/after_pincho_right.queue_free()
	
	
	$Rika.global_position = $Points/PinchoRight/PathFollow2D.global_position - Vector2(300, 0)
	$Rika.velocity = Vector2.RIGHT
	
	var tw = create_tween()
	tw.tween_property($Rika, "global_position", $Points/PinchoRight/PathFollow2D.global_position, 1)
	yield(tw, "finished")
	
	yield(cat_look_start("idle_left", get_between($Rika.global_position)), "completed")
	
	yield(Interface.chat("Rika", [
		"Tunggu!", 
		"Ku melihat kau tadi bereaksi setelah membunuh tanaman jahat itu",
		"Apakah kau seorang Sentinel?!",
		"ikutlah denganku sebentar"
	]), "completed")
	hook($Rika, "PinchoRight")
	cat_look_stop()
	
	yield(self, "unhook")
	self.queue_free()
	
	var next_scene = preload("res://worlds/scenes/03.tscn")
	get_parent().add_child(next_scene.instance())
