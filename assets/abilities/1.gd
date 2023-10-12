extends Ability

export var color: Color

func ability(): 
    get_parent().cast(color)
    yield(get_tree().create_timer(0.3), "timeout")
    
    cat.heal(10)
    $CPUParticles2D.emitting = true
