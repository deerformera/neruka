extends CanvasLayer

onready var cat = owner

# Joystick
onready var joystick = $Margin/VBox/Bot/Joystick

var center: Vector2

func _ready():
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
    for child in abilities_button.get_children(): child.hide()
    
    for i in Utils.get_abilities().size():
        var ability_button = abilities_button.get_child(i)
        ability_button.show()
        ability_button.get_node("Touch").action = "n_ability" + str(i)
