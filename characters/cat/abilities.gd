extends Node2D

func _ready():
    var abilities = Utils.get_abilities()
    for i in abilities.size():
        add_child(abilities[i].instance())

func _input(event):
    for i in Utils.get_abilities().size():
        if event.is_action_pressed("n_ability"+str(i)):
            get_child(i).emit_signal("cast")

func cast(col: Color):
    ($"../Sprite".material as ShaderMaterial).set_shader_param("u_replacement_color", col)
    get_parent().animstate.travel("cast")
    
    yield(get_tree().create_timer(0.3), "timeout")
