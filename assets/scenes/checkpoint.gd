extends Area2D

onready var cat = Utils.get_cat()
export var grow = false

func body_entered(body):
	if grow:
		$AnimationPlayer.play("close")
		
		cat.get_node("AnimationTree").active = false
		create_tween().tween_property(cat, "global_position", self.global_position, 0.1)
		
		yield(get_tree().create_timer(0.4), "timeout")
		Utils.tab_open("levelup")
		Utils.connect("tab_closed", self, "tab_closed")
	
	else:
		$AnimationPlayer.play("grow")

func tab_closed():
	Utils.disconnect("tab_closed", self, "tab_closed")
	$AnimationPlayer.play_backwards("close")
	yield(get_tree().create_timer(0.4), "timeout")
	cat.get_node("AnimationTree").active = true
