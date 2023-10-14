extends CanvasLayer

signal ability

onready var cat = owner

onready var joystick = $Margin/VBox/Bot/Joystick

var center: Vector2

func _ready():
    self.connect("ability", self, "ability")
    set_button()

func _input(event):
    joystick(event)

func joystick(event):
    if event is InputEventScreenDrag && joystick.pressed:
        center = (event.position - joystick.rect_global_position) - (joystick.rect_min_size / 2)
        center = center.normalized()
        
        cat.velocity = center
    
    if event is InputEventScreenTouch && !event.is_pressed():
        cat.velocity = Vector2()

func set_button():
    var abilities_button = $Margin/VBox/Bot/VBox/AbilitiesButtons
    var nodes = Utils.get_abilities_nodes()
    
    for child in abilities_button.get_children(): child.hide()
    
    for i in Utils.current_abilities.size():
        var ability_button = abilities_button.get_child(i)
        ability_button.show()
        (ability_button.get_node("M/Rect") as TextureRect).texture = load("res://assets/abilities/"+str(Utils.current_abilities[i])+".png")
        $"../Abilities".get_child(i).connect("ability", self, "ability", [i])
        ability_button.get_node("Touch").action = "n_ability" + str(i)

func ability(index):
    var button = $Margin/VBox/Bot/VBox/AbilitiesButtons.get_child(index)
    var ability = get_parent().get_node("Abilities").get_child(index)
    button.get_node("Prog").value = 10
    create_tween().tween_property(button.get_node("Prog"), "value", 0.0, ability.cooldown_timer.wait_time)
    
