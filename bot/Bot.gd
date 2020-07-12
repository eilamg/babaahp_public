extends KinematicBody2D


var elevator_start_stream = preload("res://bot/robot-gravitate/Robot-gravitate-start.ogg")
var elevator_loop_stream = preload("res://bot/robot-gravitate/Robot-gravitate-start.ogg")
var elevator_end_stream = preload("res://bot/robot-gravitate/Robot-gravitate-start.ogg")


export var active = false
export var speed = 1000
export var gravity = 100

var movement = Vector2.ZERO
var in_elevator = false
var on_console = null


func _physics_process(delta):
    movement.x = 0
    if active:
        if Input.is_action_pressed("move_left"):
            movement.x -= speed
        if Input.is_action_pressed("move_right"):
            movement.x += speed
        if in_elevator:
            movement.y = 0
            if Input.is_action_pressed("move_up"):
                movement.y = -speed
            if Input.is_action_pressed("move_down"):
                movement.y = speed
    
    if not(in_elevator):
        movement.y += gravity
    
    if movement.x < 0:
        $Sprite.flip_h = true
    if movement.x > 0:
        $Sprite.flip_h = false

#    if in_elevator and $ElevatorAudio.stream == null:
#        start_elevator_audio()

    if in_elevator and active:
        $ElevatorAudio.stream_paused = false
    else:
        $ElevatorAudio.stream_paused = true
    if in_elevator and movement == Vector2.ZERO:
        movement.x += rand_range(-10, 10)
        movement.y += rand_range(-10, 10)
    
    if movement.x != 0:
        $MoveAudio.stream_paused = false
    else:
        $MoveAudio.stream_paused = true
    
    move_and_slide(movement)


func _unhandled_input(event):
    if active and not(in_elevator) and event.is_action_pressed("move_up"):
        if on_console:
            # prints("used console", on_console)
            get_parent().decrease_danger_level(on_console.number)


func _on_character_switched():
    active = not(active)


func _on_entered_elevator(body):
    in_elevator = true


func _on_exited_elevator(body):
    in_elevator = false


func _on_console_entered(console):
    # prints('bot entered console', console, console.number)
    on_console = console


func _on_console_exited(console):
    # prints('bot exited console', console, console.number)
    on_console = null

#
#func _on_ElevatorAudio_finished():
#    print('end stream')
#    if $ElevatorAudio.stream == elevator_start_stream:
#        print('starting next stream')
#        $ElevatorAudio.set_stream(elevator_loop_stream)
#        print($ElevatorAudio.stream)
#        $ElevatorAudio.play()
#
#
#func start_elevator_audio():
#    $ElevatorAudio.stream = elevator_start_stream
#    $ElevatorAudio.play()
