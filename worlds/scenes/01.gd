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
	unhook()
	
	var pincho = get_tree().get_nodes_in_group("pincho")[0]
	pincho.connect("died", self, "after_pincho")
	
	$Areas/before_pincho.queue_free()
	cat_look_start("idle_up")
	create_tween().tween_property($Rika, "global_position", $Points/PinchoDown/PathFollow2D.global_position, 0.5)
	yield(get_tree().create_timer(0.5), "timeout")
	cat_look_stop()
	

func after_pincho():
	$Areas/after_pincho_down/CollisionShape2D.set_deferred("disabled", false)
	$Areas/after_pincho_right/CollisionShape2D.set_deferred("disabled", false)

func after_pincho_down_entered(body):
	$Areas/after_pincho_down.queue_free()
	$Areas/after_pincho_right.queue_free()
	
	yield(Global.chat("Rika", ["Terima kasih telah membantuku", "Aku ingin menunjukkanmu sesuatu", "ikutlah denganku sebentar"]), "completed")
	hook($Rika, "PinchoDown")

func after_pincho_right_entered(body):
	$Areas/after_pincho_down.queue_free()
	$Areas/after_pincho_right.queue_free()
	
	$Rika.global_position = $Points/PinchoRight/PathFollow2D.global_position - Vector2(300, 0)
	create_tween().tween_property($Rika, "global_position", $Points/PinchoRight/PathFollow2D.global_position, 1)
	
	yield(Global.chat("Rika", ["Tunggu", "Aku ingin menunjukkanmu sesuatu", "ikutlah denganku sebentar"]), "completed")
	hook($Rika, "PinchoRight")
	
