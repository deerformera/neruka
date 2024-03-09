extends Area2D

onready var cat = Global.get_cat()
onready var levelup = preload("res://characters/cat/tabs/levelup.tscn")

func body_entered(body):
	$AnimatedSprite.play("close")
	self.z_index = 2
	
	cat.get_node("AnimationTree").active = false
	cat.get_node("HUD").hide()
	cat.global_position = self.global_position
	yield(get_tree().create_timer(0.5), "timeout")
	
	var level_ins = levelup.instance()
	level_ins.connect("closed", self, "tab_closed")
	
	cat.add_child(level_ins)

func tab_closed():
	$AnimatedSprite.play("open")
	self.z_index = 0
	
	cat.get_node("AnimationTree").active = true
	cat.get_node("HUD").show()
	
