tool
extends Node2D


signal killbox_hit
signal ground_hit


export(int, 1, 5) var number setget set_number


func set_number(value):
    number = value
    if $Body/Sprite:
        $Body/Sprite.frame = number - 1


func crush():
    if not(Engine.editor_hint()):
        $AnimationPlayer.play("crush")


func _on_animation_finished(anim_name):
    if not(Engine.editor_hint()):
        if anim_name == "crush":
            $AnimationPlayer.play("return")


func _on_Killbox_body_entered(body):
    if not(Engine.editor_hint()):
        emit_signal("killbox_hit", body)


func _on_hit_ground():
    if not(Engine.editor_hint()):
        emit_signal("ground_hit")
