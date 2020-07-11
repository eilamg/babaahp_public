extends KinematicBody2D


export var active = true
export var speed = 1000
export var gravity = 100
export var jump_force = 1000

var movement = Vector2.ZERO
var can_jump = true
var is_jumping = false


func _physics_process(delta):
    movement.x = 0
    if active:
        if Input.is_action_pressed("move_left"):
            movement.x -= speed
        if Input.is_action_pressed("move_right"):
            movement.x += speed
        if can_jump and Input.is_action_pressed("move_up"):
            is_jumping = true
            movement.y = -jump_force
            $AnimatedSprite.play("jump")
            can_jump = false

    movement.y += gravity
    movement.y = clamp(movement.y, -INF, 10000)
    
    if not(is_jumping):
        if movement.x < 0:
            $AnimatedSprite.play("run")
            $AnimatedSprite.flip_h = true
        if movement.x > 0:
            $AnimatedSprite.play("run")
            $AnimatedSprite.flip_h = false
        if movement.x == 0:
            $AnimatedSprite.play("idle")
            
    move_and_slide(movement, Vector2.UP)
    
    if is_on_floor():
        can_jump = true
        is_jumping = false


func _on_character_switched():
    active = not(active)
