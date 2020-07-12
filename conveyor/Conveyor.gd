extends StaticBody2D


export var speed = 0.0 setget set_speed
export var factor = 0.01


func _ready():
    set_speed(0)


func set_speed(value):
    print("set_speed ", value)
    speed = value
    constant_linear_velocity.x = -speed
    if $Control/VanishingPoint:
        # TODO: tighten up to get the exact factor. probably has to do with ellipse a/b ratio
        $Control/VanishingPoint.speed = speed * (PI / 2000)


func _unhandled_input(event):
    if event.is_action_pressed("debug"):
        print("conveyor speed")
        if speed == 0:
            var v = rand_range(-500, 500)
            set_speed(v)
            print("setting speed to ", v)
        else:
            set_speed(0)
