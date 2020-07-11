extends Node2D


func _on_character_switched():
    $LeftOverlay.visible = not($LeftOverlay.visible)
    $RightOverlay.visible = not($RightOverlay.visible)
