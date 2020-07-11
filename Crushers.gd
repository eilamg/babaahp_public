extends Node2D


var crushers = []

func _ready():
    var children = get_children()
    for child in children:
        if not(child is Timer):
            crushers.append(child)


func _on_Timer_timeout():
    crushers[randi() % len(crushers)].crush()
