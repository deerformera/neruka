extends Node2D
class_name Ability

onready var cat := owner

export var cooldown: float = 1.0
export var passive = false

var cooldownTimer: Timer = Timer.new()

func _ready():
    cat.connect("cast", self, "cast")
    if passive: cat.connect("attack", self, "attack")
    
    cooldownTimer.wait_time = cooldown
    cooldownTimer.one_shot = true
    add_child(cooldownTimer)

func cast(): 
    if cooldownTimer.is_stopped():
        cooldownTimer.start()
        ability()

func ability(): pass

func attack(): pass
