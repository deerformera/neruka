extends CanvasLayer

var item = preload("res://assets/scenes/forge_item.tscn")

var selected: int

var data: Array

func _ready():
    $Margin/Panel/VBox/CloseButton.connect("pressed", self, "close")
    $Margin/Panel/VBox/Margin/HBox/VBox/ForgeButton.connect("pressed", self, "forge")
    $Margin/Panel/VBox/Margin/HBox/VBox/ForgeButton.disabled = true
    items()

func close(): self.queue_free()

func items():
    var container = $Margin/Panel/VBox/Margin/HBox/Scroll/Items
    for i in Utils.knowledges.size():
        data.append(Utils.get_ability(Utils.knowledges[i]))
        var item_ins = item.instance()
        item_ins.connect("pressed", self, "item_pressed", [i])
        container.add_child(item_ins)

func item_pressed(index):
    selected = Utils.knowledges[index]
    if Utils.abilities.has(Utils.knowledges[index]):
        $Margin/Panel/VBox/Margin/HBox/VBox/ForgeButton.disabled = true
    else: $Margin/Panel/VBox/Margin/HBox/VBox/ForgeButton.disabled = false
    
    $Margin/Panel/VBox/Margin/HBox/VBox/Name.text = data[index].name
    $Margin/Panel/VBox/Margin/HBox/VBox/Desc.text = data[index].desc

func forge():
    Utils.learn(selected)
    
