extends StaticBody2D


export(Array, int) var speeds = [0, 100, 500]
export var speed = 0.0 setget set_speed
export var factor = 0.01

var direction = 1.0


func _ready():
    set_speed(0)


func set_speed(value):
    speed = value
    constant_linear_velocity.x = -speed
    if $Control/VanishingPoint:
        # TODO: tighten up to get the exact factor. probably has to do with ellipse a/b ratio
        $Control/VanishingPoint.speed = speed * (PI / 2000.0)

#    if $AudioStreamPlayer:
#        if speed == 0:
#            $AudioStreamPlayer.stop()
#        else:
#            $AudioStreamPlayer.play()

#func _unhandled_input(event):
#    if event.is_action_pressed("debug"):
#        print("conveyor speed")
#        if speed == 0:
#            var v = rand_range(-500, 500)
#            set_speed(v)
#            print("setting speed to ", v)
#        else:
#            set_speed(0)


func _on_danger_level_changed(index, level):
    if index == 0:
        # prints('conveyor intercepted level change to', level)
        if speed == 0:
            direction = sign(rand_range(-1.0, 1.0))
        set_speed(speeds[level] * direction)
