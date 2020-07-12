extends Node


#func _unhandled_input(event):
#    if event.is_action_pressed("mute_music"):
#        $Drums.stream_paused = not($Drums.stream_paused)


func switch_to(sound):
    match sound:
        "drums":
            if not $Drums.playing:
                $Drums.play()
            $Drums.stream_paused = false
            $Drums180.stream_paused = true
        "drums180":
            $Drums.stream_paused = true
            if not $Drums180.playing:
                $Drums180.play()
            $Drums180.stream_paused = false
