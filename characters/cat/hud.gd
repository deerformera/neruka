extends CanvasLayer

signal ability

onready var cat = owner
onready var joystick = $Margin/VBox/Bot/Joystick

var inventory = preload("res://characters/cat/tabs/inventory.tscn")
var item = preload("res://characters/cat/ability_button.tscn")

var center: Vector2

func _ready():
    Utils.connect("abilities_changed", self, "set_button")
    $Margin/VBox/Top/Inventory.connect("pressed", self, "inventory")
    
    set_button()
    
    var health = Utils.get_base().health
    $Margin/VBox/Top/ProgressBar.max_value = health
    $Margin/VBox/Top/ProgressBar.value = health
    
    cat.connect("health_changed", self, "set_health")

func _input(event):
    joystick(event)

func inventory():
    get_parent().add_child(inventory.instance())

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
    
    for i in Utils.current_abilities.size():
        var ability_button = abilities_button.get_child(i)
        
        ability_button.show()
        ability_button.get_node("M/Rect").texture = load("res://assets/abilities/" + str(Utils.current_abilities[i]) + ".png")
        ability_button.get_node("Touch").action = "n_ability" + str(i)
        $"../Abilities".get_child(i).connect("ability", self, "ability", [i, $"../Abilities".get_child(i).cooldown])

func ability(index, time):
    var button = $Margin/VBox/Bot/VBox/AbilitiesButtons.get_child(index)
    button.get_node("Prog").value = 10
    create_tween().tween_property(button.get_node("Prog"), "value", 0.0, time)

func set_health():
    $Margin/VBox/Top/ProgressBar.value = get_parent().health
