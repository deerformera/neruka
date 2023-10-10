extends Area2D

var interacting := false

func _ready():
    self.connect("body_entered", self, "entered")
    self.connect("body_exited", self, "exited")

func entered(body: Node):
    body.emit_signal("interacted")
    interacting = true

func exited(body: Node):
    body.emit_signal("uninteracted")
    interacting = false

func activate():
    if Input.is_action_pressed("n_attack") && interacting:
        get_overlapping_bodies()[0].emit_signal("activated")

func _physics_process(delta):
    self.rotation = get_parent().velocity_static.angle()
