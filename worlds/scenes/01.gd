extends Cutscene

func _ready():
	$Rika.global_position = $Points/Trigger/PathFollow2D.global_position

func trigger_entered(body):
	$Areas/trigger.queue_free()
	yield(cat_look_start("idle_right", get_between($Rika.global_position)), "completed")
	hook($Rika, "Trigger")
	yield(get_tree().create_timer(0.5), "timeout")
	cat_look_stop()

func before_pincho_entered(body):
	$Areas/before_pincho.queue_free()
	
	var pincho = get_tree().get_nodes_in_group("pincho")[0]
	
	unhook()
	cat_look_start("idle_up")
	create_tween().tween_property($Rika, "global_position", $Points/PinchoDown/PathFollow2D.global_position, 0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	yield(cat_look_start("idle_up", pincho.global_position), "completed")
	yield(get_tree().create_timer(0.5), "timeout")
	yield(cat_look_stop(), "completed")
	get_parent().add_child(load("res://worlds/scenes/02.tscn").instance())
	self.queue_free()
