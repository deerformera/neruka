extends CanvasLayer

var item = preload("res://characters/cat/tabs/inventory_item.tscn")
var data: Array

var current: bool
var selected: int

func _ready():
    $Margin/Panel/VBox/HBox/CloseButton.connect("pressed", self, "close")
    $Margin/Panel/VBox/Margin/HBox/Panel/Equip.connect("pressed", self, "equip")
    set_items()

func set_items():
    data = Utils.get_abilities()
    for child in $Margin/Panel/VBox/Margin/HBox/Main/P2/M/S/Grid.get_children(): child.queue_free()
    for child in $Margin/Panel/VBox/Margin/HBox/Main/P/Currents.get_children(): child.queue_free()
    
    for i in Utils.current_abilities.size():
        var item_ins = item.instance()
        item_ins.get_node("M/TextureRect").texture = load("res://assets/abilities/"+str(Utils.current_abilities[i])+".png")
        item_ins.connect("pressed", self, "item_pressed", [i, true])
        $Margin/Panel/VBox/Margin/HBox/Main/P/Currents.add_child(item_ins)
    
    for i in data.size():
        var grid = $Margin/Panel/VBox/Margin/HBox/Main/P2/M/S/Grid
        var item_ins = item.instance()
        item_ins.get_node("M/TextureRect").texture = load("res://assets/abilities/"+str(Utils.abilities[i])+".png")
        item_ins.connect("pressed", self, "item_pressed", [i, false])
        grid.add_child(item_ins)

func item_pressed(index, current):
    $Margin/Panel/VBox/Margin/HBox/Panel/Equip.disabled = false
    
    $Margin/Panel/VBox/Margin/HBox/Panel/Name.text = data[index].name
    $Margin/Panel/VBox/Margin/HBox/Panel/Desc.text = data[index].desc
    
    self.current = current
    if current: self.selected = Utils.current_abilities[index]
    elif !current:
        if Utils.current_abilities.has(Utils.abilities[index]): 
            self.current = true
        self.selected = Utils.abilities[index]
    
    if self.current: $Margin/Panel/VBox/Margin/HBox/Panel/Equip.text = "Unequip"
    else: $Margin/Panel/VBox/Margin/HBox/Panel/Equip.text = "Equip"

func close(): self.queue_free()

func equip():
    var currents = Utils.current_abilities
    if current:
        var index = currents.find(selected)
        currents.remove(index)
    else:
        if currents.size() >= (Utils.level.mind + 1): return
        currents.append(selected)
    
    Utils.set_ability(currents)
    set_items()
    $Margin/Panel/VBox/Margin/HBox/Panel/Name.text = ""
    $Margin/Panel/VBox/Margin/HBox/Panel/Desc.text = ""
    $Margin/Panel/VBox/Margin/HBox/Panel/Equip.disabled = true
