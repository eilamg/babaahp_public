extends Node2D


export var activated = false setget set_activated


func set_activated(value):
    activated = value
    $SpriteActivated.visible = activated
    $SpriteNotActivated.visible = not(activated)
