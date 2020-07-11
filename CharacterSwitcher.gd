extends Node


signal character_switched


func _unhandled_input(event):
    if Input.is_action_pressed("switch_character"):
        emit_signal("character_switched")
