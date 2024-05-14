extends Boss

var minion = preload("res://characters/pincho/pinchoMinion.tscn")

func damaged(val):
	.damaged(val)
	
#	yield(get_tree().create_timer(0.1), "timeout")
#
#	var minion_ins = minion.instance()
#	call_deferred("add_child", minion_ins)
