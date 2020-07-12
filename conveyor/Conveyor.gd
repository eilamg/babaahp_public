extends StaticBody2D


export var speed = 0.0 setget set_speed


func _ready():
    set_speed(0)


func set_speed(value):
    speed = value
    constant_linear_velocity.x = -speed
    if $Sprite:
        $Sprite.material.set_shader_param("speed", speed)


func _unhandled_input(event):
    if event.is_action_pressed("debug"):
        print("conveyor speed")
        if speed == 0:
            var v = rand_range(-500, 500)
            set_speed(v)
            print("setting speed to ", v)
        else:
            set_speed(0)
