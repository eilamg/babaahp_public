tool
extends Node2D


signal console_entered
signal console_exited


enum STATES {OFF, ON, BLINKING}
export(STATES) var state = STATES.OFF setget set_state
# export(String, "off", "on", "blinking") var state setget set_state
var animations = {STATES.OFF: 'off', STATES.ON: 'on', STATES.BLINKING: 'blinking'}

export var blink_rate = 1.0 setget set_blink_rate
export(int, 0, 5) var number = 1 setget set_number


func _ready():
    if not(Engine.is_editor_hint()):
        if $Number:
            $Number.position += Vector2(rand_range(-5, 5), rand_range(-10, 10))


func set_state(value):
    state = value
    if get_node_or_null("Panel"):
        $Panel.play(animations[state])
    if get_node_or_null("Bulb"):
        $Bulb.play(animations[state])


func set_blink_rate(value):
    blink_rate = value
    if get_node_or_null("Panel"):
        $Panel.speed_scale = blink_rate
    if get_node_or_null("Bulb"):
        $Bulb.speed_scale = blink_rate


func set_number(value):
    number = value
    if get_node_or_null("Number"):
        $Number.frame = number


# func _on_used_button_pressed():
#     pass


func _on_danger_level_changed(index, value):
    if index == number:
        # prints('console', number, 'intercepted level change to', value)
        set_state(value)


func _on_Area2D_body_entered(body):
    emit_signal("console_entered", self)


func _on_Area2D_body_exited(body):
    emit_signal("console_exited", self)
