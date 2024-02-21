extends Character

var points = [
	Vector2(-64, -64),
	Vector2(0, -64),
	Vector2(64, -64),
	Vector2(-64, 0),
	Vector2(0, 0),
	Vector2(64, 0),
	Vector2(-64, 64),
	Vector2(0, 64),
	Vector2(64, 64),
]

var index = 0

func _ready():
	var timer = create_timer(1, false)
	timer.connect("timeout", self, "move")
	add_child(timer)
	timer.start()

func move():
	var rng = create_rng()
	var val = rng.randi_range(0, points.size() - 1)
	while index == val: val = rng.randi_range(0, points.size() - 1)
	index = val
	$CollisionShape2D.position = points[index]
	
