extends Area2D

func _ready():
	self.connect("body_entered", self, "onHit")
	$AnimatedSprite.connect("animation_finished", self, "finished")
	$AnimatedSprite.play("default")

func onHit(body: Character):
	var cat = Utils.get_cat()
	body.damaged(cat.damage)
	if cat: cat.hit()

func finished():
	self.queue_free()
