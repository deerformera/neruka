extends CanvasLayer

var android_mode = 0

var dummies := {
	"dummy": preload("res://characters/dummy/dummy.tscn"),
	"dummy_active": preload("res://characters/dummy/dummy_active.tscn"),
	"dummy_passive": preload("res://characters/dummy/dummy_passive.tscn"),
	"dummy_semipassive": preload("res://characters/dummy/dummy_semiPassive.tscn")
}

@onready var debug_list = [
	{
		"name": "Summon active creature",
		"fn": func(): print("summon!")
	},
	{
		"name": "Summon passive creature",
		"fn": func(): get_tree().root.get_node("World").add_child(dummies.dummy.instantiate())
	},
	{
		"name": "add orb",
		"fn": func(): get_tree().get_first_node_in_group("cat").add_child(load("res://assets/orb.tscn").instantiate())
	}
]

var player = {
	"inventory": [
		[0,0],
		[0,0],
		[0,0],
		[0,0]
	]
}

func _ready():
	for debug_item in debug_list:
		var b: Button = Button.new()
		b.text = debug_item.name
		b.pressed.connect(debug_item.fn)
		$Margin/HBox/VBox.add_child(b)

func _physics_process(delta):
	$Margin/HBox/VBox.visible = $Margin/HBox/Button.button_pressed

func create_timer(from, waittime: float, method: Callable):
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = waittime
	timer.timeout.connect(method)
	from.add_child(timer)
	return timer
