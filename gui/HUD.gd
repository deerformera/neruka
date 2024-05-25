extends CanvasLayer

var boss: Boss = null

func _ready():
	$M/Top/Button.connect("pressed", self, "pressed")
	$M/Top/CatHealthbar/Background.max_value = CatController.Level.getLevelValue()["health"]
	$M/Top/CatHealthbar/Foreground.max_value = CatController.Level.getLevelValue()["health"]

func pressed():
	Tab.open("inventory")

func bossEnter(boss: Boss):
	$M/BossHealthbar.show()
	if boss: 
		self.boss = boss
		$M/BossHealthbar/Background.max_value = boss.health
		$M/BossHealthbar/Foreground.max_value = boss.health

func bossExit():
	$M/BossHealthbar.hide()
	self.boss = null

func _physics_process(delta):
	if boss: 
		$M/BossHealthbar/Foreground.value = boss.health
		$M/BossHealthbar/Background.value = lerp($M/BossHealthbar/Background.value, $M/BossHealthbar/Foreground.value, 0.2)
	
	$M/Top/CatHealthbar/Foreground.value = Utils.get_cat().health
	$M/Top/CatHealthbar/Background.value = lerp($M/Top/CatHealthbar/Background.value, $M/Top/CatHealthbar/Foreground.value, 0.2)
