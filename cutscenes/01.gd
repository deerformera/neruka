extends Cutscene

func onTrigger(body):
	$Areas/Trigger/CollisionShape2D.set_deferred("disabled", true)
	
	look($Curos.global_position, cat.global_position)
	watch()
	
	yield(get_tree().create_timer(1), "timeout")
	
	$CurosRun.node = $Curos
	$Curos.animstate.travel("Walk")
	
	yield(get_tree().create_timer(1), "timeout")
	
	unwatch()
	unlook()

func onCurosKnock(body):
	if has_node("CurosRun"): $CurosRun.queue_free()
	
	$Curos.animstate.travel("Idle")
	
	create_tween().tween_property($Curos, "global_position", $KnockPoint.global_position, 0.5)
	watch()
	yield(get_tree().create_timer(1), "timeout")
	unwatch()
