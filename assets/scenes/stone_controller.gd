extends TileMap


export var stone_res: PackedScene
export var stone_time: float = 2
export var wall_res: PackedScene

var stones = 0
var max_stones = 0

func _ready():
	max_stones = get_used_cells_by_id(1).size()
	for i in get_used_cells_by_id(1):
		var stone = stone_res.instance()
		stone.position = map_to_world(i) + Vector2(32, 32)
		stone.connect("activated", self, "activated")
		stone.connect("deactivated", self, "deactivated")
		stone.time = stone_time
		call_deferred("add_child", stone)
		set_cellv(i, -1)

func activated():
	stones += 1
	if stones >= max_stones:
		for i in get_children():
			i.disable()
		
		for i in get_used_cells_by_id(0):
			var wall = wall_res.instance()
			wall.position = map_to_world(i) + Vector2(32, 32)
			call_deferred("add_child", wall)
			set_cellv(i, -1)

func deactivated(): stones -= 1
