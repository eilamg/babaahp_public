extends Node2D


var current_screen = 0


func advance():
    current_screen += 1

    match current_screen:
        1:
            $Intro1.visible = false
            $Intro2.visible = true
        2:
            $Intro2.visible = false
            $Intro3.visible = true
        3:
            $Intro3.visible = false
            $Intro4.visible = true
        4:
            $Intro4.visible = false
            $Intro5.visible = true
        5:
            get_parent().get_parent().start_game()
            queue_free()


func _input(event):
    get_tree().set_input_as_handled()
    if Input.is_action_just_pressed("ui_accept"):
        advance()
