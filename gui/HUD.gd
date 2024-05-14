extends CanvasLayer

var boss: Boss = null

func _ready():
	$M/Top/Button.connect("pressed", self, "pressed")
	$M/Top/CatHealthbar.max_value = CatController.Level.getLevelValue()["health"]

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
	$M/Top/CatHealthbar.value = Utils.get_cat().health
