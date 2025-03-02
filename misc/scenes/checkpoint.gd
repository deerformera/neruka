extends Area2D

onready var cat = Utils.get_cat()

export var active = false
var grew = false

func _ready():
	self.connect("body_entered", self, "onEnter")
	if active: $AnimationPlayer.play("grow0")

func activate():
	if active: return
	$AnimationPlayer.play("grow0")

func onEnter(body: Character):
	if grew: 
		$AnimationPlayer.play("grow2")
		cat.get_node("StateMachine").travel("Idle")
		create_tween().tween_property(cat, "global_position", self.global_position - Vector2(0, 8), 0.2)
		cat.heal(999)
		yield(get_tree().create_timer(0.5), "timeout")
		var menu = preload("res://gui/checkpointMenu.tscn").instance()
		menu.connect("exited", self, "onMenuExit")
		get_tree().root.add_child(menu)

	else: 
		grew = true
		$AnimationPlayer.play("grow1")

func onMenuExit():
	cat.get_node("StateMachine").travel("Normal")
	$AnimationPlayer.play_backwards("grow2")
	
