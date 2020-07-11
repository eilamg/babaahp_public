extends Node2D


signal killbox_hit
signal ground_hit


func crush():
    $AnimationPlayer.play("crush")


func _on_animation_finished(anim_name):
    if anim_name == "crush":
        $AnimationPlayer.play("return")


func _on_Killbox_body_entered(body):
    emit_signal("killbox_hit", body)


func _on_hit_ground():
    emit_signal("ground_hit")
