extends CanvasLayer

var android_mode = 0

var dummies := {
	"dummy_active": preload("res://characters/dummy/dummy_active.tscn"),
	"dummy_passive": preload("res://characters/dummy/dummy_passive.tscn"),
	"dummy_semipassive": preload("res://characters/dummy/dummy_semiPassive.tscn")
}

var debug_summon_creature = func(dummy):
	var dummy_ins = dummy.instantiate()
	dummy_ins.global_position = get_tree().get_first_node_in_group("cat").global_position
	get_tree().root.get_node("World").add_child(dummy_ins)

var debug_add_orb = func():
	var orb = load("res://assets/orb.tscn").instantiate()
	orb.id = 1
	get_tree().get_first_node_in_group("cat").add_child(orb)

@onready var debug_list = [
	{
		"name": "Summon active creature",
		"fn": debug_summon_creature.bind(dummies.dummy_active)
	},
	{
		"name": "Summon passive creature",
		"fn": debug_summon_creature.bind(dummies.dummy_passive)
	},
	{
		"name": "Summon semi-passive creature",
		"fn": debug_summon_creature.bind(dummies.dummy_semipassive)
	},
	{
		"name": "add orb",
		"fn": debug_add_orb
	}
]

func _ready():
	$Margin/HBox/Button.toggled.connect(func(button_pressed): $Margin/HBox/VBox.visible = button_pressed)
	for debug_item in debug_list:
		var b: Button = Button.new()
		b.text = debug_item.name
		b.pressed.connect(debug_item.fn)
		b.focus_mode = Control.FOCUS_NONE
		$Margin/HBox/VBox.add_child(b)

func create_timer(from, waittime: float, method: Callable, one_shot: bool = true, autostart: bool = false):
	var timer = Timer.new()
	timer.autostart = autostart
	timer.one_shot = one_shot
	timer.wait_time = waittime
	if method:
		timer.timeout.connect(method)
	from.add_child(timer)
	return timer
