extends CanvasLayer

var boss: Boss = null

func _ready():
	$M/CatHealthbar/Background.max_value = CatController.Level.getLevelValue()["health"] * 100
	$M/CatHealthbar/Foreground.max_value = CatController.Level.getLevelValue()["health"] * 100
	

func bossEnter(boss: Boss):
	$M/BossHealthbar.show()
	if boss: 
		self.boss = boss
		$M/BossHealthbar/Background.max_value = boss.health * 100
		$M/BossHealthbar/Foreground.max_value = boss.health * 100

func bossExit():
	$M/BossHealthbar.hide()
	self.boss = null

func _physics_process(delta):
	if boss: 
		$M/BossHealthbar/Foreground.value = boss.health * 100
		$M/BossHealthbar/Background.value = lerp($M/BossHealthbar/Background.value, $M/BossHealthbar/Foreground.value, 0.25)
	
	$M/CatHealthbar/Foreground.value = Utils.get_cat().health * 100
	$M/CatHealthbar/Background.value = lerp($M/CatHealthbar/Background.value, $M/CatHealthbar/Foreground.value, 0.25)
