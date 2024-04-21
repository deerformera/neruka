extends CanvasLayer

func _ready():
	$M/Top/Button.connect("pressed", self, "pressed")

func pressed():
	Tab.open("inventory")
