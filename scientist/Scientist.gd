extends KinematicBody2D


signal scientist_died


export var active = true
export var speed = 1000
export var gravity = 100
export var jump_force = 1000

var movement = Vector2.ZERO
var can_jump = true
var is_jumping = false

var dead = false


func _physics_process(delta):
    movement.x = 0
    if active and not dead:
        if Input.is_action_pressed("move_left"):
            movement.x -= speed
        if Input.is_action_pressed("move_right"):
            movement.x += speed
        if can_jump and Input.is_action_just_pressed("move_up"):
            is_jumping = true
            movement.y = -jump_force
            $AnimatedSprite.play("jump")
            can_jump = false

    movement.y += gravity
    movement.y = clamp(movement.y, -INF, 10000)
    
    if movement.x != 0:
        $AnimatedSprite.flip_h = movement.x < 0
        if not(is_jumping) and not(dead):
            $AnimatedSprite.play("run")
            if not $RunningAudio.playing:
                $RunningAudio.play()
    else:
        if $RunningAudio.playing:
            $RunningAudio.stop()
        if not(is_jumping) and not(dead):
            $AnimatedSprite.play("idle")

            
    move_and_slide(movement, Vector2.UP)
    
    if is_on_floor():
        can_jump = true
        is_jumping = false
        
    if dead and not($DeadCollision.disabled) and position.y >= 530:  # HACK
        $AnimatedSprite.playing = true
        set_physics_process(false)


func _on_character_switched():
    active = not(active)


func _on_Crusher_killbox_hit(body):
    if body == self and not(dead):
        die()


func die():
    dead = true
    $RunningAudio.stop()
    $DeathAudio.play(0.2)
    $Collision.set_deferred("disabled", true)
    $DeadCollision.set_deferred("disabled", false)
    $AnimatedSprite.set_animation("death")
    $AnimatedSprite.playing = false
    $AnimatedSprite.set_frame(0)
    emit_signal("scientist_died")
