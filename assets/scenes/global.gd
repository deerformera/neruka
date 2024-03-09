extends Node

var shrinken = false
export var debug = false

signal chat_end

func get_cat() -> Character:
	var arr = get_tree().get_nodes_in_group("cat")
	if arr.empty(): return null
	else: return arr[0]

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
	var cat = get_cat()
	cat.get_node("HUD").hide()
	
	$Dialogue.show()
	$Dialogue/Panel/M/HB/M/VB/Nama.text = nama
	for i in text:
		$Dialogue/Panel/M/HB/M/VB/Text.visible_characters = 0
		$Dialogue/Panel/M/HB/M/VB/Text.text = i
		while $Dialogue/Panel/M/HB/M/VB/Text.visible_characters < i.length():
			$Dialogue/Panel/M/HB/M/VB/Text.visible_characters += 1
			yield(get_tree().create_timer(0.01), "timeout")
		yield(get_tree().create_timer(0.1), "timeout")
	
	cat.get_node("HUD").show()
	$Dialogue.hide()

func introduce(texture: Texture, nama: String):
	$Poster/Label.text = nama
	$Poster/TextureRect.texture = texture
	$Poster.show()
	yield(get_tree().create_timer(1), "timeout")
	$Poster.hide()
