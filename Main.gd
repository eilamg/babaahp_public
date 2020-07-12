extends Node


signal danger_level_changed


export var crusher_delay = 2  # seconds

var consoles = {}
var crushers = {}
var danger_levels = {}
var max_danger_level = 2


func _init():
    randomize()


func start_game():
    init_consoles()
    init_crushers()
    init_danger_levels()
    $DangerTimer.start()
    $Face.visible = true
    Music.switch_to("drums")


func _ready():
    pass

func init_danger_levels():
    for i in range(6):
        set_danger_level(i, 0)


func set_danger_level(index, value):
    value = clamp(value, 0, max_danger_level)

    danger_levels[index] = value
    emit_signal("danger_level_changed", index, value)

    var danger_level_sum = 0
    for level in danger_levels.values():
        danger_level_sum += level
    if danger_level_sum >= 4:
        $Background.play("red")
        Music.switch_to("drums180")
    else:
        $Background.play("blue")
        Music.switch_to("drums")
        

func increase_danger_level(index):
    set_danger_level(index, danger_levels[index] + 1)
    

func decrease_danger_level(index):
    set_danger_level(index, danger_levels[index] - 1)
    


func init_consoles():
    var numbers = range(6)
    numbers.shuffle()
    for console in $Consoles.get_children():
        var n = numbers.pop_back()
        console.set_number(n)
        consoles[n] = console


func init_crushers():
    for crusher in $Crushers.get_children():
        crushers[crusher.number] = crusher
        
    var numbers = range(1, 6)
    numbers.shuffle()
    var i = 1
    for n in numbers:
        crushers[n].start_with_delay(crusher_delay * i)
        i += 1


func increase_random_danger_level():
    increase_danger_level(randi() % 6)



func _unhandled_input(event):
    if event.is_action_pressed("reset"):
        if $CanvasLayer/GameOver/Sprite.visible:
            $CanvasLayer/GameOver/Sprite.visible = false
            get_tree().reload_current_scene()
            Music.switch_to("drums")

    # if event.is_action_pressed("debug"):
    #     increase_random_danger_level()


func _on_DangerTimer_timeout():
    increase_random_danger_level()    


func _on_scientist_died():
    $Face.set_animation("lose")
    yield(get_tree().create_timer(1), "timeout")
    $CanvasLayer/GameOver.play("game_over")
