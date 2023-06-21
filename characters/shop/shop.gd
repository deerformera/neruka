extends StaticBody2D

signal interacted
signal uninteracted
signal activated

var shop_list: Array = [
	{
		"type": "claw",
		"id": 1,
		"price": [1, 2]
	},
	{
		"type": "sight",
		"id": 2,
		"price": [1, 2]
	},
	{
		"type": "claw",
		"id": 2,
		"price": [1, 2]
	}
]

func _ready():
	interacted.connect(func(): $Tag.show())
	uninteracted.connect(func(): $Tag.hide())
	activated.connect(func(): Player.get_node("M/Shop").set_item(shop_list))
