extends Node2D


export var activated = false setget set_activated


func set_activated(value):
    activated = value
    $SpriteActivated.visible = activated
    $SpriteNotActivated.visible = not(activated)


func _on_used_button_pressed():
    pass
