extends Sprite

func move(velocity): 
	$AnimationTree.set("parameters/move/blend_position", velocity)
	var tween = create_tween()
	tween.tween_property(self, "position", velocity * 300, 1)
	yield(tween, "finished")
	self.queue_free()
