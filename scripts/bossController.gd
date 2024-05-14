extends Node

var wall = preload("res://misc/maps/savannaWall.tscn")
export var boss_name: String
var boss: Boss

func _ready():
	if boss_name: boss = get_node(boss_name)
	if boss: boss.connect("die", self, "onBossDie")
	
	$AlertArea.connect("body_entered", self, "onAlert")
	for i in $TileMap.get_used_cells_by_id(0):
		var wall_ins = wall.instance()
		$TileMap.add_child(wall_ins)
		wall_ins.global_position = $TileMap.map_to_world(i) + Vector2(32, 32)
		$TileMap.set_cellv(i, -1)

func onBossDie():
	for i in $TileMap.get_children():
		i.hide()
	
	HUD.bossExit()

func onAlert(body: Character):
	for i in $TileMap.get_children():
		i.show()
	
	boss.enter(body)
	HUD.bossEnter(boss)
	
	$AlertArea.queue_free()
