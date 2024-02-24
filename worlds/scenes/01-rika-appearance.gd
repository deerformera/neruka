extends Node2D

onready var cat = Global.get_cat()

var entered = false

func _ready():
	$StartArea.connect("body_entered", self, "start_entered")
	$EndArea.connect("body_entered", self, "end_entered")
	$PostBoss/Down.connect("body_entered", self, "post_boss_down")
	$PostBoss/Right.connect("body_entered", self, "post_boss_right")

func start_entered(body):
	$StartArea.queue_free()
	yield(cat.cutscene_start("idle_right", Global.get_between(cat.global_position, $Rika.global_position)), "completed")
	entered = true
	yield(get_tree().create_timer(1), "timeout")
	cat.cutscene_stop()

func end_entered(body):
	$EndArea.queue_free()
	cat.cutscene_start("idle_up", $KnockPoint.global_position)
	var tw = create_tween()
	tw.tween_property($Rika, "global_position", $KnockPoint.global_position, 1)
	yield(get_tree().create_timer(2), "timeout")
	cat.cutscene_start("idle_up", $PinchoPoint.global_position)
	yield(get_tree().create_timer(3), "timeout")
	cat.cutscene_stop()
	
	var pincho = get_tree().get_nodes_in_group("pincho")[0]
	pincho.connect("died", self, "post_boss")

func post_boss():
	$PostBoss.show()

func post_boss_down(body):
	print("down")

func post_boss_right(body):
	print("right")

func _physics_process(delta):
	if entered:
		if $Path2D/PathFollow2D.unit_offset < 1:
			$Path2D/PathFollow2D.offset += 3
			$Rika.global_position = $Path2D/PathFollow2D.global_position
			$Rika.velocity = Vector2.RIGHT.rotated($Path2D/PathFollow2D.rotation)
