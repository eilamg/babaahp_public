extends KinematicBody2D


export var active = false
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
        if Input.is_action_pressed("move_up"):
            movement += Vector2(0, -speed)
        if Input.is_action_pressed("move_down"):
            movement += Vector2(0, speed)

    move_and_slide(movement)


func _on_character_switched():
    active = not(active)
