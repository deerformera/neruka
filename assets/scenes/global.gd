extends Node

var shrinken = false

func get_cat() -> Character:
	var arr = get_tree().get_nodes_in_group("cat")
	if arr.empty(): return null
	else: return arr[0]

func get_between(first_vector: Vector2, second_vector: Vector2) -> Vector2:
	return first_vector + (second_vector - first_vector) / 2

func fade_in(): 
	$BlackScreen/AnimationPlayer.play("fade")
	yield(get_tree().create_timer(0.4), "timeout")
	return

func fade_out():
	$BlackScreen/AnimationPlayer.play_backwards("fade")
	yield(get_tree().create_timer(0.4), "timeout")
	return

func shrink_in():
	if shrinken: return
	$Control/VB/AnimationPlayer.play("cinematic")
	shrinken = true

func shrink_out():
	$Control/VB/AnimationPlayer.play_backwards("cinematic")
	shrinken = false

func chat(nama: String, text: Array):
	$Dialogue.show()
	$Dialogue/Panel/M/HB/M/VB/Nama.text = nama
	for i in text:
		$Dialogue/Panel/M/HB/M/VB/Text.visible_characters = 0
		$Dialogue/Panel/M/HB/M/VB/Text.text = i
		while $Dialogue/Panel/M/HB/M/VB/Text.visible_characters < i.length():
			$Dialogue/Panel/M/HB/M/VB/Text.visible_characters += 1
			yield(get_tree().create_timer(0.05), "timeout")
		yield(get_tree().create_timer(1), "timeout")
	
	$Dialogue.hide()
