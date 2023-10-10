extends AnimationTree

var velocity: Vector2

func _physics_process(_delta):
    velocity = get_parent().velocity_static
    self.set("parameters/normal/walk/blend_position", velocity)
    self.set("parameters/normal/sit/blend_position", velocity)
    self.set("parameters/dash/blend_position", velocity)
    self.set("parameters/attack1/blend_position", velocity)
    self.set("parameters/attack2/blend_position", velocity)
