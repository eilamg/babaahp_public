extends StaticBody2D


var speed = 0 setget set_speed
var acceleration = 0 setget set_acceleration
var target = null


func _ready():
    pass
    
    
func move_to(position, speed, acceleration):
    target = position.y
    set_speed(speed)
    set_acceleration(acceleration)


func set_speed(value):
    speed = value
    
    
func set_acceleration(value):
    acceleration = value


func _physics_process(delta):
    if target != null:
        var delta_pos = speed * delta
        
        if sign(position.y + delta_pos - target) != sign(position.y - target):
            position.y = target
            speed = 0
            acceleration = 0
            target = null
            
        else:
            position.y += delta_pos
            speed += acceleration * delta
