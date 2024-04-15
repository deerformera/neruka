extends Area2D

func _ready():
	set_physics_process(false)
	self.connect("body_entered", self, "onEnter")
	self.spawn()
	set_physics_process(true)


func _physics_process(delta):
	var cat = Utils.get_cat()
	if cat: self.global_position += (cat.global_position - self.global_position).normalized() * 10
		
func onEnter(body: Character):
	self.queue_free()

func spawn():
	var rng = Utils.create_rng()
	var vec = Vector2(
		rng.randi_range(-50, 50), 
		rng.randi_range(-50, 50))
	var tw = create_tween()
	tw.tween_property(self, "global_position", global_position + vec, 0.5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	yield(tw, "finished")
	$CollisionShape2D.disabled = false
