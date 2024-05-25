extends CanvasLayer

var boss: Boss = null

func _ready():
	$M/Top/Button.connect("pressed", self, "pressed")
	$M/Top/CatHealthbar/Background.max_value = CatController.Level.getLevelValue()["health"]
	$M/Top/CatHealthbar/Foreground.max_value = CatController.Level.getLevelValue()["health"]

func pressed():
	Tab.open("inventory")

func bossEnter(boss: Boss):
	$M/C/BossHealthbar.show()
	if boss: 
		self.boss = boss
		$M/C/BossHealthbar.max_value = boss.health * 10

func bossExit():
	$M/C/BossHealthbar.hide()
	self.boss = null

func _physics_process(delta):
	if boss: $M/C/BossHealthbar.value = boss.health * 10
	$M/Top/CatHealthbar/Foreground.value = Utils.get_cat().health
	$M/Top/CatHealthbar/Background.value = lerp($M/Top/CatHealthbar/Background.value, $M/Top/CatHealthbar/Foreground.value, 0.2)
