extends CanvasLayer

signal chat_end

func chat(body: Node, content: Array):
	$M/BG/M/VB/Name.text = body.name
	self.show()
	HUD.hide()
	
	for i in content:
		$M/BG/M/VB/Content.visible_characters = 0
		$M/BG/M/VB/Content.text = i
		while $M/BG/M/VB/Content.percent_visible < 1:
			$M/BG/M/VB/Content.visible_characters += 1
			yield(get_tree().create_timer(0.02), "timeout")
		yield(get_tree().create_timer(0.7), "timeout")
	self.hide()
	emit_signal("chat_end")
