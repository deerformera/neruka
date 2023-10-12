extends Area2D

var dir = Vector2()
var damage: int

func _ready():
    self.connect("body_entered", self, "body_entered")

func init(start: Vector2, dir: Vector2, mask: int, damage: int = 1):
    self.collision_mask = pow(2, mask - 1)
    self.global_position = start
    self.dir = dir
    self.damage = damage

func body_entered(body):
    body.emit_signal("damaged", damage)
    set_deferred("monitoring", false)

func _physics_process(_delta):
    position += dir * 2
    if position.length() >= 1000:
        self.queue_free()
