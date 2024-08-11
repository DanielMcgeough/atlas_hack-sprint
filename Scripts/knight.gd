extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0
var is_dying = false
var change_is_dying = false
signal is_dying_changed(new_value)
signal char_dead_off_screen()
var ascent_distance = 0
var ascent_speed = 300
var rotation_speed = 180
var descent_speed = 300


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump -- we want to only jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	position.x = 192

	move_and_slide()
		


func _on_hitbox_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	var delta = get_physics_process_delta_time()
	if body.name == "Body":
		pass
	else:
		change_is_dying = true
		if ascent_distance < 300:
				velocity.y = -ascent_speed
				rotation += rotation_speed * delta
				ascent_distance += ascent_speed * delta
		else:
			velocity.y = descent_speed
			if position.y > get_viewport_rect().size.y / 2:
				# Handle character death completion, e.g., queue_free()
				queue_free()
				print("Char off scree")
				emit_signal("char_dead_off_screen")

func check_dying_condition():
	return change_is_dying

func _process(_delta):
	change_is_dying = check_dying_condition()
	if change_is_dying != is_dying:
		is_dying = change_is_dying
		print("sending signal")
		emit_signal("is_dying_changed", is_dying)
		if is_dying:
			$Body.set_deferred("disabled", true)
			$"Hitbox/Hitbox Area".set_deferred("disabled", true)
