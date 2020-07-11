extends KinematicBody2D


export var active = true
export var speed = 1000


func _ready():
    CharacterSwitcher.connect("character_switched", self, "_on_character_switched")


func _physics_process(delta):
    var movement = Vector2.ZERO
    if active:
        if Input.is_action_pressed("move_left"):
            movement += Vector2(-speed, 0)
        if Input.is_action_pressed("move_right"):
            movement += Vector2(speed, 0)

    move_and_slide(movement)


func _on_character_switched():
    active = not(active)
