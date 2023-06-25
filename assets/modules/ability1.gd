extends Node

var tween: Tween

func _input(event):
	if event.is_action_pressed("n_ability"):
		if tween:
			return
		tween = create_tween()
		tween.tween_property($"../../Camera2D", "zoom", Vector2(1.5, 1.5), 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
		await get_tree().create_timer(3).timeout
		tween.kill()
		tween = create_tween()
		tween.tween_property($"../../Camera2D", "zoom", Vector2(2.0, 2.0), 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		tween = null
