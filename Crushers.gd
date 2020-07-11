extends Node2D


var crushers = []

func _ready():
    var children = get_children()
    for child in children:
        if not(child is Timer):
            crushers.append(child)
    print(crushers)


func _on_Timer_timeout():
    for child in crushers:
        if child.state != child.STATES.ZEROD or randi() % 2:
            child.cycle()
