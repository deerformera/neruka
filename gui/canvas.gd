extends CanvasLayer

func unfade():
	$Tween.interpolate_property($ColorRect, "modulate:a", 1, 0, 0.5)
	$Tween.start()
	yield($Tween, "tween_completed")
	self.queue_free()
