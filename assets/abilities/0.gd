extends Ability

var bullet = preload("res://assets/scenes/bullet.tscn")

func ability():
    var bullet_ins = bullet.instance()
    bullet_ins.init(self.global_position, cat.velocity_static * 4, 3, cat.damage)
    cat.get_parent().add_child(bullet_ins)
