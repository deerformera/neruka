extends StaticBody2D

signal interacted
signal uninteracted
signal activated

var shop_list: Array = [
	{
		"type": "ability",
		"id": 1,
		"price": [1, 1]
	},
	{
		"type": "ability",
		"id": 2,
		"price": [1, 1]
	},
	{
		"type": "claw",
		"id": 1,
		"price": [1, 1]
	},
	{
		"type": "claw",
		"id": 2,
		"price": [1, 1]
	},
	{
		"type": "claw",
		"id": 3,
		"price": [1, 1]
	}
]

func _ready():
	interacted.connect(func(): $Tag.show())
	uninteracted.connect(func(): $Tag.hide())
	activated.connect(func(): Player.get_panel("Shop").init(shop_list))
