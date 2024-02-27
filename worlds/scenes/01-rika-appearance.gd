extends Node2D

onready var cat = Global.get_cat()

var entered = false
var completed = false

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
	$Path2D/PathFollow2D.unit_offset = 1
	$Rika.global_position = $Path2D/PathFollow2D.global_position
	entered = false
	cat.cutscene_start("idle_up")
	var tw = create_tween()
	tw.tween_property($Rika, "global_position", $KnockPoint.global_position, 1)
	yield(get_tree().create_timer(2), "timeout")
	cat.cutscene_start("idle_up", $PinchoPoint.global_position)
	yield(get_tree().create_timer(3), "timeout")
	cat.cutscene_stop()
	
	get_tree().get_nodes_in_group("pincho")[0].connect("died", self, "post_boss")

func post_boss():
	$PostBoss/Down/CollisionShape2D.set_deferred("disabled", false)
	$PostBoss/Right/CollisionShape2D.set_deferred("disabled", false)
	var savanna = get_tree().get_nodes_in_group("map").find("Savanna")
	print(savanna)

func post_boss_down(body):
	$PostBoss.queue_free()
	yield(cat.cutscene_start("idle_down", $Rika.global_position), "completed")
	yield(Global.chat("Rika", ["Terima kasih telah menyelamatkanku.", "ikutlah sebentar"]), "completed")
	cat.cutscene_stop()

func post_boss_right(body):
	$PostBoss.queue_free()
	
	$Rika.global_position = $PinchoPoint.global_position
	
	yield(cat.cutscene_start("idle_left", Global.get_between(cat.global_position, $Rika.global_position)), "completed")
	yield(Global.chat("Rika", ["hei tunggu!", "aku belum bilang terima kasih", "ikutlah sebentar"]), "completed")
	cat.cutscene_stop()
	
	var savanna = get_tree().get_nodes_in_group("map").find("Savanna")


func _physics_process(delta):
	if entered:
		if $Path2D/PathFollow2D.unit_offset < 1:
			$Path2D/PathFollow2D.offset += 3
			$Rika.global_position = $Path2D/PathFollow2D.global_position
			$Rika.velocity = Vector2.RIGHT.rotated($Path2D/PathFollow2D.rotation)
