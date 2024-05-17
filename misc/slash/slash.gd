extends Area2D

var hitEffect = preload("res://misc/scenes/hitEffect.tscn")

func _ready():
	self.connect("body_entered", self, "onHit")
	$AnimatedSprite.connect("animation_finished", self, "finished")
	$AnimatedSprite.play("default")

func onHit(body: Character):
	var cat = Utils.get_cat()
	if cat == null: return
	body.damaged(cat.damage)
	cat.hit()
	
	var hit_ins = hitEffect.instance()
	var middle = (body.global_position - cat.global_position)
	hit_ins.rotation = middle.angle()
	hit_ins.global_position = cat.global_position + middle / 1.5
	get_tree().root.get_node("World").add_child(hit_ins)
	

func finished():
	self.queue_free()
