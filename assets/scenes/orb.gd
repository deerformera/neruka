extends Area2D

onready var cat = get_tree().get_nodes_in_group("cat")[0]

var active: bool = false

func _ready():
    self.connect("body_entered", self, "body_entered")
    
    randomize()
    var random = Vector2(rand_range(-50, 50), rand_range(-50, 50))
    var tween = create_tween()
    tween.tween_property(self, "global_position", global_position + random, 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    
    yield(tween, "finished")
    
    active = true

func _physics_process(delta):
    if active:
        self.global_position += (cat.global_position - self.global_position).normalized() * 8

func body_entered(body):
    Utils.add_orb()
    self.queue_free()
