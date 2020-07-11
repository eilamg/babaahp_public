#actions:
#    ready
#    crush
#    reload
#
#states:
#    unwound
#    primed
#    down
#
#parameters:
#    time between
#    three points - stop top, stop primed, stop down
#    prime speed, crush speed, reload speed


extends Node2D


enum STATES {ZEROD, PRIMED, CRUSHED}
var state = STATES.ZEROD


func zero():
    # $Body.position = $Zero.position
    $Body.move_to($Zero.position, -1000, 0)
    state = STATES.ZEROD


func prime():
    # $Body.position = $Primed.position
    $Body.move_to($Primed.position, 20, 1000)
    state = STATES.PRIMED


func crush():
    # $Body.position = $Crushed.position
    $Body.move_to($Crushed.position, 2000, 100000)
    state = STATES.CRUSHED


func cycle():
    match state:
        STATES.ZEROD:
            prime()
        STATES.PRIMED:
            crush()
        STATES.CRUSHED:
            zero()


func _unhandled_input(event):
    if event.is_action_pressed("ui_down"):
        if randi() % 2:
            cycle()
