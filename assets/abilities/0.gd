extends Ability

var bullet = preload("res://assets/scenes/bullet.tscn")
export var color: Color

func ability():
	get_parent().cast(color)
	yield(get_tree().create_timer(0.3), "timeout")
	
	var bullet_ins = bullet.instance()
	bullet_ins.init(self.global_position, cat.velocity_static * 4, cat.damage)
	cat.get_parent().add_child(bullet_ins)
