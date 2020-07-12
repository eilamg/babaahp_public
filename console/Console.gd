tool
extends Node2D


# enum STATES {OFF = "off", ON = "on", BLINKING = "blinking"}
# export(STATES) var state = STATES.OFF setget set_state
export(String, "off", "on", "blinking") var state setget set_state
export var blink_rate = 1.0 setget set_blink_rate
export(int, 1, 5) var number = 1 setget set_number


func _ready():
    if not(Engine.is_editor_hint()):
        if $Number:
            $Number.position += Vector2(rand_range(-5, 5), rand_range(-10, 10))


func set_state(value):
    state = value
    if $Panel:
        $Panel.play(state)
    if $Bulb:
        $Bulb.play(state)


func set_blink_rate(value):
    blink_rate = value
    if $Panel:
        $Panel.speed_scale = blink_rate
    if $Bulb:
        $Bulb.speed_scale = blink_rate


func set_number(value):
    number = value
    if $Number:
        $Number.frame = number

# func _on_used_button_pressed():
#     pass
