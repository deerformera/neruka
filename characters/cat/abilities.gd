extends Node2D

func _ready():
    Utils.connect("abilities_changed", self, "abilities_changed")
    abilities_changed()

func abilities_changed():
    for i in get_children(): i.free()
    
    var abilities = Utils.get_abilities_nodes()
    for i in abilities.size():
        add_child(abilities[i].instance())

func _input(event):
    for i in Utils.current_abilities.size():
        if event.is_action_pressed("n_ability"+str(i)):
            get_child(i).emit_signal("cast")

func cast(col: Color):
    ($"../Sprite".material as ShaderMaterial).set_shader_param("u_replacement_color", col)
    get_parent().animstate.travel("cast")
