tool
extends Node2D


signal killbox_hit
signal ground_hit


export(Array, float) var animation_speeds = [1.0, 1.25, 1.5]
export(Array, float) var timings = [8.0, 4.0, 2.0]
export(int, 1, 5) var number setget set_number


func set_number(value):
    number = value
    if get_node_or_null("Body/Sprite"):
        $Body/Sprite.frame = number - 1


func crush():
   if not(Engine.editor_hint):
        $AnimationPlayer.play("crush")
        
        
func start_with_delay(delay):
    yield(get_tree().create_timer(delay), "timeout")
    crush()
    $Timer.start()


func _on_animation_finished(anim_name):
    if not(Engine.editor_hint):
        if anim_name == "crush":
            $AnimationPlayer.play("return")


func _on_Killbox_body_entered(body):
    if not(Engine.editor_hint):
        emit_signal("killbox_hit", body)


func _on_hit_ground():
    if not(Engine.editor_hint):
        emit_signal("ground_hit")


func _on_Timer_timeout():
    crush()


func _on_danger_level_changed(index, value):
    if index == number:
        # prints('crusher', number, 'intercepted danger level change to', value)
        $Timer.wait_time = timings[value] * rand_range(0.9, 1.1)
        $AnimationPlayer.playback_speed = animation_speeds[value]
        $Body/Sprite.use_parent_material = (value != 2) # TODO: this shouldn't be hardcoded
