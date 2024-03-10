extends Cutscene

var active = false

func first_checkpoint_entered(body):
	$Areas/first_checkpoint.queue_free()
	active = true
	
	yield(cat_look_start("idle_up", $Checkpoint.global_position), "completed")
	
	yield(Interface.chat("Rika", [
		"Coba sentuh itu.."
	]), "completed")
	cat_look_stop()

func _physics_process(delta):
	if active && cat.has_node("LevelUp"):
		active = false
		cat.get_node("LevelUp").connect("closed", self, "closed")

func closed():
	cat_look_start("idle_left", get_between($Rika.global_position))
	yield(Interface.chat("Rika", [
		"Ternyata benar.. Kau seorang sentinel",
		"Aku mengetahuinya karena aku pernah mengenal salah satu dari jenismu",
		"Sekarang ia sedang terperangkap di sekitar sini, dan dia memintaku untuk mencari bantuan",
		"Tolong bantulah dia. Kau akan lebih mengerti kemampuanmu bila kau berbicara dengannya",
		"Aku akan menunggu di sini"
	]), "completed")
	cat_look_stop()
