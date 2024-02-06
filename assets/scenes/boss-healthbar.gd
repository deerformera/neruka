extends CanvasLayer

func _ready():
	$M/ProgressBar.max_value = get_parent().health
	$M/ProgressBar.value = get_parent().health
	
	get_parent().connect("health_changed", self, "update")

func update():
	$M/ProgressBar.value = get_parent().health
