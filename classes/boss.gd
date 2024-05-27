extends Character
class_name Boss

export var id: int = 0
var target: Character = null

var orb = preload("res://misc/scenes/orb.tscn")

func enter(target: Character):
	self.target = target
	target.connect("die", self, "onTargetDie")
	get_node("StateMachine").travel("Aggressive")

func damaged(val):
	.damaged(val)
	
	$Sprite.material.set_shader_param("amount", 2.0)
	create_tween().tween_property($Sprite, "material:shader_param/amount", 0.0, 0.1)

func die():
	.die()
	CatController.Abilities.identify(id)
	get_tree().root.get_node("World").call_deferred("add_child", create_orb())
	get_node("AnimationPlayer").play("Die")

func onTargetDie():
	get_node("StateMachine").travel("Idle")
	target = null

func create_orb():
	var orb_ins = orb.instance()
	orb_ins.global_position = self.global_position
	return orb_ins
