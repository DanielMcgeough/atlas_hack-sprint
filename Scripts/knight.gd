extends CharacterBody2D
extends KinematicBody2D
extends StaticBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
var is_dying = false
var ascent_distance = 0
export var ascent_speed = 300
export var rotation_speed = 180
export var descent_speed = 300
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump -- we want to only jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	position.x = 123

	move_and_slide()


# Death function and animation
# func _on_hitbox_body_entered(body:Node2D):
# 	queue_free()

	var collision = move_and_collide(velocity)
	if collision:
		if collision.collider.is_in_group("obstacle"):
			player_death()
	
	if is_dying:
        if ascent_distance < 300:
            velocity.y = -ascent_speed
            rotation += rotation_speed * delta
            ascent_distance += ascent_speed * delta
        else:
            velocity.y = descent_speed
            if position.y > get_viewport_rect().size.y / 2:
                # Handle character death completion, e.g., queue_free()
                queue_free()
    else:
		#this is for normal player movement.		

func player_death():
	is_dying = true
